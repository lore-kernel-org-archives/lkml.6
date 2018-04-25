Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeDYIZZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:25:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750945AbeDYIZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:25:23 -0400
Date: Wed, 25 Apr 2018 10:25:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
Message-ID: <20180425102519.16e6195b.cohuck@redhat.com>
In-Reply-To: <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:48:06 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> The Sub channel event callback is threaded using workqueues.
> The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
> event.

I don't think this is a good name; after all, all of the events are
events for the subchannel :)

This seems to be more of a "we need to update the schib" event...
VFIO_CCW_EVENT_SCHIB_CHANGED? _SCH_CHANGED? _UPDATE_NEEDED?

Tbh, I'm not quite sure this makes sense for me yet... will continue
reading, but this probably needs a 'why'.

> The update of the SCHIB is now done inside the FSM function.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  3 +++
>  3 files changed, 39 insertions(+), 20 deletions(-)
