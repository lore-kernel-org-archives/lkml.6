Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4C9A60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeFFRsm convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 13:48:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45186 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeFFRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:48:41 -0400
Date: Wed, 06 Jun 2018 13:48:36 -0400 (EDT)
Message-Id: <20180606.134836.249970219401888866.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: arun.parameswaran@broadcom.com,
        vivien.didelot@savoirfairelinux.com, andrew@lunn.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, peron.clem@gmail.com
Subject: Re: [PATCH 1/1] net: dsa: b53: Fix for brcm tag issue in Cygnus SoC
From: David Miller <davem@davemloft.net>
In-Reply-To: <c51cf072-beeb-6630-e260-24c585d29aae@gmail.com>
References: <1528231092-31472-1-git-send-email-arun.parameswaran@broadcom.com>
        <c51cf072-beeb-6630-e260-24c585d29aae@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 5 Jun 2018 14:41:41 -0700

> On 06/05/2018 01:38 PM, Arun Parameswaran wrote:
>> In the Broadcom Cygnus SoC, the brcm tag needs to be inserted
>> in between the mac address and the ether type (should use
>> 'DSA_PROTO_TAG_BRCM') for the packets sent to the internal
>> b53 switch.
>> 
>> Since the Cygnus was added with the BCM58XX device id and the
>> BCM58XX uses 'DSA_PROTO_TAG_BRCM_PREPEND', the data path is
>> broken, due to the incorrect brcm tag location.
>> 
>> Add a new b53 device id (BCM583XX) for Cygnus family to fix the
>> issue. Add the new device id to the BCM58XX family as Cygnus
>> is similar to the BCM58XX in most other functionalities.
>> 
>> Fixes: 11606039604c ("net: dsa: b53: Support prepended Broadcom tags")
>> 
>> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> 
> Clement originally reported this to me/us:
> 
> Reported-by: Clément Péron <peron.clem@gmail.com>
> 
> I completely overlooked that when adding support for prepended Broadcom
> tags, thanks for the fix Arun!
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> David, can you also queue this up for -stable? Thank you

Applied and queued up for -stable, thanks everyone.
