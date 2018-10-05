Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C7621477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgZDQ9zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C7621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJEWGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJEWGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:06:40 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5872064A;
        Fri,  5 Oct 2018 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538752052;
        bh=tkXJ92t1+SOdVwZHfs4LHrN7Cp0amzcXgCFWnxf7KU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IgZDQ9zcH2Xov2E9fFvmhlvXKuBfqGvrKIZuGHwaeN44tqD4U4uRUhsUXJlGUl/gA
         EGTIrapLBTixezLMhdYO21053QVgiEL8s3FUUz44TX1iZoVp1j681DGOHrFVLNAKCN
         NKIfOcx7xq3HmmdqlOOCRgF2Phe9HPvLuKN/rY4s=
Received: by mail-qk1-f171.google.com with SMTP id a85-v6so8131102qkg.3;
        Fri, 05 Oct 2018 08:07:32 -0700 (PDT)
X-Gm-Message-State: ABuFfohu3mFSN/xDa6qEhgRQWcy50Jl+XV1xFO2NzzejUs2+dUrOWyyN
        r88J0XxxpHLaSRUvvtPrKhSIT5vKrrKbQznrAA==
X-Google-Smtp-Source: ACcGV60TAPkCwXnXlWQW1NxIu1h8kkfGOK+n3LGDK3LMWtkiUCOwOwdpl+1nWrZ5dJ03KF4rSUGKFAWxdO3/Cvlw1Gw=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr9502824qks.147.1538752051679;
 Fri, 05 Oct 2018 08:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com> <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 5 Oct 2018 10:07:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
Message-ID: <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
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
>
> If the properties are already in the live tree then there is no
> need to create a changeset entry to add them since they must
> have the same value.  This reduces the memory used by the
> changeset and eliminates a possible memory leak.  This is
> verified by 12 fewer warnings during the devicetree unittest,
> as the possible memory leak warnings about #address-cells and

and...?

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

Perhaps this should be generalized to apply to any property? We can't
really deal with property values changing on the fly anyways.

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

Remove the extra blank lines.

> +               check_for_non_overlay_node = true;
>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>                                                 new_prop);
> -       else
> +
> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
> +
> +               if (prop->length != 4 || new_prop->length != 4 ||
> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)

Technically these are __be32 types. This could use a helper (of_prop_val_eq).

I'm not sure we really need to validate the length here as dtc does
that (but yes, not everything is from dtc).

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
