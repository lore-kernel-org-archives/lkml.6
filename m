Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B39204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QOYXGoHj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cEl/OVUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B39204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeIRLk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:40:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIRLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:40:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3850B60558; Tue, 18 Sep 2018 06:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537250966;
        bh=t2vlNqcVKj13MR4CKgxUIzX4J2eZTym2aUZZIkt70Vw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QOYXGoHj6VS106UgrYZD9Cq+g4OvTaQ7Op5Wejhn+ewT5EeHtK1LOlQ6Uvn78S8lC
         6af1n3W1uZqwjM412KDn471R50sWEJURb3hH9g1hvMy5zCE4scA79/cABoREgS59nm
         z7qCqcLuf4oMJlSywA1/AGNUbtxr2jDr3fkr+RGg=
Received: from [10.79.129.80] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2D846020A;
        Tue, 18 Sep 2018 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537250965;
        bh=t2vlNqcVKj13MR4CKgxUIzX4J2eZTym2aUZZIkt70Vw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cEl/OVUMyR09M30LeRwv/g78SXESvHaMxo5zSTAUrnC12IyPdXBu7SJrU1xmuWOw3
         86FWYWNbx5QXwVSuXusQkHOArbM47/VzeGDXAx1fuKaQDa1xnBmzAyguLtkRRev4WN
         GA3lkIgmbzEUVTplxPd5GSYMyIA1DLltvfYJZA90=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2D846020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180917213304.44476-1-mka@chromium.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <98e5a46b-d7db-14c2-320e-f8f6c3c063bf@codeaurora.org>
Date:   Tue, 18 Sep 2018 11:39:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917213304.44476-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 3:03 AM, Matthias Kaehlcke wrote:
> sysrq_handle_crash() dereferences a NULL pointer on purpose to force
> an exception, the local variable 'killer' is assigned to NULL and
> dereferenced later. Clang detects the NULL pointer dereference at compile
> time and emits a BRK instruction (on arm64) instead of the expected NULL
> pointer exception. Change 'killer' to a global variable (and rename it
> to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
> detecting the condition. By default global variables are initialized
> with zero/NULL in C, therefore an explicit initialization is not needed.
> 
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   drivers/tty/sysrq.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 06ed20dd01ba..49fa8e758690 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
>   #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
>   #endif /* CONFIG_VT */
>   
> +char *sysrq_killer;
> +
>   static void sysrq_handle_crash(int key)
>   {
> -	char *killer = NULL;
> -
>   	/* we need to release the RCU read lock here,
>   	 * otherwise we get an annoying
>   	 * 'BUG: sleeping function called from invalid context'
> @@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
>   	rcu_read_unlock();
>   	panic_on_oops = 1;	/* force panic */
>   	wmb();
> -	*killer = 1;
> +	*sysrq_killer = 1;
>   }
>   static struct sysrq_key_op sysrq_crash_op = {
>   	.handler	= sysrq_handle_crash,
> 

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
