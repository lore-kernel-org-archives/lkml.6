Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0AEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D092075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D092075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIEV2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:28:38 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50021 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:28:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 72052C1181;
        Wed,  5 Sep 2018 16:57:35 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OZM8OspfBaxb; Wed,  5 Sep 2018 16:57:35 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4320FC08BD;
        Wed,  5 Sep 2018 16:57:27 +0000 (UTC)
Subject: Re: [PATCH] selftests: memory-hotplug: add required configs
To:     Lei Yang <Lei.Yang@windriver.com>, po-hsu.lin@canonical.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1536141435-10097-1-git-send-email-Lei.Yang@windriver.com>
Cc:     Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <18c9ce53-a2e8-1522-24ca-7289c028d767@kernel.org>
Date:   Wed, 5 Sep 2018 10:57:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536141435-10097-1-git-send-email-Lei.Yang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 03:57 AM, Lei Yang wrote:
> add CONFIG_MEMORY_HOTREMOVE=y in config
> without this config, /sys/devices/system/memory/memory*/removable
> always return 0, I endup getting an early skip during test
> 
> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  tools/testing/selftests/memory-hotplug/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/config b/tools/testing/selftests/memory-hotplug/config
> index 2fde301..a7e8cd5 100644
> --- a/tools/testing/selftests/memory-hotplug/config
> +++ b/tools/testing/selftests/memory-hotplug/config
> @@ -2,3 +2,4 @@ CONFIG_MEMORY_HOTPLUG=y
>  CONFIG_MEMORY_HOTPLUG_SPARSE=y
>  CONFIG_NOTIFIER_ERROR_INJECTION=y
>  CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
> +CONFIG_MEMORY_HOTREMOVE=y
> 

Thanks. Applied to linux-kselftest next

-- Shuah
