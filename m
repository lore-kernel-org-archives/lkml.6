Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8F0222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiOuTB41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393597AbfBMSLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:11:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34582 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfBMSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:11:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so1525919pgd.1;
        Wed, 13 Feb 2019 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrHS5vFxEgzmiNAbM+qdLXpZHZsBwglSNvtisleVQFM=;
        b=hiOuTB41KUT+3dO2DqXiQYlNJ0nfESiYWuY1GIsF6LrmhLIBwSj0Pz1jhcJ4vxysK2
         SkUgeN+GF0bbCdk+tpVcZygDONjEBmtliP9hiIWAgyKz/xxPpjD3fdzw1sWVvCQTCezU
         egxEqgf+S1dEH0uiv4afhYibBku1421QXErwKbIjsA1V+J2xUJcGsxQvJ6HQm8Dz4EZu
         jyGKXcqJX888r0T9H7l9+3f45VYHTXBgc/6clzrez+jaCIB1cekpOAmbPCqWgk9aY11U
         oBk8hETfA0gC3lBhnrSgWsZUtWNp/q2fC8gONvWK2/S4B9a3qELdwyGnVvwk0OEju3z/
         9GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrHS5vFxEgzmiNAbM+qdLXpZHZsBwglSNvtisleVQFM=;
        b=iVdbmOjlq+HkfcrlxiPnhxPbGSBLuURN6T3PSBurqnl/18CmHeAnZDq4rqm8UtUh7Z
         Djt+DD5hjz0ebOkFHSGvAXWTA8Jgigf+/oYUAHCMKbr2yJ1cmLA/9kBK60yS9GgochI2
         sYUuVMhvirZNhOZktZfDb9OkbDAEeKXUghhIY2M4wrta5mPgyW7GHMZv1yJp93rYjezq
         qqP4vLa2dD0u8Czetq3upZ/hqXeDpM0GAOGl47CsCLS4gKXbKBjXEanhQAFhBcDpkP45
         koSohlenv3bocJ1vw8+tMTcqzBhumR2zgGtKjPxD3qDdZiP+mPwBGaYHJkh9YjjuTFZm
         C3aA==
X-Gm-Message-State: AHQUAubX3s3TrwldQI/7E5kWRjRQxAAmNbLfcfGldJquGH5qu3J4QARx
        pR00/xO4Mq0LfXAs46Hc87JqE1BZ41si9RBv2/0=
X-Google-Smtp-Source: AHgI3IZMnOM2XgB3sT2zXY6lAMaLztKgEwGl5gkLG6wpAsTvOWBygE8L8+x2RztdJP5BLKWhij0k6xQXQV8AAgSd+nM=
X-Received: by 2002:a63:4a21:: with SMTP id x33mr1628694pga.428.1550081473868;
 Wed, 13 Feb 2019 10:11:13 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1550064437-1363-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1550064437-1363-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Feb 2019 20:11:01 +0200
Message-ID: <CAHp75VeasVqg0MJ9_WSGLocd16m1iu32xHd9KYvNu0+kQ9MfVA@mail.gmail.com>
Subject: Re: [PATCH v9] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:27 PM Liming Sun <lsun@mellanox.com> wrote:
>
> This commit adds the TmFifo platform driver for Mellanox BlueField
> Soc. TmFifo is a shared FIFO which enables external host machine
> to exchange data with the SoC via USB or PCIe. The driver is based
> on virtio framework and has console and network access enabled.

Thanks for an update, my comments below.

Again, to Mellanox: guys, please, establish internal mailing list for
review and don't come with such quality of code.

Next time I would like to see Reviewed-by from Mellanox people I know,
like Vadim or Leon.

> +config MLXBF_TMFIFO
> +       tristate "Mellanox BlueField SoC TmFifo platform driver"

> +       depends on ARM64 && ACPI && VIRTIO_CONSOLE && VIRTIO_NET

Split this to three logical parts.

> +       help
> +         Say y here to enable TmFifo support. The TmFifo driver provides
> +          platform driver support for the TmFifo which supports console
> +          and networking based on the virtio framework.

>  obj-$(CONFIG_MLXREG_HOTPLUG)   += mlxreg-hotplug.o
>  obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
> +obj-$(CONFIG_MLXBF_TMFIFO)     += mlxbf-tmfifo.o

I would suggest to keep it sorted.

> +#define MLXBF_TMFIFO_TX_DATA 0x0

I suggest to use same fixed format for offsets.
Here, for example, 0x00 would be better.

> +#define MLXBF_TMFIFO_TX_STS__COUNT_RMASK 0x1ff
> +#define MLXBF_TMFIFO_TX_STS__COUNT_MASK  0x1ff

#include <linux/bits.h>
...
GENMASK()

> +#define MLXBF_TMFIFO_TX_CTL__LWM_RMASK 0xff
> +#define MLXBF_TMFIFO_TX_CTL__LWM_MASK  0xff

> +#define MLXBF_TMFIFO_TX_CTL__HWM_RMASK 0xff
> +#define MLXBF_TMFIFO_TX_CTL__HWM_MASK  0xff00

> +#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_RMASK 0x1ff
> +#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL

GENMASK() / GENMASK_ULL()

> +#define MLXBF_TMFIFO_RX_STS__COUNT_RMASK 0x1ff
> +#define MLXBF_TMFIFO_RX_STS__COUNT_MASK  0x1ff

GENMASK()

> +#define MLXBF_TMFIFO_RX_CTL__LWM_RMASK 0xff
> +#define MLXBF_TMFIFO_RX_CTL__LWM_MASK  0xff

> +#define MLXBF_TMFIFO_RX_CTL__HWM_RMASK 0xff
> +#define MLXBF_TMFIFO_RX_CTL__HWM_MASK  0xff00

> +#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK 0x1ff
> +#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL

Ditto.

> +#include <linux/acpi.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/bitfield.h>
> +#include <linux/cache.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/efi.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_console.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ring.h>

Do you need all of them?

> +#define MLXBF_TMFIFO_VRING_SIZE                        1024

SZ_1K ?

> +/* Console Tx buffer size. */
> +#define MLXBF_TMFIFO_CONS_TX_BUF_SIZE          (32 * 1024)

SZ_32K ?

> +/* House-keeping timer interval. */
> +static int mlxbf_tmfifo_timer_interval = HZ / 10;

> +/* Global lock. */

Noise. Either explain what it protects, or remove.

> +static DEFINE_MUTEX(mlxbf_tmfifo_lock);

> +/* Struct declaration. */

Noise.

> +/* Structure to maintain the ring state. */
> +struct mlxbf_tmfifo_vring {
> +       void *va;                       /* virtual address */
> +       dma_addr_t dma;                 /* dma address */
> +       struct virtqueue *vq;           /* virtqueue pointer */
> +       struct vring_desc *desc;        /* current desc */
> +       struct vring_desc *desc_head;   /* current desc head */
> +       int cur_len;                    /* processed len in current desc */
> +       int rem_len;                    /* remaining length to be processed */
> +       int size;                       /* vring size */
> +       int align;                      /* vring alignment */
> +       int id;                         /* vring id */
> +       int vdev_id;                    /* TMFIFO_VDEV_xxx */
> +       u32 pkt_len;                    /* packet total length */
> +       u16 next_avail;                 /* next avail desc id */
> +       struct mlxbf_tmfifo *fifo;      /* pointer back to the tmfifo */
> +};

Perhaps kernel-doc?

> +/* Interrupt types. */
> +enum {
> +       MLXBF_TM_RX_LWM_IRQ,            /* Rx low water mark irq */
> +       MLXBF_TM_RX_HWM_IRQ,            /* Rx high water mark irq */
> +       MLXBF_TM_TX_LWM_IRQ,            /* Tx low water mark irq */
> +       MLXBF_TM_TX_HWM_IRQ,            /* Tx high water mark irq */
> +       MLXBF_TM_IRQ_CNT

CNT...

> +};
> +
> +/* Ring types (Rx & Tx). */
> +enum {
> +       MLXBF_TMFIFO_VRING_RX,          /* Rx ring */
> +       MLXBF_TMFIFO_VRING_TX,          /* Tx ring */
> +       MLXBF_TMFIFO_VRING_NUM

...NUM

Perhaps one style for max numbers?

> +};

> +
> +/* Structure for the virtual device. */
> +struct mlxbf_tmfifo_vdev {
> +       struct virtio_device vdev;      /* virtual device */
> +       u8 status;
> +       u64 features;
> +       union {                         /* virtio config space */
> +               struct virtio_console_config cons;
> +               struct virtio_net_config net;
> +       } config;

Describe, which field allows to distinguish what type of the data is in a union.

> +       struct mlxbf_tmfifo_vring vrings[MLXBF_TMFIFO_VRING_NUM];
> +       u8 *tx_buf;                     /* tx buffer */
> +       u32 tx_head;                    /* tx buffer head */
> +       u32 tx_tail;                    /* tx buffer tail */
> +};

kernel-doc?

> +/* Structure of the interrupt information. */
> +struct mlxbf_tmfifo_irq_info {
> +       struct mlxbf_tmfifo *fifo;      /* tmfifo structure */
> +       int irq;                        /* interrupt number */
> +       int index;                      /* array index */
> +};

Ditto.

> +
> +/* Structure of the TmFifo information. */
> +struct mlxbf_tmfifo {
> +       struct mlxbf_tmfifo_vdev *vdev[MLXBF_TMFIFO_VDEV_MAX]; /* devices */
> +       struct platform_device *pdev;   /* platform device */
> +       struct mutex lock;              /* fifo lock */
> +       void __iomem *rx_base;          /* mapped register base */
> +       void __iomem *tx_base;          /* mapped register base */
> +       int tx_fifo_size;               /* number of entries of the Tx FIFO */
> +       int rx_fifo_size;               /* number of entries of the Rx FIFO */
> +       unsigned long pend_events;      /* pending bits for deferred process */
> +       struct mlxbf_tmfifo_irq_info irq_info[MLXBF_TM_IRQ_CNT]; /* irq info */
> +       struct work_struct work;        /* work struct for deferred process */
> +       struct timer_list timer;        /* keepalive timer */
> +       struct mlxbf_tmfifo_vring *vring[2];    /* current Tx/Rx ring */
> +       bool is_ready;                  /* ready flag */
> +       spinlock_t spin_lock;           /* spin lock */
> +};

Ditto.

> +/* Use a union struction for 64-bit little/big endian. */

What does this mean?

> +union mlxbf_tmfifo_data_64bit {
> +       u64 data;
> +       __le64 data_le;
> +};
> +
> +/* Message header used to demux data in the TmFifo. */
> +union mlxbf_tmfifo_msg_hdr {
> +       struct {
> +               u8 type;                /* message type */
> +               __be16 len;             /* payload length */
> +               u8 unused[5];           /* reserved, set to 0 */
> +       } __packed;

It's already packed. No?

> +       union mlxbf_tmfifo_data_64bit u;        /* 64-bit data */
> +};

> +/* MTU setting of the virtio-net interface. */
> +#define MLXBF_TMFIFO_NET_MTU           1500

Don't we have this globally defined?

> +/* Supported virtio-net features. */
> +#define MLXBF_TMFIFO_NET_FEATURES      ((1UL << VIRTIO_NET_F_MTU) | \
> +                                        (1UL << VIRTIO_NET_F_STATUS) | \
> +                                        (1UL << VIRTIO_NET_F_MAC))

BIT_UL() ?

> +/* Function declarations. */

Noise.

> +static int mlxbf_tmfifo_remove(struct platform_device *pdev);

Why do you need forward declaration for this?

> +/* Return the consumed Tx buffer space. */
> +static int mlxbf_tmfifo_vdev_tx_buf_len(struct mlxbf_tmfifo_vdev *vdev)
> +{
> +       return ((vdev->tx_tail >= vdev->tx_head) ?
> +               (vdev->tx_tail - vdev->tx_head) :
> +               (MLXBF_TMFIFO_CONS_TX_BUF_SIZE - vdev->tx_head +
> +                vdev->tx_tail));

Split this for better reading.

> +}
> +
> +/* Return the available Tx buffer space. */
> +static int mlxbf_tmfifo_vdev_tx_buf_avail(struct mlxbf_tmfifo_vdev *vdev)
> +{
> +       return (MLXBF_TMFIFO_CONS_TX_BUF_RSV_SIZE -
> +               mlxbf_tmfifo_vdev_tx_buf_len(vdev));

Redundant parens.
Moreover, you might consider temporary variable for better reading.

> +}
> +
> +/* Update Rx/Tx buffer index pointer. */
> +static void mlxbf_tmfifo_vdev_tx_buf_index_inc(u32 *index, u32 len)
> +{
> +       *index += len;
> +       if (*index >= MLXBF_TMFIFO_CONS_TX_BUF_SIZE)
> +               *index -= MLXBF_TMFIFO_CONS_TX_BUF_SIZE;
> +}
> +
> +/* Allocate vrings for the fifo. */
> +static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
> +                                    struct mlxbf_tmfifo_vdev *tm_vdev,
> +                                    int vdev_id)
> +{
> +       struct mlxbf_tmfifo_vring *vring;
> +       dma_addr_t dma;
> +       int i, size;
> +       void *va;
> +
> +       for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
> +               vring = &tm_vdev->vrings[i];
> +               vring->fifo = fifo;
> +               vring->size = MLXBF_TMFIFO_VRING_SIZE;
> +               vring->align = SMP_CACHE_BYTES;
> +               vring->id = i;
> +               vring->vdev_id = vdev_id;
> +

> +               size = PAGE_ALIGN(vring_size(vring->size, vring->align));

Why do you need this?
dma_alloc_coherent() allocates memory on page granularity anyway.

> +               va = dma_alloc_coherent(tm_vdev->vdev.dev.parent, size, &dma,
> +                                       GFP_KERNEL);
> +               if (!va) {

> +                       dev_err(tm_vdev->vdev.dev.parent,

Would be much easy if you have temporary variable for this device.

> +                               "dma_alloc_coherent failed\n");
> +                       return -ENOMEM;
> +               }
> +
> +               vring->va = va;
> +               vring->dma = dma;
> +       }
> +
> +       return 0;
> +}

> +/* Interrupt handler. */
> +static irqreturn_t mlxbf_tmfifo_irq_handler(int irq, void *arg)
> +{
> +       struct mlxbf_tmfifo_irq_info *irq_info;
> +
> +       irq_info = (struct mlxbf_tmfifo_irq_info *)arg;

Useless casting.
Assignment can be done in definition block.

> +       if (irq_info->index < MLXBF_TM_IRQ_CNT &&
> +           !test_and_set_bit(irq_info->index, &irq_info->fifo->pend_events))
> +               schedule_work(&irq_info->fifo->work);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* Get the next packet descriptor from the vring. */
> +static struct vring_desc *mlxbf_tmfifo_get_next_desc(struct virtqueue *vq)
> +{
> +       struct mlxbf_tmfifo_vring *vring;
> +       unsigned int idx, head;
> +       struct vring *vr;
> +
> +       vr = (struct vring *)virtqueue_get_vring(vq);

Return type is different? Is it safe to cast? Why?

> +       if (!vr)
> +               return NULL;

+ blank line

> +       vring = (struct mlxbf_tmfifo_vring *)vq->priv;

Do you need explicit casting?

> +       if (vring->next_avail == virtio16_to_cpu(vq->vdev, vr->avail->idx))
> +               return NULL;

+blank line

> +       idx = vring->next_avail % vr->num;
> +       head = virtio16_to_cpu(vq->vdev, vr->avail->ring[idx]);
> +       if (WARN_ON(head >= vr->num))
> +               return NULL;
> +       vring->next_avail++;
> +
> +       return &vr->desc[head];
> +}
> +
> +/* Release virtio descriptor. */
> +static void mlxbf_tmfifo_release_desc(struct virtio_device *vdev,
> +                                     struct vring *vr, struct vring_desc *desc,
> +                                     u32 len)
> +{
> +       u16 idx, vr_idx;
> +
> +       vr_idx = virtio16_to_cpu(vdev, vr->used->idx);
> +       idx = vr_idx % vr->num;
> +       vr->used->ring[idx].id = cpu_to_virtio32(vdev, desc - vr->desc);
> +       vr->used->ring[idx].len = cpu_to_virtio32(vdev, len);
> +
> +       /* Virtio could poll and check the 'idx' to decide
> +        * whether the desc is done or not. Add a memory
> +        * barrier here to make sure the update above completes
> +        * before updating the idx.
> +        */

Multi-line comment style is broken.

> +       mb();
> +       vr->used->idx = cpu_to_virtio16(vdev, vr_idx + 1);
> +}

> +/* House-keeping timer. */
> +static void mlxbf_tmfifo_timer(struct timer_list *arg)
> +{
> +       struct mlxbf_tmfifo *fifo;

> +       fifo = container_of(arg, struct mlxbf_tmfifo, timer);

Can't be done in the definition block?

> +       /*
> +        * Wake up the work handler to poll the Rx FIFO in case interrupt
> +        * missing or any leftover bytes stuck in the FIFO.
> +        */
> +       test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events);

How do you utilize test results?

> +
> +       /*
> +        * Wake up Tx handler in case virtio has queued too many packets
> +        * and are waiting for buffer return.
> +        */
> +       test_and_set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);

Ditto.

> +
> +       schedule_work(&fifo->work);
> +
> +       mod_timer(&fifo->timer, jiffies + mlxbf_tmfifo_timer_interval);
> +}

> +       /* Adjust the size to available space. */
> +       if (size + sizeof(hdr) > avail * sizeof(u64))
> +               size = avail * sizeof(u64) - sizeof(hdr);

Can avail be 0?

> +       /* Write header. */
> +       hdr.u.data = 0;
> +       hdr.type = VIRTIO_ID_CONSOLE;
> +       hdr.len = htons(size);
> +       hdr.u.data_le = cpu_to_le64(hdr.u.data);

> +       writeq(hdr.u.data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);

So, this one is not protected anyhow? Potential race condition?

> +
> +       spin_lock_irqsave(&fifo->spin_lock, flags);
> +
> +       while (size > 0) {
> +               addr = cons->tx_buf + cons->tx_head;
> +
> +               if (cons->tx_head + sizeof(u64) <=
> +                   MLXBF_TMFIFO_CONS_TX_BUF_SIZE) {
> +                       memcpy(&data, addr, sizeof(u64));
> +               } else {
> +                       partial = MLXBF_TMFIFO_CONS_TX_BUF_SIZE - cons->tx_head;
> +                       memcpy(&data, addr, partial);
> +                       memcpy((u8 *)&data + partial, cons->tx_buf,
> +                              sizeof(u64) - partial);
> +               }
> +               writeq(data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +
> +               if (size >= sizeof(u64)) {
> +                       mlxbf_tmfifo_vdev_tx_buf_index_inc(&cons->tx_head,
> +                                                          sizeof(u64));
> +                       size -= sizeof(u64);
> +               } else {
> +                       mlxbf_tmfifo_vdev_tx_buf_index_inc(&cons->tx_head,
> +                                                          size);
> +                       size = 0;
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&fifo->spin_lock, flags);
> +}

> +       /* Rx/Tx one word (8 bytes) if not done. */
> +       if (vring->cur_len != len)
> +               mlxbf_tmfifo_rxtx_word(fifo, vdev, vring, desc, is_rx, avail,
> +                                      len);

In such case better to keep it in one line.

> +/* Get the array of feature bits for this device. */
> +static u64 mlxbf_tmfifo_virtio_get_features(struct virtio_device *vdev)
> +{
> +       struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +       tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +       return tm_vdev->features;
> +}
> +
> +/* Confirm device features to use. */
> +static int mlxbf_tmfifo_virtio_finalize_features(struct virtio_device *vdev)
> +{
> +       struct mlxbf_tmfifo_vdev *tm_vdev;
> +

> +       tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);

This is candidate to be a macro

#define mlxbt_vdev_to_tmfifo(...) ...

> +       tm_vdev->features = vdev->features;
> +
> +       return 0;
> +}

> +/* Create vdev type in a tmfifo. */
> +static int mlxbf_tmfifo_create_vdev(struct device *dev,
> +                                   struct mlxbf_tmfifo *fifo,
> +                                   int vdev_id, u64 features,
> +                                   void *config, u32 size)
> +{
> +       struct mlxbf_tmfifo_vdev *tm_vdev;
> +       int ret = 0;
> +
> +       mutex_lock(&fifo->lock);
> +
> +       tm_vdev = fifo->vdev[vdev_id];
> +       if (tm_vdev) {
> +               dev_err(dev, "vdev %d already exists\n", vdev_id);
> +               ret = -EEXIST;
> +               goto fail;
> +       }
> +
> +       tm_vdev = devm_kzalloc(dev, sizeof(*tm_vdev), GFP_KERNEL);
> +       if (!tm_vdev) {
> +               ret = -ENOMEM;
> +               goto fail;
> +       }
> +
> +       tm_vdev->vdev.id.device = vdev_id;
> +       tm_vdev->vdev.config = &mlxbf_tmfifo_virtio_config_ops;
> +       tm_vdev->vdev.dev.parent = &fifo->pdev->dev;
> +       tm_vdev->features = features;
> +       if (config)
> +               memcpy(&tm_vdev->config, config, size);
> +       if (mlxbf_tmfifo_alloc_vrings(fifo, tm_vdev, vdev_id)) {
> +               dev_err(dev, "unable to allocate vring\n");
> +               ret = -ENOMEM;
> +               goto fail;
> +       }
> +       if (vdev_id == VIRTIO_ID_CONSOLE)

> +               tm_vdev->tx_buf = devm_kmalloc(dev,
> +                                              MLXBF_TMFIFO_CONS_TX_BUF_SIZE,
> +                                              GFP_KERNEL);

Are you sure devm_ suits here?

> +       fifo->vdev[vdev_id] = tm_vdev;
> +
> +       /* Register the virtio device. */
> +       ret = register_virtio_device(&tm_vdev->vdev);
> +       if (ret) {
> +               dev_err(&fifo->pdev->dev, "register_virtio_device failed\n");
> +               goto register_fail;
> +       }
> +
> +       mutex_unlock(&fifo->lock);
> +       return 0;
> +
> +register_fail:
> +       mlxbf_tmfifo_free_vrings(fifo, vdev_id);
> +       fifo->vdev[vdev_id] = NULL;
> +fail:
> +       mutex_unlock(&fifo->lock);
> +       return ret;
> +}

> +/* Read the configured network MAC address from efi variable. */
> +static void mlxbf_tmfifo_get_cfg_mac(u8 *mac)
> +{
> +       efi_guid_t guid = EFI_GLOBAL_VARIABLE_GUID;
> +       efi_status_t status;
> +       unsigned long size;
> +       u8 buf[6];
> +
> +       size = sizeof(buf);
> +       status = efi.get_variable(mlxbf_tmfifo_efi_name, &guid, NULL, &size,
> +                                 buf);
> +       if (status == EFI_SUCCESS && size == sizeof(buf))
> +               memcpy(mac, buf, sizeof(buf));
> +}

Shouldn't be rather helper in EFI lib in kernel?

> +/* Probe the TMFIFO. */
> +static int mlxbf_tmfifo_probe(struct platform_device *pdev)
> +{
> +       struct virtio_net_config net_config;
> +       struct resource *rx_res, *tx_res;
> +       struct mlxbf_tmfifo *fifo;
> +       int i, ret;
> +
> +       /* Get the resource of the Rx FIFO. */
> +       rx_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!rx_res)
> +               return -ENODEV;
> +
> +       /* Get the resource of the Tx FIFO. */
> +       tx_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!tx_res)
> +               return -ENODEV;
> +
> +       if (!devm_request_mem_region(&pdev->dev, rx_res->start,
> +                                    resource_size(rx_res), "bf-tmfifo"))
> +               return -EBUSY;
> +
> +       if (!devm_request_mem_region(&pdev->dev, tx_res->start,
> +                                    resource_size(tx_res), "bf-tmfifo"))
> +               return -EBUSY;
> +
> +       fifo = devm_kzalloc(&pdev->dev, sizeof(*fifo), GFP_KERNEL);
> +       if (!fifo)
> +               return -ENOMEM;
> +
> +       fifo->pdev = pdev;
> +       platform_set_drvdata(pdev, fifo);
> +
> +       spin_lock_init(&fifo->spin_lock);
> +       INIT_WORK(&fifo->work, mlxbf_tmfifo_work_handler);
> +
> +       timer_setup(&fifo->timer, mlxbf_tmfifo_timer, 0);
> +
> +       for (i = 0; i < MLXBF_TM_IRQ_CNT; i++) {
> +               fifo->irq_info[i].index = i;
> +               fifo->irq_info[i].fifo = fifo;

> +               fifo->irq_info[i].irq = platform_get_irq(pdev, i);


> +               ret = devm_request_irq(&pdev->dev, fifo->irq_info[i].irq,
> +                                      mlxbf_tmfifo_irq_handler, 0,
> +                                      "tmfifo", &fifo->irq_info[i]);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "devm_request_irq failed\n");
> +                       fifo->irq_info[i].irq = 0;
> +                       return ret;
> +               }
> +       }
> +

> +       fifo->rx_base = devm_ioremap(&pdev->dev, rx_res->start,
> +                                    resource_size(rx_res));
> +       if (!fifo->rx_base)
> +               return -ENOMEM;
> +
> +       fifo->tx_base = devm_ioremap(&pdev->dev, tx_res->start,
> +                                    resource_size(tx_res));
> +       if (!fifo->tx_base)
> +               return -ENOMEM;

Switch to devm_ioremap_resource().
However, I think you probably need memremap().

> +       mutex_init(&fifo->lock);

Isn't too late for initializing this one?


> +/* Device remove function. */
> +static int mlxbf_tmfifo_remove(struct platform_device *pdev)
> +{
> +       struct mlxbf_tmfifo *fifo = platform_get_drvdata(pdev);
> +

> +       if (fifo)

How is it possible to be not true?

> +               mlxbf_tmfifo_cleanup(fifo);
> +

> +       platform_set_drvdata(pdev, NULL);

Redundant.

> +
> +       return 0;
> +}

> +MODULE_LICENSE("GPL");

Is it correct?

-- 
With Best Regards,
Andy Shevchenko
