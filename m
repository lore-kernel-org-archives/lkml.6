Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeCTQeF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:34:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeCTQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:34:03 -0400
Date: Tue, 20 Mar 2018 12:34:01 -0400 (EDT)
Message-Id: <20180320.123401.2138083793709750726.davem@davemloft.net>
To: LIRAN.ALON@ORACLE.COM
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@ORACLE.COM, yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
From: David Miller <davem@davemloft.net>
In-Reply-To: <5AB132C5.5010806@ORACLE.COM>
References: <5AB12A0E.2060704@ORACLE.COM>
        <20180320.120036.1999626754164343704.davem@davemloft.net>
        <5AB132C5.5010806@ORACLE.COM>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <LIRAN.ALON@ORACLE.COM>
Date: Tue, 20 Mar 2018 18:11:49 +0200

> 1. Do we want to make a flag for every bug that is user-space visible?
> I think there is place for consideration on a per-case basis. I still
> don't see how a user can utilize this behaviour. He is basically
> loosing information (skb->mark) without this patch.

And maybe people trying to work in this situation have added code to
get the mark set some other way, or to validate that it is in fact
zero after passing through, which we would break with this change.

If it's set to zero now, it's reasonable to expect it to be zero.

By changing it to non-zero, different rules and routes will match
and this for sure has potential to break things.
