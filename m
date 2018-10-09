Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EBEC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EBD20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArxDbKtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EBD20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJIIoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:44:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45245 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:44:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so8597032pgd.12;
        Mon, 08 Oct 2018 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AGhFdwi1qhFZtPr98X/jDRCMO7N/jAM12unSNMmMjrs=;
        b=ArxDbKtJN9Ur1FFUBoKHqCZVS7WDyDaRG5oZ9czNvbLmz/wARlllno7b2XLd43L4M+
         HxX/yqM5UaVyaU5Yzns12zWPhmBWMeSFjEIAj9xewfOGiCMQ+eHz1d9CG7jFApbxkd9+
         JReHksw0zkCa3nj8ZOMWlFa0nssy1wZnbMfl/bKu/knRdc5ZTLJ4FBmz8itnyNigjE7V
         iA1lXRT9nnVv7Mf5DXYiKhzRKKU+nZYydpdRRuoBEp2WfEUCcWWPDcjiGKRlc0SMdCBq
         DoW+BsMZeOsmFRa5SGknRaLwj4VpqlGdYWpOrGESZOlC+32PiOBmJUeIGQnvQcKi4eRD
         rz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGhFdwi1qhFZtPr98X/jDRCMO7N/jAM12unSNMmMjrs=;
        b=cOlZTgh4LmZh8cD3S0p/I3eLyR/83f95gsHXcL3s9bKvj94vdXSjtuAkTB/TDMupCx
         BVdGhJ0oYWDz/KqDowgRSjgsbVrmtGjSgOs8XVQs3f4fDFysNp/wTu++GwGwo5hn7gFm
         aaes/kGkZTKs9alo6e17keP+goh+msHI0Woj/dNF0ZRtHcRlJQoLkeU+7SuyELG8Yi7g
         U8Ov4B3RlqnFB5sorJzCot5u40REG8gukS9nbN3Nt68DHyuo3HlI94yFNSb9PDZWXxAs
         y4KC58skq/w2CWHx9KzZ2f+oh+EsrKuCwTiQOtqnuBLWO/laf8uv3+ehTwISLWitHthK
         C5TQ==
X-Gm-Message-State: ABuFfoiqFa1QixBVZX+cHOhfFej62JURP0ABn7ch4+TAx8Ujize6c8ai
        8dMNrrI4cBFc7zysx7CrZFM=
X-Google-Smtp-Source: ACcGV61KVoqPstDxpEqPlAWs2+Vi+WeeIIe20or0K7oDdGJepLvjhW7Lkha8W8kz9W6sLA2t0GEPvg==
X-Received: by 2002:a62:e80c:: with SMTP id c12-v6mr20257106pfi.124.1539048578462;
        Mon, 08 Oct 2018 18:29:38 -0700 (PDT)
Received: from localhost ([82.102.30.219])
        by smtp.gmail.com with ESMTPSA id s133-v6sm23898592pgc.78.2018.10.08.18.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 18:29:37 -0700 (PDT)
Date:   Mon, 8 Oct 2018 18:29:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/113] 4.4.160-stable review
Message-ID: <20181009012933.GA26684@localhost>
References: <20181008175530.864641368@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:30:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.160 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Oct 10 17:55:13 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.160-rc1.gz
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
