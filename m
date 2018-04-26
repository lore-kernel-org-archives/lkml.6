Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeDZIRB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:17:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39814 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753717AbeDZIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:16:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BACE60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Eyal Reizer <eyalreizer@gmail.com>
Cc: linux-wireless@vger.kernel.org, robh@kernel.org, sre@kernel.org,
        tony@atomide.com, linux-kernel@vger.kernel.org,
        Eyal Reizer <eyalr@ti.com>
Subject: Re: [PATCH v2] wlcore: sdio: allow pm to handle sdio power
References: <1524721631-5983-1-git-send-email-eyalr@ti.com>
Date: Thu, 26 Apr 2018 11:16:48 +0300
In-Reply-To: <1524721631-5983-1-git-send-email-eyalr@ti.com> (Eyal Reizer's
        message of "Thu, 26 Apr 2018 08:47:11 +0300")
Message-ID: <87po2m7573.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Reizer <eyalreizer@gmail.com> writes:

> pm_runtime handles sdio power on and power off transitions.
> An old workaround for trying to control the power explicitly from the
> driver was in fact causing failures on suspend/resume as the mmc layer
> already power the module on resume.
>
> In case of resume pm_runtime_get sync returns a positive device's usage
> count causing the driver to try an re-initialize an already initialized
> device. This was causing sdio bus failure on resume.
>
> Remove this manual power on/off sequence as it is in-fact not needed.
>
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

No changelog. 

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

No need to resubmit because of this, I guess you just fixed the title
and added Tony's Acked-by?

-- 
Kalle Valo
