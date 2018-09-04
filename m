Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E2CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C575F20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG89lFEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C575F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeIDUcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:32:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37199 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:32:23 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so4582744qtl.4;
        Tue, 04 Sep 2018 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQGn3b9dcfwdP2p0w9uJac7HrY2amUtgOZR6sQnMh4E=;
        b=jG89lFEeQrA7b5L2wywqIGiCgHqJZdt2IYPyVWH7Opl1GTS7Wd8Hk24sLOhW8IbA3E
         M0Vqh6Sg6nzLxRGSpPHyiKVKlv6GPrtbeIJEevdpH6QZaSDiFO88d58ju6EHdVOTNrdb
         GYC4vE1a8X4RcaSVIDzJgWQ6cMdmFraMgn34YQ/sexVjFz9R88LxM0b+Ur928+Pi545K
         kFDAFk4leemup9KuABSTelSrT5PUYhrKpIQKr71wfxXxBtP1WaU9sH7s2FUazOE4prHw
         Vq8MMR0fKGiKSKDoiAt/DmBsGaflJKhppt04YH04spwaG4ce4p8Txfi9X/H+g+KCjDBV
         /8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQGn3b9dcfwdP2p0w9uJac7HrY2amUtgOZR6sQnMh4E=;
        b=dmlQghRHDeAtzOKIrDEJ9c1h9ArXraAr8SUspCBxoc1XolVmnRtzo2MGFPQjiMGfga
         v43d3R9WDFnNyKruBMcGcMKT/URfAla/iXRl6zYCATFVYzl4+Loywp+ZxIcmgArLg5Kv
         q7EFWXWSbDnC7kbmnVrjenG+WVURWB4kZup7P2XgUdcfqUuoIgsBXBIXZhKVD+rq9wwf
         +lYNetyBzYurPP0MppeSh9w833zvaHqCSsmk+QybKARDlQIgGchVGCwi5xU3I1Y+s9Tm
         oyInXih100MKYnjqJB50Bi1kz8bsC3cNuOIaTaTr/3yBs1kJby1XR3HQwEahWMq1J9lA
         3hJQ==
X-Gm-Message-State: APzg51DxSeqBlOkoy5aRX3RELlXasysve4vhjcmOo+E6Crp3tp/5ekeo
        OCUzXKZjO7Pp0UZiCgdfbFdmHG0QMFvpBsDBN/g=
X-Google-Smtp-Source: ANB0VdYZoiWg74oot/Upu8SbaS2AkcdsM4shvcgdVm9Sdt4g0Iey412yGg6EwPjgyd5hKsTTHv+UpQx0cfpN1u8YfxY=
X-Received: by 2002:ac8:435e:: with SMTP id a30-v6mr30427040qtn.261.1536077197329;
 Tue, 04 Sep 2018 09:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-5-jarkko.sakkinen@linux.intel.com> <CAHp75VchsQXGRrcrcB06w68PzUZb5NJLo2B_ZKf6ZLqyBbvWhA@mail.gmail.com>
 <83f5ec5f-1b31-15eb-7341-84ee9c7977e2@intel.com>
In-Reply-To: <83f5ec5f-1b31-15eb-7341-84ee9c7977e2@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Sep 2018 19:06:26 +0300
Message-ID: <CAHp75VfqFAgPbHDLBdDF_VRFRoGuBBMtA0HuOeDTZtNgFe-8yQ@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] x86/sgx: Architectural structures
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 7:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 09/03/2018 06:16 AM, Andy Shevchenko wrote:
> >> +       EBLOCK  = 0x9,
> >> +       EPA     = 0xA,
> >> +       EWB     = 0xB,
> >> +       ETRACK  = 0xC,
> >> +       EAUG    = 0xD,
> >> +       EMODPR  = 0xE,
> >> +       EMODT   = 0xF,
> >> +};
> > Hmm... This E prefix confuses me with (system wide) error codes. Has
> > it been discussed before? If so, can you point on the conclusion why
> > the current format is good?
>
> Making them SGX_EWHATEVER isn't a horrible idea.

+1 here. Namespace will not shadow SDM naming scheme.

-- 
With Best Regards,
Andy Shevchenko
