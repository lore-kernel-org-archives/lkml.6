Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934280AbeBLLwx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:52:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933898AbeBLLwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:52:49 -0500
Date: Mon, 12 Feb 2018 12:52:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180212115242.z3qv5uejbnhgvd6o@sirius.home.kraxel.org>
References: <20180126135803.29781-2-tomeu.vizoso@collabora.com>
 <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
 <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
 <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
 <20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
 <04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
 <38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> can we reach agreement on whether vsock should be involved in this?

I think the best approach would be to have guest proxy and host proxy
use vsock for the wayland protocol.  Use a wayland protocol extension to
reference the buffers in stdvga / ivshmem / virtio-gpu.  Only the two
proxies need to understand the extension, the client <=> guest proxy and
host proxy <=> server communication would be standard wayland protocol.

cheers,
  Gerd
