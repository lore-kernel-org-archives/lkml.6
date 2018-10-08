Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F54C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2C62145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVVMB6Wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2C62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJHXKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbeJHXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:10:53 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581AC2145D;
        Mon,  8 Oct 2018 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539014308;
        bh=6bPHYSqqcTTnoh7EbtIq2dGvzt+kn8l1/Vy8N6/2ZE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lVVMB6WnhtlOrKU6Uam3oRjjnjKl7hQgp4eJobLHfX0B+2NTyqXrJyLN+ZsGK4TVx
         mPEnH41p/ng5qwAzBtcskGhhOLcq4Xt55BQkyOK2V+MNc8ejNbbEj7B/lEd/GErRtX
         /UDiy8+o3rytV/6c6d4lJaukIkFHtGjLXqdHLnGg=
Received: by mail-ed1-f41.google.com with SMTP id z21-v6so13637646edb.11;
        Mon, 08 Oct 2018 08:58:28 -0700 (PDT)
X-Gm-Message-State: ABuFfoi1/Cij/2vkgHV9ibgE15LsWDFioEP3rwjiVGsJ2C8++LFMRb2c
        o4VbdV1jtLfZKnID11iG8NQXvxa4O97GYojTxGU=
X-Google-Smtp-Source: ACcGV60Ps4cDrZT7OM2ci2vuqoiu+j0y3Fy2Ojhh9Dj1yCwNlNrQxNTxmn3esfrjv6UX735D08iXf2hG0NzFUTY/XL0=
X-Received: by 2002:a17:906:7384:: with SMTP id f4-v6mr23743432ejl.8.1539014306619;
 Mon, 08 Oct 2018 08:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com> <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 8 Oct 2018 10:57:50 -0500
X-Gmail-Original-Message-ID: <CANk1AXQFTfdwy9n+WH2k98w6oyqLj3wLDRfaMmtTGk66sJjqUw@mail.gmail.com>
Message-ID: <CANk1AXQFTfdwy9n+WH2k98w6oyqLj3wLDRfaMmtTGk66sJjqUw@mail.gmail.com>
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> If overlay properties #address-cells or #size-cells are already in
> the live devicetree for any given node, then the values in the
> overlay must match the values in the live tree.

Hi Frank,

I'm starting some FPGA testing on this patchset applied to v4.19-rc7.
That applied cleanly; if that's not the best base to test against,
please let me know.

On a very simple overlay, I'm seeing this patch's warning catching
things other than #address-cells or #size-cells.  I'm just getting
started looking at this, will spend time understanding this better and
I'll test other overlays.  The warnings were:

Applying dtbo: socfpga_overlay.dtb
[   33.117881] fpga_manager fpga0: writing soc_system.rbf to Altera
SOCFPGA FPGA Manager
[   33.575223] OF: overlay: WARNING: add_changeset_property(), memory
leak will occur if overlay removed.  Property:
/soc/base-fpga-region/firmware-name
[   33.588584] OF: overlay: WARNING: add_changeset_property(), memory
leak will occur if overlay removed.  Property:
/soc/base-fpga-region/fpga-bridges
[   33.601856] OF: overlay: WARNING: add_changeset_property(), memory
leak will occur if overlay removed.  Property:
/soc/base-fpga-region/ranges

Here's part of that overlay including the properties it's complaining about:

/dts-v1/;
/plugin/;
/ {
        fragment@0 {
                target = <&base_fpga_region>;
                #address-cells = <1>;
                #size-cells = <1>;
                __overlay__ {
                        #address-cells = <1>;
                        #size-cells = <1>;

                        firmware-name = "soc_system.rbf";
                        fpga-bridges = <&fpga_bridge1>;
                        ranges = <0x20000 0xff200000 0x100000>,
                        <0x0 0xc0000000 0x20000000>;

                        gpio@10040 {
so on...

By the way, I didn't get any warnings when I subsequently removed this overlay.

Alan

>
> If the properties are already in the live tree then there is no
> need to create a changeset entry to add them since they must
> have the same value.  This reduces the memory used by the
> changeset and eliminates a possible memory leak.  This is
> verified by 12 fewer warnings during the devicetree unittest,
> as the possible memory leak warnings about #address-cells and
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 29c33a5c533f..e6fb3ffe9d93 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>   * @target may be either in the live devicetree or in a new subtree that
>   * is contained in the changeset.
>   *
> - * Some special properties are not updated (no error returned).
> + * Some special properties are not added or updated (no error returned):
> + * "name", "phandle", "linux,phandle".
> + *
> + * Properties "#address-cells" and "#size-cells" are not updated if they
> + * are already in the live tree, but if present in the live tree, the values
> + * in the overlay must match the values in the live tree.
>   *
>   * Update of property in symbols node is not allowed.
>   *
> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  {
>         struct property *new_prop = NULL, *prop;
>         int ret = 0;
> +       bool check_for_non_overlay_node = false;
>
>         if (!of_prop_cmp(overlay_prop->name, "name") ||
>             !of_prop_cmp(overlay_prop->name, "phandle") ||
> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>         if (!new_prop)
>                 return -ENOMEM;
>
> -       if (!prop)
> +       if (!prop) {
> +
> +               check_for_non_overlay_node = true;
>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>                                                 new_prop);
> -       else
> +
> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
> +
> +               if (prop->length != 4 || new_prop->length != 4 ||
> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
> +                              target->np);
> +
> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
> +
> +               if (prop->length != 4 || new_prop->length != 4 ||
> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
> +                              target->np);
> +
> +       } else {
> +
> +               check_for_non_overlay_node = true;
>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
>                                                    new_prop);
>
> +       }
> +
> +       if (check_for_non_overlay_node &&
> +           !of_node_check_flag(target->np, OF_OVERLAY))
> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
> +                      __func__, target->np, new_prop->name);
> +
>         if (ret) {
>                 kfree(new_prop->name);
>                 kfree(new_prop->value);
> --
> Frank Rowand <frank.rowand@sony.com>
>
