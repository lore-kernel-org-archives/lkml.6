Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A89C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F1321872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550089860;
	bh=xj1LZ+jnKZlswnp3WoAydmXdhhBSefw3dKE1DZhjRBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aiWUCn8EkdDQFmCMaan6muPEbFqtdhyMYDygNmTsASH53p85Y8Hr8SMs/DNSjE2jI
	 Xzzi8cSAPzLFoLjJ3DpnTWKfLCcqlC52kfMxA4Hw7+n4HjvwOcPXnpVh3DX3DRRkBm
	 W0Or0eCv+fqpP0J3+SBhoSiSRrNj3NyO5rvnt0oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394621AbfBMUa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730402AbfBMUa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:30:57 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3C9222D0;
        Wed, 13 Feb 2019 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550089856;
        bh=xj1LZ+jnKZlswnp3WoAydmXdhhBSefw3dKE1DZhjRBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n+xQX9FfiwEwV439VYH9f5NPgMzunKjdEuqzVsKnesfSr2IiQn7t56pjBDUy16zh6
         z+13APQuvwwiKxq2AouTlMh8dDvNW5viwJ936rOAWx3PpGh/dfBAEDsbiKcDheukRe
         WJUbD86EGOeUczEFifcoZB4ME59G2MJfTy1+3Nns=
Received: by mail-qt1-f171.google.com with SMTP id v10so4247114qtp.8;
        Wed, 13 Feb 2019 12:30:56 -0800 (PST)
X-Gm-Message-State: AHQUAuYDthoRIPTP3G0KtMwx0tXU8y5aEf9RCLjOjc8YdpqgihBc5K1E
        YAa+WaT/N4BJ+2qGoIAJdagBbQUUYqr9KJcWsw==
X-Google-Smtp-Source: AHgI3IYDsIV8gTq8dUSUUAkiMlLS2SxXjOHRPPmNGLGKRJlHu6sXFFA1tGRjrdTJ1JIz7axkPgP2sB0zAO89lDBDtRk=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr17703qvq.106.1550089855282;
 Wed, 13 Feb 2019 12:30:55 -0800 (PST)
MIME-Version: 1.0
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1548245116-6360-3-git-send-email-liaoweixiong@allwinnertech.com>
 <20190130160707.GA31844@bogus> <ab72f73d-b7ea-4688-f768-509d55964be0@allwinnertech.com>
In-Reply-To: <ab72f73d-b7ea-4688-f768-509d55964be0@allwinnertech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Feb 2019 14:30:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qmBrXVLoD8FzgB589xET3isnqMsAxRiJJDvQyu+ZfiQ@mail.gmail.com>
Message-ID: <CAL_Jsq+qmBrXVLoD8FzgB589xET3isnqMsAxRiJJDvQyu+ZfiQ@mail.gmail.com>
Subject: Re: [RFC v7 2/5] dt-bindings: pstore-block: new support for blkoops
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 7:51 AM liaoweixiong
<liaoweixiong@allwinnertech.com> wrote:
>
>
> On 2019-01-31 00:07, Rob Herring wrote:> On Wed, Jan 23, 2019 at
> 08:05:13PM +0800, liaoweixiong wrote:
> >> Create DT binding document for blkoops.
> >>
> >> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> >> ---
> >>  .../devicetree/bindings/pstore-block/blkoops.txt   | 32 ++++++++++++++++++++++
> >
> > /bindings/pstore/...
> >
> > I wouldn't call it blkoops either. I believe ramoops is called that to
> > maintain compatibility keeping the same kernel module name that
> > preceeded pstore.
> >
>
> Fixed.
>
> In addition, I don't known whether should we move
> ramreserved-memory/ooos.txt to /bindings/pstore. This is for maintainer
> to decide, and do it on other patch.
>
> >>  MAINTAINERS                                        |  1 +
> >>  2 files changed, 33 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pstore-block/blkoops.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/pstore-block/blkoops.txt b/Documentation/devicetree/bindings/pstore-block/blkoops.txt
> >> new file mode 100644
> >> index 0000000..a25835b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pstore-block/blkoops.txt
> >> @@ -0,0 +1,32 @@
> >> +Blkoops oops logger
> >> +===================
> >> +
> >> +Blkoops provides a block partition for oops, excluding panics now, so they can
> >> +be recovered after a reboot.
> >> +
> >> +Any space of block partition will be used for a circular buffer of oops records.
> >> +These records have a configurable size, with a size of 0 indicating that they
> >> +should be disabled.
> >> +
> >> +"partition-size" and at least one of "dmesg-size" or "pmsg-size" must be set
> >> +non-zero, but are otherwise optional as listed below.
> >> +
> >> +Blkoops will take value from Kconfig if device tree do not set, but settings
> >> +from module parameters can also overwrite them.
> >
> > That's all kernel details not relevant to the binidng.
> >
>
> Deleted.
>
> >> +
> >> +Required properties:
> >> +
> >> +- compatible: must be "blkoops".
> >> +
> >> +- partition-size: size in kbytes, must be a multiple of 4.
> >
> > This seems unnecessary given a partition has a known size.
> >
>
> partition-size is necessary for psotre/blk. User should tell pstore/blk
> how large space can it use.

The partition table says how big a partition is. If you only want to
use part of it, then make the partition smaller or use a file system.
This is a solved problem, so we don't need a new way in DT to handle
this.

> >> +Optional properties:
> >> +
> >> +- partition-path: strings must begin with "/dev", tell blkoops which partition
> >> +  it can used. If it is not set, blkoops will drop all data when reboot.
> >
> > No. '/dev/...' is a Linux thing and doesn't belong in DT.
> >
> > You should define a partition UUID and/or label and the kernel can find
> > the right partition to use.
> >
>
> pstore/blk do general read/write by filp_open/kernel_read/kernel_write,
> which need device path.
> In addition, i have no idea how to use UUID and/or label to do general
> read/write on kernel layer, can you give me a tip?

The kernel can mount a filesystem by label or UUID though I think
those are filesystem UUID and label, not partition UUID and label. But
certainly bootloaders find the EFI system partition by UUID.

Rob
