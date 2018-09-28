Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F73EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A862073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2cZw+4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A862073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeI2EcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeI2EcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:32:00 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243792073F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538172374;
        bh=IQrAz0TmJceKloJYPVIfOdYfTLTLDxWv5hUM9uam0r4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K2cZw+4o+Ox+SckSzeuujaaN36fVCbKYlfJw/amGooh6jr19m13tLJQ94GA0+eQlS
         VaCh06fK/cRdZHTxNEMpmaLL5sbVGdVZy79Vlol17jxtA+qH9J4P5wQNQznkvln07m
         UgqJxH/FhxCKhPn8pwgUaKcfuDfMfEcBs7+asEHk=
Received: by mail-qt1-f179.google.com with SMTP id c56-v6so3438194qtd.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:06:14 -0700 (PDT)
X-Gm-Message-State: ABuFfoivSPwDMktP72mxUkugq0ZtQ+4foeUP2Iywpa1sb+XINzH4l0Pz
        ty8z5Mq838rdS4c//nS0xvIkPpg2jpXSeNRlaw==
X-Google-Smtp-Source: ACcGV63EVnnEGr11htp6wQOVkifOgsmzbkZcxEQMogZlvTBuguGVPfKw/KpOh+x2SjrQ/gu1ah4dUZZlPqv95G9CzjY=
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr475936qte.164.1538172373376;
 Fri, 28 Sep 2018 15:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-37-robh@kernel.org>
In-Reply-To: <20180828015252.28511-37-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 17:06:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLDacDPo8VsqTS8otF5WOZgFXvGUNuzAZVEyDG-52zyhw@mail.gmail.com>
Message-ID: <CAL_JsqLDacDPo8VsqTS8otF5WOZgFXvGUNuzAZVEyDG-52zyhw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: Convert to using %pOFn instead of device_node.name
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/nvmem/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Ping. This has no dependencies, so please apply.

Rob

>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index aa1657831b70..6988ee9f11ba 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -304,6 +304,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
>         mutex_lock(&nvmem_cells_mutex);
>         list_del(&cell->node);
>         mutex_unlock(&nvmem_cells_mutex);
> +       kfree(cell->name);
>         kfree(cell);
>  }
>
> @@ -879,7 +880,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>         cell->nvmem = nvmem;
>         cell->offset = be32_to_cpup(addr++);
>         cell->bytes = be32_to_cpup(addr);
> -       cell->name = cell_np->name;
> +       cell->name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
>
>         addr = of_get_property(cell_np, "bits", &len);
>         if (addr && len == (2 * sizeof(u32))) {
> @@ -904,6 +905,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>         return cell;
>
>  err_sanity:
> +       kfree(cell->name);
>         kfree(cell);
>
>  err_mem:
> --
> 2.17.1
>
