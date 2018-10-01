Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFBC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B962075E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN227xsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B962075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeJAHsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:48:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46940 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeJAHsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:48:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id g32-v6so2262861edg.13;
        Sun, 30 Sep 2018 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DtARMq2gN2KlII7tid6ka0zoaXtZkQ1gGsevWBanKLg=;
        b=cN227xsAMlw8Au4Z0VZJDwcMmHF4alXJbl8Ct0p3UH+RwhhB3VzL0Gz3guX+cul4Yj
         hvZit8eUKwufgvsww/0pl39D+l63Mty7AuofdOO49yjKVSNZDk55+4V8UyFpolcJBWI8
         JOeCrjGoJLFX4jZB4/rATn0nHxaJVpZPx7TzPJ6qYvwcOJeWeJtxEt3tstbyZEtHlkhm
         UjAJnQa8tPBC03SD41KTRbmhXmAV6O1sHtBBEYQb1fnimjhN2iEAtpN+KLRGhOJHA/T+
         Hc3lhe14zm3XcGuxeh6M2hrLd2SLq708/i9hIVAjHVNChlDszzu8j4bvOagvmLoWZeOm
         B5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DtARMq2gN2KlII7tid6ka0zoaXtZkQ1gGsevWBanKLg=;
        b=lQ1RDjfYZ3sX0c1q0wXu7AOxOZEaRf+QZ4DsjbhbjQqIkQpvi4BqScQHmGpkfw1lbO
         93tiA8ouK6KewPV3MPd0Q1ngwJS4XerSfts1gHI+uG28hnKTF87E8LrXQq3R6o7xOVsw
         E9ASb7x1QDfRWBU2aVf64AcBUNCD0rLqyXdERPGvOyfNSu9nUIXoLML5sZHGSabqcmEk
         sjGWYkGgc5hCRabfqImdUbOCCU1sY5RUIwEDJxa1VKwP5/kg9XcF3LJQUsskJIWjlXTA
         eEgGrAaVqBW9/x9r96fFp91IzMrDH8+OsE8+ci3cCE2uoq0q+4QxarbYm9f/1MA0dsPh
         wwpQ==
X-Gm-Message-State: ABuFfogWITjOozB3b5y9gOgwJBQ44UtjFp833ekN0vHDxCUyMnA3wS3j
        /t6CRPkU+v1DpWL2MQzDPgmb9V5GmqOZZ52rtYc=
X-Google-Smtp-Source: ACcGV63FQR+klocGEPrwu1J1OZ77cYOVayoBeOxn4VDK509e7bHYR1kYqYhhq7qiXe2gq9I5DKRtuQIiv/6/9zfwqRQ=
X-Received: by 2002:aa7:d653:: with SMTP id v19-v6mr2336658edr.223.1538356373883;
 Sun, 30 Sep 2018 18:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
 <20180925203701.13605-2-dangtranhieu2012@gmail.com> <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
 <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com> <20180927224723.GF20825@sirena.org.uk>
In-Reply-To: <20180927224723.GF20825@sirena.org.uk>
From:   Hieu Tran Dang <dangtranhieu2012@gmail.com>
Date:   Mon, 1 Oct 2018 08:12:42 +0700
Message-ID: <CAAObPoFfhJZpr_iwcmub2zndTV4GK5byV0DFBybeqA_vB8mbQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agree. I will create new patch which will just allow stalling by default.

V=C3=A0o Th 6, 28 thg 9, 2018 v=C3=A0o l=C3=BAc 05:47 Mark Brown <broonie@k=
ernel.org> =C4=91=C3=A3 vi=E1=BA=BFt:
>
> On Wed, Sep 26, 2018 at 09:37:39PM +0700, =C4=90=E1=BA=B7ng Tr=E1=BA=A7n =
Hi=E1=BA=BFu wrote:
>
> > Default value of the register is to allow stalling (NOSTALL bit not
> > set) but the spi-fsl-lpspi driver defaults to setting the NOSTALL bit
> > in CFGR1. To me, it's more logical to leave the NOSTALL bit off with
> > fsl,nostall binding to set the bit but as I am not sure if there are
> > other drivers depending on the NOSTALL bit being set and not wanting
> > to break other drivers hence introduction of this binding to keep the
> > current default behavior.
>
> I can't see a situation where you'd actively want to report an error
> rather than stall, stalling allows us to handle things gracefully by
> restarting things.  Even if it's a timeout situation it sounds like we
> can unblock by reading/writing the stalled FIFO, and normally you'd be
> resetting the entire IP anyway.  I'd imagine the driver is this way
> either through an oversight or because there's some bug on some silicon
> which means that stalling breaks.
>
> Probably best to just always enable stalling unless I'm misreading
> things, if it is silicon bugs on some versions then either a whitelist
> or blacklist of SoCs to enable on (depending on how common the bug is)
> would be the way forwards - that way SoCs where it works get the benefit.
