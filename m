Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47203217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550504291;
	bh=fiufsnkwY5Ye4dpDt8/DYHb+fwDhNY9kEFnPVmnu3VE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wikvN+pfkpgG3bci53/1zlm2DU/z/M7nTOlRgfLpWu+693wpr4n8FG/JQryunPZmy
	 9rhe0i0wLLRl9VTvOm86UcKsINNczBr290QVZDlrKOFc+dwub9eN/ceERDsR/lV7RJ
	 A4dLKDyaR5/FMBaNlT8F/xCeXSpkOgyFh96SDHrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfBRPiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfBRPiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:38:09 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B910B21903;
        Mon, 18 Feb 2019 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550504287;
        bh=fiufsnkwY5Ye4dpDt8/DYHb+fwDhNY9kEFnPVmnu3VE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A/PjcJi1jy1g94rV79HjZoSMrTGSLyjIliFsLBaTaToOWpmVR2I7z2D7bUKX+r1y/
         80XehwGmyYgaZ4V/833rwTUH3VGMAXeDWezG7kLQrIvdRyOt227HbrnznjkbVfEHN+
         STV8IBKEBzMrXmH12OvdjaYYqLi1ozs3ksaUsrqw=
Received: by mail-qt1-f173.google.com with SMTP id w4so19671957qtc.1;
        Mon, 18 Feb 2019 07:38:07 -0800 (PST)
X-Gm-Message-State: AHQUAuZejNN+In/YMD32+JpbEj9+AIfCJFrvj+T5K10v1FbRNbC1FVJm
        PUMGbTeLqXSPEtzAff6twH3SZ2MePZNG/IlbeA==
X-Google-Smtp-Source: AHgI3IYKU6ukv4jBX4zyVcCE9E7JRZw9XP9TLmPNv+NYcRDI3XG+wkgyqS+0oF9LeOMPlr1yinrImnw2OMPsSCP3eb4=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr17493506qve.246.1550504286830;
 Mon, 18 Feb 2019 07:38:06 -0800 (PST)
MIME-Version: 1.0
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1548245116-6360-3-git-send-email-liaoweixiong@allwinnertech.com>
 <20190130160707.GA31844@bogus> <ab72f73d-b7ea-4688-f768-509d55964be0@allwinnertech.com>
 <CAL_Jsq+qmBrXVLoD8FzgB589xET3isnqMsAxRiJJDvQyu+ZfiQ@mail.gmail.com> <d94eb644-d99a-1f9d-af06-a6e9ec3e3959@allwinnertech.com>
In-Reply-To: <d94eb644-d99a-1f9d-af06-a6e9ec3e3959@allwinnertech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 18 Feb 2019 09:37:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zZyBcnQn-SzK+u-7BacD5kuqk9WJKqT9V3L20TPAbVw@mail.gmail.com>
Message-ID: <CAL_Jsq+zZyBcnQn-SzK+u-7BacD5kuqk9WJKqT9V3L20TPAbVw@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 7:06 PM liaoweixiong
<liaoweixiong@allwinnertech.com> wrote:
>
> On 2019-02-14 04:30, Rob Herring wrote:
> > On Wed, Feb 13, 2019 at 7:51 AM liaoweixiong
> > <liaoweixiong@allwinnertech.com> wrote:
> >>
> >>
> >> On 2019-01-31 00:07, Rob Herring wrote:> On Wed, Jan 23, 2019 at
> >> 08:05:13PM +0800, liaoweixiong wrote:
> >>>> Create DT binding document for blkoops.
> >>>>
> >>>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> >>>> ---
> >>>>  .../devicetree/bindings/pstore-block/blkoops.txt   | 32 ++++++++++++++++++++++
> >>>
> >>> /bindings/pstore/...
> >>>
> >>> I wouldn't call it blkoops either. I believe ramoops is called that to
> >>> maintain compatibility keeping the same kernel module name that
> >>> preceeded pstore.
> >>>
> >>
> >> Fixed.
> >>
> >> In addition, I don't known whether should we move
> >> ramreserved-memory/ooos.txt to /bindings/pstore. This is for maintainer
> >> to decide, and do it on other patch.
> >>
> >>>>  MAINTAINERS                                        |  1 +
> >>>>  2 files changed, 33 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/pstore-block/blkoops.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pstore-block/blkoops.txt b/Documentation/devicetree/bindings/pstore-block/blkoops.txt
> >>>> new file mode 100644
> >>>> index 0000000..a25835b
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/pstore-block/blkoops.txt
> >>>> @@ -0,0 +1,32 @@
> >>>> +Blkoops oops logger
> >>>> +===================
> >>>> +
> >>>> +Blkoops provides a block partition for oops, excluding panics now, so they can
> >>>> +be recovered after a reboot.
> >>>> +
> >>>> +Any space of block partition will be used for a circular buffer of oops records.
> >>>> +These records have a configurable size, with a size of 0 indicating that they
> >>>> +should be disabled.
> >>>> +
> >>>> +"partition-size" and at least one of "dmesg-size" or "pmsg-size" must be set
> >>>> +non-zero, but are otherwise optional as listed below.
> >>>> +
> >>>> +Blkoops will take value from Kconfig if device tree do not set, but settings
> >>>> +from module parameters can also overwrite them.
> >>>
> >>> That's all kernel details not relevant to the binidng.
> >>>
> >>
> >> Deleted.
> >>
> >>>> +
> >>>> +Required properties:
> >>>> +
> >>>> +- compatible: must be "blkoops".
> >>>> +
> >>>> +- partition-size: size in kbytes, must be a multiple of 4.
> >>>
> >>> This seems unnecessary given a partition has a known size.
> >>>
> >>
> >> partition-size is necessary for psotre/blk. User should tell pstore/blk
> >> how large space can it use.
> >
> > The partition table says how big a partition is. If you only want to
> > use part of it, then make the partition smaller or use a file system.
> > This is a solved problem, so we don't need a new way in DT to handle
> > this.
> >
>
> You are right, partition size is known and pstore/blk can get it
> automatically from specified block device. I will try to do it on next
> version patch.
> But i prefer to rename partition-size to total-size and move it to
> optional properties. Total-size means how big space pstore/blk can use.
> It is not only about partition size as pstore/blk can use ram if no
> partition specified.
> So, I will process as follow logic:
> 1. If specify total size, use total size.
> 2. If no total size but specify partition, get size from partition.

You haven't given any reason why we need to support this.

> >>>> +Optional properties:
> >>>> +
> >>>> +- partition-path: strings must begin with "/dev", tell blkoops which partition
> >>>> +  it can used. If it is not set, blkoops will drop all data when reboot.
> >>>
> >>> No. '/dev/...' is a Linux thing and doesn't belong in DT.
> >>>
> >>> You should define a partition UUID and/or label and the kernel can find
> >>> the right partition to use.
> >>>
> >>
> >> pstore/blk do general read/write by filp_open/kernel_read/kernel_write,
> >> which need device path.
> >> In addition, i have no idea how to use UUID and/or label to do general
> >> read/write on kernel layer, can you give me a tip?
> >
> > The kernel can mount a filesystem by label or UUID though I think
> > those are filesystem UUID and label, not partition UUID and label. But
> > certainly bootloaders find the EFI system partition by UUID.
> >
>
> As your words, those are file system UUID and label, not partition
> UUID/label.

Actually, looking at do_mounts.c, it is the partition UUID and label.
See PARTUUID and PARTLABEL.

> Pstore is a file system, there is no other file system any
> more for specified partition. Pstore/blk can't get specified partition
> by UUID or label.
>
> As far as i know, block device manager on user space scans each block
> device and matches file system table to get UUID and label. Not even all
> file systems have UUID/label.

Yes, userspace has more capabilities for mounting.

> MTD device may has label, but it is not suitable for all block device.

MTD is special...

> How if i cancel the prefix requirement for /dev and add it to the codes?
> Then rename partition-path to block-device, by this, DT property may be
> "mmcblk0p10" or "sda6" .

There is simply no way we are putting Linux device names into DT.
Besides just being Linux specific, the device names are not guaranteed
to be stable.

Rob
