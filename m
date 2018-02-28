Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbeB1TVj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:21:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:43037 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933424AbeB1TVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:21:32 -0500
Subject: Re: [PATCH] xen-netfront: Fix hang on device removal
To: Jason Andryuk <jandryuk@gmail.com>, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Cc: Eduardo Otubo <otubo@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180228122323.3914-1-jandryuk@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <d6411bf3-9edd-15a7-1f4e-a9f51869129d@suse.com>
Date: Wed, 28 Feb 2018 20:21:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228122323.3914-1-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/18 13:23, Jason Andryuk wrote:
> A toolstack may delete the vif frontend and backend xenstore entries
> while xen-netfront is in the removal code path.  In that case, the
> checks for xenbus_read_driver_state would return XenbusStateUnknown, and
> xennet_remove would hang indefinitely.  This hang prevents system
> shutdown.
> 
> xennet_remove must be able to handle XenbusStateUnknown, and
> netback_changed must also wake up the wake_queue for that state as well.
> 
> Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading module")
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> Cc: Eduardo Otubo <otubo@redhat.com>

Committed to xen/tip for-linus-4.16a


Juergen
