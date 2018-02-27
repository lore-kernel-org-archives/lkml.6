Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbeB0QSV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:18:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbeB0QSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:18:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BE9A60285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtlwifi: rtl8192cu: remove pointless memcpy
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180209132531.2755482-1-arnd@arndb.de>
References: <20180209132531.2755482-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227161817.C4BD36070A@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 16:18:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> gcc-8 points out that source and destination of the memcpy() are
> always the same pointer, so the effect of memcpy() is undefined
> here (its arguments must not overlap):
> 
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c: In function '_rtl_rx_process':
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:430:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
> 
> Most likely this is harmless, but it's easy to just remove the
> line and get rid of the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

dcdd54c2bcae rtlwifi: rtl8192cu: remove pointless memcpy

-- 
https://patchwork.kernel.org/patch/10208979/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
