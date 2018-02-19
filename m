Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeBSTzp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:55:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753727AbeBSTzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:55:42 -0500
Subject: Re: [PATCH v3 3/3] s390/setup : enable display support for KVM guest
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <8a6103fcc2b05f4426dcf6573a2175ffe6211403.1519053920.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b7e118a9-9920-07bc-ccac-f72f451fccea@redhat.com>
Date: Mon, 19 Feb 2018 20:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8a6103fcc2b05f4426dcf6573a2175ffe6211403.1519053920.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2018 16:47, Farhan Ali wrote:
> The S390 architecture does not support any graphics hardware,
> but with the latest support for Virtio GPU in Linux and Virtio
> GPU emulation in QEMU, it's possible to enable graphics for
> S390 using the Virtio GPU device.
> 
> To enable display we need to enable the Linux Virtual Terminal (VT)
> layer for S390. But the VT subsystem initializes quite early
> at boot so we need a dummy console driver till the Virtio GPU
> driver is initialized and we can run the framebuffer console.
> 
> The framebuffer console over a Virtio GPU device can be run
> in combination with the serial SCLP console (default on S390).
> The SCLP console can still be accessed by management applications
> (eg: via Libvirt's virsh console).
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/setup.c      | 2 ++
>  drivers/tty/Kconfig           | 2 +-
>  drivers/video/console/Kconfig | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
