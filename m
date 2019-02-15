Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9075C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99612089F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vth31cBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfBOKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:43:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35877 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfBOKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:43:47 -0500
Received: by mail-it1-f196.google.com with SMTP id h6so20975589itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uivGbSiXEQOpFxzRP1Er6b88Pvgzr9mkKYga4UclYYY=;
        b=Vth31cBsvgohEbL6fkFmJxauSF3dkTrIL9QQMg9pZtde32g5P44WMetvV2/+IXkULb
         +SgVkKGTZtt6q17mQ/y7vFLo5YOSzY/Ypc/8cPecGM2HE7KJkUl+ntDZsZLauWY61PSN
         avc2TDVi3gNDL2bGVtH0kBmLQRcV13dl2P6xbmK92kpyA21QhBp5pXzX+DbdhNnzXN0E
         0FSMO6E3yPOF8LzhWB0bke1jCE2EOgKXEWeYVJoz7NVsqrR4QvUW31ZVE/shJRBwfY+K
         bjunU8H1RghqyAbs7FFKguaiCH0TM5k0Oiw8xOfNSGm2oFQ4RmSl5cslMt/6Bp/oq8kl
         9/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uivGbSiXEQOpFxzRP1Er6b88Pvgzr9mkKYga4UclYYY=;
        b=CwX0L4ChWfzOO7oSyCjQKZbd9D4oDTNBRaIPg/OU/QD/1rSiEZD/7AjEvgDicAMV0F
         CVLsCSYaEcoDc36PqHMOxuVuCvbg5LSW8l9QRfElrrVD8+8KlyfzXSrsi4wIyyS2Uuy6
         Yxj7GxahpE7WfGLhIQA3IZ0Fc49fPmJecUuAsyCt9ktkjkLb7PmDVFcExfodyLTfwD4G
         SjlJSWg1OedJhgNh5dN2XMlgdpAkj9yVlje0ESdhmuyjj2MlN2OdnNFWQBisSDGep9dH
         g9J5tgyPAgvYRLD3JbjPUHG/E9C4RpehCpHBvhXEE1aLCDYEq2pYfBsSih/aydk8/nsi
         iNng==
X-Gm-Message-State: AHQUAuZd07A8mzSobbwhD+M3bhjc1FfjXPVoH6jiKG93NoKy4Ytpfcg1
        LkShKk3DpTVedDieo6yQKsM89Vw0QCq2w1P/Rc7+Mdw8
X-Google-Smtp-Source: AHgI3IZB29HkOOMAYesu+V3ThY9QdZiW+UgWdVW29nIG73WO4wGt21bzf6y+RRbNfVGIFr/zFeMtrQee8164dhfogN0=
X-Received: by 2002:a02:9d55:: with SMTP id m21mr4736863jal.24.1550227426427;
 Fri, 15 Feb 2019 02:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20190214162349.22740-1-brgl@bgdev.pl> <e566b4ba-0f3e-052a-bf08-ad881cf7b7c0@linaro.org>
 <CAMRc=MdW47YspeOv+9U6h9Ps35S0As2yBVXPdiwJFXNg_hMZZg@mail.gmail.com> <2ef927a7-0698-3d2f-797f-b9f742bce905@linaro.org>
In-Reply-To: <2ef927a7-0698-3d2f-797f-b9f742bce905@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 15 Feb 2019 11:43:35 +0100
Message-ID: <CAMRc=Mdxw+YMOuUYPB3NvEJw=u7TWxrGsLLE7R8i_0mJY7ZO_A@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: fix the return value check when calling the
 notifier chain
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 15 lut 2019 o 11:26 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 15/02/2019 09:41, Bartosz Golaszewski wrote:
> >> rval will be masked with STOP MASK, so the above statement could be
> >> false even if we have error.
> >> So you should consider returning an errono which can be understood by =
user:
> >>
> >> may be something like this:
> >>
> >> if (rval & NOTIFY_STOP_MASK) {
> >>          rval =3D notifier_to_errno(rval);
> >>          goto err_remove_cells
> >> }
> >>
> > Actually I'm now thinking we can remove this check at all - most users
> > never check the return values of notifier chain calls. This function
> > cannot fail in itself. What do you think?
> Thats even better, I was about to suggest the same on the fact that we
> should allow nvmem provider to register to be successful irrespective of
> the notifier callback failures.
>
> --srini

Right, I sent a different patch.

Bart
