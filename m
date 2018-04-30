Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeD3Pn3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:43:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753334AbeD3Pn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:43:28 -0400
Date: Mon, 30 Apr 2018 17:43:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 08/10] vfio: ccw: Handling reset and shutdown with
 states
Message-ID: <20180430174324.34f59569.cohuck@redhat.com>
In-Reply-To: <1524149293-12658-9-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-9-git-send-email-pmorel@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:48:11 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Two new events, VFIO_CCW_EVENT_ONLINE and VFIO_CCW_EVENT_OFFLINE
> allow to handle the enabling and disabling of a Sub Channel and
> the shutdown, quiesce and reset operations are changed accordingly.

OK, onlining/offlining via the fsm makes more sense conceptually than
the init event.

How is that supposed to play with enabling the subchannel in the init
event? I would rather expect it to be done in the onlining transition
only?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 47 ++++++--------------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 66 +++++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 15 +++------
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  4 files changed, 83 insertions(+), 48 deletions(-)
