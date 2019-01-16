Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5204520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfAPJEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:04:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34832 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfAPJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:04:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so6381882qtc.2;
        Wed, 16 Jan 2019 01:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5JLoYZyr7ko3pxF3d0m/ILrs4Xoft/sF6jGA27FK68=;
        b=ljz9d/fQGRy05/odaBVBNnzI9y6eAEl7XabS5fwrWnKPCBe3Ak0ywu88Q8hHALRre5
         fpyMQNLFmllvz/TF7aae1eL2xg/wMqxI+8WfqPdycHMIDrltb6ExXzB1+RQVIYvEuJE1
         FJsi402qswreo8TdIjt2n6PuZmih2nPsF+YrcgOMheFHhb4fr01ztxVayX+3QIbGWFqe
         8CanTegZwebI0JEG1Wi1ZZEOE9dQrPs2INVCaq/32Tx2BmGd1DYK19Hdcmmswp27G3ks
         mRnBg2/5XFRIxwfL88p3eDZmTv0oS7bygVo7kgFJP1vdlpWFlnwV6QA8P1R0xFnsB0iU
         hPXQ==
X-Gm-Message-State: AJcUukegYAgaQr+g5+FN7aVJhD1dzAhr2q0cTbdAPX08Wmkhq/tErCP9
        X5gx4nKYkdeOUhRMW9lhz0Qx0BjU5/j3AFLF3bQ=
X-Google-Smtp-Source: ALg8bN4Vid741bDPYI3y7NMmjtovum5hMwrktZH26yjLKKOBx95eEO1CrNaGdl7GBz6gC7zTEyIasKRSR7HRF2q8HCA=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr6357492qta.152.1547629478779;
 Wed, 16 Jan 2019 01:04:38 -0800 (PST)
MIME-Version: 1.0
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com> <1545351802-4354-2-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1545351802-4354-2-git-send-email-thor.thayer@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 10:04:22 +0100
Message-ID: <CAK8P3a3uoW=kUy_H2kXvtnyVZk7psF+hb3aS66GvtPZFDwpkgQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] mfd: altera-sysmgr: Add SOCFPGA System Manager
To:     thor.thayer@linux.intel.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 1:21 AM <thor.thayer@linux.intel.com> wrote:
>
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> The SOCFPGA System Manager register block aggregates different
> peripheral functions into one area.
> On 32 bit ARM parts, handle in the same way as syscon.
> On 64 bit ARM parts, the System Manager can only be accessed by
> EL3 secure mode. Since a SMC call to EL3 is required, this new
> driver uses regmaps similar to syscon to handle the SMC call.
>
> Since regmaps abstract out the underlying register access, the
> changes to drivers accessing the System Manager are minimal.
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 Implement Arnd's changes.
>    1. Change socfpga_is_s10() to check compatible string.
>       Add new compatible string for Stratix10 in bindings
>       and add proper detection method.
>    2. Replace base cast with resource_size_t member.
>    3. Change s10_sysmgr_regmap_cfg to altr_sysmgr_regmap_cfg to
>       be generic.
>    4. Always use 4 byte width.
>    5. Initialize the .reg_read and .reg_write in S10 case only.
>    6. Remove call to syscon in 32bit ARM case and handle both
>       ARM32 and ARM64 in of_sysmgr_register().
>    7. Replace IS_ERR_OR_NULL() with IS_ERR().
>    8. Remove compatible check functions except phandle function.

These all look good, thanks for the good updates!

> +struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np)
> +{
> +       struct altr_sysmgr *sysmgr = NULL;
> +
> +       if (!p_sysmgr)
> +               sysmgr = of_sysmgr_register(np);
> +       else
> +               sysmgr = p_sysmgr;
> +
> +       if (IS_ERR(sysmgr))
> +               return ERR_CAST(sysmgr);
> +
> +       return sysmgr->regmap;
> +}
> +EXPORT_SYMBOL_GPL(altr_sysmgr_node_to_regmap);
> +
> +struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +                                                   const char *property)
> +{
> +       struct device_node *sysmgr_np;
> +       struct regmap *regmap;
> +
> +       if (property)
> +               sysmgr_np = of_parse_phandle(np, property, 0);
> +       else
> +               sysmgr_np = np;
> +
> +       if (!sysmgr_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       regmap = altr_sysmgr_node_to_regmap(sysmgr_np);
> +       of_node_put(sysmgr_np);
> +
> +       return regmap;
> +}
> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_phandle);
> +
> +static int sysmgr_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct altr_sysmgr *sysmgr;
> +       struct resource *res;
> +
> +       /* Skip Initialization if already created */
> +       if (p_sysmgr)
> +               goto finish;
> +
> +       sysmgr = of_sysmgr_register(pdev->dev.of_node);
> +       if (IS_ERR(sysmgr)) {
> +               dev_err(dev, "regmap init failed\n");
> +               return -ENODEV;
> +       }

It seems odd to still have these two ways of registering the sysmgr,
from either the probe function or the lookup.

Since the sysmgr should always get probed before its users, you could
try to change it like this:

- let only the probe() function register it and create the regmap, then
  set the regmap as the private data of the device.

- In lookup_by_phandle(), use driver_find_device() to look up the
  'struct device' based on its of_node(), by comparing dev->of_node
  to of_parse_phandle(np, property).

- return the private data of the device.

That will also let you remove the global variable and make it (theoretically)
work with multiple sysmgr devices, which is generally the preferred way to
write a driver.

> +#ifdef CONFIG_MFD_ALTERA_SYSMGR
> +struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np);
> +struct regmap *altr_sysmgr_regmap_lookup_by_compatible(const char *s);
> +struct regmap *altr_sysmgr_regmap_lookup_by_pdevname(const char *s);
> +struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +                                                   const char *property);
> +

You seem to have some dead declarations from before the cleanup that
should be removed now. Please go through the header file one more time
to see what is actually still used.

      Arnd
