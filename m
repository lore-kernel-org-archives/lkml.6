Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8A208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gM0sDmJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF8A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeHXTO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:14:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36427 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeHXTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:14:59 -0400
Received: by mail-it0-f67.google.com with SMTP id p16-v6so2492594itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ezry/Y3Wgw+4f1feLnZlgoHsZiJ7oMHPTRCWsKS9KNE=;
        b=gM0sDmJaqaXijOBsoaTcRdZZ0aKEHL6H5YVxPhUAJTI9kkja0V/kkdonCdA6eyrEwQ
         mYopqvGVWBsADYAMSl5WPfu0OwYcAwxzC2WJ3azGoSz+y7BIcHqV+AoacEj09LPTY8gh
         gjoV7yop6xn68WMrh1Lp5+T+pqkJTtoudh1jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ezry/Y3Wgw+4f1feLnZlgoHsZiJ7oMHPTRCWsKS9KNE=;
        b=tJPj/JCGhkgmg+ycLLx2/WlC64Gpli7akOfOuyDCSUkGZXwSfjb7QrAU59NKOzT9hg
         16NHir1yU1sNG2Yyv73XCskshEe//FzpzSP3TOOdmdpBujWE3qW1AauCHi4ld2T9cf7i
         e6jPsfnwSUWCBCqWibzog5GSja4KN7h/QUU/OZUXvAb2dKHdU/AcnbolAWKXN3b/tavM
         H2YGaRv1oGdzBqJurDgnO5sAv5KtkdGP1dfVZDtCktc7R7E1zfqQUGwY/B1MsZaJkshU
         vRsVHEhWyE4+0kj+2Ug6IwojcnhtjArN65qCUpoTWRuvDnEwqQg2/3UjRhr2SMmevHUb
         lv1g==
X-Gm-Message-State: APzg51CiOlpk6J+aLIABDQ2ut+mNk5kPuvNqyPCJEL46TxnZE1ezbMV5
        b/UYc01Ta079mLeiWIuDq5D5XgmuwAU5qWFfuulDig==
X-Google-Smtp-Source: ANB0VdayemEjvBjsWuJ7yPFAIrDTrRJ4kgCSkYjHLP2nLM9i3OJsDh93zqfGckWyj9C2J+RyWyuod3gykEgoERmpv1k=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr1811115ita.148.1535125188026;
 Fri, 24 Aug 2018 08:39:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 08:39:47
 -0700 (PDT)
In-Reply-To: <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com> <20180822062016.GA10356@infradead.org>
 <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 Aug 2018 16:39:47 +0100
Message-ID: <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
To:     Jeffrey Lien <Jeff.Lien@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 August 2018 at 16:32, Jeffrey Lien <Jeff.Lien@wdc.com> wrote:
> I rebuilt my 4.18 kernel with CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy as Marti=
n recommended and got even better performance results vs the CRC Slice by 1=
6 changes.  Here's a summary of the results
>
> FIO Sequential Write, 64K Block Size, Queue Depth 64
> PCLMUL =3D y Kernel:        bw =3D 2237 MiB/s
> Slice by 16 CRC Calc:      bw =3D 1964 MiB/s
> Base Kernel:                     bw =3D   357 MiB/s
>
> FIO Sequential Read, 64K Block Size, Queue Depth 64
> PCLMUL =3D y Kernel:        bw =3D 3839 MiB/s
> Slice by 16 CRC Calc:      bw =3D 2730  MiB/s
> Base Kernel:                     bw =3D   797 MiB/s
>
> So it seems the CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy provides the best perf=
ormance.  Are there any negative side effect to this config option?   If no=
t, does it make sense to recommend all the major distro's change their conf=
ig options to have CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy as the default option=
?
>

I think the way the library version of crc_t10dif() invokes the crypto
API should be revised.

Would it be possible to allocate the crypto transform upon first use
instead of from an initcall? If crc_t10dif() is mostly called from
non-process context, that would not really work, but otherwise, we
could simply defer it (and occasional calls from non-process context
that do occur would use the generic code until the point where another
call from process context allocates the transform)

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Wednesday, August 22, 2018 1:20 AM
> To: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Jeffrey Lien <Jeff.Lien@wdc.com>; linux-kernel@vger.kernel.org; linux=
-crypto@vger.kernel.org; linux-block@vger.kernel.org; linux-scsi@vger.kerne=
l.org; herbert@gondor.apana.org.au; tim.c.chen@linux.intel.com; David Darri=
ngton <david.darrington@wdc.com>; Jeff Furlong <jeff.furlong@wdc.com>
> Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
>
> On Tue, Aug 21, 2018 at 09:40:34PM -0400, Martin K. Petersen wrote:
>> When crc-t10dif is initialized, the crypto infrastructure will pick
>> the algorithm with the highest priority currently registered. Both
>> block and SCSI will cause crc-t10dif to be compiled as a built-in so
>> this selection happens very early.
>
> Ouch.  This might actually happen in a lot of other users of the crypto f=
unctionality as well.
>
>> However, it seems like a bit of a deficiency in crypto that there is
>> no way to upgrade existing transformations if higher priority
>> algorithms become available. btrfs and a few others work around this
>> issue by not using the generic lib/ CRC functions (which defeats the
>> purpose of having these in the first place). Instead they are
>> registering their own transformation at a later time where any
>> accelerator modules are more likely to be loaded.
>
> If we can't fix this in crypto (which doesn't seem that easy), we should =
at least clearly document the issue somewhere, and fix this in the t10pi co=
de by initializing crct10dif_tfm in a lazy fashion only once the fist block=
 device starts using it.
