Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEJThd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:37:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeEJThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:37:32 -0400
Date: Thu, 10 May 2018 15:37:30 -0400 (EDT)
Message-Id: <20180510.153730.348233195080672901.davem@davemloft.net>
To: mgamal@redhat.com
Cc: netdev@vger.kernel.org, sthemmin@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, devel@linuxdriverproject.org,
        vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_netvsc: Fix net device attach on older Windows
 hosts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1525853854-8277-1-git-send-email-mgamal@redhat.com>
References: <1525853854-8277-1-git-send-email-mgamal@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammed Gamal <mgamal@redhat.com>
Date: Wed,  9 May 2018 10:17:34 +0200

> On older windows hosts the net_device instance is returned to
> the caller of rndis_filter_device_add() without having the presence
> bit set first. This would cause any subsequent calls to network device
> operations (e.g. MTU change, channel change) to fail after the device
> is detached once, returning -ENODEV.
> 
> Instead of returning the device instabce, we take the exit path where
> we call netif_device_attach()
> 
> Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

Applied.
