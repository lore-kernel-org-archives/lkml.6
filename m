Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25287222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391082AbfBOUoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:44:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBOUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:44:21 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1gukLL-0006Vu-B9
        for linux-kernel@vger.kernel.org; Fri, 15 Feb 2019 20:44:19 +0000
Received: by mail-it1-f197.google.com with SMTP id v12so8677641itv.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 12:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A9WtFQMilKbKMRbQBy9WP+3hK09k4Gbdl3FV6hhfD8o=;
        b=aoYkwtI4+y/hRafU6QM9t4Vf+2fZu91I2I0EgRjNYvpkQ9ZRrIz7lm0RfYJPBb1Q/g
         GO/uSfdxWm3JufrWh9N8gx1OfmdwgendRsp6CPPR4ryYBCsCxVcQOmnqqUJhdGk3a1hL
         jgCnYleb86+cpGvUbrlCRDaBwAXVxwFpJ6hjV60GEOr3P2ISpvIJmOlKRYT3RSAeDVjP
         AuLaKQiGfDzi9gMTy3PrG2qxvxByHKdySBy5+a6ZFPCPjFTr1A2YlMdIsHFgRB0fGVdq
         UfsU1QWPRIfzj+KEDHT6tYTrTqgPq6yEPAACo6RFvQau2u7HUVVsDXC0f3GkqswLTAXN
         HKXQ==
X-Gm-Message-State: AHQUAuZ1uyGgVNRq3/F2WA7zjSApKJYI/uToH1ooxnYoBZCW8iPlotXm
        /QSvxoYgJ5mAPbCuzFVfBaKnxsWhE1mIMASYRefVEqpovnrWVa1DQoSf2DBmiCjQG955QTK6/1W
        3b+8xg6LbKcx77oXurdG1wHqiH9y6Qf1QWj56mG3ZwQ==
X-Received: by 2002:a6b:6d18:: with SMTP id a24mr7551952iod.292.1550263458245;
        Fri, 15 Feb 2019 12:44:18 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbOgSKawyJh7zalNtBcT07cSc5l1ckriSLe5CuOum8N37ohPaD/p302L7fyToKav4ZBkOGn7g==
X-Received: by 2002:a6b:6d18:: with SMTP id a24mr7551935iod.292.1550263457892;
        Fri, 15 Feb 2019 12:44:17 -0800 (PST)
Received: from xps13.canonical.com (c-107-2-141-103.hsd1.co.comcast.net. [107.2.141.103])
        by smtp.gmail.com with ESMTPSA id k18sm2637193ioa.39.2019.02.15.12.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 12:44:16 -0800 (PST)
Date:   Fri, 15 Feb 2019 13:44:15 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, yanaijie@huawei.com
Subject: Re: [PATCH] scsi: libsas: Fix rphy phy_identifier for PHYs with end
 devices attached
Message-ID: <20190215204415.GA1006@xps13.dannf>
References: <1550162277-17615-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550162277-17615-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:37:57AM +0800, John Garry wrote:
> The sysfs phy_identifier attribute for a sas_end_device comes
> from the rphy phy_identifier value.
> 
> Currently this is not being set for rphys with an end device attached,
> so we see incorrect symlinks from systemd disk/by-path:
> 
> root@localhost:~# ls -l /dev/disk/by-path/
> total 0
> lrwxrwxrwx 1 root root  9 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0 -> ../../sdb
> lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part1 -> ../../sdb1
> lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part2 -> ../../sdb2
> lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part3 -> ../../sdc3
> 
> Indeed, each sas_end_device phy_identifier value is 0:
> 
> root@localhost:/# more sys/class/sas_device/end_device-0\:0\:2/phy_identifier
> 0
> root@localhost:/# more sys/class/sas_device/end_device-0\:0\:10/phy_identifier
> 0
> 
> This patch fixes the discovery code to set the phy_identifier.
> With this, we now get proper symlinks:
> 
> root@localhost:~# ls -l /dev/disk/by-path/
> total 0
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy10-lun-0 -> ../../sdg
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy11-lun-0 -> ../../sdh
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0 -> ../../sda
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0-part1 -> ../../sda1
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0 -> ../../sdb
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part1 -> ../../sdb1
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part2 -> ../../sdb2
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0 -> ../../sdc
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part1 -> ../../sdc1
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part2 -> ../../sdc2
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part3 -> ../../sdc3
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy5-lun-0 -> ../../sdd
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0 -> ../../sde
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part1 -> ../../sde1
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part2 -> ../../sde2
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part3 -> ../../sde3
> lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0 -> ../../sdf
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part1 -> ../../sdf1
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part2 -> ../../sdf2
> lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part3 -> ../../sdf3
> 
> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
> Reported-by: dann frazier <dann.frazier@canonical.com>

Thanks John. Solves the problem for me as well.

Tested-by: dann frazier <dann.frazier@canonical.com>

  -dann

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 17eb4185f29d..f21c93bbb35c 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -828,6 +828,7 @@ static struct domain_device *sas_ex_discover_end_dev(
>  		rphy = sas_end_device_alloc(phy->port);
>  		if (!rphy)
>  			goto out_free;
> +		rphy->identify.phy_identifier = phy_id;
>  
>  		child->rphy = rphy;
>  		get_device(&rphy->dev);
> @@ -854,6 +855,7 @@ static struct domain_device *sas_ex_discover_end_dev(
>  
>  		child->rphy = rphy;
>  		get_device(&rphy->dev);
> +		rphy->identify.phy_identifier = phy_id;
>  		sas_fill_in_rphy(child, rphy);
>  
>  		list_add_tail(&child->disco_list_node, &parent->port->disco_list);
