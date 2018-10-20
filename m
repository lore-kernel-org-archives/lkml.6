Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CAECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A4B21528
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CipwXlLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A4B21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJTSgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 14:36:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45676 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeJTSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 14:36:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id f17-v6so8129594wrs.12;
        Sat, 20 Oct 2018 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNop1Tr0WKAujPscibmXQNdNSPhna5AwVbmlfr0Gyy0=;
        b=CipwXlLDshKOgowzke0v/Li6ezQQuNJDr0NRuzSQvxDjr1t9dy+9v76/qVttuLPlNy
         AoMi6OKbnBSGIXgHgPpXcvpNeo2whehAOoL6Izyj+McHJl3GoMXno5tdfXYYbsrrRuZQ
         /ZD1xUt+RMSBOiSux7Ishubj2spKlH/00FN8X/BjB9h8yY6ZTV900ffvsg6EbRwdcjo8
         e32oK+DXOuMd+32Nf+K3Tw+dA5dlmFL/3gQh/TD8YTEfRu2To9lDM/l4CzvKoq9OW+nK
         HniSXGb/E3u51zlZ0c/8qOH/8YX+dZSUYuKOpuPuJbi2dS+CsX1s3YMD5zoKNMgiQWCy
         p33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pNop1Tr0WKAujPscibmXQNdNSPhna5AwVbmlfr0Gyy0=;
        b=cQPUbUZpqMz+WZLcs0jc/7VyWwkc1/i82Qas76oBmPM79egApCfa0I03x3sX6UUA5F
         uzJQ4KLwUw8LRYorOpLPwnrDMIg8h54KMJifLbNB2PnYUYbSR17c0PVoehils0+pdxE+
         HR+WluAh1H1p35MBNEdTquGMh36yaYm9uRLhk1tQ699z1rVtH86r8JCKyCwwpJRsGqu3
         66cigPw7RKllvRaVXgW2X+qB2QmCM5aDdazxZBFy8m/af0yQU78/Bkgehnt/WATCftLK
         mLkmAzYDrMNhUhO8GIVyoBwe9OeO8lhCNcI0Ly45+k1mikv3pO5Fv31VwfqxVTdtTY5S
         aqpA==
X-Gm-Message-State: AGRZ1gLkko524S2DBcsBwpPPSWzCJfW8tYr289I6CyCWnKYRi3YlGWgc
        Vq2EBNXdeB1XtpuLjTkm9fLYNI6dMeA=
X-Google-Smtp-Source: AJdET5dyoZdop3JPKQE9+LquIdFNV4AAFUNTXFEu2aqeI5yLPfMwcSqldtPzlrs6vIDraZ+Yrw2RUw==
X-Received: by 2002:adf:db43:: with SMTP id f3-v6mr1753892wrj.246.1540031182732;
        Sat, 20 Oct 2018 03:26:22 -0700 (PDT)
Received: from [192.168.8.100] (89-24-40-28.nat.epc.tmcz.cz. [89.24.40.28])
        by smtp.gmail.com with ESMTPSA id 191-v6sm2379346wmk.30.2018.10.20.03.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 03:26:22 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
Date:   Sat, 20 Oct 2018 12:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20181019190411.GB246441@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 21:04, Eric Biggers wrote:
> Hi Jason,
> 
> On Fri, Oct 19, 2018 at 05:58:35PM +0200, Jason A. Donenfeld wrote:
>> Hello Eric,
>>
>>> As before, some of these patches conflict with the new "Zinc" crypto
>>> library.  But I don't know when Zinc will be merged, so for now I've
>>> continued to base this patchset on the current 'cryptodev'.
>>
>> I'd appreciate it if you waited to merge this until you can rebase it
>> on top of Zinc. In fact, if you already want to build it on top of
>> Zinc, I'm happy to work with you on that in a shared repo or similar.
>> We can also hash out the details of that in person in Vancouver in a
>> few weeks. I think pushing this in before will create undesirable
>> churn for both of us.
>>
> 
> I won't be at Plumbers, sorry!  For if/when it's needed, I'll start a version of
> this based on Zinc.  The basic requirements are that we need (1) xchacha12 and
> xchacha20 available as 'skciphers' in the crypto API, and (2) the poly1305_core
> functions (see patch 08/12).  In principle, these can be implemented in Zinc.
> The Adiantum template and all the NHPoly1305 stuff will be the same either way.
> (Unless you'll want one or both of those moved to Zinc too.  To be honest, even
> after your explanations I still don't have a clear idea of what is supposed to
> go in Zinc and what isn't...)
> 
> However, for now I'm hesitant to completely abandon the current approach and bet
> the farm on Zinc.  Zinc has a large scope and various controversies that haven't
> yet been fully resolved to everyone's satisfaction, including unclear licenses
> on some of the essential assembly files.  It's not appropriate to grind kernel
> crypto development to grind a halt while everyone waits for Zinc.
> 
> So if Zinc is ready, then it makes sense for it to go first;
> otherwise, it doesn't.  It's not yet clear which is the case.

Does it mean, that if Adiantum is based on Zinc, it can be no longer used
for FDE (dm-crypt)? IOW only file-based encryption is possible?

Adiantum (as in your current git branches on kernel.org) can be used for dm-crypt
without any changes (yes, I played with it :) and with some easy tricks directly
through cryptsetup/LUKS as well.

I think we should have this as an alternative to length-preserving wide-block
cipher modes for FDE.

Milan
