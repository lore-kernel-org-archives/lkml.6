Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BEBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0777214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFNXvUP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0777214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbeIYAKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:10:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51801 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeIYAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:10:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id y25-v6so3272535wmi.1;
        Mon, 24 Sep 2018 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yzYjtuslhKWQ8AUMAKUmGoKj31Uy5YospYfjHHGRA1I=;
        b=kFNXvUP6ocbCcEwxPsvJGoIFtuZsK17iKJ+aJK4c20MHhwVOi9aTC+iejYaNg46Efw
         42Wd7d3lddm3zv5ThIs4bUvdjJK2nsBjq8hPkoxGLciTfV7v8yv1GtEbHuKrIA/o52KU
         g0ow6vncij67YuLc6ribV83jWoRmBpXRG14enS1MYYfpLCq3JLx0p0nl9JnHOB+b3JaP
         hutxucZ8oy4/yt8ku4e2OTrFtSycbcbK2JByaPHSg0hFqWZjiN7Pja5Xv8sUBZBbe7Du
         w6UYPLGSSZVCBSVbINPl1MRbnLTcZOmTPeccf7aFlsF0WaePmpicN0F9QtdTzT5yT0Vr
         su5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yzYjtuslhKWQ8AUMAKUmGoKj31Uy5YospYfjHHGRA1I=;
        b=ujkwe5M7wPT8sVoBzjb4rE5TIH442SqsqcWWPpAL+rfXK3bo7ojF/5gOhWzv1gvLke
         1mP/TfpNn5kpbS7HgRVzS2y7mpUY1225LEpgzynFjGORwRkowommPdWv89qZWPO+DuPn
         yb7Va1ca5uhDxKhpKE3fcCLGVK2bJBE6e6zSCTm/iWOK63NyX0dHYGe8J2DLdjgWWhn6
         Utj0Bd1EFVVJ1X0XmSNgqwnESEuRigcrJavh6eJIOg4yzQaPNt3ChAGiWOMph2vd6Fzo
         vYdHVmNtzDYFSdih3Kje4FQVNBIiRUuvdgGFrGYpuoXpvIdqGN6h1BffQ1a+DettMaMI
         uyQQ==
X-Gm-Message-State: APzg51Ab787Y1fRlCAA09noEhiGQSTdlFwKEfMS6LSKD7e7aOP5vwRMj
        rM8R75PfpqY/D+8owXP6Odo=
X-Google-Smtp-Source: ACcGV63tL0dDQfaiGanlq1j1yaEILzc8cC3ilBfnmgKPxplj4LXtB1qyfQetHe4+1OsMWl5fN+eQrg==
X-Received: by 2002:a1c:ee8d:: with SMTP id j13-v6mr2905592wmi.125.1537812430644;
        Mon, 24 Sep 2018 11:07:10 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j27-v6sm1502454wmc.17.2018.09.24.11.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 11:07:09 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:07:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/173] 4.14.72-stable review
Message-ID: <20180924180707.GC4232@flashbox>
References: <20180924113114.334025954@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:50:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.72 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:10 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
