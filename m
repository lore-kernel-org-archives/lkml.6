Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DA2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF8B208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB8ksn7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF8B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeFTIdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:33:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43570 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbeFTIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:32:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so2315986wrm.10;
        Wed, 20 Jun 2018 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0OxmhA+/6S6BDHl5aiALBuuQ6K1bt3IdUjUy9b4f5NQ=;
        b=RB8ksn7OdJD08TpumK00LYofMFCzho+I4i6KPOJbQL85b/ZCcgpM7KBUZ8ovUYwtgy
         BcKw5HivV2ZEyDmcSPoRK/ftNQpQASNfEhciWOboZtiRp4KXpfV8uyD7fBBJcxJtAeHb
         SFJQmh5aS7brnMSjgYapAHlwGrffF+q2ilyjN5+3VjkJnGn4vvl0Dw7S3EdjBYEnYVJh
         i/CzLXTb2+KK/t/Mg55Devc7neVa5ikn6ZobTHgpLFBE55r7gAgKdNYiApb0G18rY5+8
         HO1qfoNjWHnOCHKIvA3vlSIZ873Hcs+tIruhwwcDqsmNBkTftnwuw4e3U//phNhplk0l
         p5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0OxmhA+/6S6BDHl5aiALBuuQ6K1bt3IdUjUy9b4f5NQ=;
        b=aj7+rtwYqJee6EBkYsWic5cfEICa8vFvYNXe9hRfUK0S/PcQbsRCBRnCinge8ridK1
         UKAUr7euQOiDc0mcNsG/V4sZCrDnMzVPvFAyo7E0VRc0Ac6eccP54JowlDsrGMWJ5UtO
         iAGFDXfvpeajNiz/VYyS/nOkjIuiELrT7s4+KdWN0sJMJhxqM9BuQpqm56mHufZ/0U+h
         EIquhF0aNwtADmjYsAqr8B+Hh7M0Oox3ucVPA/1X9Keki0wZAJb2zFDyBsqDNGfKxdM2
         MM/6vS8dCnUeF+NQKpZCET2jHRMdoBNSaYbgWKrxjfOSfsaVBhpqS0gWxRIz1+c2qtHw
         CJIg==
X-Gm-Message-State: APt69E1q8AfB3JSE3uaIN8kNOyrgXElg2vLeuUAMdofx52+XBH2LDuUQ
        0Vlxys6dpcE4+NNnP6g7rOmb1cPv
X-Google-Smtp-Source: ADUXVKJGP/r3QfbpVagL+drWljz73HrPuCODUU5/iu97gDRAD1N/ORWw8tdt89GaPLtL1qGK79e0sg==
X-Received: by 2002:adf:9663:: with SMTP id c32-v6mr17811863wra.89.1529481737416;
        Wed, 20 Jun 2018 01:02:17 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-154-24.clienti.tiscali.it. [78.12.154.24])
        by smtp.googlemail.com with ESMTPSA id c201-v6sm3043017wmh.18.2018.06.20.01.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:02:16 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
To:     Matthias Kaehlcke <mka@chromium.org>, Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
 <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
 <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
 <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
 <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
 <20180619183622.GB169030@google.com>
 <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
 <20180619211019.GE169030@google.com>
 <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
 <20180619234543.GG169030@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <c1d26d79-6e0c-fca8-af3c-e97af47b6b5f@redhat.com>
Date:   Wed, 20 Jun 2018 10:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619234543.GG169030@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 01:45, Matthias Kaehlcke wrote:
> 
> v4.16 with an x86 allyesconfig and a few drivers disabled since they
> don't build with clang (yet):
> 
> 16 occurrences of -Wconstant-conversion, including the ones fixed by
> this patch. Certainly no need for an endless churn of patches, and
> given the limited number it also doesn't seem likely that new
> instances will be added on a regular base.

Thanks for providing numbers!  The next question is: how many of these
16 occurrences are actual bugs?  This is what measures the usefulness of
the warning.

Paolo
