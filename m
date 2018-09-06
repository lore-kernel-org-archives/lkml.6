Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BDE20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lYnBzhoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BDE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeIFVlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:41:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37945 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeIFVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:41:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so9966339ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CHYSJFJh/+NC70/QoqHiEGMVPCzGj7q1ys+RuLM/ZIg=;
        b=lYnBzhoqW6XOsrPXBaPuIAtGYepbFrWcQK/BqOeY1xsrEVovQH1TuUXtxTzko7tKL+
         BwI82zHK8qAGfqJ1yn51D06CDidAnMSbFNypL/YU6UsHL/EPKy/rbn2jeuzX2+OHf6jK
         mcPyGobAW06+lAxVYW6UXu8na/ppO4r+cM0Ngpd9z3KxR0YjHZCETON7Xb2zSxA1oxlK
         VjjOY3dLgj99XY+44cpmlK8f82+rB3wS1e5l7cAfo3VLh7jOCWECyXuTG8r9dJc+rCtv
         aIiRQH59U1beKPXXu/u++gASx7EfccZmZ9RtXXMcuSNBeNbmZ4curshKSceo7ZRMMtoN
         eRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CHYSJFJh/+NC70/QoqHiEGMVPCzGj7q1ys+RuLM/ZIg=;
        b=MufVLVzUOcBmv98+CsF94RU/pRks6hbIqtKBMr3huNapvaWTNmOJhfC42I5cHRJoz/
         //yELBx592irTsbfWDyI8EXBF5f3wlr++ur10pngWfKmOLhLzQBbFKYiu+605unXkxsQ
         0gSZMXTehufPz5dyc4ADkYhD5bq5G+PcAG9pC5hxlEXpRfRUlnMRc8VLUKVd+t1M71eW
         s0dsgmCjbFPyaQ88C4Q7teed9HKhFALWFOftQ897wtd1craE8yMxUp6QKe5fVdXkyVl6
         DjInsz6uTnfGVaBUYArI51JdnguPcFvSW4Zdipz0DBmFuN62sk2We4puvpY9o7iFZm0x
         QIWg==
X-Gm-Message-State: APzg51BRndU9tJSQfVs95htyRxMoSZRkV94oQQiJ/rfNkijbnP6lgLMN
        QTwc8Hya0FJPwi1hkgtFndkeqA==
X-Google-Smtp-Source: ANB0VdY0z1zjXK2Ui9SIU2IKWWUO1idMgOlneVwVo8XSrfuumqM+dJacuXGuo6PrBuIE3RvR8AQfwQ==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr2410732ljt.8.1536253487901;
        Thu, 06 Sep 2018 10:04:47 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id m22-v6sm889265lfc.44.2018.09.06.10.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:04:45 -0700 (PDT)
Date:   Thu, 6 Sep 2018 09:59:32 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
Message-ID: <20180906165932.csa5b4vlmaekv5y2@localhost>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
 <1536246639-7420-1-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536246639-7420-1-git-send-email-sudeep.holla@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 06, 2018 at 04:10:39PM +0100, Sudeep Holla wrote:
> Firmware can provide zero as values for sustained performance level and
> corresponding sustained frequency in kHz in order to hide the actual
> frequencies and provide only abstract values. It may endup with divide
> by zero scenario resulting in kernel panic.
> 
> Let's set the multiplication factor to one if either one or both of them
> (sustained_perf_level and sustained_freq) are set to zero.
> 
> Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Hi ARM SoC team,
> 
> Can you pick this patch directly ?

Applied, however:

> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 721e6c57beae..64342944d917 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  					le32_to_cpu(attr->sustained_freq_khz);
>  		dom_info->sustained_perf_level =
>  					le32_to_cpu(attr->sustained_perf_level);
> -		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
> +		if (!dom_info->sustained_freq_khz ||
> +		    !dom_info->sustained_perf_level)
> +			/* CPUFreq converts to kHz, hence default 1000 */
> +			dom_info->mult_factor =	1000;
> +		else
> +			dom_info->mult_factor =
> +					(dom_info->sustained_freq_khz * 1000) /
>  					dom_info->sustained_perf_level;
>  		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);

I noticed you do memcpy of these name strings in a few places, and use
it as a string. Any firmware that would return a non-terminated string
would cause problems later on. strlcpy() might be a better approach.



-Olof
