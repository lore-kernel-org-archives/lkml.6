Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FAA2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH5YmUFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FAA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKGFDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:03:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35926 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKGFDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:03:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so4022226qth.3;
        Tue, 06 Nov 2018 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CdkQGVNQ8mvxr791JCWHivi8n5evGd0RCMXtZ6U0Lnw=;
        b=lH5YmUFkJC+45SynoOKIhJw0xgb75ma01ULuO4WEK5ro8AOlWaFH8r4QVLF3UKaprp
         /d9q0NpNEyVTW5Qh9j9dQLOxHE3/aaDG9PrrfKmu7JqA7uPRSp9z4x1OTtRP4A49JOMI
         Op+/JQo51wOwFHw7QLxEmoS8Hk3blyStgmS6wouN2RKw62AvMFQjMmvTzwcT6L/KMXCy
         T3Kom/44PkuugENcU+WRa9rUy202yhhQB6eXQer7zgB3q/qlbBbrNimazm1HzgVlxxgM
         mIkBT8MS3Rhg/ca0fVbZBPi01AHLEvsWws1svHc4lshJMGlAbaMoRilc6LM3gywL1l4L
         EnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdkQGVNQ8mvxr791JCWHivi8n5evGd0RCMXtZ6U0Lnw=;
        b=kOcbkVKgl90BrfhvS9Xcw3QmkBggWffppw87nS1rEs3EpxCczPPB69QWnCDc6av2Ox
         jaAlMn7HSgysnV4LKG1I9exijQk2UgLJVKms45YWbxO8IuvCpgNUkoUoWCSVHMYFy1Ve
         sp60E5p+LxjQbO+jAIHr+ZDf3PFnpx99FWNF8YZI232/Rg4hPek5f2qxFVDXGIPyvnBU
         tgrCVpmddf1lIJ2JFdULYz2QpDm0+FHU9HIE4ubpIckU6KHB1A/a9qMkKp2BUUplsxDg
         EEa/HjMnirFNLQgpXaMogrkoOhHfVvEfDCX/VMzePLY7swFRdC3S5iGN/kiQmOrFiuTA
         YzJw==
X-Gm-Message-State: AGRZ1gIFDWIuXdUWI9FJAMJGxAAw6uEx8Pk8yhsKqrdXnbi96W8jOWxn
        5Yd8Gly6+/Q7nGuYz18TPw==
X-Google-Smtp-Source: AJdET5dTZHNI7fqcJcuyGOubDkjNqH1JyiLsVYIv9aN6nJZAXq9LcAnPBUQjRxyMFe8gKWywyBWbcQ==
X-Received: by 2002:ac8:2df0:: with SMTP id q45mr18011322qta.178.1541533007106;
        Tue, 06 Nov 2018 11:36:47 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h25-v6sm32339482qta.89.2018.11.06.11.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 11:36:46 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:36:38 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181106193636.svyjwuwrlgnpuyyf@gabell>
References: <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106184519.GA16391@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:45:19PM +0100, Borislav Petkov wrote:
> Ok, having swapped the whole thing back into my brain, forget what I
> said earlier today.
> 
> Didn't we talk about passing info with setup_data to the later kernel
> stage? You even had a patch:
> 
> https://lkml.kernel.org/r/20181022154204.kagmdb55jtoez4ca@gabell
> 
> So what is that "idea" again about adding SRAT parsing code to
> arch/x86/mm/kaslr.c?!?!
> 
> The intent of passing info with setup_data is to *avoid* parsing SRAT
> yet another time and duplicating that code one more time.
> 
> IOW:
> 
> * The first place that needs SRAT parsing, does the parsing - i.e., the
> compressed stage.
> 
> * Later stages get information passed to them with setup_data. No second
> parsing.
> 
> Ok?

Yes, I think I can see what you are saying. However, I'm not sure how
I use the setup_data in legacy BIOS environment. So, I said the another
idea which adding the SRAT parsing code to arch/x86/mm/kaslr.c as well.
Yes, as you said, that is not so good...

I would appreciate if you could help to use setup_data or something to
pass the information to later kernel stage in BIOS environment.

Thanks,
Masa
