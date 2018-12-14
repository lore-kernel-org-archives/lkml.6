Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1628BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC042146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC042146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeLNMgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:36:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33726 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbeLNMgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:36:37 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so5993990qtp.0;
        Fri, 14 Dec 2018 04:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJWcXh9F9+owIeg4owxsGscTGbFFGmdRksELWLDUZTo=;
        b=l8rYzY42bqKP8aB/8R/KRAD4nDDXFvLtSKsFlM/gzvQlVYvkri/6HypyHNXeVPEVh9
         XKAUE036VajQGYZEiVOebHV91QjGrAR+KIKnLR5pJZPxsy413GirWvS6Cca+gy3o1Gkm
         cQ3BcxxAD96ROL3JPttM/Jp7XH6vtINyReBvb4QIuijOrlD2nAketPzH4rJoTcvcz8Vy
         byOqTAOyXyE3fCn67WauGEkSqAhEHTrLQ9pTw7eUq4yKFC5zyl0oOPa0T9t9EmP8Fs56
         x8D4Qpyti22xwN2bAEw6YcgF18ijSWZAyHnwxrjh0dLKWqGNnkPHOp63ARKV2dCQL/lS
         HjUQ==
X-Gm-Message-State: AA+aEWYa4LpPYHstpEK1ftpJ6vmdt099T28cmTT601Fv2sNHW2FYqu8O
        T2LSGXUqXUN3pYISlphHICyFDoQD4HDkudaAjXA=
X-Google-Smtp-Source: AFSGD/XwTzQWGMosfRpU0oE6o60jDxE4OG/BJ9bluVUl4BYR3u8Z9SPu6YZdAGeEytXk2voKaHTqwCYCCQdRMygbNuI=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr2439929qtr.319.1544790996514;
 Fri, 14 Dec 2018 04:36:36 -0800 (PST)
MIME-Version: 1.0
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com> <1542125174-8204-2-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1542125174-8204-2-git-send-email-thor.thayer@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Dec 2018 13:36:19 +0100
Message-ID: <CAK8P3a1+LKakyD_gJTiNqKwNuP2Ptr_Wj4zJXf=+SDHSJHbexA@mail.gmail.com>
Subject: Re: [RESEND 1/4] mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
To:     thor.thayer@linux.intel.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        David Miller <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 5:03 PM <thor.thayer@linux.intel.com> wrote:
>
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> The SOCFPGA System Manager register block aggregate different
> peripheral functions into one place.
> On 32 bit ARM parts, the syscon framework fits this problem well.
> On 64 bit ARM parts, the System Manager can only be accessed by
> EL3 secure mode. Since a SMC call to EL3 is required, a new
> driver using regmaps similar to syscon was created that handles
> the SMC call.
> Since regmaps abstract out the underlying register access, the
> changes to drivers using System Manager are minimal.
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> Resend - update use_single_rw to use_single_read and
>          use_single_write which was added in 4.20.

Sorry for stepping in late here, I forgot to review it earlier and
Lee had to remind me to take a look.

> +static const struct regmap_config s10_sysmgr_regmap_cfg = {
> +       .name = "s10_sysmgr",
> +       .reg_bits = 32,
> +       .reg_stride = 4,
> +       .val_bits = 32,
> +       .reg_read = s10_protected_reg_read,
> +       .reg_write = s10_protected_reg_write,
> +       .fast_io = true,
> +       .use_single_read = true,
> +       .use_single_write = true,
> +};

The new regmap seems fine to me, that looks like a good way
of abstracting the two hardware methods.

> +/**
> + * socfpga_is_s10
> + * Determine if running on Stratix10 platform.
> + * Return: True if running Stratix10, otherwise false.
> + */
> +static int socfpga_is_s10(void)
> +{
> +       return of_machine_is_compatible("altr,socfpga-stratix10");
> +}

I don't really like the way you are checking for a specific here
here though, that is something that should only be done in
an absolute emergency when there is no way of fixing the
device tree files.

Since this is a new driver for a device that is not used in
mainline kernels yet (AFAICT), let's fix the binding and add
a proper detection method here.

> +
> +/**
> + * of_sysmgr_register
> + * Create and register the Altera System Manager regmap.
> + * Return: Pointer to new sysmgr on success.
> + *         Pointer error on failure.
> + */
> +static struct altr_sysmgr *of_sysmgr_register(struct device_node *np)
> +{
> +       struct altr_sysmgr *sysmgr;
> +       struct regmap *regmap;
> +       u32 reg_io_width;
> +       int ret;
> +       struct regmap_config sysmgr_config = s10_sysmgr_regmap_cfg;
> +       struct resource res;
> +
> +       if (!of_device_is_compatible(np, "altr,sys-mgr"))
> +               return ERR_PTR(-EINVAL);
> +
> +       sysmgr = kzalloc(sizeof(*sysmgr), GFP_KERNEL);
> +       if (!sysmgr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (of_address_to_resource(np, 0, &res)) {
> +               ret = -ENOMEM;
> +               goto err_map;
> +       }
> +
> +       /* Need physical address for SMCC call */
> +       sysmgr->base = (void __iomem *)res.start;

The cast here seems really ugly. Instead of mixinx up
address spaces, how about adding a resource_size_t
member in the sysmgr structure?

> +        * search for reg-io-width property in DT. If it is not provided,
> +        * default to 4 bytes. regmap_init will return an error if values
> +        * are invalid so there is no need to check them here.
> +        */
> +       ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
> +       if (ret)
> +               reg_io_width = 4;

How likely is it that this would ever not be four bytes? It looks
like you just copied this from syscon, but it really should not be
needed.

> +struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np)
> +{
> +       struct altr_sysmgr *sysmgr = NULL;
> +
> +       if (!socfpga_is_s10())
> +               return syscon_node_to_regmap(np);

Why do you go through syscon here? Doesn't this add a lot of complexity?

I'd suggest using regmap_init_mmio() directly and open-coding the
initialization you need as you do for the s10 case.

> +       if (!p_sysmgr)
> +               sysmgr = of_sysmgr_register(np);
> +       else
> +               sysmgr = p_sysmgr;
> +
> +       if (IS_ERR_OR_NULL(sysmgr))
> +               return ERR_CAST(sysmgr);

Don't use IS_ERR_OR_NULL(), it's just a sign that your API
is bad. Instead, define the interface either so that you
always return NULL on error or that you always return an
PTR_ERR() value on error.

> +struct regmap *altr_sysmgr_regmap_lookup_by_compatible(const char *s)
> +{
> +       struct device_node *sysmgr_np;
> +       struct regmap *regmap;
> +
> +       if (!socfpga_is_s10())
> +               return syscon_regmap_lookup_by_compatible(s);
> +
> +       sysmgr_np = of_find_compatible_node(NULL, NULL, s);
> +       if (!sysmgr_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       regmap = altr_sysmgr_node_to_regmap(sysmgr_np);
> +       of_node_put(sysmgr_np);
> +
> +       return regmap;
> +}
> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_compatible);

That should not be needed, just look it up by phandle and be done
with it. Again, lookup by compatible should only be needed for
compatibility with old DTB files, but you should be able to fix the
binding so you always have a phandle to the correct node here,
at least for the s10 case.

For the older chips with existing DTs, I guess drivers can fall back to
the syscon method directly.

> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_pdevname);

Same comment.

        Arnd
