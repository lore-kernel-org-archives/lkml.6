Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5F620C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz/f8M4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F620C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbeHOTZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbeHOTZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:25:31 -0400
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18EF320C09;
        Wed, 15 Aug 2018 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534350760;
        bh=KxW+oaviKll9FejvCzi6IW/yOe2jA9/vUvfZhHNpgE0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nz/f8M4LYtE4mJur3H/R76UzwT4Sn7GPHgNs8E+1A1MpLVYKzGF+FLlHBZa/BYeex
         FvMs4Jd26J+7MIHDPLJ74GbdD6yrsxRjbsMXxD9zxRjf8cYyJTuzGoq9yI1zGLtdCb
         1IA5iOaKsHzAa+FXVXSj+RHZQJNO5nOEH8e60TFY=
Received: by mail-yw1-f44.google.com with SMTP id r3-v6so1251416ywc.5;
        Wed, 15 Aug 2018 09:32:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlE2CW2SorWxqRIFKzE2PbqnUpFt0GEII6Ksg+xs4pNcG9/uVjth
        4VZjBZKwH9t04ruCChtdqTosV7EX8E5Glf/U26U=
X-Google-Smtp-Source: AA+uWPxnZozumNX0SnzBs3SigEIMjrjfP5QOlk2KqD+C7yghLEhiJy/U+o3vY6OmZrRBK465Aieah2jKmPmzZ9l5WMA=
X-Received: by 2002:a0d:e64f:: with SMTP id p76-v6mr15124558ywe.483.1534350759208;
 Wed, 15 Aug 2018 09:32:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81cc:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 09:31:58
 -0700 (PDT)
In-Reply-To: <ae18c3c0-6ba4-7e9f-9f94-0f8b7cdc8156@infradead.org>
References: <20180814191526.3247-1-atull@kernel.org> <20180814191526.3247-9-atull@kernel.org>
 <ae18c3c0-6ba4-7e9f-9f94-0f8b7cdc8156@infradead.org>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 15 Aug 2018 11:31:58 -0500
X-Gmail-Original-Message-ID: <CANk1AXSo98Es+tCEx4CPAs=Hg=m6-Q2vAeq0zJBd8XzRs4jf+A@mail.gmail.com>
Message-ID: <CANk1AXSo98Es+tCEx4CPAs=Hg=m6-Q2vAeq0zJBd8XzRs4jf+A@mail.gmail.com>
Subject: Re: [PATCH 8/8] docs: fpga: document programming fpgas using regions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 9:40 PM, Randy Dunlap <rdunlap@infradead.org> wrote=
:

Hi Randy,

> On 08/14/2018 12:15 PM, Alan Tull wrote:
>> Clarify the intention that interfaces and upper layers use
>> regions rather than managers directly.
>>
>> Rearrange API documentation to better group the API functions
>> used to create FPGA mgr/bridge/regions and the API used for
>> programming FPGAs.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>>  Documentation/driver-api/fpga/fpga-bridge.rst      |  38 ++-----
>>  Documentation/driver-api/fpga/fpga-mgr.rst         | 117 ++------------=
-------
>>  Documentation/driver-api/fpga/fpga-programming.rst | 103 ++++++++++++++=
++++
>>  Documentation/driver-api/fpga/fpga-region.rst      |  92 ++++++++------=
--
>>  Documentation/driver-api/fpga/index.rst            |   2 +
>>  5 files changed, 166 insertions(+), 186 deletions(-)
>>  create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst
>>
>
> Hi,
> A few comments below...
>
>
>> diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Docume=
ntation/driver-api/fpga/fpga-programming.rst
>> new file mode 100644
>> index 0000000..cc34d17
>> --- /dev/null
>> +++ b/Documentation/driver-api/fpga/fpga-programming.rst
>> @@ -0,0 +1,103 @@
>> +In-kernel API for FPGA Programming
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Overview
>> +--------
>> +
>> +The in-kernel API for FPGA programming is a combination of APIs from
>> +FPGA manager, bridge, and regions.  The actual function used to
>> +trigger FPGA programming is :c:func:`fpga_region_program_fpga()`.
>> +
>> +:c:func:`fpga_region_program_fpga()` uses functionality supplied by
>> +the FPGA manager and bridges.  It will:
>> +
>> + * lock the region's mutex
>> + * lock the mutex of the region's FPGA manager
>> + * build a list of FPGA bridges if a method has been specified to do so
>> + * disable the bridges
>> + * program the FPGA using info passed in :c:member:`fpga_region->info`.
>> + * re-enable the bridges
>> + * release the locks
>> +
>> +The struct fpga_image_info specifies what FPGA image to program.  It is=
 allocated/freed by :c:func:`fpga_image_info_alloc()` and freed with :c:fun=
c:`fpga_image_info_free()`
>> +
>> +How to program an FPGA using a region
>> +-------------------------------------
>> +
>> +When the FPGA region driver probed, it was given a pointer to a FPGA ma=
nager
>
>                                                               to an FPGA

Yes

>
>> +driver so it knows which manager to use.  The region also either has a =
list of
>> +bridges to control during programming or it has a pointer to a function=
 that
>> +will generate that list.  Here's some sample code of what to do next::
>> +
>> +     #include <linux/fpga/fpga-mgr.h>
>> +     #include <linux/fpga/fpga-region.h>
>> +
>> +     struct fpga_image_info *info;
>> +     int ret;
>> +
>> +     /*
>> +      * First, alloc the struct with information about the FPGA image t=
o
>> +      * program.
>> +      */
>> +     info =3D fpga_image_info_alloc(dev);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     /* Set flags as needed, such as: */
>> +     info->flags =3D FPGA_MGR_PARTIAL_RECONFIG;
>> +
>> +     /*
>> +      * Indicate where the FPGA image is. This is pseudo-code; you're
>> +      * going to use one of these three.
>> +      */
>> +     if (image is in a scatter gather table) {
>> +
>> +             info->sgt =3D [your scatter gather table]
>> +
>> +     } else if (image is in a buffer) {
>> +
>> +             info->buf =3D [your image buffer]
>> +             info->count =3D [image buffer size]
>> +
>> +     } else if (image is in a firmware file) {
>> +
>> +             info->firmware_name =3D devm_kstrdup(dev, firmware_name,
>> +                                                GFP_KERNEL);
>> +
>> +     }
>> +
>> +     /* Add info to region and do the programming */
>> +     region->info =3D info;
>> +     ret =3D fpga_region_program_fpga(region);
>> +     if (ret)
>> +             return ret;
>> +
>
> always deallocate and then do:
>         if (ret)
>                 return ret;
> ?

Yep, I'll fix it.

>
>> +     /* Deallocate the image info if you're done with it */
>> +     fpga_image_info_free(info);
>> +
>> +     /* Now enumerate whatever hardware has appeared in the FPGA. */
>> +
>> +API for programming an FPGA
>> +---------------------------
>> +
>> +* :c:func:`fpga_region_program_fpga` =E2=80=94  Program a FPGA
>> +* :c:type:`fpga_image_info` =E2=80=94  Specifies what FPGA image to pro=
gram
>> +* :c:func:`fpga_image_info_alloc()` =E2=80=94  Allocate a FPGA image in=
fo struct
>> +* :c:func:`fpga_image_info_free()` =E2=80=94  Free a FPGA image info st=
ruct
>> +
>> +.. kernel-doc:: drivers/fpga/fpga-region.c
>> +   :functions: fpga_region_program_fpga
>> +
>> +FPGA Manager flags
>> +
>> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
>> +   :doc: FPGA Manager flags
>> +
>> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
>> +   :functions: fpga_image_info
>> +
>> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
>> +   :functions: fpga_image_info_alloc
>> +
>> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
>> +   :functions: fpga_image_info_free
>
> [snip]
>
>>  API to add a new FPGA region
>>  ----------------------------
>>
>> +* struct :c:type:`fpga_region` =E2=80=94 The FPGA region struct
>> +* :c:func:`devm_fpga_region_create` =E2=80=94 Allocate and init a regio=
n struct
>> +* :c:func:`fpga_region_register` =E2=80=94  Register a FPGA region
>
>                                                 an FPGA
>
>> +* :c:func:`fpga_region_unregister` =E2=80=94  Unregister a FPGA region
>
>                                                     an FPGA
>
>> +
>> +The FPGA region's probe function will need to get a reference to the FP=
GA
>> +Manager it will be using to do the programming.  This usually would hap=
pen
>> +during the region's probe function.
>> +
>> +* :c:func:`fpga_mgr_get` =E2=80=94 Get a reference to a FPGA manager, r=
aise ref count
>
>                                                  an FPGA
>
>> +* :c:func:`of_fpga_mgr_get` =E2=80=94  Get a reference to a FPGA manage=
r, raise ref count,
>
>                                                      an FPGA
>
>> +  given a device node.
>> +* :c:func:`fpga_mgr_put` =E2=80=94 Put a FPGA manager
>
>                                   an FPGA

I'll fix these too; I'll go through this folder and s/a FPGA/an FPGA/g

>
>> +
>> +The FPGA region will need to specify which bridges to control while pro=
gramming
>> +the FPGA.  The region driver can build a list of bridges during probe t=
ime
>> +(:c:member:`fpga_region->bridge_list`) or it can have a function that c=
reates
>> +the list of bridges to program just before programming
>> +(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supp=
lies the
>> +following APIs to handle building or tearing down that list.
>> +
>> +* :c:func:`fpga_bridge_get_to_list` =E2=80=94 Get a ref of a FPGA bridg=
e, add it to a
>> +  list
>> +* :c:func:`of_fpga_bridge_get_to_list` =E2=80=94 Get a ref of a FPGA br=
idge, add it to a
>> +  list, given a device node
>> +* :c:func:`fpga_bridges_put` =E2=80=94 Given a list of bridges, put the=
m
>> +
>>  .. kernel-doc:: include/linux/fpga/fpga-region.h
>>     :functions: fpga_region
>>
>
>
>
> --
> ~Randy

Thanks for the review!

Alan
