Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756725AbeDZUAQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:00:16 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39211 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbeDZUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:00:13 -0400
X-Google-Smtp-Source: AIpwx4+VPzUKhQK7pGthpevFW0WDPrPauO2QyHlbiVkCtdhoIBUHIvCkG0kiA84iNl5YGSAF2r+DkQ==
Date: Thu, 26 Apr 2018 22:00:10 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Janusz Lisiecki <janusz.lisiecki@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: Re: [PATCH] staging: ks7010: fix ks_wlan_start_xmit()'s return type
Message-ID: <20180426200009.lpfmn47d6hz75w6b@ltop.local>
References: <20180424131824.5164-1-luc.vanoostenryck@gmail.com>
 <2203ebe4-63c2-3728-50fa-a30b195d1508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2203ebe4-63c2-3728-50fa-a30b195d1508@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 06:44:38PM +0200, Janusz Lisiecki wrote:
> Maybe inside ks_wlan_start_xmit, instead of "return 0;", there should be
> "return NETDEV_TX_OK;" and "return NETDEV_TX_BUSY;" otherwise. It is just
> suggestion.

I see, yes. However, since:
1) this sort of change is really outside the goal of this patch;
2) more change are needed for returning NETDEV_TX_BUSY (most not
   free the skb, probably should stop the queue/device, ...);
3) the driver is actively improving by someone just now (Sergio);
I prefer to let this change to Sergio.

I'll resend my (unimportant) change in a few weeks (if still needed).


Cheers,
-- Luc
