Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeBMCHU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933326AbeBMCHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:07:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8E4217B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Mon, 12 Feb 2018 18:07:09 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Juergen Gross <jgross@suse.com>
cc: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Stefano Stabellini <stefano@aporeto.com>
Subject: Re: [PATCH 2/2] pvcalls-front: wait for other operations to return
 when release passive sockets
In-Reply-To: <e2d6f037-cb0c-7669-0efc-c1e9bcf69a07@suse.com>
Message-ID: <alpine.DEB.2.10.1802121807030.3704@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1802051448460.10160@sstabellini-ThinkPad-X260> <1517871107-15349-1-git-send-email-sstabellini@kernel.org> <1517871107-15349-2-git-send-email-sstabellini@kernel.org> <e2d6f037-cb0c-7669-0efc-c1e9bcf69a07@suse.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Juergen Gross wrote:
> On 05/02/18 23:51, Stefano Stabellini wrote:
> > Passive sockets can have ongoing operations on them, specifically, we
> > have two wait_event_interruptable calls in pvcalls_front_accept.
> > 
> > Add two wake_up calls in pvcalls_front_release, then wait for the
> > potential waiters to return and release the sock_mapping refcount.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> 
> Acked-by: Juergen Gross <jgross@suse.com>

Thanks!
