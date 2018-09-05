Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B34C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D81A20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeF9roHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D81A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIEHs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:48:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45273 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeIEHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:48:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so2692217pfo.12;
        Tue, 04 Sep 2018 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2WBR5dtm30RWWDQTUxMC/dUSaIScttpr6CWmwgFAyes=;
        b=oeF9roHjfXQl8Ep+GXFPqfFJjwWwbdjN4Mz0Pw5SMytcQHMognvzFTcOJYsIocLVO/
         RF+UKmdSshX2S/0krWmvXC7iV4E3c3DG5FnCzNuvgUNdWUQgakYJvPap63DyLP3cUaRz
         /C/SWXtoXmYX9LLEwuvJOHwsQlwXG7KvGMCqcB4oMKcxZFFl1zSys5cvbX4NKFd6osRB
         6ZIkxp6HXKtofzTMsXdHhzE7vMIysFTYpBmo+bGcjzwcSBNgdlcg+chbKXCZJp44MbnY
         wV+zrYcWjViVOhLAMGHcH6ElFOOc329ZCJ0IrbV+o8RrBD0WapMTGfA1Tt5Ht+dCoKAm
         hDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2WBR5dtm30RWWDQTUxMC/dUSaIScttpr6CWmwgFAyes=;
        b=RG4Zba5z/OPGBW9s/sdvLjVFISjEPahFWKPW1Yn0VY34G9MYI79EGVtVXSeppv2rJB
         x5XFum96kfCWLPDR4dp0c5DW0O8IeZoFmmiq3fZSxf6dyyUcMNJRVXl+iORyN706LWpT
         /bAt2Wr4omu+Ym6AM5dslkDkmPJ75Lw0yK/WFmccuOPIV5NnzGVAVZpgAOYET/ltvTgL
         W00MAVMOQeNBM6//gOzcJ6Zb24einMJNUUC8MoWR3KVc+COmkszcc/uCSBWcX0Z1ovBU
         3wiNkgrT0eHmGbccdh1nM3JXucIhDCwDDcSqKpfND8SR2i5PQS/TgxDcqZRlef66skSb
         Zr3w==
X-Gm-Message-State: APzg51Ct07dai/EFOMCh1szd+PH6ZKtYAa761IXZtxKmbfRWK3ALsMP+
        Lzi84mAArdrmOLDzrYdToYg=
X-Google-Smtp-Source: ANB0VdZ38lhy8qyP7TybMpYZxuHGaiayuTCcrnN30RfRjLQNydA/xmV0ne8EUzfvneBGwnMUuqrvyQ==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr34704963pgq.382.1536117624651;
        Tue, 04 Sep 2018 20:20:24 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id t15-v6sm614210pfa.158.2018.09.04.20.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 20:20:23 -0700 (PDT)
Subject: Re: [PATCH] of: add node name compare helper functions
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180830185216.20054-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ef6c5e8c-4a73-4035-0dc3-bda9b35fa8cc@gmail.com>
Date:   Tue, 4 Sep 2018 20:20:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185216.20054-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 11:52, Rob Herring wrote:
> In preparation to remove device_node.name pointer, add helper functions
> for node name comparisons which are a common pattern throughout the kernel.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/base.c  | 22 ++++++++++++++++++++++
>  include/linux/of.h | 13 +++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 466e3c8582f0..185bfe077d0a 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -54,6 +54,28 @@ DEFINE_MUTEX(of_mutex);
>   */
>  DEFINE_RAW_SPINLOCK(devtree_lock);
>  
> +bool of_node_name_eq(const struct device_node *np, const char *name)
> +{
> +	const char *node_name;
> +	size_t len;
> +
> +	if (!np)
> +		return false;
> +
> +	node_name = kbasename(np->full_name);
> +	len = strchrnul(node_name, '@') - node_name;
> +
> +	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
> +}
> +
> +bool of_node_name_prefix(const struct device_node *np, const char *prefix)

        of_node_name_prefix_eq() would be more clear and consistent.

of_node_name_prefix() sounds like it would return the prefix of *np.


> +{
> +	if (!np)
> +		return false;
> +
> +	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
> +}
> +
>  int of_n_addr_cells(struct device_node *np)
>  {
>  	u32 cells;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..a40f63a36afa 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -256,6 +256,9 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
>  #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
>  #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
>  
> +extern bool of_node_name_eq(const struct device_node *np, const char *name);
> +extern bool of_node_name_prefix(const struct device_node *np, const char *prefix);
> +
>  static inline const char *of_node_full_name(const struct device_node *np)
>  {
>  	return np ? np->full_name : "<no-node>";
> @@ -561,6 +564,16 @@ static inline struct device_node *to_of_node(const struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> +static inline bool of_node_name_eq(const struct device_node *np, const char *name)
> +{
> +	return false;
> +}
> +
> +static inline bool of_node_name_prefix(const struct device_node *np, const char *prefix)
> +{
> +	return false;
> +}
> +
>  static inline const char* of_node_full_name(const struct device_node *np)
>  {
>  	return "<no-node>";
> 

