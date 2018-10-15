Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A551C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21BB208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PegXvAu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21BB208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJPD6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:58:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38609 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeJPD6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:58:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so23025151qtf.5;
        Mon, 15 Oct 2018 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AlfY25v+18voL78ThbYJmBm+nHyy/C8e+MCv1H06SHo=;
        b=PegXvAu5Jnv5KBqM056DS0+bGkmdGFFD10vknlorRKOaP06Yy1N4aJeXr+57BCDpXG
         c+UYEcYP7eyh861I/aNTpHYruMCzhvkAL/aoMhwgcWE3HIp0tWFLie+ZGBxPo8UVTt2R
         0X6lXuuNT1sUfc0gsTvOQfdoGlUv+kzKmLNq/bl0hmio3vXiZ0etP4YgfFZDKF22i4nD
         ULnKyU2xt57kOEwmIZyIAbln2yfBp8GGSsG2dFUEwSt5GSXelD6rYRNNkrxw9WW6S8WF
         N8b8hYMCwsElfZ5m0zChhVh3nUT5BXP3wdBSdrwaT4PqMOA4T5TTtmj/mtuuPgirOlJz
         66Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AlfY25v+18voL78ThbYJmBm+nHyy/C8e+MCv1H06SHo=;
        b=CIcomPUogVS7MuEjUCM/LPTDklZUN9q1JaG/ZIvrvt/+0JXIRPDvKltXH9DFgB2En0
         xwC402UVci/yJ+NeDfLwbpsG5C3knppX0Kltjm2k8AMYyNJENqfdbE/XCo7vm2vkTEdj
         4pVaj10BN90UKIIloqC1m0VUaLegaXR63/yQoZ4SSPLe3YMugzSz1HXeKVX1XzmIi7dx
         Si83DotdiPHSWtb2EwdQykIM9B3N6/6HRJOqblHkEpCOneDTqCVVa18qzLsqI8E3zwbM
         MY+PhBVKiYnRlit83wI8ITb4P6aXdk4cWP2Sbn/B1eDVqFgZZdhIU7YdLFyrqs8Vx70W
         v8mQ==
X-Gm-Message-State: ABuFfojDdVDNVOAY8J3pYUMnrBP7sgTlHlUvcOB19pejJLlpgBxY7oie
        KAf54PLHbRd7Yf/YSIfVcoO0Nw6xV1+DvmsV1jU=
X-Google-Smtp-Source: ACcGV60StL/ft65PREkfOOvfSEKyJSZN0x8xoa+oOZ9CskpIc3qToZjLPsfwvAMBvBrqn76InnVPvY7WyJQUXOEpZyU=
X-Received: by 2002:ac8:3026:: with SMTP id f35-v6mr17315288qte.45.1539634293582;
 Mon, 15 Oct 2018 13:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1537978342-17697-1-git-send-email-atull@kernel.org> <1537978342-17697-5-git-send-email-atull@kernel.org>
In-Reply-To: <1537978342-17697-5-git-send-email-atull@kernel.org>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Mon, 15 Oct 2018 13:11:22 -0700
Message-ID: <CAJYdmeNdBbJBVGjLkk03PpGERA2j=D__BVsb9_FBXwWFkMXR_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] docs: fpga: document programming fpgas using regions
To:     Alan Tull <atull@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:12 AM Alan Tull <atull@kernel.org> wrote:
>
> Clarify the intention that interfaces and upper layers use
> regions rather than managers directly.
>
> Rearrange API documentation to better group the API functions
> used to create FPGA mgr/bridge/regions and the API used for
> programming FPGAs.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Suggested-by: Federico Vaga <federico.vaga@cern.ch>

Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: Add suggested-by
>     s/a FPGA/an FPGA/
>     document freeing the fpga_mgr_info on success path
>     minor formatting fixes and suggested edits
> v3: no changes
> ---
>  Documentation/driver-api/fpga/fpga-bridge.rst      |  38 ++-----
>  Documentation/driver-api/fpga/fpga-mgr.rst         | 117 ++-------------=
------
>  Documentation/driver-api/fpga/fpga-programming.rst | 107 +++++++++++++++=
++++
>  Documentation/driver-api/fpga/fpga-region.rst      |  92 ++++++++-------=
-
>  Documentation/driver-api/fpga/index.rst            |   2 +
>  Documentation/driver-api/fpga/intro.rst            |   2 +-
>  6 files changed, 171 insertions(+), 187 deletions(-)
>  create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst
>
> diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentatio=
n/driver-api/fpga/fpga-bridge.rst
> index ebbcbde..71c5a40 100644
> --- a/Documentation/driver-api/fpga/fpga-bridge.rst
> +++ b/Documentation/driver-api/fpga/fpga-bridge.rst
> @@ -4,6 +4,12 @@ FPGA Bridge
>  API to implement a new FPGA bridge
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> +* struct :c:type:`fpga_bridge` =E2=80=94 The FPGA Bridge structure
> +* struct :c:type:`fpga_bridge_ops` =E2=80=94 Low level Bridge driver ops
> +* :c:func:`devm_fpga_bridge_create()` =E2=80=94 Allocate and init a brid=
ge struct
> +* :c:func:`fpga_bridge_register()` =E2=80=94 Register a bridge
> +* :c:func:`fpga_bridge_unregister()` =E2=80=94 Unregister a bridge
> +
>  .. kernel-doc:: include/linux/fpga/fpga-bridge.h
>     :functions: fpga_bridge
>
> @@ -14,39 +20,7 @@ API to implement a new FPGA bridge
>     :functions: devm_fpga_bridge_create
>
>  .. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_create
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_free
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
>     :functions: fpga_bridge_register
>
>  .. kernel-doc:: drivers/fpga/fpga-bridge.c
>     :functions: fpga_bridge_unregister
> -
> -API to control an FPGA bridge
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -You probably won't need these directly.  FPGA regions should handle this=
.
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: of_fpga_bridge_get
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_get
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_put
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_get_to_list
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: of_fpga_bridge_get_to_list
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_enable
> -
> -.. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_disable
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/d=
river-api/fpga/fpga-mgr.rst
> index db8885e..576f194 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -98,67 +98,19 @@ The ops include a .state function which will determin=
e the state the FPGA is in
>  and return a code of type enum fpga_mgr_states.  It doesn't result in a =
change
>  in state.
>
> -How to write an image buffer to a supported FPGA
> -------------------------------------------------
> -
> -Some sample code::
> -
> -       #include <linux/fpga/fpga-mgr.h>
> -
> -       struct fpga_manager *mgr;
> -       struct fpga_image_info *info;
> -       int ret;
> -
> -       /*
> -        * Get a reference to FPGA manager.  The manager is not locked, s=
o you can
> -        * hold onto this reference without it preventing programming.
> -        *
> -        * This example uses the device node of the manager.  Alternative=
ly, use
> -        * fpga_mgr_get(dev) instead if you have the device.
> -        */
> -       mgr =3D of_fpga_mgr_get(mgr_node);
> -
> -       /* struct with information about the FPGA image to program. */
> -       info =3D fpga_image_info_alloc(dev);
> -
> -       /* flags indicates whether to do full or partial reconfiguration =
*/
> -       info->flags =3D FPGA_MGR_PARTIAL_RECONFIG;
> -
> -       /*
> -        * At this point, indicate where the image is. This is pseudo-cod=
e; you're
> -        * going to use one of these three.
> -        */
> -       if (image is in a scatter gather table) {
> -
> -               info->sgt =3D [your scatter gather table]
> -
> -       } else if (image is in a buffer) {
> -
> -               info->buf =3D [your image buffer]
> -               info->count =3D [image buffer size]
> -
> -       } else if (image is in a firmware file) {
> -
> -               info->firmware_name =3D devm_kstrdup(dev, firmware_name, =
GFP_KERNEL);
> -
> -       }
> -
> -       /* Get exclusive control of FPGA manager */
> -       ret =3D fpga_mgr_lock(mgr);
> -
> -       /* Load the buffer to the FPGA */
> -       ret =3D fpga_mgr_buf_load(mgr, &info, buf, count);
> -
> -       /* Release the FPGA manager */
> -       fpga_mgr_unlock(mgr);
> -       fpga_mgr_put(mgr);
> -
> -       /* Deallocate the image info if you're done with it */
> -       fpga_image_info_free(info);
> -
>  API for implementing a new FPGA Manager driver
>  ----------------------------------------------
>
> +* ``fpga_mgr_states`` =E2=80=94  Values for :c:member:`fpga_manager->sta=
te`.
> +* struct :c:type:`fpga_manager` =E2=80=94  the FPGA manager struct
> +* struct :c:type:`fpga_manager_ops` =E2=80=94  Low level FPGA manager dr=
iver ops
> +* :c:func:`devm_fpga_mgr_create` =E2=80=94  Allocate and init a manager =
struct
> +* :c:func:`fpga_mgr_register` =E2=80=94  Register an FPGA manager
> +* :c:func:`fpga_mgr_unregister` =E2=80=94  Unregister an FPGA manager
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :functions: fpga_mgr_states
> +
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
>     :functions: fpga_manager
>
> @@ -169,56 +121,7 @@ API for implementing a new FPGA Manager driver
>     :functions: devm_fpga_mgr_create
>
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_create
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_free
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
>     :functions: fpga_mgr_register
>
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
>     :functions: fpga_mgr_unregister
> -
> -API for programming an FPGA
> ----------------------------
> -
> -FPGA Manager flags
> -
> -.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> -   :doc: FPGA Manager flags
> -
> -.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> -   :functions: fpga_image_info
> -
> -.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> -   :functions: fpga_mgr_states
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_image_info_alloc
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_image_info_free
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: of_fpga_mgr_get
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_get
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_put
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_lock
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_unlock
> -
> -.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> -   :functions: fpga_mgr_states
> -
> -Note - use :c:func:`fpga_region_program_fpga()` instead of :c:func:`fpga=
_mgr_load()`
> -
> -.. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_load
> diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documen=
tation/driver-api/fpga/fpga-programming.rst
> new file mode 100644
> index 0000000..b5484df
> --- /dev/null
> +++ b/Documentation/driver-api/fpga/fpga-programming.rst
> @@ -0,0 +1,107 @@
> +In-kernel API for FPGA Programming
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +The in-kernel API for FPGA programming is a combination of APIs from
> +FPGA manager, bridge, and regions.  The actual function used to
> +trigger FPGA programming is :c:func:`fpga_region_program_fpga()`.
> +
> +:c:func:`fpga_region_program_fpga()` uses functionality supplied by
> +the FPGA manager and bridges.  It will:
> +
> + * lock the region's mutex
> + * lock the mutex of the region's FPGA manager
> + * build a list of FPGA bridges if a method has been specified to do so
> + * disable the bridges
> + * program the FPGA using info passed in :c:member:`fpga_region->info`.
> + * re-enable the bridges
> + * release the locks
> +
> +The struct fpga_image_info specifies what FPGA image to program.  It is
> +allocated/freed by :c:func:`fpga_image_info_alloc()` and freed with
> +:c:func:`fpga_image_info_free()`
> +
> +How to program an FPGA using a region
> +-------------------------------------
> +
> +When the FPGA region driver probed, it was given a pointer to an FPGA ma=
nager
> +driver so it knows which manager to use.  The region also either has a l=
ist of
> +bridges to control during programming or it has a pointer to a function =
that
> +will generate that list.  Here's some sample code of what to do next::
> +
> +       #include <linux/fpga/fpga-mgr.h>
> +       #include <linux/fpga/fpga-region.h>
> +
> +       struct fpga_image_info *info;
> +       int ret;
> +
> +       /*
> +        * First, alloc the struct with information about the FPGA image =
to
> +        * program.
> +        */
> +       info =3D fpga_image_info_alloc(dev);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       /* Set flags as needed, such as: */
> +       info->flags =3D FPGA_MGR_PARTIAL_RECONFIG;
> +
> +       /*
> +        * Indicate where the FPGA image is. This is pseudo-code; you're
> +        * going to use one of these three.
> +        */
> +       if (image is in a scatter gather table) {
> +
> +               info->sgt =3D [your scatter gather table]
> +
> +       } else if (image is in a buffer) {
> +
> +               info->buf =3D [your image buffer]
> +               info->count =3D [image buffer size]
> +
> +       } else if (image is in a firmware file) {
> +
> +               info->firmware_name =3D devm_kstrdup(dev, firmware_name,
> +                                                  GFP_KERNEL);
> +
> +       }
> +
> +       /* Add info to region and do the programming */
> +       region->info =3D info;
> +       ret =3D fpga_region_program_fpga(region);
> +
> +       /* Deallocate the image info if you're done with it */
> +       region->info =3D NULL;
> +       fpga_image_info_free(info);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Now enumerate whatever hardware has appeared in the FPGA. */
> +
> +API for programming an FPGA
> +---------------------------
> +
> +* :c:func:`fpga_region_program_fpga` =E2=80=94  Program an FPGA
> +* :c:type:`fpga_image_info` =E2=80=94  Specifies what FPGA image to prog=
ram
> +* :c:func:`fpga_image_info_alloc()` =E2=80=94  Allocate an FPGA image in=
fo struct
> +* :c:func:`fpga_image_info_free()` =E2=80=94  Free an FPGA image info st=
ruct
> +
> +.. kernel-doc:: drivers/fpga/fpga-region.c
> +   :functions: fpga_region_program_fpga
> +
> +FPGA Manager flags
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :doc: FPGA Manager flags
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :functions: fpga_image_info
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: fpga_image_info_alloc
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: fpga_image_info_free
> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentatio=
n/driver-api/fpga/fpga-region.rst
> index dc9f75c..0529b2d 100644
> --- a/Documentation/driver-api/fpga/fpga-region.rst
> +++ b/Documentation/driver-api/fpga/fpga-region.rst
> @@ -34,41 +34,6 @@ fpga_image_info including:
>   * flags indicating specifics such as whether the image is for partial
>     reconfiguration.
>
> -How to program an FPGA using a region
> --------------------------------------
> -
> -First, allocate the info struct::
> -
> -       info =3D fpga_image_info_alloc(dev);
> -       if (!info)
> -               return -ENOMEM;
> -
> -Set flags as needed, i.e.::
> -
> -       info->flags |=3D FPGA_MGR_PARTIAL_RECONFIG;
> -
> -Point to your FPGA image, such as::
> -
> -       info->sgt =3D &sgt;
> -
> -Add info to region and do the programming::
> -
> -       region->info =3D info;
> -       ret =3D fpga_region_program_fpga(region);
> -
> -:c:func:`fpga_region_program_fpga()` operates on info passed in the
> -fpga_image_info (region->info).  This function will attempt to:
> -
> - * lock the region's mutex
> - * lock the region's FPGA manager
> - * build a list of FPGA bridges if a method has been specified to do so
> - * disable the bridges
> - * program the FPGA
> - * re-enable the bridges
> - * release the locks
> -
> -Then you will want to enumerate whatever hardware has appeared in the FP=
GA.
> -
>  How to add a new FPGA region
>  ----------------------------
>
> @@ -77,15 +42,36 @@ An example of usage can be seen in the probe function=
 of [#f2]_.
>  .. [#f1] ../devicetree/bindings/fpga/fpga-region.txt
>  .. [#f2] ../../drivers/fpga/of-fpga-region.c
>
> -API to program an FPGA
> -----------------------
> -
> -.. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_program_fpga
> -
>  API to add a new FPGA region
>  ----------------------------
>
> +* struct :c:type:`fpga_region` =E2=80=94 The FPGA region struct
> +* :c:func:`devm_fpga_region_create` =E2=80=94 Allocate and init a region=
 struct
> +* :c:func:`fpga_region_register` =E2=80=94  Register an FPGA region
> +* :c:func:`fpga_region_unregister` =E2=80=94  Unregister an FPGA region
> +
> +The FPGA region's probe function will need to get a reference to the FPG=
A
> +Manager it will be using to do the programming.  This usually would happ=
en
> +during the region's probe function.
> +
> +* :c:func:`fpga_mgr_get` =E2=80=94 Get a reference to an FPGA manager, r=
aise ref count
> +* :c:func:`of_fpga_mgr_get` =E2=80=94  Get a reference to an FPGA manage=
r, raise ref count,
> +  given a device node.
> +* :c:func:`fpga_mgr_put` =E2=80=94 Put an FPGA manager
> +
> +The FPGA region will need to specify which bridges to control while prog=
ramming
> +the FPGA.  The region driver can build a list of bridges during probe ti=
me
> +(:c:member:`fpga_region->bridge_list`) or it can have a function that cr=
eates
> +the list of bridges to program just before programming
> +(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework suppl=
ies the
> +following APIs to handle building or tearing down that list.
> +
> +* :c:func:`fpga_bridge_get_to_list` =E2=80=94 Get a ref of an FPGA bridg=
e, add it to a
> +  list
> +* :c:func:`of_fpga_bridge_get_to_list` =E2=80=94 Get a ref of an FPGA br=
idge, add it to a
> +  list, given a device node
> +* :c:func:`fpga_bridges_put` =E2=80=94 Given a list of bridges, put them
> +
>  .. kernel-doc:: include/linux/fpga/fpga-region.h
>     :functions: fpga_region
>
> @@ -93,13 +79,25 @@ API to add a new FPGA region
>     :functions: devm_fpga_region_create
>
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_create
> -
> -.. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_free
> -
> -.. kernel-doc:: drivers/fpga/fpga-region.c
>     :functions: fpga_region_register
>
>  .. kernel-doc:: drivers/fpga/fpga-region.c
>     :functions: fpga_region_unregister
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: fpga_mgr_get
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: of_fpga_mgr_get
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: fpga_mgr_put
> +
> +.. kernel-doc:: drivers/fpga/fpga-bridge.c
> +   :functions: fpga_bridge_get_to_list
> +
> +.. kernel-doc:: drivers/fpga/fpga-bridge.c
> +   :functions: of_fpga_bridge_get_to_list
> +
> +.. kernel-doc:: drivers/fpga/fpga-bridge.c
> +   :functions: fpga_bridges_put
> diff --git a/Documentation/driver-api/fpga/index.rst b/Documentation/driv=
er-api/fpga/index.rst
> index c51e5eb..31a4773 100644
> --- a/Documentation/driver-api/fpga/index.rst
> +++ b/Documentation/driver-api/fpga/index.rst
> @@ -11,3 +11,5 @@ FPGA Subsystem
>     fpga-mgr
>     fpga-bridge
>     fpga-region
> +   fpga-programming
> +
> diff --git a/Documentation/driver-api/fpga/intro.rst b/Documentation/driv=
er-api/fpga/intro.rst
> index 50d1cab..f54c7da 100644
> --- a/Documentation/driver-api/fpga/intro.rst
> +++ b/Documentation/driver-api/fpga/intro.rst
> @@ -44,7 +44,7 @@ FPGA Region
>  -----------
>
>  If you are adding a new interface to the FPGA framework, add it on top
> -of an FPGA region to allow the most reuse of your interface.
> +of an FPGA region.
>
>  The FPGA Region framework (fpga-region.c) associates managers and
>  bridges as reconfigurable regions.  A region may refer to the whole
> --
> 2.7.4
>

Thanks,
Moritz
