Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC54C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2789D21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtaisCbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2789D21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJMAlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:41:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43558 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:41:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so14194497wrt.10;
        Fri, 12 Oct 2018 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vgSWLj6H/hOO9P/wLPIzoXyWjTDT83QazZhukg2KLcA=;
        b=FtaisCbRNM3WGDqEXVFzVi1kJrh/5OT988tFTex53+eSrC3Juf26IbdZKo8csZMrN2
         p2sjjaICo3mVhlrnnSPz549/rjbNV03pKaoLOj05Oc3qj3myo+Alg2JCTwh4IZgMwRRO
         WSSzsG9b/A3GKfNLb2qSQYUKR9xKHV+iBu3karU8SH5PSPQCxkEzpUVcWeDDtXLayPCd
         jOVQ1nl7kgtmD7zDyq9EMfw0nltcFErPaPiQachO19DoyyhhCNm/t3tUUTRO3cyvT55u
         hqvjc/1AguHFi1ZoH/HeeIF86Anymx5jTj5+5uaitkLPgIehj4Q9AFGseb5ac6fhLr+3
         9nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vgSWLj6H/hOO9P/wLPIzoXyWjTDT83QazZhukg2KLcA=;
        b=dI3f//sZQoP7HM9tC2yRUTclKyGg5iZwoaCShuPBUonTXuq7cIEnt7XI1qScm6/3x4
         o4nHjaBXjXldwOwAihhsY6tGuFUYEjqgFJJvCgyrufHd8+/NtFVc2Kp0ymQExGIWnarc
         kuyffCnQ2sy3+M0aOHeIKDw8b/xH7O2G1Ze5I1RkkbILoT0yGWtk6rQ5hT07weotgVOS
         P/KjPf0bl3ZyxBB3LI4/6a40+fAJ9FXNLhUK2Mn+ZY9v/I4lnxFykdBoC3pnHaimW+UB
         LuIKTg1YUIZ47/l3tiXwJfaRNoYywiESL4b77bN7oXV2ED6BbUZIYjVWyoKLYRKAIC+l
         zutg==
X-Gm-Message-State: ABuFfojvTs4bhurhZNH0a+Xel3IspL8qVhiH4OC1wNY7ukFPUPEkUOM/
        IFzc8FqvDg31dbhng2oL65Y=
X-Google-Smtp-Source: ACcGV61TG/qj8npBuDs0uOL24SZ/zeJkWpeQ2VdPj+/4U1w0QzzxXyjA7xDG6Os+/i8lyMwNXCjJUw==
X-Received: by 2002:adf:fa04:: with SMTP id m4-v6mr5689210wrr.182.1539364055461;
        Fri, 12 Oct 2018 10:07:35 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y4-v6sm1961823wrd.25.2018.10.12.10.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:07:35 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:07:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/27] 4.4.161-stable review
Message-ID: <20181012170732.GB28298@flashbox>
References: <20181011152534.014964888@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:34:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.161 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:23 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
