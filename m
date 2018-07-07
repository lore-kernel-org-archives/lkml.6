Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFAAC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF3208CB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnhXbTcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDF3208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbeGGVHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:07:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36850 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754302AbeGGVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:07:03 -0400
Received: by mail-pl0-f67.google.com with SMTP id a7-v6so4338651plp.3;
        Sat, 07 Jul 2018 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2eG9/tQWG9gmErpx/9tnlsf3QjwIbeblnr6Hf9L5wGQ=;
        b=NnhXbTcCNcXjmKPlFpRa4VYLBMA+qAo5WmlOm0MYganfMYIdwWytcM1EDvVbpIWi+/
         QImYnYwOVmOj8+wP9QcA/PBGqNr4vM+GsBH40fIOBPj8/eGR4YvNpOxkZWezllm+bzOO
         f0yH6d3IsgvO6m2Z8npkqdAbaTLiIqjxz7iqz3PZQSmiQDVal2JNTccGfQe62PvuNktH
         co5YZjvc1cM77LLlC+axHvvzr+EjlOrhiSMiQPe1XOOCnqOqwUAq3MvkZrdSqCMk58GD
         ebP82LlJGnnTkDu/VQC0btRHdKzJ8WJw3WC19YYcOiooGDMElfFJjBTM+eXa8DYX+U//
         /mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2eG9/tQWG9gmErpx/9tnlsf3QjwIbeblnr6Hf9L5wGQ=;
        b=h33F9CfIEXydmSjt/LvgTZvZ0vWEnY0cJ6u1lwUH3//lJHBr6ZgAGYtbnqtC2pfk/L
         7MJUkS3FO7f6AZe/lnS+t5Vqj3D1UMvNVP6e8G96qVS6hgI7X9Nx8PFb10yHmz2fLL0z
         /Qb7q8LWF4hZnRmuykwJ2pZ2ODuBBM3K+AtEagQI0+f6EX/fPCpJQX5Y1nyvtDTQ+4qw
         /WghbmSWlC/MvxbrAa/gKuo066C1PU7RaPiZgBiXxXTapd8zeIGYdIa+LyXiKn4EXi5z
         Lg74KsGiTGjBxe6mPWpTtTALhnr8xNYCLiqv40HYSn5HmPJ2Z9zPkC/0WQCqs2Idz9eC
         HkXg==
X-Gm-Message-State: APt69E0dHi3ZuXxrPTtet/JzN4TIYuUjBqnZ2AZSa7lOPviUTwcsdUke
        Qn3/In35foR77wHGKLvysuopM5Kl
X-Google-Smtp-Source: AAOMgpcTRG1Ipat2XOIuFc+IglmkoBbgOJ8X+SWoyRBV+EnzlzTF/PKWZjwOjkEkAJSFaAT2M6VuHg==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr15085556plt.126.1530997622261;
        Sat, 07 Jul 2018 14:07:02 -0700 (PDT)
Received: from [192.168.1.54] (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.gmail.com with ESMTPSA id w72-v6sm1276878pfa.26.2018.07.07.14.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 14:07:01 -0700 (PDT)
Subject: Re: [PATCH v5 15/17] media: platform: Switch to
 v4l2_async_notifier_add_subdev
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc:     kbuild-all@01.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180702060907.xlghcxtsj5eepdxu@mwanda>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <eb8fbaae-6ab3-e1fa-9575-fbadb8d55342@gmail.com>
Date:   Sat, 7 Jul 2018 14:06:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702060907.xlghcxtsj5eepdxu@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2018 11:09 PM, Dan Carpenter wrote:
> Hi Steve,
>
> I love your patch! Perhaps something to improve:
>
> url:    https://github.com/0day-ci/linux/commits/Steve-Longerbeam/media-imx-Switch-to-subdev-notifiers/20180630-035625
> base:   git://linuxtv.org/media_tree.git master
>
> New smatch warnings:
> drivers/media/platform/xilinx/xilinx-vipp.c:97 xvip_graph_build_one() error: '%pOF' expects argument of type 'struct device_node*', argument 3 has type 'struct fwnode_handle*'
> drivers/media/platform/xilinx/xilinx-vipp.c:335 xvip_graph_notify_bound() error: '%pOF' expects argument of type 'struct device_node*', argument 3 has type 'struct fwnode_handle*'
>
> Old smatch warnings:
> drivers/media/platform/xilinx/xilinx-vipp.c:106 xvip_graph_build_one() error: '%pOF' expects argument of type 'struct device_node*', argument 4 has type 'struct fwnode_handle*'
> drivers/media/platform/xilinx/xilinx-vipp.c:133 xvip_graph_build_one() error: '%pOF' expects argument of type 'struct device_node*', argument 3 has type 'struct fwnode_handle*'
> drivers/media/platform/xilinx/xilinx-vipp.c:143 xvip_graph_build_one() error: '%pOF' expects argument of type 'struct device_node*', argument 4 has type 'struct fwnode_handle*'

Thanks for the report. Will fix for v8.

Steve


