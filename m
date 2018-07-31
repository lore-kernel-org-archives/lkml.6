Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC673C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEB4208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d8bEeNZP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ItKhHil8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEB4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGaJAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:00:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbeGaJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:00:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7D47B60708; Tue, 31 Jul 2018 07:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021674;
        bh=gTnLJBimGIaOh1d4ClKvGeIUL30HxgBqEQNLpLJOxCc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=d8bEeNZPdspMRCWh9QvCtoBwzI61HS8MmtoT9rTrGxcXkHVIshplL/iCuZy5n0gjX
         iAAvjEun2Lii1cYnyAm/9vBjhHTaJAOP93myF6C2DV20WIf5AnyPD9SrLjRu5yq7oF
         GOyFyKIzISbnhC5yPusr+dgbKxHOMnILCppNxbVs=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 656D760376;
        Tue, 31 Jul 2018 07:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021673;
        bh=gTnLJBimGIaOh1d4ClKvGeIUL30HxgBqEQNLpLJOxCc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ItKhHil8Oe8WKmg4afHnALWKepngxO2XIfQJl9/UtzPoczYPdu53ADBkQs+5M4hUC
         /rzj9vPej2lKF3HjeGzbS1P8b9VHlyh6CdL7USBb6gM0ZtyEug8pxwwk6u9Jq7O1Wd
         I5qaN3kZCq1MkAzXNUu1ciqJrl4AE74uEhwvo2Yk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 656D760376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/10] atmel: hide unused procfs helpers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180713064658.10340-1-yuehaibing@huawei.com>
References: <20180713064658.10340-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <simon@thekelleys.org.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072114.7D47B60708@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:21:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/net/wireless/atmel/atmel.c:1402:12: warning: ‘atmel_proc_show’ defined but not used [-Wunused-function]
>  static int atmel_proc_show(struct seq_file *m, void *v)
>             ^
> fix this by adding #ifdef around it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

8b8f3278d241 atmel: hide unused procfs helpers

-- 
https://patchwork.kernel.org/patch/10522647/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

