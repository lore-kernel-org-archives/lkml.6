Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeAaPas (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:30:48 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44864 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeAaPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:30:47 -0500
Date: Wed, 31 Jan 2018 10:30:44 -0500 (EST)
Message-Id: <20180131.103044.1805785714040464628.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: netdev@vger.kernel.org, ebiederm@xmission.com, dsahern@gmail.com,
        fw@strlen.de, daniel@iogearbox.net, lucien.xin@gmail.com,
        mschiffer@universe-factory.net, jakub.kicinski@netronome.com,
        vyasevich@gmail.com, linux-kernel@vger.kernel.org, jbenc@redhat.com,
        w.bumiller@proxmox.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 1/1] rtnetlink: enable IFLA_IF_NETNSID for
 RTM_NEWLINK
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180129170720.29724-2-christian.brauner@ubuntu.com>
References: <20180129170720.29724-1-christian.brauner@ubuntu.com>
        <20180129170720.29724-2-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 29 Jan 2018 18:07:20 +0100

> - Backwards Compatibility:
>   If userspace wants to determine whether RTM_NEWLINK supports the
>   IFLA_IF_NETNSID property they should first send an RTM_GETLINK request
>   with IFLA_IF_NETNSID on lo. If either EACCESS is returned or the reply
>   does not include IFLA_IF_NETNSID userspace should assume that
>   IFLA_IF_NETNSID is not supported on this kernel.
>   If the reply does contain an IFLA_IF_NETNSID property userspace
>   can send an RTM_NEWLINK with a IFLA_IF_NETNSID property. If they receive
>   EOPNOTSUPP then the kernel does not support the IFLA_IF_NETNSID property
>   with RTM_NEWLINK. Userpace should then fallback to other means.
> 
> - Security:
>   Callers must have CAP_NET_ADMIN in the owning user namespace of the
>   target network namespace.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied.
