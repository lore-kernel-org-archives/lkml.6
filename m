Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeB0Nwr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:52:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeB0Nwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:52:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02879607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] bcma: Replace mdelay with usleep_range in
 bcma_pmu_resources_init
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1516984715-9237-1-git-send-email-baijiaju1990@gmail.com>
References: <1516984715-9237-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Larry.Finger@lwfinger.net, zajec5@gmail.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227135244.E5FF1607EF@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 13:52:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> After checking all possible call chains to bcma_pmu_resources_init() here,
> my tool finds that this function is never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> Thus mdelay can be replaced with usleep_range to avoid busy wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

8100091d0248 bcma: Replace mdelay with usleep_range in bcma_pmu_resources_init

-- 
https://patchwork.kernel.org/patch/10186561/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
