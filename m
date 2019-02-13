Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D6C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C153222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390234AbfBMIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:06:40 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:51476 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfBMIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:06:40 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544482800"; 
   d="scan'208";a="369201899"
Received: from unknown (HELO [193.50.110.185]) ([193.50.110.185])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA; 13 Feb 2019 09:06:16 +0100
Subject: Re: [PATCH v2] device-dax: Auto-bind device after successful new_id
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <155002261877.645460.9109209504128012410.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Brice Goglin <Brice.Goglin@inria.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Brice.Goglin@inria.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <37673cff-fec8-a575-5e50-164497fbe7d3@inria.fr>
Date:   Wed, 13 Feb 2019 09:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155002261877.645460.9109209504128012410.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan, remove_id works now.

Brice


Le 13/02/2019 à 02:50, Dan Williams a écrit :
> The typical 'new_id' attribute behavior is to immediately attach a
> device to its driver after a new device-id is added. Implement this
> behavior for the dax bus.
>
> Reported-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1:
> * Fix the remove_id path since do_id_store() is shared with the new_id
>   path (Brice)
>
> Brice, this works for me. I'll push it out on libnvdimm-pending, or in
> the meantime you can apply this patch after reverting commit
> a9f1ffdb6a20 on the current state of the branch.
>
>  drivers/dax/bus.c |   24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index c620ad52d7e5..a410154d75fb 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -57,8 +57,13 @@ static int dax_match_id(struct dax_device_driver *dax_drv, struct device *dev)
>  	return match;
>  }
>  
> +enum id_action {
> +	ID_REMOVE,
> +	ID_ADD,
> +};
> +
>  static ssize_t do_id_store(struct device_driver *drv, const char *buf,
> -		size_t count, bool add)
> +		size_t count, enum id_action action)
>  {
>  	struct dax_device_driver *dax_drv = to_dax_drv(drv);
>  	unsigned int region_id, id;
> @@ -77,7 +82,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
>  	mutex_lock(&dax_bus_lock);
>  	dax_id = __dax_match_id(dax_drv, buf);
>  	if (!dax_id) {
> -		if (add) {
> +		if (action == ID_ADD) {
>  			dax_id = kzalloc(sizeof(*dax_id), GFP_KERNEL);
>  			if (dax_id) {
>  				strncpy(dax_id->dev_name, buf, DAX_NAME_LEN);
> @@ -86,26 +91,33 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
>  				rc = -ENOMEM;
>  		} else
>  			/* nothing to remove */;
> -	} else if (!add) {
> +	} else if (action == ID_REMOVE) {
>  		list_del(&dax_id->list);
>  		kfree(dax_id);
>  	} else
>  		/* dax_id already added */;
>  	mutex_unlock(&dax_bus_lock);
> -	return rc;
> +
> +	if (rc < 0)
> +		return rc;
> +	if (action == ID_ADD)
> +		rc = driver_attach(drv);
> +	if (rc)
> +		return rc;
> +	return count;
>  }
>  
>  static ssize_t new_id_store(struct device_driver *drv, const char *buf,
>  		size_t count)
>  {
> -	return do_id_store(drv, buf, count, true);
> +	return do_id_store(drv, buf, count, ID_ADD);
>  }
>  static DRIVER_ATTR_WO(new_id);
>  
>  static ssize_t remove_id_store(struct device_driver *drv, const char *buf,
>  		size_t count)
>  {
> -	return do_id_store(drv, buf, count, false);
> +	return do_id_store(drv, buf, count, ID_REMOVE);
>  }
>  static DRIVER_ATTR_WO(remove_id);
>  
>
