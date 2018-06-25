Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AC7256A1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="TbYgoUwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AC7256A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeFYJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:23:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37039 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755024AbeFYJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:22:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so9119408wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWPCSMXS7B4axIKsH74moh/Gzyq4iJ+iUcQdmbfgBbA=;
        b=TbYgoUwEgY9Eirp2vnaRE8srCXVwJgY1ErBVrznP0Ym/yFpG+3gN71tf5MC7WHXiNg
         MtWgFkFC05ipw3LPOBYc1jLCJCoX2Qgx0VSkWEerXAgiFea4f7IU9ehDlFQ8Zv9s7/Pt
         nHlrHcHka4JcI+BXSsD0PL+UmJug/+Atw+UA2OrqpUdy0VQ2S22uZ/97a6v8YF+xCRWS
         anUMHXv4XxDgyTEHiNcmgbEyflFtUlpUOv9ay0GTtLMCD6/rnCZypglJW4/AWbsURN0T
         XoSs8CyGQX5EZqOI4GxSbdqANpePkt6u1OVQpLNdXcli+ZKKqqjf8RLvLrDPS3wxdyJ2
         zpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWPCSMXS7B4axIKsH74moh/Gzyq4iJ+iUcQdmbfgBbA=;
        b=cN8SVp0VETx8vROZMlzPEVl3fgABY6LhOsm5i+cAmNihbECht80QXsblKZ5eYgsFCg
         L+xiGr22XMYsEUltin33ZhVT2DmdkLMq4LCQAOEcgVRNKSAiIVkPecnFpqJ8JIyvgiPD
         6cLkh7cECGSVRnXvYapGqRTqFaN2/8SJVzBCzOn2IT8Oncd9dzlZk3ScQVmt1VdO7hUo
         ghT+ONf8jR0nFnvjMo8Pz+Fj4NRampznOExNZsfHBWQAo0rO/NNchx+CY3TIzpQuXOmC
         sDYDWTCf1kDgQHgKF0X4ipRMZbhGgZO5DMAiwMshKzrE1L4RkEJ2WsbrG38n9QZt5gc2
         mesA==
X-Gm-Message-State: APt69E3t+O57soS7wlxYvoJ3pa06nljvxUUOAhp4+9OYC5/zi0FjmJol
        08sWxgsdR8WhGW4lcYPRzlmkc5Oma1g=
X-Google-Smtp-Source: AAOMgpcV0wMn5nqbTdKYBn4DWm44qTgw8pHG/hL1GITOgYX7uClL4RNrUcF2aPhen71v03ezuxybzQ==
X-Received: by 2002:a1c:5d08:: with SMTP id r8-v6mr318616wmb.91.1529918577847;
        Mon, 25 Jun 2018 02:22:57 -0700 (PDT)
Received: from [10.96.72.132] (bzq-219-43-106.isdn.bezeqint.net. [62.219.43.106])
        by smtp.gmail.com with ESMTPSA id m10-v6sm17959300wrq.56.2018.06.25.02.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:22:56 -0700 (PDT)
Subject: Re: [RESEND PATCH] sh: make use of for_each_node_by_type()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rich Felker <dalias@libc.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180624224252.GA220395@dtor-ws>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <20c14792-a43a-213e-35a6-01e72f6c28e1@cogentembedded.com>
Date:   Mon, 25 Jun 2018 12:23:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180624224252.GA220395@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/25/2018 1:42 AM, Dmitry Torokhov wrote:

> Instead of open-coding the loop, let's use canned macro.
> 
> Also make sure we are not leaking "cpus" node reference.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Sounds/looks like a material for 2 separate patches.

> ---
> 
>   arch/sh/boards/of-generic.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> index 46b2481eec903..26789ad281936 100644
> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
> @@ -56,15 +56,15 @@ const struct of_cpu_method __cpu_method_of_table_sentinel
>   
>   static void sh_of_smp_probe(void)
>   {
> -	struct device_node *np = 0;
> -	const char *method = 0;
> +	struct device_node *np;
> +	const char *method = NULL;
>   	const struct of_cpu_method *m = __cpu_method_of_table;
>   
>   	pr_info("SH generic board support: scanning for cpus\n");
>   
>   	init_cpu_possible(cpumask_of(0));
>   
> -	while ((np = of_find_node_by_type(np, "cpu"))) {
> +	for_each_node_by_type(np, "cpu") {
>   		const __be32 *cell = of_get_property(np, "reg", NULL);
>   		u64 id = -1;
>   		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
> @@ -80,6 +80,7 @@ static void sh_of_smp_probe(void)
>   	if (!method) {
>   		np = of_find_node_by_name(NULL, "cpus");
>   		of_property_read_string(np, "enable-method", &method);
> +		of_node_put(np);
>   	}
>   
>   	pr_info("CPU enable method: %s\n", method);

MBR, Sergei
