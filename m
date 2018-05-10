Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEJT1Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:27:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36008 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEJT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:27:22 -0400
Date: Thu, 10 May 2018 15:27:19 -0400 (EDT)
Message-Id: <20180510.152719.500625126905254406.davem@davemloft.net>
To: vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com, petrm@mellanox.com, jiri@mellanox.com,
        idosch@mellanox.com, ivecera@redhat.com, stephen@networkplumber.org,
        andrew@lunn.ch, f.fainelli@gmail.com, nikolay@cumulusnetworks.com,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next] net: dsa: fix added_by_user switchdev
 notification
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
References: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue,  8 May 2018 23:03:12 -0400

> Commit 161d82de1ff8 ("net: bridge: Notify about !added_by_user FDB
> entries") causes the below oops when bringing up a slave interface,
> because dsa_port_fdb_add is still scheduled, but with a NULL address.
> 
> To fix this, keep the dsa_slave_switchdev_event function agnostic of the
> notified info structure and handle the added_by_user flag in the
> specific dsa_slave_switchdev_event_work function.
 ...
> Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notifications")
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied, thanks Vivien.
