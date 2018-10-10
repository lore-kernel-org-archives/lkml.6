Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD98214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE8DByP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD98214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJJOKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:10:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41408 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:10:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so2037469plr.8;
        Tue, 09 Oct 2018 23:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpMkdS3QhWrgpn06vOefCnQ39CvqBm/6WODayrNfPEY=;
        b=NE8DByP4QseDU65CppldgCKW0b7Qrx9OQdtheif0cMaquiFtwb9J07iwtE9kox4ipg
         re0/NrMwmNtiVRvDXaptrEfvl4M+kwXpYm+7K+LeWExhY5vSDHoeUpTJoBG3QsSCxB1F
         ZQQkUYLu4NqRbq0IV8xzM/VtJiUojNGtIDi0aNfpXF8e4emvP2atPeNYCpr/eUN2Tkh9
         hRfmeb35uhIB0ivtjNPT/n/VavSGtnYLSy4j3CM03b8J0nBntGOjHxEv8eVJg6TnbpEB
         ehwWcOca3p/RWMTcoxQGILuQtEPvzK1YzZzY30zv3wDgYbi1+LM1fcXo6ojp2eIl0p8Q
         3XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpMkdS3QhWrgpn06vOefCnQ39CvqBm/6WODayrNfPEY=;
        b=QUH7xi6uai+qS8PbdDKJd3kbY03RpB7Sz/7QFhY6a84E1gfxHQGuG+yl8uG30jmImq
         7AZ0BdXqI1fMjC5BHn0wnd0SKphfuv5vYbTHiqmXLZANCR7TyCq1UEJELubHfS7ywPvd
         u3wliT/3jUaXrTo2Xc5s2VjP5GWvg2Wfe9kNcsZQnPRxndG58FwdWhHn+5oSYEltnbJq
         IOt4xC67RCVWRWjGdl9njEayUe63urzaZjEIo4R1AEpDNOYuGc/yquU1NiJshtLhDkES
         OD8ClFrzZAMQSeePjTjDRgh38hHwBjVy7lTQs1WGDXjzCDCzhoy/eBI9YrWMP5x30brs
         +gqw==
X-Gm-Message-State: ABuFfohfgQHykeI+St2afJ6rLRBLgBARXjOnYtX8WOYBjeud9EqzGSrx
        8YVQy2nZkYdAVD7J1oIxzuZQx4FJ
X-Google-Smtp-Source: ACcGV60QU2F+ipwuJLOwq8Y3vUKaUsjQgvKKy7D8wd6sogy8uqMfWU6iJgsHpiXFk/hAeloKEaGMpw==
X-Received: by 2002:a17:902:b285:: with SMTP id u5-v6mr31087829plr.221.1539154162488;
        Tue, 09 Oct 2018 23:49:22 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id m10-v6sm33112807pfg.180.2018.10.09.23.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 23:49:21 -0700 (PDT)
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
Message-ID: <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
Date:   Tue, 9 Oct 2018 23:49:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 23:04, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> 
> "of: overlay: use prop add changeset entry for property in new nodes"
> fixed a problem where an 'update property' changeset entry was
> created for properties contained in nodes added by a changeset.
> The fix was to use an 'add property' changeset entry.
> 
> This exposed more bugs in the apply overlay code.  The properties
> 'name', 'phandle', and 'linux,phandle' were filtered out by
> add_changeset_property() as special properties.  Change the filter
> to be only for existing nodes, not newly added nodes.
> 
> The second bug is that the 'name' property does not exist in the
> newest FDT version, and has to be constructed from the node's
> full_name.  Construct an 'add property' changeset entry for
> newly added nodes.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> 
> Hi Alan,
> 
> Thanks for reporting the problem with missing node names.
> 
> I was able to replicate the problem, and have created this preliminary
> version of a patch to fix the problem.
> 
> I have not extensively reviewed the patch yet, but would appreciate
> if you can confirm this fixes your problem.
> 
> I created this patch as patch 17 of the series, but have also
> applied it as patch 05.1, immediately after patch 05/16, and
> built the kernel, booted, and verified name and phandle for
> one of the nodes in a unittest overlay for both cases.  So
> minimal testing so far on my part.
> 
> I have not verified whether the series builds and boots after
> each of patches 06..16 if this patch is applied as patch 05.1.
> 
> There is definitely more work needed for me to complete this
> patch because it allocates some more memory, but does not yet
> free it when the overlay is released.
> 
> -Frank
> 
> 
>  drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 0b0904f44bc7..9746cea2aa91 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  	struct property *new_prop = NULL, *prop;
>  	int ret = 0;
>  
> -	if (!of_prop_cmp(overlay_prop->name, "name") ||
> -	    !of_prop_cmp(overlay_prop->name, "phandle") ||
> -	    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> -		return 0;
> +	if (target->in_livetree)
> +		if (!of_prop_cmp(overlay_prop->name, "name") ||
> +		    !of_prop_cmp(overlay_prop->name, "phandle") ||
> +		    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> +			return 0;

This is a big hammer patch.

Nobody should waste time reviewing this patch.

The following part should not be needed (though the above section might have
to become _slightly_ more complex).

-Frank
>  
>  	if (target->in_livetree)
>  		prop = of_find_property(target->np, overlay_prop->name, NULL);
> @@ -443,10 +444,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>  		struct target *target, const struct device_node *overlay_node)
>  {
>  	struct device_node *child;
> -	struct property *prop;
> +	struct property *prop, *name_prop;
> +	bool has_name = false;
>  	int ret;
>  
>  	for_each_property_of_node(overlay_node, prop) {
> +		if (!strcmp(prop->name, "name"))
> +			has_name = true;
>  		ret = add_changeset_property(ovcs, target, prop, 0);
>  		if (ret) {
>  			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
> @@ -455,6 +459,57 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>  		}
>  	}
>  
> +	/*
> +	 * With FDT version 0x10 we may not have the name property,
> +	 * recreate it here from the unit name if absent
> +	 */
> +
> +	if (!has_name) {
> +		const char *p = target->np->full_name, *ps = p, *pa = NULL;
> +		int len;
> +
> +		/*
> +		 * zzz
> +		 * TODO: stash name_prop on a list in ovcs, to be freed
> +		 * after overlay removed
> +		 */
> +
> +		while (*p) {
> +			if ((*p) == '@')
> +				pa = p;
> +			else if ((*p) == '/')
> +				ps = p + 1;
> +			p++;
> +		}
> +
> +		if (pa < ps)
> +			pa = p;
> +		len = (pa - ps) + 1;
> +
> +		name_prop = kmalloc(sizeof(*name_prop), GFP_KERNEL);
> +		if (!name_prop)
> +			return -ENOMEM;
> +
> +		name_prop->name = kstrdup("name", GFP_KERNEL);
> +		name_prop->value = kmalloc(len, GFP_KERNEL);
> +		if (!name_prop->name || !name_prop->value) {
> +			ret = -ENOMEM;
> +			goto err_free_name_prop;
> +		}
> +
> +		memcpy(name_prop->value, ps, len - 1);
> +		((char *)name_prop->value)[len - 1] = 0;
> +
> +		name_prop->length = strlen(name_prop->value) + 1;
> +
> +		ret = add_changeset_property(ovcs, target, name_prop, 0);
> +		if (ret) {
> +			pr_debug("Failed to apply name_prop @%pOF/%s, err=%d\n",
> +				 target->np, name_prop->name, ret);
> +			goto err_free_name_prop;
> +		}
> +	}
> +
>  	for_each_child_of_node(overlay_node, child) {
>  		ret = add_changeset_node(ovcs, target, child);
>  		if (ret) {
> @@ -466,6 +521,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>  	}
>  
>  	return 0;
> +
> +err_free_name_prop:
> +	kfree(name_prop->name);
> +	kfree(name_prop->value);
> +	kfree(name_prop);
> +	return ret;
> +
>  }
>  
>  /*
> 

