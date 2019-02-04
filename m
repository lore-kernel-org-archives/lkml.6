Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD7B214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TySybSrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfBDP04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:26:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53588 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfBDP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:26:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14FQ4jY041368;
        Mon, 4 Feb 2019 09:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549293964;
        bh=ZAiTKUMONViPCmDQH91nCbue+sqhhm1LBPKjYp8T9Mw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TySybSrIIXV5CNRqEgwNhD6Ek2gSqgdZMiqCoMcX1R2i4FBHOntZBEJm94NBtuCqO
         /0TNg8+V5Htx0t12nO0pCz2czHDT0hMB+fg2bw7V/udrml2DG+DGTati5IUD3yGU22
         GxCTPaqaS0y0YB7vf6sGh5NELYgr4REIV58XyP8Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14FQ36c119160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:26:04 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:26:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:26:03 -0600
Received: from [172.22.77.137] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14FQ2DL010368;
        Mon, 4 Feb 2019 09:26:03 -0600
Subject: Re: [PATCH v2 14/14] rpmsg: pru: add a PRU RPMsg driver
To:     Roger Quadros <rogerq@ti.com>, <tony@atomide.com>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-15-git-send-email-rogerq@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <e97f7bfc-a3c2-92a9-953e-572d9438d020@ti.com>
Date:   Mon, 4 Feb 2019 09:26:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1549290167-876-15-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 8:22 AM, Roger Quadros wrote:
> From: Jason Reeder <jreeder@ti.com>
> 

[...]

> +/* .name matches on RPMsg Channels and causes a probe */
> +static const struct rpmsg_device_id rpmsg_driver_pru_id_table[] = {
> +	{ .name	= "rpmsg-pru" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_pru_id_table);
> +
> +static struct rpmsg_driver rpmsg_pru_driver = {
> +	.drv.name	= KBUILD_MODNAME,
> +	.id_table	= rpmsg_driver_pru_id_table,
> +	.probe		= rpmsg_pru_probe,
> +	.callback	= rpmsg_pru_cb,
> +	.remove		= rpmsg_pru_remove,
> +};
> +
> +static int __init rpmsg_pru_init(void)
> +{
> +	int ret;
> +
> +	rpmsg_pru_class = class_create(THIS_MODULE, "rpmsg_pru");
> +	if (IS_ERR(rpmsg_pru_class)) {
> +		pr_err("Unable to create class\n");
> +		ret = PTR_ERR(rpmsg_pru_class);
> +		goto fail_create_class;
> +	}
> +
> +	ret = alloc_chrdev_region(&rpmsg_pru_devt, 0, PRU_MAX_DEVICES,
> +				  "rpmsg_pru");
> +	if (ret) {
> +		pr_err("Unable to allocate chrdev region\n");
> +		goto fail_alloc_region;
> +	}
> +
> +	ret = register_rpmsg_driver(&rpmsg_pru_driver);
> +	if (ret) {
> +		pr_err("Unable to register rpmsg driver");
> +		goto fail_register_rpmsg_driver;
> +	}
> +
> +	return 0;
> +
> +fail_register_rpmsg_driver:
> +	unregister_chrdev_region(rpmsg_pru_devt, PRU_MAX_DEVICES);
> +fail_alloc_region:
> +	class_destroy(rpmsg_pru_class);
> +fail_create_class:
> +	return ret;
> +}
> +
> +static void __exit rpmsg_pru_exit(void)
> +{
> +	unregister_rpmsg_driver(&rpmsg_pru_driver);
> +	idr_destroy(&rpmsg_pru_minors);
> +	mutex_destroy(&rpmsg_pru_lock);
> +	class_destroy(rpmsg_pru_class);
> +	unregister_chrdev_region(rpmsg_pru_devt, PRU_MAX_DEVICES);
> +}
> +
> +module_init(rpmsg_pru_init);
> +module_exit(rpmsg_pru_exit);
> +
> +MODULE_AUTHOR("Jason Reeder <jreeder@ti.com>");
> +MODULE_ALIAS("rpmsg:rpmsg-pru");

MODULE_ALIAS not needed, MODULE_DEVICE_TABLE will generate the alias.

Andrew

> +MODULE_DESCRIPTION("PRU Remote Processor Messaging Driver");
> +MODULE_LICENSE("GPL v2");
> 
