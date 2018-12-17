Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ECC20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeLQKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:05:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65286 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeLQKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:05:19 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8f2cfd3f1568eef7; Mon, 17 Dec 2018 11:05:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
Date:   Mon, 17 Dec 2018 11:04:54 +0100
Message-ID: <2768059.sVLBmlUf0W@aspire.rjw.lan>
In-Reply-To: <20181215010247.26101-7-okaya@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org> <20181215010247.26101-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 15, 2018 2:02:47 AM CET Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..d0f68607efe6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1437,6 +1437,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  {
> +#ifdef CONFIG_PCI
>  	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>  		struct acpi_iort_node *parent;
>  		struct acpi_iort_id_mapping *map;
> @@ -1462,6 +1463,7 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  			}
>  		}
>  	}
> +#endif
>  
>  	return false;
>  }
> 

I need a maintainer ACK here.



