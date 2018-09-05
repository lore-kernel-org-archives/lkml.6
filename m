Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8062075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8062075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIEVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:19:02 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56979 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:19:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C3D634135F;
        Wed,  5 Sep 2018 16:48:01 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ye1XnBiE2vsr; Wed,  5 Sep 2018 16:48:01 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4EE4840C8C;
        Wed,  5 Sep 2018 16:47:54 +0000 (UTC)
Subject: Re: [PATCH] sysctl: kselftests: use kernel module instead of built-in
To:     Lei Yang <Lei.Yang@windriver.com>, mcgrof@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1536114044-31236-1-git-send-email-Lei.Yang@windriver.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <8aeffc5f-ed8c-b418-5db3-ef0299456002@kernel.org>
Date:   Wed, 5 Sep 2018 10:47:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536114044-31236-1-git-send-email-Lei.Yang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 08:20 PM, Lei Yang wrote:
> It uses modprobe $TEST_DRIVER in sysctl.sh, so update
> config to use "m" instead
> 
> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  tools/testing/selftests/sysctl/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
> index 6ca1480..fc263ef 100644
> --- a/tools/testing/selftests/sysctl/config
> +++ b/tools/testing/selftests/sysctl/config
> @@ -1 +1 @@
> -CONFIG_TEST_SYSCTL=y
> +CONFIG_TEST_SYSCTL=m
> 

What happens if it is a built-in? Can you elaborate in the changelog

On that note we might have other cases that do modprobe in scripts and
run into the same issue you are trying to solve. :)

thanks,
-- Shuah
