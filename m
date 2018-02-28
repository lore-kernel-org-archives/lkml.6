Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933491AbeB1RdC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:33:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932236AbeB1Rc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:32:59 -0500
Date: Wed, 28 Feb 2018 19:32:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, bhe@redhat.com,
        slp@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com
Subject: Re: [PATCH v16 06/11] fw_cfg: handle fw_cfg_read_blob() error
Message-ID: <20180228193142-mutt-send-email-mst@kernel.org>
References: <20180228150615.17317-1-marcandre.lureau@redhat.com>
 <20180228150615.17317-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228150615.17317-7-marcandre.lureau@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -557,7 +566,10 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>  		goto err_probe;
>  
>  	/* get revision number, add matching top-level attribute */
> -	fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
> +	err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
> +	if (err < 0)
> +		goto err_probe;
> +
>  	fw_cfg_rev = le32_to_cpu(rev);
>  	err = sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
>  	if (err)

So on this one, maybe we should just drop this attribute.
Does anyone use it?
Removing it will speed up boot slightly.

> -- 
> 2.16.1.73.g5832b7e9f2
