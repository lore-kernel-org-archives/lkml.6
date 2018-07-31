Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13334C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC733208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XFC/oBhd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gp5UetPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC733208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGaJEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:04:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeGaJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:04:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26D726071C; Tue, 31 Jul 2018 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021956;
        bh=4QqzVQIXhQWrmiOYWBn8J2jvUQkYQusrX/6Ko5R0hGE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XFC/oBhd6AczJLwfK/Mc8eP99na9zFqXdyOJOq+SPJuel7HQXGw6nJCL/YvYr8BwU
         jxjzONuMC10Fq8Ui8xQ+0HqXSSLpx9+tKiZVdqmcTl8UmvBpTTDqQDrALCBuSUReMT
         +SQcTVdXuVa6gVZROoeYRxDZrLg1PQ+TG5kwclJY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AB8260397;
        Tue, 31 Jul 2018 07:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021955;
        bh=4QqzVQIXhQWrmiOYWBn8J2jvUQkYQusrX/6Ko5R0hGE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=gp5UetPlkzMGND+7YGxRDNyqnHObqW0UjcEDhYIKbngG1sdtpy3+5O3Epw8BZMvPQ
         mIted78Bf8aEb/aLBbCm6fFPjEo5YjVNjuCiWz2zfhB00f8pvjajAIeNon9w183eFw
         9tRLpfDA/qouxGheszSt+Z0K618cIGb+WB3RUcvk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AB8260397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] atmel: Replace mdelay() with msleep() in
 probe_atmel_card()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180727084535.3848-1-baijiaju1990@gmail.com>
References: <20180727084535.3848-1-baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     simon@thekelleys.org.uk, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072556.26D726071C@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:25:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> probe_atmel_card() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

5685bee313e9 atmel: Replace mdelay() with msleep() in probe_atmel_card()

-- 
https://patchwork.kernel.org/patch/10546747/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

