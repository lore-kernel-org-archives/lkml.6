Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeFAPw7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:52:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeFAPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:52:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C5C460769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] qtnfmac: fix NULL pointer dereference
References: <20180601132408.GA2572@embeddedor.com>
Date: Fri, 01 Jun 2018 18:52:51 +0300
In-Reply-To: <20180601132408.GA2572@embeddedor.com> (Gustavo A. R. Silva's
        message of "Fri, 1 Jun 2018 08:24:08 -0500")
Message-ID: <87muwezep8.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> In case *vif* is NULL at 655: if (!vif), the execution path jumps to
> label out, where *vif* is dereferenced at 679:
>
> if (vif->sta_state == QTNF_STA_CONNECTING)
>
> Fix this by immediately returning when *vif* is NULL instead of
> jumping to label out.
>
> Addresses-Coverity-ID: 1469567 ("Dereference after null check")
> Fixes: 480daa9cb62c ("qtnfmac: fix invalid STA state on EAPOL failure")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

As commit 480daa9cb62c was recently applied to wireless-drivers-next
I'll queue this to 4.18.

-- 
Kalle Valo
