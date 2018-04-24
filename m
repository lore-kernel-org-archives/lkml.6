Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758215AbeDXNr4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:47:56 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:46574 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756377AbeDXNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:47:52 -0400
Subject: Re: [regression, bisected] rockchip rk3399 video output breakage
To: JeffyChen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-rockchip@lists.infradead.org
Cc: klaus.goger@theobroma-systems.com,
        Huang Jiachai <sandy.huang@rock-chips.com>
References: <3beabd18-0c39-be65-cfe7-8498dc7c296b@theobroma-systems.com>
 <5ADF24F3.6070106@rock-chips.com>
 <fdd0fe29-2117-c67b-5dba-5d1ab0b19dd1@theobroma-systems.com>
 <5ADF321E.4060408@rock-chips.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <179239ba-0833-945c-0c2f-26fd9b7c2755@theobroma-systems.com>
Date: Tue, 24 Apr 2018 15:47:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5ADF321E.4060408@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.18 15:33, JeffyChen wrote:
>>> [   36.076577] WARNING: CPU: 1 PID: 83 at
>>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1004
>>> vop_crtc_atomic_flush+0x1c0/0x1c8
> 
> this looks like an issue recently reported by heiko, we found that might 
> due to an unbalanced irq disable in vop driver.
> 
> my test patch is:
> 
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1601,6 +1601,8 @@ static void vop_unbind(struct device *dev, struct 
> device *master, void *data)
>   {
>          struct vop *vop = dev_get_drvdata(dev);
> 
> +       // Pair with the initial disable_irq()
> +       enable_irq(vop->irq);
> 
> 
> 
> and i think sandy would send the real patch soon(maybe already sent?)

Works fine with your patch! Thank you very much Jeffy.

Best regards,
Jakob
