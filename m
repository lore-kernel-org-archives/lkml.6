Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BD6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE43020879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029209;
	bh=Tw1pjOzzR3JELLMTEbUNki1sX+wPBmOQPPKoW9OmBOU=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=rJuG2EMsCr+r+e9btwWIiZpFGZ32pkLFASafqc8EvqTJJ+LoRvMO+crvSvpzYbaSM
	 08b4QSA/sz8PdDZ1CFAdoAhlGHMJ4seo4oy6MsPfyGgpnVjYO/sJeCmg6fNE0HV6Fl
	 op0bVq2furYRYRz8Psw0N9HtRzgvDNi2b1clGsEU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE43020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeLERAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLERAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:00:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 689DD2084C;
        Wed,  5 Dec 2018 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544029207;
        bh=Tw1pjOzzR3JELLMTEbUNki1sX+wPBmOQPPKoW9OmBOU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=GPbWDeJD8A+1/ft1J5lU/91Ww+VbnCYMtEsOV2srFih6hb9Y3DdKR4offBwLQivSV
         cTVuTTx7C+mLTB2B6xtpV3+snYTS6sXpaiSKq870TwdIUyFYOquxMHwQ/VW7tLj0jt
         c1moGzE7dpvsHDOzPF/Sle2jdRk74JZ2E/nQAg1M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181205061600.7zglbpkgbktn27am@vireshk-i7>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
Message-ID: <154402920660.88331.5729780274488650479@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Wed, 05 Dec 2018 09:00:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-12-04 22:16:00)
> On 05-12-18, 09:07, Taniya Das wrote:
> > Hello Stephen, Viresh
> > =

> > Thanks for the code and suggestions.
> > =

> > Having a NR_DOMAINS '2' makes the driver not scalable for re-use.
> =

> Sure, I didn't like it either and that wasn't really what I was suggestin=
g in
> the first place. I didn't wanted to write the code myself and pass it on,=
 but I
> have it now anyway :)
> =

> It may have a bug or two in there, but compiles just fine and is rebased =
over
> your patch Taniya.

If we move the ioremap of registers to the cpufreq_driver::init path
then we need to unmap it on cpufreq_driver::exit. In fact, all the
devm_*() code in the init path needs to change to non-devm. Otherwise
it's a nice simplification!

> +static int qcom_cpufreq_hw_read_lut(struct device *dev,
> +                                   struct cpufreq_policy *policy,
> +                                   void __iomem *base)
>  {
>         u32 data, src, lval, i, core_count, prev_cc =3D 0, prev_freq =3D =
0, freq;
> -       unsigned int max_cores =3D cpumask_weight(&c->related_cpus);
> +       unsigned int max_cores =3D cpumask_weight(policy->cpus);
> +       struct cpufreq_frequency_table  *table;
>  =

> -       c->table =3D devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> -                               sizeof(*c->table), GFP_KERNEL);
> -       if (!c->table)
> +       table =3D devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +                               sizeof(*table), GFP_KERNEL);

This one.

> +       if (!table)
>                 return -ENOMEM;
>  =

>         for (i =3D 0; i < LUT_MAX_ENTRIES; i++) {
> @@ -194,22 +154,29 @@ static void qcom_get_related_cpus(int index, struct=
 cpumask *m)
>         }
>  }
>  =

> -static int qcom_cpu_resources_init(struct platform_device *pdev,
> -                                  unsigned int cpu, int index,
> -                                  unsigned long xo_rate,
> -                                  unsigned long cpu_hw_rate)
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  {
> -       struct cpufreq_qcom *c;
> +       struct device *dev =3D &global_pdev->dev;
> +       struct of_phandle_args args;
> +       struct device_node *cpu_np;
>         struct resource *res;
> -       struct device *dev =3D &pdev->dev;
>         void __iomem *base;
> -       int ret, cpu_r;
> +       int ret, index;
>  =

> -       c =3D devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> -       if (!c)
> -               return -ENOMEM;
> +       cpu_np =3D of_cpu_device_node_get(policy->cpu);
> +       if (!cpu_np)
> +               return -EINVAL;
> +
> +       ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +                       "#freq-domain-cells", 0, &args);
> +       of_node_put(cpu_np);
>  =

> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, index);
> +       if (ret)
> +               return ret;
> +
> +       index =3D args.args[0];
> +
> +       res =3D platform_get_resource(global_pdev, IORESOURCE_MEM, index);
>         base =3D devm_ioremap_resource(dev, res);

And this one.

>         if (IS_ERR(base))
>                 return PTR_ERR(base);

Here's a patch to squash in to fix those tiny problems. I left it as
devm_ioremap_resource() because that has all the nice features of
resource requesting inside and it didn't seem too bad to devm_iounmap()
on the exit path.

---------8<--------------

 drivers/cpufreq/qcom-cpufreq-hw.c | 37 ++++++++++++++++++++++++++---------=
--
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufr=
eq-hw.c
index bcf9bb37298a..1e865e216839 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
 =

 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
@@ -77,8 +78,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 	unsigned int max_cores =3D cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;
 =

-	table =3D devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
-				sizeof(*table), GFP_KERNEL);
+	table =3D kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 =

@@ -144,7 +144,7 @@ static void qcom_get_related_cpus(int index, struct cpu=
mask *m)
 =

 		ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
 						 "#freq-domain-cells", 0,
-						  &args);
+						 &args);
 		of_node_put(cpu_np);
 		if (ret < 0)
 			continue;
@@ -170,7 +170,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_poli=
cy *policy)
 	ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
 			"#freq-domain-cells", 0, &args);
 	of_node_put(cpu_np);
-
 	if (ret)
 		return ret;
 =

@@ -184,13 +183,15 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_po=
licy *policy)
 	/* HW should be in enabled state to proceed */
 	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto error;
 	}
 =

 	qcom_get_related_cpus(index, policy->cpus);
 	if (!cpumask_weight(policy->cpus)) {
 		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
-		return -ENOENT;
+		ret =3D -ENOENT;
+		goto error;
 	}
 =

 	policy->driver_data =3D base + REG_PERF_STATE;
@@ -198,11 +199,25 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_po=
licy *policy)
 	ret =3D qcom_cpufreq_hw_read_lut(dev, policy, base);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
-		return ret;
+		goto error;
 	}
 =

 	policy->fast_switch_possible =3D true;
 =

+	return 0;
+
+error:
+	devm_iounmap(dev, base);
+	return ret;
+}
+
+static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+{
+	void __iomem *base =3D policy->driver_data - REG_PERF_STATE;
+
+	kfree(policy->freq_table);
+	devm_iounmap(&global_pdev->dev, base);
+
 	return 0;
 }
 =

@@ -219,6 +234,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver =3D=
 {
 	.target_index	=3D qcom_cpufreq_hw_target_index,
 	.get		=3D qcom_cpufreq_hw_get,
 	.init		=3D qcom_cpufreq_hw_cpu_init,
+	.exit		=3D qcom_cpufreq_hw_cpu_exit,
 	.fast_switch    =3D qcom_cpufreq_hw_fast_switch,
 	.name		=3D "qcom-cpufreq-hw",
 	.attr		=3D qcom_cpufreq_hw_attr,
@@ -248,12 +264,11 @@ static int qcom_cpufreq_hw_driver_probe(struct platfo=
rm_device *pdev)
 	ret =3D cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
-		return ret;
+	} else {
+		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
 	}
 =

-	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
-
-	return 0;
+	return ret;
 }
 =

 static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
