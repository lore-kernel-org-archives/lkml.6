Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeEVN5S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:57:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEVN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:57:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A82B5604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Ramon Fried <ramon.fried@gmail.com>
Cc: jjohnson@codeaurora.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Eyal Ilsar <eilsar@codeaurora.org>,
        Ramon Fried <ramon.fried@linaro.org>
Subject: Re: [PATCH v2] wcn36xx: Add support for Factory Test Mode (FTM)
References: <20180518103122.28439-1-ramon.fried@gmail.com>
Date: Tue, 22 May 2018 16:57:09 +0300
In-Reply-To: <20180518103122.28439-1-ramon.fried@gmail.com> (Ramon Fried's
        message of "Fri, 18 May 2018 13:31:22 +0300")
Message-ID: <87a7srvlmy.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon Fried <ramon.fried@gmail.com> writes:

> From: Eyal Ilsar <eilsar@codeaurora.org>
>
> Introduce infrastructure for supporting Factory Test Mode (FTM) of the
> wireless LAN subsystem. In order for the user space to access the
> firmware in test mode the relevant netlink channel needs to be exposed
> from the kernel driver.
>
> The above is achieved as follows:
> 1) Register wcn36xx driver to testmode callback from netlink
> 2) Add testmode callback implementation to handle incoming FTM commands
> 3) Add FTM command packet structure
> 4) Add handling for GET_BUILD_RELEASE_NUMBER (msgid=0x32A2)
> 5) Add generic handling for all PTT_MSG packets
>
> Signed-off-by: Eyal Ilsar <eilsar@codeaurora.org>
> Signed-off-by: Ramon Fried <ramon.fried@linaro.org>

kbuild bot reported a warning:

drivers/net/wireless/ath/wcn36xx/testmode.c:122:5: warning: 'msg' may be used uninitialized in this function [-Wmaybe-uninitialized]

-- 
Kalle Valo
