Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D170CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABDF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABDF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJSBE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:04:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46969 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSBE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:04:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id o21so30445196otb.13;
        Thu, 18 Oct 2018 10:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cETW7hbTpVAjv5VCuBz0OkmilWTcZUemT5Kzp8m8Bq8=;
        b=PNkELAodDoEuq2o3ERN6usYQuM4RKKPisPNYl1+3IyLJyVrlLUfr1OSgpKBUHuko06
         KsdX6esnWYan+Cc4ctJsMKcZ/AoV1H4zJBcUN2Lv5ccj2Um5PKWk9m26HS6bdzXbUlr6
         c7mw6oIVTgDmtMUIWxOe9vbZAcZ0wAGhHHflW7/J+m/QeVWkuXaSvMYcH4+0KorNipVk
         stI/a6xMDoIZbwuHqgpHukegxzFjO9aKcLhQ+bTEHAlH2QUwcP0BirFDrPsNVJXTDqTg
         L1I+9OFqfDarudKhXpoc1UV6CLtfw1OxGI99G5MhZYLS3EflZhHlaEIqe9v4AkbUeLq/
         aBwQ==
X-Gm-Message-State: ABuFfohfYlpknQaQm8I42IQ/lbe9u0uF8B3qUr9FKEK019Mjt9U4N6Tm
        gXBOHIsHfnI9fhjtilGH5A==
X-Google-Smtp-Source: ACcGV63HVBX6F1IcWwcrKaQRnKvwZWcBLPpimTQ8OzIUZxxJVHPjutSTC5afwQMV7f5Q9peed6p0rw==
X-Received: by 2002:a9d:3cbd:: with SMTP id z58mr20537878otc.159.1539882185222;
        Thu, 18 Oct 2018 10:03:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u107sm3866233otb.71.2018.10.18.10.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 10:03:04 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:03:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
Message-ID: <20181018170303.GA15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:37:21PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add checks:
>   - attempted kfree due to refcount reaching zero before overlay
>     is removed
>   - properties linked to an overlay node when the node is removed
>   - node refcount > one during node removal in a changeset destroy,
>     if the node was created by the changeset
> 
> After applying this patch, several validation warnings will be
> reported from the devicetree unittest during boot due to
> pre-existing devicetree bugs. The warnings will be similar to:
> 
>   OF: ERROR: of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest11/test-unittest111 contains unexpected properties
>   OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 expected refcount 1 instead of 2.  of_node_get() / of_node_put() are unbalanced for this node.

These messages could be formatted more consistently. Put the path either 
at the beginning (after any prefix) or end. Beginning is more like a 
compiler error. End puts what the problem is before it's off the edge of 
the screen. 

> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since v3:
>   - Add expected value of refcount for destroy cset entry error.  Also
>     explain the cause of the error.
> 
>  drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
>  drivers/of/overlay.c |  1 +
>  include/linux/of.h   | 15 ++++++++++-----
>  3 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index f4f8ed9b5454..24c97b7a050f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
>  	if (!of_node_check_flag(node, OF_DYNAMIC))
>  		return;
>  
> +	if (of_node_check_flag(node, OF_OVERLAY)) {
> +
> +		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {

I worry the flags are getting unwieldy.

> +			/* premature refcount of zero, do not free memory */
> +			pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
> +			       __func__, node);
> +			return;
> +		}
> +
> +		/*
> +		 * If node->properties non-empty then properties were added
> +		 * to this node either by different overlay that has not
> +		 * yet been removed, or by a non-overlay mechanism.
> +		 */
> +		if (node->properties)
> +			pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
> +			       __func__, node);
> +	}
> +
>  	property_list_free(node->properties);
>  	property_list_free(node->deadprops);
>  
> @@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
>  
>  static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
>  {
> +	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
> +	    of_node_check_flag(ce->np, OF_OVERLAY)) {
> +		if (kref_read(&ce->np->kobj.kref) > 1) {
> +			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
> +			       ce->np, kref_read(&ce->np->kobj.kref));
> +		} else {
> +			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
> +		}
> +	}
> +
>  	of_node_put(ce->np);
>  	list_del(&ce->node);
>  	kfree(ce);
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index eda57ef12fd0..1176cb4b6e4e 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>  			return -ENOMEM;
>  
>  		tchild->parent = target_node;
> +		of_node_set_flag(tchild, OF_OVERLAY);
>  
>  		ret = of_changeset_attach_node(&ovcs->cset, tchild);
>  		if (ret)
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..aa1dafaec6ae 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
>  extern struct device_node *of_stdout;
>  extern raw_spinlock_t devtree_lock;
>  
> -/* flag descriptions (need to be visible even when !CONFIG_OF) */
> -#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
> -#define OF_DETACHED	2 /* node has been detached from the device tree */
> -#define OF_POPULATED	3 /* device already created for the node */
> -#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
> +/*
> + * struct device_node flag descriptions
> + * (need to be visible even when !CONFIG_OF)
> + */
> +#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
> +#define OF_DETACHED		2 /* detached from the device tree */
> +#define OF_POPULATED		3 /* device already created */
> +#define OF_POPULATED_BUS	4 /* platform bus created for children */
> +#define OF_OVERLAY		5 /* allocated for an overlay */
> +#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
>  
>  #define OF_BAD_ADDR	((u64)-1)
>  
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
