Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041C12083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z67Ix8s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfBUP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:57:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42621 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBUP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:57:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so14021760pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPJIV3SRc0MBgPvFIne5ranIwYs42oAH55ZrePwI6GA=;
        b=Z67Ix8s0DkFOZEIo6VtqZSe49wwzG6CbxITdFBAoxuA/br9ECJK3Ag08AWnDb2lruG
         8dsmOYLMvtKfUZYnxx4HVgNscEKl2rI7piECDoq+Yeoj4fUVXH+9dOWtHYtLVSCzkDqj
         7Cb0cqk/TlveMZw0YnvFR9SM0xvRl7Qvfm9fQnBbuE018qdEbjqHhXz4m5S+rDP2l5wb
         MBQJVhcE7WEoIwfi8a1DLHYXtsF0DQc+YzmJ90aIm6crgZdhmPlDk2dUL4foMDGI49q6
         CmFrQqZamAYwbFT68OEbIR2WNCGLo9N/YJvry3b2ddLrsuMoT75kXSIz3b2Hzf/+6N+T
         P+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPJIV3SRc0MBgPvFIne5ranIwYs42oAH55ZrePwI6GA=;
        b=Tgcvf2LCcrRNfpCVraW2h0KxXZprfDCvThnEK/y2NKTFNPnp57QEADXGW3ZqFG56wg
         DtfJtJST5bw0GvI9kvYtbh7Dsx+dDHJynULu4L3JtE3Sp/akMRLjF4wUb7+99cUGUfeZ
         TNRgrlO547VzJRw9fSq5YGIELNwLAglXOYVrryl6uQ6oAqmaOT3+h8DjxriUgpL0eKhE
         meKeN5cVfV4BSmi5Z1sX3+DUfNAoAd2M+/KFfj4ZC3G8TQcBbPq+Q2ko0tmEQKyWrTK7
         0aIeR7efzf+8fJyvpGZ/yC40zCK2IZyO0+uuGt1Jt57lbWP787koZkGekyvlHsu7cTJ4
         wxVg==
X-Gm-Message-State: AHQUAuY6bCyzf8Rj5sk5gEWaZgBLb57JWmzqMhjCoO+CuPPM+RqlO/PV
        Si9c/VOhFt5ZSG1gmi/vBmDsbQ==
X-Google-Smtp-Source: AHgI3IYjkX6R8qvsrNFwabxutWQwzahbYb0g/eCyvLnI04fCAyq+CosGYdjtd0H7zJ6RxbMIk0E/bg==
X-Received: by 2002:a62:a113:: with SMTP id b19mr7031150pff.227.1550764665994;
        Thu, 21 Feb 2019 07:57:45 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s2sm41234340pfa.167.2019.02.21.07.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:57:44 -0800 (PST)
Date:   Thu, 21 Feb 2019 07:57:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 3/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190221155742.GD2122@tuxbook-pro>
References: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
 <20190221121841.GA32108@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221121841.GA32108@pendragon.ideasonboard.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Feb 04:18 PST 2019, Laurent Pinchart wrote:

> Hi Vaishali,
> 
> Thank you for the patch.
> 
> On Wed, Feb 20, 2019 at 10:28:29AM +0530, Vaishali Thakkar wrote:
> > The Qualcomm socinfo provides a number of additional attributes,
> > add these to the socinfo driver and expose them via debugfs
> > functionality.
> 
> What is the use case for these attributes ? I fear they will be used in
> production systems, and that would require debugfs in production, which
> isn't a good idea. If you need to expose those attributes for anything
> else than debugging then we need a proper API, likely sysfs-based.
> 

The use case of these attributes, beyond development/debugging, are
unfortunately somewhat unknown and is the reason why they where moved to
debugfs from the earlier attempts to upstream this.

I think the production requirements at hand prohibits debugfs to be
present, so attributes that are required beyond development/debugging
purposes would have to be migrated out to sysfs - but the idea here is
that such migration would have come with the missing motivation to add
them there today.

Regards,
Bjorn

> > Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> > ---
> > Changes since v1:
> > 	- Remove unnecessary debugfs dir creation check
> > 	- Align ifdefs to left
> > 	- Fix function signatures for debugfs init/exit
> > ---
> >  drivers/soc/qcom/socinfo.c | 198 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 198 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> > index 02078049fac7..5f4bef216ae1 100644
> > --- a/drivers/soc/qcom/socinfo.c
> > +++ b/drivers/soc/qcom/socinfo.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (c) 2017-2019, Linaro Ltd.
> >   */
> >  
> > +#include <linux/debugfs.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > @@ -29,6 +30,28 @@
> >   */
> >  #define SMEM_HW_SW_BUILD_ID            137
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +/* pmic model info */
> > +static const char *const pmic_model[] = {
> > +	[0]  = "Unknown PMIC model",
> > +	[9]  = "PM8994",
> > +	[11] = "PM8916",
> > +	[13] = "PM8058",
> > +	[14] = "PM8028",
> > +	[15] = "PM8901",
> > +	[16] = "PM8027",
> > +	[17] = "ISL9519",
> > +	[18] = "PM8921",
> > +	[19] = "PM8018",
> > +	[20] = "PM8015",
> > +	[21] = "PM8014",
> > +	[22] = "PM8821",
> > +	[23] = "PM8038",
> > +	[24] = "PM8922",
> > +	[25] = "PM8917",
> > +};
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> >  /* Socinfo SMEM item structure */
> >  struct socinfo {
> >  	__le32 fmt;
> > @@ -70,6 +93,10 @@ struct socinfo {
> >  struct qcom_socinfo {
> >  	struct soc_device *soc_dev;
> >  	struct soc_device_attribute attr;
> > +#ifdef CONFIG_DEBUG_FS
> > +	struct dentry *dbg_root;
> > +#endif /* CONFIG_DEBUG_FS */
> > +	struct socinfo *socinfo;
> >  };
> >  
> >  struct soc_of_id {
> > @@ -133,6 +160,171 @@ static const char *socinfo_machine(struct device *dev, unsigned int id)
> >  	return NULL;
> >  }
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +#define UINT_SHOW(name, attr)						\
> > +static int qcom_show_##name(struct seq_file *seq, void *p)		\
> > +{									\
> > +	struct socinfo *socinfo = seq->private;				\
> > +	seq_printf(seq, "%u\n", le32_to_cpu(socinfo->attr));		\
> > +	return 0;							\
> > +}									\
> > +static int qcom_open_##name(struct inode *inode, struct file *file)	\
> > +{									\
> > +	return single_open(file, qcom_show_##name, inode->i_private);	\
> > +}									\
> > +									\
> > +static const struct file_operations qcom_ ##name## _ops = {		\
> > +	.open = qcom_open_##name,					\
> > +	.read = seq_read,						\
> > +	.llseek = seq_lseek,						\
> > +	.release = single_release,					\
> > +}
> > +
> > +#define DEBUGFS_UINT_ADD(name)						\
> > +	debugfs_create_file(__stringify(name), 0400,			\
> > +			    qcom_socinfo->dbg_root,			\
> > +			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> > +
> > +#define HEX_SHOW(name, attr)						\
> > +static int qcom_show_##name(struct seq_file *seq, void *p)		\
> > +{									\
> > +	struct socinfo *socinfo = seq->private;				\
> > +	seq_printf(seq, "0x%x\n", le32_to_cpu(socinfo->attr));		\
> > +	return 0;							\
> > +}									\
> > +static int qcom_open_##name(struct inode *inode, struct file *file)	\
> > +{									\
> > +	return single_open(file, qcom_show_##name, inode->i_private);	\
> > +}									\
> > +									\
> > +static const struct file_operations qcom_ ##name## _ops = {		\
> > +	.open = qcom_open_##name,					\
> > +	.read = seq_read,						\
> > +	.llseek = seq_lseek,						\
> > +	.release = single_release,					\
> > +}
> > +
> > +#define DEBUGFS_HEX_ADD(name)						\
> > +	debugfs_create_file(__stringify(name), 0400,			\
> > +			    qcom_socinfo->dbg_root,			\
> > +			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> > +
> > +
> > +#define QCOM_OPEN(name, _func)						\
> > +static int qcom_open_##name(struct inode *inode, struct file *file)	\
> > +{									\
> > +	return single_open(file, _func, inode->i_private);		\
> > +}									\
> > +									\
> > +static const struct file_operations qcom_ ##name## _ops = {		\
> > +	.open = qcom_open_##name,					\
> > +	.read = seq_read,						\
> > +	.llseek = seq_lseek,						\
> > +	.release = single_release,					\
> > +}
> > +
> > +#define DEBUGFS_ADD(name)						\
> > +	debugfs_create_file(__stringify(name), 0400,			\
> > +			    qcom_socinfo->dbg_root,			\
> > +			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> > +
> > +
> > +static int qcom_show_build_id(struct seq_file *seq, void *p)
> > +{
> > +	struct socinfo *socinfo = seq->private;
> > +
> > +	seq_printf(seq, "%s\n", socinfo->build_id);
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_show_accessory_chip(struct seq_file *seq, void *p)
> > +{
> > +	struct socinfo *socinfo = seq->private;
> > +
> > +	seq_printf(seq, "%d\n", le32_to_cpu(socinfo->accessory_chip));
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_show_platform_subtype(struct seq_file *seq, void *p)
> > +{
> > +	struct socinfo *socinfo = seq->private;
> > +	int subtype = le32_to_cpu(socinfo->hw_plat_subtype);
> > +
> > +	if (subtype < 0)
> > +		return -EINVAL;
> > +
> > +	seq_printf(seq, "%u\n", subtype);
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_show_pmic_model(struct seq_file *seq, void *p)
> > +{
> > +	struct socinfo *socinfo = seq->private;
> > +	int model = SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
> > +
> > +	if (model < 0)
> > +		return -EINVAL;
> > +
> > +	seq_printf(seq, "%s\n", pmic_model[model]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
> > +{
> > +	struct socinfo *socinfo = seq->private;
> > +
> > +	seq_printf(seq, "%u.%u\n",
> > +		   SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
> > +		   SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
> > +
> > +	return 0;
> > +}
> > +
> > +UINT_SHOW(raw_version, raw_ver);
> > +UINT_SHOW(hardware_platform, hw_plat);
> > +UINT_SHOW(platform_version, plat_ver);
> > +UINT_SHOW(foundry_id, foundry_id);
> > +HEX_SHOW(chip_family, chip_family);
> > +HEX_SHOW(raw_device_family, raw_device_family);
> > +HEX_SHOW(raw_device_number, raw_device_num);
> > +QCOM_OPEN(build_id, qcom_show_build_id);
> > +QCOM_OPEN(accessory_chip, qcom_show_accessory_chip);
> > +QCOM_OPEN(pmic_model, qcom_show_pmic_model);
> > +QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
> > +QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
> > +
> > +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
> > +{
> > +	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
> > +
> > +	DEBUGFS_UINT_ADD(raw_version);
> > +	DEBUGFS_UINT_ADD(hardware_platform);
> > +	DEBUGFS_UINT_ADD(platform_version);
> > +	DEBUGFS_UINT_ADD(foundry_id);
> > +	DEBUGFS_HEX_ADD(chip_family);
> > +	DEBUGFS_HEX_ADD(raw_device_family);
> > +	DEBUGFS_HEX_ADD(raw_device_number);
> > +	DEBUGFS_ADD(build_id);
> > +	DEBUGFS_ADD(accessory_chip);
> > +	DEBUGFS_ADD(pmic_model);
> > +	DEBUGFS_ADD(platform_subtype);
> > +	DEBUGFS_ADD(pmic_die_revision);
> > +}
> > +
> > +static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
> > +{
> > +	debugfs_remove_recursive(qcom_socinfo->dbg_root);
> > +}
> > +#else
> > +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo) { return 0; }
> > +static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) {  }
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> >  static int qcom_socinfo_probe(struct platform_device *pdev)
> >  {
> >  	struct qcom_socinfo *qs;
> > @@ -165,6 +357,10 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
> >  	if (IS_ERR(qs->soc_dev))
> >  		return PTR_ERR(qs->soc_dev);
> >  
> > +	qs->socinfo = info;
> > +
> > +	socinfo_debugfs_init(qs);
> > +
> >  	/* Feed the soc specific unique data into entropy pool */
> >  	add_device_randomness(info, item_size);
> >  
> > @@ -179,6 +375,8 @@ static int qcom_socinfo_remove(struct platform_device *pdev)
> >  
> >  	soc_device_unregister(qs->soc_dev);
> >  
> > +	socinfo_debugfs_exit(qs);
> > +
> >  	return 0;
> >  }
> > 
> 
> -- 
> Regards,
> 
> Laurent Pinchart
