Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A234DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5920661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5oQkySH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E5920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeIDUpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:45:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54265 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeIDUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:45:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so5087898wme.3;
        Tue, 04 Sep 2018 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=xXfhCKyEdYmMz9/Nd8prPhZsLoSApiN/wPBbJZJMB/w=;
        b=d5oQkySHsqdyAL3V7dO+vBDZ+frQIYE0AaAkQo9E+Qoi+cuK4q9ucPY6pv065JJegS
         PbGGBOjtCmT9+Re01J/6eD2Vj3juWzKDSuh27F1dC+jF/p0RQIDZ8UNdoTXrmnlG4xJV
         9NIXGITyOHIINqouhwd1C1azHKmYauOf5eAmUt6ecoxJckzpoqSzYVez4JXH0rCbs5Qc
         ulZogutbbjCgzEpAoFiBLVEjIthzGxKSW9VBIAJ+Y5uzWoEef/JP6e3rr366NkHV0Sml
         P4vXJmLc4B3gCHr+8Bi49U4/N6ptLQ/KeQrh9mTiUBmqA7fJhmPlwUp6ua3S+oQXbb3p
         2nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=xXfhCKyEdYmMz9/Nd8prPhZsLoSApiN/wPBbJZJMB/w=;
        b=QtFLlc7kIF/wcW/eQLEUWDY1rClUc8tafIPdq33lS7y11tmYqDV6z9B/+WuGJ7LDYw
         vSKftwrLahDklpglYn9w/Do/apdkerNetgCHkX/aJnvpetH474DdY9oBv2PcaFjZaeMZ
         ded8QcEU24UWU/csUYJC/zKg8x9+cGcHTvV2f4HqN21m7KkpJBMch7Nbq84TkIaIsIbF
         ay5Ns4H2RzaMECglWXVyCP6//tp6YMq2xO0/fvWSnR0RmSeiddTA3v/GQ0oiAyFfnDkj
         6zWE274lMalQ5hVLxdov/y85BKTicdV7iUdsJBKf/BfHHzcT369YtOe2+yXT2s1n4ks1
         yU9A==
X-Gm-Message-State: APzg51AliALuazMRXVfRznDZzOa3kyfbb8cZlGrE4R04oZ6V5+Rp1kB9
        6k9D1x8dLHonCtTtcW/JxA==
X-Google-Smtp-Source: ANB0Vdbu74OCqzSySia2+bOb+HNU21N2sb9HmVLvHnvopKFF//jzlxpvqSpa6j3SSyPHUAquIM+ooQ==
X-Received: by 2002:a1c:d141:: with SMTP id i62-v6mr1448899wmg.113.1536077992367;
        Tue, 04 Sep 2018 09:19:52 -0700 (PDT)
Received: from Helena.home (host86-176-130-140.range86-176.btcentralplus.com. [86.176.130.140])
        by smtp.gmail.com with ESMTPSA id h10-v6sm3481836wmf.44.2018.09.04.09.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:19:51 -0700 (PDT)
Date:   Tue, 04 Sep 2018 17:19:48 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180904140538.16602-1-srinivas.kandagatla@linaro.org>
References: <20180904140538.16602-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2] irqchip/gic-v3: Add quirk for msm8996 secured registers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        marc.zyngier@arm.com
CC:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org
From:   Craig Tatlor <ctatlor97@gmail.com>
Message-ID: <A0BB4E01-1CF6-49B1-9B5C-27FAC1DF821A@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 September 2018 15:05:38 BST, Srinivas Kandagatla <srinivas=2Ekandagat=
la@linaro=2Eorg> wrote:
>Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor=2E
>Its been more than 2 years of wait for this to be fixed, which has
>no hopes to be fixed=2E This change was introduced for the "lead device"
>on msm8996 platform=2E It looks like all publicly available msm8996
>devices have this implementation=2E
>
>So add a quirk to not access this register on msm8996=2E
>
>With this quirk MSM8996 can at least boot out of mainline,
>which can help community to work with boards based on MSM8996=2E
>
>Without this patch Qualcomm DB820c board reboots when GICR_WAKER
>is accessed=2E
>
>Signed-off-by: Srinivas Kandagatla <srinivas=2Ekandagatla@linaro=2Eorg>
>---
>Hi Marc,
>
>There is no errata associated with this quirk, so I could not add
>any entries into Documentation/arm64/silicon-errata=2Etxt Or add
>any number to the quirk description=2E
>
>Changes since v1:
>- renamed gic_v3 references to gic
>- added full mask for iidr register match
>
>thanks,
>srini
>
> drivers/irqchip/irq-gic-v3=2Ec | 29 ++++++++++++++++++++++++++++-
> 1 file changed, 28 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/irqchip/irq-gic-v3=2Ec
>b/drivers/irqchip/irq-gic-v3=2Ec
>index d5912f1ec884=2E=2E406d4a44c887 100644
>--- a/drivers/irqchip/irq-gic-v3=2Ec
>+++ b/drivers/irqchip/irq-gic-v3=2Ec
>@@ -41,6 +41,8 @@
>=20
> #include "irq-gic-common=2Eh"
>=20
>+#define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>+
> struct redist_region {
> 	void __iomem		*redist_base;
> 	phys_addr_t		phys_base;
>@@ -55,6 +57,7 @@ struct gic_chip_data {
> 	struct irq_domain	*domain;
> 	u64			redist_stride;
> 	u32			nr_redist_regions;
>+	u64			flags;
> 	bool			has_rss;
> 	unsigned int		irq_nr;
> 	struct partition_desc	*ppi_descs[16];
>@@ -139,6 +142,9 @@ static void gic_enable_redist(bool enable)
> 	u32 count =3D 1000000;	/* 1s! */
> 	u32 val;
>=20
>+	if (gic_data=2Eflags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
>+		return;
>+
> 	rbase =3D gic_data_rdist_rd_base();
>=20
> 	val =3D readl_relaxed(rbase + GICR_WAKER);
>@@ -1068,13 +1074,31 @@ static const struct irq_domain_ops
>partition_domain_ops =3D {
> 	=2Eselect =3D gic_irq_domain_select,
> };
>=20
>+static bool __maybe_unused gic_enable_quirk_msm8996(void *data)
>+{
>+	struct gic_chip_data *d =3D data;
>+
>+	d->flags |=3D FLAGS_WORKAROUND_GICR_WAKER_MSM8996;
>+
>+	return true;
>+}
>+
>+static const struct gic_quirk gic_quirks[] =3D {
>+	{
>+		=2Edesc	=3D "GICv3: Qualcomm MSM8996 skip GICR_WAKER Read/Write",
>+		=2Eiidr	=3D 0x00001070,	/* MSM8996 */
>+		=2Emask	=3D 0xffffffff,
>+		=2Einit	=3D gic_enable_quirk_msm8996,
>+	},
>+};
>+
> static int __init gic_init_bases(void __iomem *dist_base,
> 				 struct redist_region *rdist_regs,
> 				 u32 nr_redist_regions,
> 				 u64 redist_stride,
> 				 struct fwnode_handle *handle)
> {
>-	u32 typer;
>+	u32 typer, iidr;
> 	int gic_irqs;
> 	int err;
>=20
>@@ -1130,6 +1154,9 @@ static int __init gic_init_bases(void __iomem
>*dist_base,
> 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
> 		its_init(handle, &gic_data=2Erdists, gic_data=2Edomain);
>=20
>+	iidr =3D readl_relaxed(dist_base + GICD_IIDR);
>+	gic_enable_quirks(iidr, gic_quirks, &gic_data);
>+
> 	gic_smp_init();
> 	gic_dist_init();
> 	gic_cpu_init();

This bug also affects sdm660/630 and probably 8998 but I cant verify so it=
 would probably make sense to loosen up the naming for the quirk=2E
-- 
