Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeEHOvR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:51:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeEHOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:51:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36A3960250
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wireless: ath: ath9k: Fix a possible data race in ath_chanctx_set_next
References: <20180508080636.13827-1-baijiaju1990@gmail.com>
Date: Tue, 08 May 2018 17:51:11 +0300
In-Reply-To: <20180508080636.13827-1-baijiaju1990@gmail.com> (Jia-Ju Bai's
        message of "Tue, 8 May 2018 16:06:36 +0800")
Message-ID: <87o9hqxktc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> writes:

> The write operation to "sc->next_chan" is protected by
> the lock on line 1287, but the read operation to
> this data on line 1262 is not protected by the lock.
> Thus, there may exist a data race for "sc->next_chan".
>
> To fix this data race, the read operation to "sc->next_chan" 
> should be also protected by the lock.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

I need this reviewed by someone else before I'm willing to take it.

-- 
Kalle Valo
