Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F04C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0444521903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWLlXkKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAZVs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:48:29 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41882 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfAZVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:48:29 -0500
Received: by mail-ua1-f66.google.com with SMTP id z24so4407784ual.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fF79YLYE1hKZSv/2wcivjap/8uZqvGhdgcmhBLSoGk=;
        b=XWLlXkKQ1QWC8ozof/e1S3HrWbMIbbC/Gmq876VlWgPIo1NfCUuF8m3y69pUJzoFfw
         Vemh/X3CEWXPvwThjvVDzwjsOvW2zx0rdN2OoDeunKzjevPzcAZoRsz5FcWY3+TWpMYZ
         YOtCzdVNFGX8ty9q4tvm0j4IbqrigxreiCPHIi/Rn5AgMryKqApXzPxm8JN07jMtwV4c
         FPPxO912ylnBQ7BBirfQKE7WXPu7Ij19eqsz7ocSHYJPKNspbob76fjrNfKZ8fCA2M93
         xstQrZ8s8PapIIQezcbQVcDKX7bmlGPgomDReqN0fpb12sYQGrG4vTgDaHzeaOQHqZzc
         D64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fF79YLYE1hKZSv/2wcivjap/8uZqvGhdgcmhBLSoGk=;
        b=BeG570UzdAqVvjzs5kFkS8oE6xVLLctemt72/ybA+RVk2asGTWjtXGV29BnFy4N4Z4
         qhKM0wlL0Y142/EUwHYNXA0Mci06Hm1XTdBCkASTsGiJKP23HCiWUcvTCd7oSBqBLOlB
         Stjl6UWcHmzCul4FMUHMJffkklk2MoVpBTu/2WBwEqFJ9rqlwb1bfkKJfzsJqvbyxQ3x
         kisWgcLABlVxBEWEuwJfRouAKndLK4vcfIwu9bngCm0gvUVo5AgUV/51xgnL5wFL9i6S
         q41bjDoBYCzq6MPwHPBYeuDXmL7+KtzCqU6tA8ypRICs0Rx8SFFtYxIacodgiDkz+Ck4
         gTkA==
X-Gm-Message-State: AJcUukfogPqAbX07rAE79kJyT/6sQL3UxqskV2SsU3U/1KG61lar/EW+
        Kt5+pYz6fz/aUoBiqwi3f/JL7Sn4r87H3/RkDnQP8j6llXA=
X-Google-Smtp-Source: ALg8bN4V37bRr3WvoNIwpuRUAyGwbweJitaQXeSDhXTsDQCVDbrW6qA4HnvSz3h6ezJoolacSOM56Z30DRpwJvPx1GU=
X-Received: by 2002:ab0:7544:: with SMTP id k4mr6533657uaq.66.1548539307472;
 Sat, 26 Jan 2019 13:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
 <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com>
 <CAFCwf10jv4aMNefk_1Xj_Tg5Yjg8ekzWtZ94TssfHzaSN5CVAA@mail.gmail.com> <CAK8P3a3=1Rocb8jcG8XHadgcUCL6xXs8GRxc-Az6oyPqffYTpw@mail.gmail.com>
In-Reply-To: <CAK8P3a3=1Rocb8jcG8XHadgcUCL6xXs8GRxc-Az6oyPqffYTpw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 26 Jan 2019 23:48:02 +0200
Message-ID: <CAFCwf109SsyUVfvWAwA-j6HbqJ-QEZkWUhwirtX7dUf5CP_R7A@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 11:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jan 26, 2019 at 5:25 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Sat, Jan 26, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Jan 23, 2019 at 1:01 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > > diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > > > new file mode 100644
> > > > index 000000000000..9dbb7077eabd
> > > > --- /dev/null
> > > > +++ b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > >
> > > Since this is a apparently a user space ABI, the file should be in
> > > include/uapi/linux/,
> > > not in the driver directory.
> >
> > This is not a user space ABI. This is the ABI between the driver and the F/W.
>
> Ah, I see. In that case, you should get rid of all the bitfields and make the
> struct members all __le32/__le64/... to make it work on big-endian kernels.
>
I really don't want to start converting bitfields and structures to
use __le32/64.
As I wrote in one of the previous reviews, we don't support big-endian
architecture (what's left after POWER moved to support little endian
?).  We actually do run on POWER9 but with ppc64le architecture
In any case, our software stack is so big that this minor change in
the driver won't have any impact on the overall ability to run
something on our H/W

> > >
> > > > +/* must be aligned to 4 bytes */
> > > > +struct armcp_info {
> > > > +       struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
> > > > +       __u8 kernel_version[VERSION_MAX_LEN];
> > > > +       __u32 reserved[3];
> > > > +       __u32 cpld_version;
> > > > +       __u32 infineon_version;
> > > > +       __u8 fuse_version[VERSION_MAX_LEN];
> > > > +       __u8 thermal_version[VERSION_MAX_LEN];
> > > > +       __u8 armcp_version[VERSION_MAX_LEN];
> > > > +       __u64 dram_size;
> > > > +};
> > >
> > > The compiler will align this to 8 bytes on most architectures, and
> > > add another padding field before dram_size. Better remove the
> > > 'reserved' fields, or make them an even number.
> > I can't do that, because those fields were once used by the F/W and if
> > I will change the order here, or add/remove those fields then it will
> > break compatibility with old F/W.
>
> Ok, I see. Then you should add an explicit padding field and fix the
> comment to make the structure match the actual interface.
>
>        Arnd
Understood, will be fixed.
Thanks,
Oded
