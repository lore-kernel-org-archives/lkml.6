Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeDSSOq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:14:46 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:46094 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDSSOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:14:45 -0400
X-Google-Smtp-Source: AIpwx49ftQ62oAQ+js6qvOy4sgnxl7K30MTlgDHdFxHG3OyCphtOnZsimK9BofXl8DMmPtw5yFU6oKv5Jv80jEXn+bA=
MIME-Version: 1.0
In-Reply-To: <1b07e839-5633-3b1e-1997-b86a891b2962@invisiblethingslab.com>
References: <20180228122323.3914-1-jandryuk@gmail.com> <1b07e839-5633-3b1e-1997-b86a891b2962@invisiblethingslab.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Thu, 19 Apr 2018 14:14:43 -0400
Message-ID: <CAKf6xpuusCJ0DMJ_G3hG5pd9vd8rUBH=VPa4TCvaoptGto-=Zw@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] xen-netfront: Fix hang on device removal
To: Simon Gaiser <simon@invisiblethingslab.com>
Cc: netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        Eduardo Otubo <otubo@redhat.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 2:10 PM, Simon Gaiser
<simon@invisiblethingslab.com> wrote:
> Jason Andryuk:
>> A toolstack may delete the vif frontend and backend xenstore entries
>> while xen-netfront is in the removal code path.  In that case, the
>> checks for xenbus_read_driver_state would return XenbusStateUnknown, and
>> xennet_remove would hang indefinitely.  This hang prevents system
>> shutdown.
>>
>> xennet_remove must be able to handle XenbusStateUnknown, and
>> netback_changed must also wake up the wake_queue for that state as well.
>>
>> Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading module")
>
> I think this should go into stable since AFAIK the hanging network
> device can only be fixed by rebooting the guest. AFAICS this affects all
> 4.* branches since 5b5971df3bc2 got backported to them.
>
> Upstream commit c2d2e6738a209f0f9dffa2dc8e7292fc45360d61.

Simon,

Yes, I agree.  I actually submitted the request to stable earlier
today, so hopefully it gets added soon.

Have you experienced this hang?

Regards,
Jason
