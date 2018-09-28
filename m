Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC01320685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCF2eheh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC01320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI2APh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:15:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39252 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeI2APg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:15:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so7273912wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LS8AAoIw9CgoI0j5IPI8Zm8pUCqPzs5Y0JKM+noeoI=;
        b=GCF2ehehfhdfxqJUNUFSf2PsRVKDsmlkr7JWNG1rcMY+w7EhQ//PgGsYppzP4kyp0/
         7auCAhlmf1bPyX1Bv6xeOZMRO2evI6/H+elWyV6CcsUnzYvNQo9L2XccA29mM8UZSQ87
         30GyvrtaxkiwAeP3KIJFPgmNBn6Io9MD035GhwVKa6LdwXf7xbzkQioxd90iH1YiZKoM
         xEU1T867kdV/6TpphnYEaNplPJL+ADF5kJTOz7Uj8iaSmM7QxA8cqAP+QAHu2UNjB1hE
         3iHFXKCDJHoiWXdvLBhOYTK6BfL4Sg0t51MnAP48xNEdqxMPccsuQ4BVruq4PWtzJnfZ
         lmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1LS8AAoIw9CgoI0j5IPI8Zm8pUCqPzs5Y0JKM+noeoI=;
        b=fRpGYv4iVZSAumyIJjWgGvwhvpPPOlp8EcCt3I4RKiE4OLleLqnWMpuFsY86wT9Q8M
         e9asslo2MuPXTZU8g4RFrdCV+vbRRyXVSt6gGiGd/EXdh0IA7nKUGJ62lPZlNkbm9rd9
         GL1KSPQybzcQZZ3w07bZkaOvjiYRIR8h6FBM/Tz9gjAU+3kKTcoMhFTBvlCc2O2BxIbi
         rYxZkBFg+PUf+NiW+jMTbHhCuyR/Kxa5H/MkAlv9Ej8myBx7ATVgBUCFeK21yt7JXBMx
         jMORxltU00BnUJFsfMgcqCz203b1VoXQCy1HsICt4z1pAZJk6L022lkN6aNw/enbHlJt
         CAiA==
X-Gm-Message-State: ABuFfojAC/6sBrpnlPZJvMuTFF9XzpoRY2MZasxAp/u0atHISnU0+j0Q
        Qt1aAy7Bltjm4chHnyFj/vaHHTy0
X-Google-Smtp-Source: ACcGV627OndyJ4snR0mRHUWV7ltjo4MoBT6C19IhO35phFr/pZtDJA8I3OowpfJa9D9CgP7IRdth+g==
X-Received: by 2002:adf:ade3:: with SMTP id w90-v6mr13596394wrc.73.1538157041836;
        Fri, 28 Sep 2018 10:50:41 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id t25-v6sm1975597wmh.15.2018.09.28.10.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:50:40 -0700 (PDT)
Subject: Re: [PATCH 1/3] firmware/psci: Fix cpu_resume entry points with
 THUMB2_KERNEL
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>, Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <20180927192711.26455-2-f.fainelli@gmail.com>
 <20180928134704.deonmn5hozam74tz@lakrids.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <b21ea7e5-9ca7-f76e-1bbf-9d29374553f8@gmail.com>
Date:   Fri, 28 Sep 2018 10:50:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928134704.deonmn5hozam74tz@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 06:47 AM, Mark Rutland wrote:
> On Thu, Sep 27, 2018 at 12:27:09PM -0700, Florian Fainelli wrote:
>> When THUMB2_KERNEL is enabled, we would be failing to resume from an
>> idle or system suspend call where the reentry point is set to
>> cpu_resume() because that function is in Thumb2. Utilize
>> cpu_resume_arm() for ARM 32-bit kernels which takes care of the mode
>> switching for us.
> 
> Looking at the PSCI spec, if bit[0] of the entry point address is set,
> the CPU should be placed into thumb state.
> 
> So either there's a FW bug here, or perhaps we're stripping bit[0] when
> we do the __pa_symbol() dance.
> 
> Which firmware have you seen this with?

This is a custom implementation use with ARCH_BRCMSTB, the same way I
managed to miss it during code review, I missed it again here, sorry
about that and thanks for pointing me in the right direction.
-- 
Florian
