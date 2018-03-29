Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeC2QJH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:09:07 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45364 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbeC2QJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:09:05 -0400
Date: Thu, 29 Mar 2018 12:09:03 -0400 (EDT)
Message-Id: <20180329.120903.1175452061863560219.davem@davemloft.net>
To: dongli.zhang@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, wei.liu2@citrix.com, paul.durrant@citrix.com
Subject: Re: [PATCH 1/1] xen-netback: process malformed sk_buff correctly
 to avoid BUG_ON()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522194136-11985-1-git-send-email-dongli.zhang@oracle.com>
References: <1522194136-11985-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Wed, 28 Mar 2018 07:42:16 +0800

> The "BUG_ON(!frag_iter)" in function xenvif_rx_next_chunk() is triggered if
> the received sk_buff is malformed, that is, when the sk_buff has pattern
> (skb->data_len && !skb_shinfo(skb)->nr_frags). Below is a sample call
> stack:

We should fix the parts of the kernel which build illegal malformed
SKBs rather than adding checks to every driver in the tree.

I'm not applying this, sorry.
