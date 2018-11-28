Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9CFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09E206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eind1fu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A09E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeK2FUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:20:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeK2FUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:20:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so27297405wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/6dqDbgP3jrLAdpIZD+FHUC8leBdDURZpae6U4KQbxc=;
        b=Eind1fu1UbIoiGljhptjlhk/0qwLI8AiT7oGLyysq3uI89xEiagiN691sFx+iilmhJ
         Qj7CN1DWS12MHIwiVartQhywV/nsAPT4n1Vf57A1fDlcqAO2cdTqVofAHHZ7gdqj90fb
         KS5zVU3PMmizbVN20ezxbeuxMmEhRkA7d8+lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6dqDbgP3jrLAdpIZD+FHUC8leBdDURZpae6U4KQbxc=;
        b=UMVSHR53Gem/isBtDkA9n3yxY8Dl7M5WNsfIcKKEPA8mIetigEc8RPUMBAPLxq+xCd
         aNbf/63uUb4DRiVxCrHSWNQrcG0eTTEQwsM6QB3HNor/+W8MwmKG62wilwWKoFShciio
         szTOd6jBNbT9gwApzD/CbKWCc2eigQtyiEBbhXMxnjfT/i8xQ8hLzufcGf5yGnaevPri
         TFul1qviePcgBFJJsBJ8keByaResSgu4uNwXGu/jxSRfovg1PAUqexuQjJt/fjd9i/lF
         fW0Hfmqp4xHnNtuI32PYu5tDgmz8XIeKyFdv5T02PoGD4xW6yqAMmhMhTLfUSdc0bAdY
         hKlg==
X-Gm-Message-State: AA+aEWY2Z9fTsY/YB7uvri22jGmygbCVJDuTOTR8ltgHhabmAHgyILHP
        1dG3UROn/fkg6gGE6x1KE7kOtg==
X-Google-Smtp-Source: AFSGD/UEmSLEBvSoZWMb3mlr/dc9FwxaCguHyHaOjCwr859bl5EDLoq9an6C77GmI4k5n/VOxtSG5Q==
X-Received: by 2002:adf:8342:: with SMTP id 60mr30612846wrd.212.1543429087854;
        Wed, 28 Nov 2018 10:18:07 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id s1sm9643298wro.9.2018.11.28.10.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:18:07 -0800 (PST)
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect
 API
To:     Joe Perches <joe@perches.com>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        thierry.reding@gmail.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-2-georgi.djakov@linaro.org>
 <5d16a4a57ed5529299d7b73e13a249add00b1afe.camel@perches.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <82026d31-39e8-08f1-761b-c0b3ccf8ce20@linaro.org>
Date:   Wed, 28 Nov 2018 20:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <5d16a4a57ed5529299d7b73e13a249add00b1afe.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 11/27/18 20:35, Joe Perches wrote:
> On Tue, 2018-11-27 at 20:03 +0200, Georgi Djakov wrote:
>> This patch introduces a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
> 
> trivial notes:
> 
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> []
>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +	struct icc_node *next, *prev = NULL;
>> +	int ret = -EINVAL;
>> +	int i;
>> +
>> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +		struct icc_provider *p;
>> +
>> +		next = path->reqs[i].node;
>> +		/*
>> +		 * Both endpoints should be valid master-slave pairs of the
>> +		 * same interconnect provider that will be configured.
>> +		 */
>> +		if (!prev || next->provider != prev->provider)
>> +			continue;
>> +
>> +		p = next->provider;
>> +
>> +		/* set the constraints */
>> +		ret = p->set(prev, next);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +out:
>> +	return ret;
>> +}
> 
> The use of ", prev = next" appears somewhat tricky code.
> Perhaps move the assignment of prev to the bottom of the loop.
> Perhaps the temporary p assignment isn't useful either.
> 
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
> []
>> +	ret = apply_constraints(path);
>> +	if (ret)
>> +		pr_debug("interconnect: error applying constraints (%d)", ret);
> 
> Ideally all pr_<foo> formats should end in '\n'
> 
>> +static struct icc_node *icc_node_create_nolock(int id)
>> +{
>> +	struct icc_node *node;
>> +
>> +	/* check if node already exists */
>> +	node = node_find(id);
>> +	if (node)
>> +		goto out;
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node) {
>> +		node = ERR_PTR(-ENOMEM);
>> +		goto out;
> 
> Generally, this code appears to overly rely on goto when
> direct returns could be more readable.
> 
>> +	}
>> +
>> +	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>> +	if (WARN(id < 0, "couldn't get idr")) {
> 
> This seems to unnecessarily hide the id < 0 test in a WARN
> 
> Why is this a WARN and not a simpler
> 	if (id < 0) {
> 		[ pr_err(...); or WARN(1, ...); ]
> 
>> +		kfree(node);
>> +		node = ERR_PTR(id);
>> +		goto out;
>> +	}
>> +
>> +	node->id = id;
>> +
>> +out:
>> +	return node;
>> +}

Thank you for helping to improve the code. The above suggestions make it 
cleaner indeed.

> []
>> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> []
>> +/* macros for converting to icc units */
>> +#define bps_to_icc(x)	(1)
>> +#define kBps_to_icc(x)	(x)
> []
>> +#define MBps_to_icc(x)	(x * 1000)
>> +#define GBps_to_icc(x)	(x * 1000 * 1000)
>> +#define kbps_to_icc(x)	(x / 8 + ((x) % 8 ? 1 : 0))
>> +#define Mbps_to_icc(x)	(x * 1000 / 8 )
>> +#define Gbps_to_icc(x)	(x * 1000 * 1000 / 8)
> 
> The last 5 macros should parenthesize x

Oops.. obviously i forgot to run checkpatch --strict. Will fix!

BR,
Georgi
