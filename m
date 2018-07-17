Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB70AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3A20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF3A20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGQKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:30:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65190 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbeGQKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:30:27 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 42182fbe77285237; Tue, 17 Jul 2018 11:58:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org, p.paillet@st.com,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] base: core: Remove WARN_ON from link dependencies check
Date:   Tue, 17 Jul 2018 11:56:59 +0200
Message-ID: <4236937.TuBsddNVuo@aspire.rjw.lan>
In-Reply-To: <20180716113744.13300-1-benjamin.gaignard@st.com>
References: <20180716113744.13300-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 16, 2018 1:37:44 PM CEST Benjamin Gaignard wrote:
> In some cases the link between between customer and supplier
> already exist, for example when a device use its parent as a supplier.
> Do not warn about already existing dependencies because device_link_add()
> takes care of this case.
> 
> Link: http://lkml.kernel.org/r/20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C@eucas1p1.samsung.com
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

That's better. :-)

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index df3e1a44707a..fcdc17f0f349 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -105,7 +105,7 @@ static int device_is_dependent(struct device *dev, void *target)
>  	struct device_link *link;
>  	int ret;
>  
> -	if (WARN_ON(dev == target))
> +	if (dev == target)
>  		return 1;
>  
>  	ret = device_for_each_child(dev, target, device_is_dependent);
> @@ -113,7 +113,7 @@ static int device_is_dependent(struct device *dev, void *target)
>  		return ret;
>  
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (WARN_ON(link->consumer == target))
> +		if (link->consumer == target)
>  			return 1;
>  
>  		ret = device_is_dependent(link->consumer, target);
> 


