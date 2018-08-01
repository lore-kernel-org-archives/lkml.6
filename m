Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD90C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06D720844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fpLWzdHH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VJaGszFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06D720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeHBAqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:46:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35984 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeHBAqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:46:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1684D6035F; Wed,  1 Aug 2018 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533164274;
        bh=C04Re1CqJXuw98/PHxnY9Cuky0miG3IpX92+IQKs0lQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fpLWzdHHQ7dggRQQ4RoM1ZiRaTmY7vpLXWce4F+u9ksjTCOpQtlgq7WHNHeGMoDY6
         puQpw35rmCOvoveCdYkLEOcl2VFHtAGuPM0nFPPPmIZpjhiOzlNYpUugouRUK17poQ
         444VAW2PePBqB1J0KomaBbifiixVbd/wxLZoN3p8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B42296035F;
        Wed,  1 Aug 2018 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533164272;
        bh=C04Re1CqJXuw98/PHxnY9Cuky0miG3IpX92+IQKs0lQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJaGszFd1KMFUnTR7WHFUZiryv8vXQ+1bZfDnCQsDNH/MUZhztsJ6hA108e5ceSlw
         Vp8jNo8D4Ipw1v96HJsqIrVGH9h08KtSJrU7vSpYG/NeVq/voyFxZ8w3A9Fjl+JUf1
         Z+RX02BcydsFyKqOk484dOJ8ZfOm5XwYdEpShgDY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 15:57:52 -0700
From:   skannan@codeaurora.org
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
In-Reply-To: <20180731161340.13000-9-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
Message-ID: <804925d5927ccb6927b16f7e9a4aa05c@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 09:13, Georgi Djakov wrote:
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation 
> function
> to help us get the board specific interconnect data from device-tree.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h |  7 ++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 9fef180cf77e..d1b6adff0a3d 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <linux/overflow.h>
>  #include <linux/uaccess.h>
> 
> @@ -251,6 +252,67 @@ static int apply_constraints(struct icc_path 
> *path)
>  	return ret;
>  }
> 
> +struct icc_path *of_icc_get(struct device *dev, const char *name)
> +{
> +	struct device_node *np = NULL;
> +	struct of_phandle_args src_args, dst_args;
> +	u32 src_id, dst_id;
> +	int idx = 0;
> +	int ret;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	np = dev->of_node;
> +
> +	/*
> +	 * When the consumer DT node do not have "interconnects" property
> +	 * return a NULL path to skip setting constraints.
> +	 */
> +	if (!of_find_property(np, "interconnects", NULL))
> +		return NULL;
> +
> +	/*
> +	 * We use a combination of phandle and specifier for endpoint. For 
> now
> +	 * lets support only global ids and extend this is the future if 
> needed
> +	 * without breaking DT compatibility.
> +	 */
> +	if (name) {
> +		idx = of_property_match_string(np, "interconnect-names", name);
> +		if (idx < 0)
> +			return ERR_PTR(idx);
> +	}
> +
> +	ret = of_parse_phandle_with_args(np, "interconnects",
> +					 "#interconnect-cells", idx * 2,
> +					 &src_args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	of_node_put(src_args.np);
> +
> +	if (!src_args.args_count || src_args.args_count > 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	src_id = src_args.args[0];
> +
> +	ret = of_parse_phandle_with_args(np, "interconnects",
> +					 "#interconnect-cells", idx * 2 + 1,
> +					 &dst_args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	of_node_put(dst_args.np);
> +
> +	if (!dst_args.args_count || dst_args.args_count > 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	dst_id = dst_args.args[0];
> +
> +	return icc_get(dev, src_id, dst_id);
> +}
> +EXPORT_SYMBOL_GPL(of_icc_get);
> +
>  /**
>   * icc_set() - set constraints on an interconnect path between two 
> endpoints
>   * @path: reference to the path returned by icc_get()
> diff --git a/include/linux/interconnect.h 
> b/include/linux/interconnect.h
> index 593215371fd6..ae6744da9bc2 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -17,6 +17,7 @@ struct device;
> 
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>  			 const int dst_id);
> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>  void icc_put(struct icc_path *path);
>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
> 
> @@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct
> device *dev, const int src_id,
>  	return NULL;
>  }
> 
> +static inline struct icc_path *of_icc_get(struct device *dev,
> +					  const char *name)
> +{
> +	return NULL;
> +}
> +

Might want to return PTR(-ENODEV) or some error code so that client 
doesn't have to do NULL check AND an error check?

-Saravana
