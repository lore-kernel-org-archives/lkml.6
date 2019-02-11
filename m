Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EAFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F2F20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rc5VpAZ5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JjHjZpGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfBKQJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:09:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfBKQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:09:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EA6F6109B; Mon, 11 Feb 2019 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549901344;
        bh=BIpqkAFvht1bC6kR8JT6ResgeGOXjjDO504/d3d+Y9Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rc5VpAZ5rmRDaij4J0hiUgbfnQgrS493Jp/c8CpgBE3Cf17yfHD68n8zMX+TglYCa
         u/B/18pNbjKAJuZeOpJ+NbTv0fja2u+p4zn26I4OlwZpkwMopWDfoL+xYp7/tR58RD
         J5KI3kuwhznPQSPY1DYcxeuHmAl73jO+JBSi9XoA=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1292610DC;
        Mon, 11 Feb 2019 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549901342;
        bh=BIpqkAFvht1bC6kR8JT6ResgeGOXjjDO504/d3d+Y9Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JjHjZpGc7A8W2LpaXJkPPILwaZ/xsNx1U22FEPN7FMGOSIY+q+0+Se2Upqd62pT2G
         xWdcqy/SQx4De+PUW2g6YyA5rAGuN9MSzIAWs4Sa1wsS/JIKxQFSb4vr5iRrqgjKuf
         BK7ZOPTjD9YlkAgvV7nnwZ21vF6I3CGyp66oWO8s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1292610DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
References: <20190129061021.94775-1-sboyd@kernel.org>
 <20190129061021.94775-3-sboyd@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <41f8f325-2738-3995-1fc8-354a9412041e@codeaurora.org>
Date:   Mon, 11 Feb 2019 09:09:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129061021.94775-3-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/2019 11:10 PM, Stephen Boyd wrote:
> The clk_ops::get_parent function is limited in ability to return errors
> because it returns a u8. A "workaround" to return an error is to return
> a number >= the number of parents of a clk. This will in turn cause the
> framework to "orphan" the clk and make the parent of the clk NULL. This
> isn't really correct, because if an error occurs while reading the
> parents of a clk we should fail the clk registration, instead of
> orphaning the clk and waiting for the clk to appear later.
> 
> We really need to have three different return values from the get_parent
> clk op. Something valid for a clk that exists, something invalid for a
> clk that doesn't exist and never will exist or can't be determined
> because the register operation to read the parent failed, and something
> for a clk that doesn't exist because the framework doesn't know about
> what it is. Introduce a new clk_op that can express all of this by
> returning a pointer to the clk_hw of the parent. It's expected that clk
> provider drivers will return a valid pointer when the parent is
> findable, an error pointer like EPROBE_DEFER if their parent provider
> hasn't probed yet but is valid, a NULL pointer if they can't find the
> clk but index is valid, and an error pointer with an appropriate error
> code otherwise.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

<snip>

> +static int clk_init_parent(struct clk_core *core)
> +{
> +	core->parent = __clk_init_parent(core, true);
> +	if (IS_ERR(core->parent))
> +		return PTR_ERR(core->parent);
> +
> +	/*
> +	 * Populate core->parent if parent has already been clk_core_init'd. If
> +	 * parent has not yet been clk_core_init'd then place clk in the orphan
> +	 * list.  If clk doesn't have any parents then place it in the root
> +	 * clk list.
> +	 *
> +	 * Every time a new clk is clk_init'd then we walk the list of orphan
> +	 * clocks and re-parent any that are children of the clock currently
> +	 * being clk_init'd.
> +	 */
> +	if (core->parent) {
> +		hlist_add_head(&core->child_node,
> +				&core->parent->children);
> +		core->orphan = core->parent->orphan;
> +	} else if (!core->num_parents) {
> +		hlist_add_head(&core->child_node, &clk_root_list);
> +		core->orphan = false;
> +	} else {
> +		hlist_add_head(&core->child_node, &clk_orphan_list);

Missing "core->orphan = true;"?
The snippet below had that line.  Its not clear why it appears to be 
dropped here.

> +	}
> +
> +	return 0;
> +}

<snip>

> @@ -3073,29 +3143,9 @@ static int __clk_core_init(struct clk_core *core)
>   				"%s: invalid NULL in %s's .parent_names\n",
>   				__func__, core->name);
>   
> -	core->parent = __clk_init_parent(core);
> -
> -	/*
> -	 * Populate core->parent if parent has already been clk_core_init'd. If
> -	 * parent has not yet been clk_core_init'd then place clk in the orphan
> -	 * list.  If clk doesn't have any parents then place it in the root
> -	 * clk list.
> -	 *
> -	 * Every time a new clk is clk_init'd then we walk the list of orphan
> -	 * clocks and re-parent any that are children of the clock currently
> -	 * being clk_init'd.
> -	 */
> -	if (core->parent) {
> -		hlist_add_head(&core->child_node,
> -				&core->parent->children);
> -		core->orphan = core->parent->orphan;
> -	} else if (!core->num_parents) {
> -		hlist_add_head(&core->child_node, &clk_root_list);
> -		core->orphan = false;
> -	} else {
> -		hlist_add_head(&core->child_node, &clk_orphan_list);
> -		core->orphan = true;
> -	}
> +	ret = clk_init_parent(core);
> +	if (ret)
> +		goto out;
>   
>   	/*
>   	 * optional platform-specific magic


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
