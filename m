Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D18C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3221715
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hY49YGp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB3221715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeHOCK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:10:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46449 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:10:25 -0400
Received: by mail-io0-f196.google.com with SMTP id x5-v6so3375025iop.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/cm80ilGxhFT46VR5KItk7TvXZpf+anDxTfluZbjTuw=;
        b=hY49YGp2hIdxwi0mdwajB369TCGhRXi7ZB/cBE13oJ8lM+h+3fm37WCk0szWsbDoRq
         5h5OdqogK7lDJlOMklJFc1b5jEY3KqBrNMjKxTQRvIWMgMku183UGee7nLvisghNafZB
         RWFlLNw+XByUl3JR0hfdIxZqYp4kkENChk6nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cm80ilGxhFT46VR5KItk7TvXZpf+anDxTfluZbjTuw=;
        b=YLlW6Wdrus7OVsz1GzUFmTi5HuC48iCYJcm7StAqmjWgWH7vmhhTKpa9QHE9CrnUlb
         0l6cD9Nq378cUEo17AxSIAQUYeb9LvEUQmaBnKegu3qnMkqHUBQcLx+r0sBCi1O29/4r
         bfOyG2ap9PWYQcOuME9PxTxECeT7L5TvvKPQPJ4MKDR8eNnOeyBLYzCwFi9UaLaBCk6f
         N86N5JpUX+EEbptw7ouaRy/Jj/WN5Zc+uLKtBm6wehw9Osu7i27xvsCEerqkbM0mQ+7k
         /QLUR14jtxE6OqKoXXv0KxqVcQBE752AcZUnjBhbi6HN7ayxF9zxWyLz3PdrBYfhOwwd
         Zabg==
X-Gm-Message-State: AOUpUlHJyMOvBYotVJ3EjmZY4ZS0dj0TqSGN1Fueu0ln8NmKRs4pTwPL
        /bywlD9+CP0qEiyEyqbtclW4hg==
X-Google-Smtp-Source: AA+uWPzZxUzFU03pPbFcXhQubr6mqSQ5gdsYa54SNgARVem48NF9RELq+QlXgFVr7/n9r6VQBzya7w==
X-Received: by 2002:a6b:c643:: with SMTP id w64-v6mr20701699iof.51.1534288857264;
        Tue, 14 Aug 2018 16:20:57 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r1-v6sm6034623ioa.47.2018.08.14.16.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 16:20:56 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:20:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
Subject: Re: [PATCH 08/13] coresight: Add support for CLAIM tag protocol
Message-ID: <20180814232053.GA5131@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:41:50PM +0100, Suzuki K Poulose wrote:
> Add support for the CLAIM tag protocol for negotiating the
> device ownership with other agents trying to use the coresight
> component (internal vs. external). The Coresight architecture
> specifies CLAIM tags (managed via CLAIMSET CLAIMCLR registers)
> to negotiate the ownership of the device. PSCI recommends the
> reservation of the bits in CLAIM tags for self-hosted and external
> debug use. This patch implements the protocol for claiming
> the devices before they are actually used.

I think the first paragraph of the cover letter (minus the reference to the
documentation since you've included it below) would be perfect instead of the
above.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h |  7 +++
>  drivers/hwtracing/coresight/coresight.c      | 85 ++++++++++++++++++++++++++++
>  include/linux/coresight.h                    | 20 +++++++
>  3 files changed, 112 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index c11da55..579f349 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -25,6 +25,13 @@
>  #define CORESIGHT_DEVID		0xfc8
>  #define CORESIGHT_DEVTYPE	0xfcc
>  
> +
> +/*
> + * Coresight device CLAIM protocol.
> + * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
> + */
> +#define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
> +
>  #define TIMEOUT_US		100
>  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
>  
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index e73ca6a..8f06866 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -128,6 +128,91 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	return -ENODEV;
>  }
>  
> +static inline u32 coresight_read_claim_tags(void __iomem *base)
> +{
> +	return readl_relaxed(base + CORESIGHT_CLAIMCLR);
> +}
> +
> +static inline bool coresight_is_claimed_self_hosted(void __iomem *base)
> +{
> +	return coresight_read_claim_tags(base) == CORESIGHT_CLAIM_SELF_HOSTED;
> +}
> +
> +static inline bool coresight_is_claimed_any(void __iomem *base)
> +{
> +	return coresight_read_claim_tags(base) != 0;
> +}
> +
> +static inline void coresight_set_claim_tags(void __iomem *base)
> +{
> +	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
> +	isb();
> +}
> +
> +static inline void coresight_clear_claim_tags(void __iomem *base)
> +{
> +	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
> +	isb();
> +}
> +
> +/*
> + * coresight_claim_device_unlocked : Claim the device for self-hosted usage
> + * to prevent an external tool from touching this device. As per PSCI
> + * standards, section "Preserving the execution context" => "Debug and Trace
> + * save and Restore", DBGCLAIM[1] is reserved for Self-hosted debug/trace and
> + * DBGCLAIM[0] is reserved for external tools.
> + *
> + * Called with CS_UNLOCKed for the component.
> + * Returns : 0 on success
> + */
> +int coresight_claim_device_unlocked(void __iomem *base)
> +{
> +	if (coresight_is_claimed_any(base))
> +		return -EBUSY;
> +
> +	coresight_set_claim_tags(base);
> +	if (coresight_is_claimed_self_hosted(base))
> +		return 0;
> +	/* There was a race setting the tags, clean up and fail */
> +	coresight_clear_claim_tags(base);
> +	return -EBUSY;
> +}
> +
> +int coresight_claim_device(void __iomem *base)
> +{
> +	int rc;
> +
> +	CS_UNLOCK(base);
> +	rc = coresight_claim_device_unlocked(base);
> +	CS_LOCK(base);
> +
> +	return rc;
> +}
> +
> +/*
> + * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
> + * Called with CS_UNLOCKed for the component.
> + */
> +void coresight_disclaim_device_unlocked(void __iomem *base)
> +{
> +
> +	if (coresight_is_claimed_self_hosted(base))
> +		coresight_clear_claim_tags(base);
> +	else
> +		/*
> +		 * Either we or the external agent doesn't follow
> +		 * the protocol.
> +		 */
> +		WARN_ON_ONCE(1);

When writing "... or the external agent doesn't follow the protocol", I deduce
that an external agent would have trampled our claim tag.  I think this needs
to be said explicitly in the comment.

> +}
> +
> +void coresight_disclaim_device(void __iomem *base)
> +{
> +	CS_UNLOCK(base);
> +	coresight_disclaim_device_unlocked(base);
> +	CS_LOCK(base);
> +}
> +
>  static int coresight_enable_sink(struct coresight_device *csdev,
>  				 u32 mode, void *data)
>  {
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 5353582..16151a2 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -257,6 +257,13 @@ extern int coresight_enable(struct coresight_device *csdev);
>  extern void coresight_disable(struct coresight_device *csdev);
>  extern int coresight_timeout(void __iomem *addr, u32 offset,
>  			     int position, int value);
> +
> +extern int coresight_claim_device(void __iomem *base);
> +extern int coresight_claim_device_unlocked(void __iomem *base);
> +
> +extern void coresight_disclaim_device(void __iomem *base);
> +extern void coresight_disclaim_device_unlocked(void __iomem *base);
> +
>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
> @@ -266,6 +273,19 @@ coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
>  static inline void coresight_disable(struct coresight_device *csdev) {}
>  static inline int coresight_timeout(void __iomem *addr, u32 offset,
>  				     int position, int value) { return 1; }
> +static inline int coresight_claim_device_unlocked(void __iomem *base)
> +{
> +	return 0;
> +}
> +
> +static inline int coresight_claim_device(void __iomem *base)
> +{
> +	return 0;
> +}

Returning 0 would give a caller the impression the operation has succeeded when
in fact it didn't.  I think we should return an error code here.

> +
> +static inline void coresight_disclaim_device(void __iomem *base) {}
> +static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
> +
>  #endif
>  
>  #ifdef CONFIG_OF
> -- 
> 2.7.4
> 
