Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBHTeA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:34:00 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48338 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:33:59 -0500
Date: Thu, 08 Feb 2018 14:33:56 -0500 (EST)
Message-Id: <20180208.143356.2044831753683027153.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: netdev@vger.kernel.org, ktkhai@virtuozzo.com,
        stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH net 1/1 v4] rtnetlink: require unique netns identifier
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180207125320.9103-2-christian.brauner@ubuntu.com>
References: <20180207125320.9103-1-christian.brauner@ubuntu.com>
        <20180207125320.9103-2-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed,  7 Feb 2018 13:53:20 +0100

> Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
> it is possible for userspace to send us requests with three different
> properties to identify a target network namespace. This affects at least
> RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
> network namespace which is confusing. For legacy reasons the kernel will
> pick the IFLA_NET_NS_PID property first and then look for the
> IFLA_NET_NS_FD property but there is no reason to extend this type of
> behavior to network namespace ids. The regression potential is quite
> minimal since the rtnetlink requests in question either won't allow
> IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
> support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks Christian.
