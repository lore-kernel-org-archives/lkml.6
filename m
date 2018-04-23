Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeDWOLB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:11:01 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:18114 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754962AbeDWOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:10:57 -0400
X-IronPort-AV: E=Sophos;i="5.49,318,1520899200";
   d="scan'208";a="52449256"
Date: Mon, 23 Apr 2018 15:09:11 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <ian.jackson@eu.citrix.com>, <wei.liu2@citrix.com>,
        <srinivas.eeda@oracle.com>
Subject: Re: [RFC 0/2] To introduce xenwatch multithreading (xen mtwatch)
Message-ID: <20180423140911.bihiwfwtlneobgzd@citrix.com>
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 07:25:53PM +0800, Dongli Zhang wrote:
> About per-domU xenwatch thread create/destroy, a new type of xenstore node is
> introduced: '/local/domain/0/mtwatch/<domid>'.
> 
> Suppose the new domid id 7. During the domU (domid=7) creation, the xen
> toolstack writes '/local/domain/0/mtwatch/7' to xenstore before the insertion
> of '/local/domain/7'. When the domid=7 is destroyed, the last xenstore
> operation by xen toolstack is to remove '/local/domain/0/mtwatch/7'.
> 
> The dom0 kernel subscribes a watch at node '/local/domain/0/mtwatch'.  Kernel
> thread [xen-mtwatch-7] is created when '/local/domain/0/mtwatch/7' is inserted,
> while this kernel thread is destroyed when the corresponding xenstore node is
> removed.

Instead of inventing yet another node, can you not watch /local/domain
directly?

Wei.
