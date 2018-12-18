Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B289C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE06A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T4iKTNaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLRGVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:21:14 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3514 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRGVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:21:13 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1891cf0000>; Mon, 17 Dec 2018 22:21:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 22:21:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Dec 2018 22:21:11 -0800
Received: from [10.19.11.86] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 06:21:10 +0000
Subject: Re: [PATCH 01/18] mfd: aat2870-core: Make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-2-git-send-email-paul.gortmaker@windriver.com>
X-Nvconfidentiality: public
From:   jinyoungp <jinyoungp@nvidia.com>
Message-ID: <da508bdd-390e-bd56-9b54-776519114442@nvidia.com>
Date:   Tue, 18 Dec 2018 15:21:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545078688-21217-2-git-send-email-paul.gortmaker@windriver.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545114063; bh=tzHGIOs8lDXYt4k5sYdUM6mGhkvC4ekQC56erETxbNQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=T4iKTNawWYqVF2gZmUiYtOovXmEFkh8bIgiF4FFpCUyKEimiCr2/kx1r7HJfzfAB/
         zthQCxD1puAymcVW5PaTdmYHRpLGAy9XlEExNrvDgqimffaJu/DAy/XgD+DEOw3Bep
         FJFCwGJfQldzKNg6V924cz9wHaSMBgr4r/3HRpgG36Gy/UfOo4a3ykgLnOyrA+svuE
         j8h3VW+gAh2in636Y12v3MZC2+grnwzMvlE1rmwqpzCEs+FRAzvkHNmE7fRqO6U9o/
         MUorGYk4ZivQS620XuGIaWaBFQeS1sff6xC3ONNgYYF4vdmUSuuRXpTT4wi2i+mbL2
         1WK5P7Ptk964A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by : Jin Park <jinyoungp@nvidia.com>


Thanks,

Jinyoung.


On 12/18/18 5:31 AM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/mfd/Kconfig:config MFD_AAT2870_CORE
> drivers/mfd/Kconfig:    bool "AnalogicTech AAT2870"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Jin Park <jinyoungp@nvidia.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/mfd/aat2870-core.c | 40 +++-------------------------------------
>   1 file changed, 3 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> index 3ba19a45f199..9d3d90d386c2 100644
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
> @@ -20,7 +20,6 @@
>    */
>   
>   #include <linux/kernel.h>
> -#include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/debugfs.h>
>   #include <linux/slab.h>
> @@ -349,18 +348,10 @@ static void aat2870_init_debugfs(struct aat2870_data *aat2870)
>   			 "Failed to create debugfs register file\n");
>   }
>   
> -static void aat2870_uninit_debugfs(struct aat2870_data *aat2870)
> -{
> -	debugfs_remove_recursive(aat2870->dentry_root);
> -}
>   #else
>   static inline void aat2870_init_debugfs(struct aat2870_data *aat2870)
>   {
>   }
> -
> -static inline void aat2870_uninit_debugfs(struct aat2870_data *aat2870)
> -{
> -}
>   #endif /* CONFIG_DEBUG_FS */
>   
>   static int aat2870_i2c_probe(struct i2c_client *client,
> @@ -440,20 +431,6 @@ static int aat2870_i2c_probe(struct i2c_client *client,
>   	return ret;
>   }
>   
> -static int aat2870_i2c_remove(struct i2c_client *client)
> -{
> -	struct aat2870_data *aat2870 = i2c_get_clientdata(client);
> -
> -	aat2870_uninit_debugfs(aat2870);
> -
> -	mfd_remove_devices(aat2870->dev);
> -	aat2870_disable(aat2870);
> -	if (aat2870->uninit)
> -		aat2870->uninit(aat2870);
> -
> -	return 0;
> -}
> -
>   #ifdef CONFIG_PM_SLEEP
>   static int aat2870_i2c_suspend(struct device *dev)
>   {
> @@ -492,15 +469,14 @@ static const struct i2c_device_id aat2870_i2c_id_table[] = {
>   	{ "aat2870", 0 },
>   	{ }
>   };
> -MODULE_DEVICE_TABLE(i2c, aat2870_i2c_id_table);
>   
>   static struct i2c_driver aat2870_i2c_driver = {
>   	.driver = {
> -		.name	= "aat2870",
> -		.pm	= &aat2870_pm_ops,
> +		.name			= "aat2870",
> +		.pm			= &aat2870_pm_ops,
> +		.suppress_bind_attrs	= true,
>   	},
>   	.probe		= aat2870_i2c_probe,
> -	.remove		= aat2870_i2c_remove,
>   	.id_table	= aat2870_i2c_id_table,
>   };
>   
> @@ -509,13 +485,3 @@ static int __init aat2870_init(void)
>   	return i2c_add_driver(&aat2870_i2c_driver);
>   }
>   subsys_initcall(aat2870_init);
> -
> -static void __exit aat2870_exit(void)
> -{
> -	i2c_del_driver(&aat2870_i2c_driver);
> -}
> -module_exit(aat2870_exit);
> -
> -MODULE_DESCRIPTION("Core support for the AnalogicTech AAT2870");
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Jin Park <jinyoungp@nvidia.com>");
