Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBAQg7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:36:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBAQg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:36:58 -0500
Date: Thu, 1 Feb 2018 17:36:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
 <20180126135803.29781-2-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126135803.29781-2-tomeu.vizoso@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Sorry for joining the party late.  Had a broken finger and was offline
for a bunch of weeks (and a buif backlog afterwards ...).

> This is to allow clients running within VMs to be able to communicate
> with a compositor in the host. Clients will use the communication
> protocol that the compositor supports, and virtio-gpu will assist with
> making buffers available in both sides, and copying content as needed.

Why not use virtio-vsock to run the wayland protocol?  I don't like the
idea to duplicate something with very simliar functionality in
virtio-gpu.

> It is expected that a service in the guest will act as a proxy,
> interacting with virtio-gpu to support unmodified clients.

If you have a guest proxy anyway using virtio-sock for the protocol
stream and virtio-gpu for buffer sharing (and some day 3d rendering too)
should work fine I think.

> When the client notifies the compositor that it can read from that buffer,
> the proxy should copy the contents from the SHM region to the virtio-gpu
> resource and call DRM_VIRTGPU_TRANSFER_TO_HOST.

What is the plan for the host side?  I see basically two options.
Either implement the host wayland proxy directly in qemu.  Or implement
it as separate process, which then needs some help from qemu to get
access to the buffers.  The later would allow qemu running independant
from the desktop session.

cheers,
  Gerd
