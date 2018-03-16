Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCPLz7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:55:59 -0400
Received: from mail.phycore.de ([217.6.246.34]:46555 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeCPLz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:55:58 -0400
Subject: Re: [PATCH v3] mfd: rk808: Add restart functionality
To: Daniel Schultz <d.schultz@phytec.de>, lee.jones@linaro.org
Cc: zhangqing@rock-chips.com, xsf@rock-chips.com, tony.xie@rock-chips.com,
        linux-kernel@vger.kernel.org
References: <1521188783-14985-1-git-send-email-d.schultz@phytec.de>
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <5cec78da-9b76-12fa-703a-bbaa90a6d58c@phytec.de>
Date: Fri, 16 Mar 2018 12:49:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521188783-14985-1-git-send-email-d.schultz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.03.2018 12:49:08,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.03.2018 12:49:08,
        Serialize complete at 16.03.2018 12:49:08
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 16.03.2018 um 09:26 schrieb Daniel Schultz:
> When using Rockchip SoCs with rk805/808/818 PMICs, restarts are realized by
> setting the reset registers in the "Clock and Reset Unit".
>
> Since all three shutdown functions have almost the same code, all logic
> from the shutdown functions can be refactored to a new function
> "rk808_update_bits", which can update a register by a given address and
> bitmask.
>
> After that, notifier blocks and the restart functions were added to the
> driver. Like the shutdown function, the restart is bound to the
> "rockchip,system-power-controller" device tree property and can easily
> revoked to the software restart by removing the property.
can you please split the changes into separate patches? One patch for
the refactoring of the shutdown functions and one for the new
system-reset-controller binding.

Regards,
Wadim
