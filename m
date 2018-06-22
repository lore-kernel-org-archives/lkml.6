Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD450C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A71E24737
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZGVo17N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A71E24737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934328AbeFVSbT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:31:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40587 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeFVSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:31:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so3594493pfe.7;
        Fri, 22 Jun 2018 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dnlmeh0ETRyTeQmQmJpCWaYnEVSEN/4h7gHXw6oj92o=;
        b=XZGVo17NoLaFqAfuKkuTDWfQhoF/O6wM5fndQLT2HlHWP26x2HTVUOlKonsPA6teZi
         vQI2aIzVeVMegWKww5aUEU81iom64CVwEgMHCY1AN+055kWK1MMkKzE75WJYxmXQk0QT
         I5OS8ZQZ/G3nqGs1auXk4Pi5f9e3/r3+VW78BV421Q49CyBFSLItwb7TwdXzOWRmlzaZ
         tO7NPe7SOOzeqhFL4YknY5wdoRjvbWbg1fDzmz4U6Pvh//Rwg+FJNidbcRNnx51JCfD/
         X4x8p2yG+k06PjxfEMmOQagZW0PJPQ9MCIFtF6bk04iQRRZKxexLJICB8KgD7MdtoRmj
         kSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dnlmeh0ETRyTeQmQmJpCWaYnEVSEN/4h7gHXw6oj92o=;
        b=nQymIxNy7cH3xcAit6iw0kdX3BQtNU3Zg8PnPSExqkGEYAtUOftnRopCdulwF561hA
         df5Q9Y88ihEn1NVi6HrZvJdTQFCmxzjlUU7LUuEG4rGNZVDauQiTv/otXvX/g8gHI1NH
         /cDhdqehrYVJUTSxk7xl2hoTSZ8MNTY1lTE0LrRS27WkJHW7oUepL99gF6BQ2V0AEFHv
         4q/Ig9og4h0vMWGmOV1xATtpmr3UHWbdY8QAvX9Acilj+uNCbcF62FuQUogM3eEtfG0r
         j4t4j/XOpHIM48vCLYdRzm3LMbm1PT1sEWxZQzeOR+MZm0qkqHOzjSfEPJCNNDgcY7fw
         aPAg==
X-Gm-Message-State: APt69E3l4IGtsg2zCf+WzaqVuW0913ltcInsCuZamLDEJx9RIr57RbQK
        6VI+Z25OMu8zHDsCZ7KD4DyGsevd
X-Google-Smtp-Source: ADUXVKLWK6fSB6VMB8pTJvG0eYbXanKfPHbMESmANTrhEuzzu59X1diupblMBtkjjpjKbXCwuyDp4Q==
X-Received: by 2002:a63:7d4c:: with SMTP id m12-v6mr2361286pgn.201.1529692277076;
        Fri, 22 Jun 2018 11:31:17 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id r3-v6sm4380740pfl.162.2018.06.22.11.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:31:16 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:31:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     chen.zhong@mediatek.com, lee.jones@linaro.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] input: mtk-pmic-keys: Fix probe when no DT node present
Message-ID: <20180622183114.GA92912@dtor-ws>
References: <20180622114228.8619-1-matthias.bgg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622114228.8619-1-matthias.bgg@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:42:28PM +0200, Matthias Brugger wrote:
> The drivers gets probed from a mfd devices. So the driver runs
> probe although no DT node exists. This leads to a NULL pointer
> dereference in the probe function. Check if a node exists and
> error out in case none is present.

Hmm, if a cell specifies of_compatible and no such node is present in DT
maybe we should bail out in mfd_add_device() instead of pushing the
check into individual drivers? Something like:

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..36a5fd98000d 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -137,6 +137,18 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
 }
 #endif
 
+static struct device_node *mfd_get_node_for_cell(struct device *parent,
+						 const struct mfd_cell *cell)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(parent->of_node, np)
+		if (of_device_is_compatible(np, cell->of_compatible))
+			return np;
+
+	return NULL;
+}
+
 static int mfd_add_device(struct device *parent, int id,
 			  const struct mfd_cell *cell, atomic_t *usage_count,
 			  struct resource *mem_base,
@@ -144,7 +156,6 @@ static int mfd_add_device(struct device *parent, int id,
 {
 	struct resource *res;
 	struct platform_device *pdev;
-	struct device_node *np = NULL;
 	int ret = -ENOMEM;
 	int platform_id;
 	int r;
@@ -176,11 +187,11 @@ static int mfd_add_device(struct device *parent, int id,
 		goto fail_res;
 
 	if (parent->of_node && cell->of_compatible) {
-		for_each_child_of_node(parent->of_node, np) {
-			if (of_device_is_compatible(np, cell->of_compatible)) {
-				pdev->dev.of_node = np;
-				break;
-			}
+		pdev->dev.of_node = mfd_get_node_for_cell(parent, cell);
+		if (!pdev->dev.of_node) {
+			dev_err(parent, "unable to locate node for %s (%s)\n",
+				cell->name, cell->of_compatible);
+			goto fail_res;
 		}
 	}
 
Lee?

> 
> Fixes: 3e9f0b3e2b27 ("input: Add MediaTek PMIC keys support")
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..388043e1939c 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -257,6 +257,9 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id =
>  		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
>  
> +	if (of_id == NULL)
> +		return -ENODEV;
> +
>  	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
>  	if (!keys)
>  		return -ENOMEM;
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
