Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524828000; cv=none;
        d=google.com; s=arc-20160816;
        b=SMvuTMiKs3w2RFSQWXIVo/q/ohbbJBBDDCtRuRUA6VjSc7p9KCYO9ElndlnXaKuzLG
         YFZrnZC/T2vrjte4MmI4XQyfAKcGlgZYqaYiyKfHv4etPLbeaudG4H2jLp+OjITEjrFs
         QjAVuDVWwCTRQUaCnqKEWX83Q07Gz3ugv2b+D8CoIYfOvKiOLtyfBCFBFFCPT4d/EHCE
         3SMHCMlaBcnPxS0kNXHAaUThwQDwyv/o+M/RLMZ/6xaQmXAZGHVm9EaGjrh0yVDR5gwX
         trTYW/YBlQFXpINqWt7VBdpPY0zuTcqNlFB8mjwoZGSwo9SPgJy+Fe4QVj3l8+r8kQFR
         dqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=w0bHS/HiA8WZO52N6Y0OJXLLq5hFUu+lE7cZ8jlOQqY=;
        b=a92rt2N/hMI2SVAwXMMEAeMhK3Ph+P0OS/UM5ggEUrxXCoH2h9rN4np9kc0Vo7c+s2
         S1zutVDww2HXwsd+islllHRpLePjX3stQuaC9njzi4Wun5HNKHQeRd4t99bT6RDKdLOW
         zA66GV2eOH1L/AG67+KygvstbNKQqlAG2uBac01Gwv466BCaSmddKxco01m2vY2Pk+fF
         Ab5mKaPm8YmYjjLpvpNbXi0SW9jTLLrAP5/FPyYZtGUJbRVVOtfmxkKWqwoo538V5tp3
         mlx3pZFXWfyL7m2/dl1Wh0lfFTq2ON8MUls2dXac8Wsz8abecX1uRMhAVHrUH3s7OWBx
         M6fQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FfZNO41v;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FfZNO41v;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZp5GuvV7jWSd6aRt9HQrCu5IxpRaIhl7qYUa0bvVrBZfGxFeghROIKRuKK6FIwX1wmmtih38vOC5HZI8brBcL0=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1524795811-21399-4-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org> <1524795811-21399-4-git-send-email-sdias@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 13:19:59 +0200
X-Google-Sender-Auth: IzVu0OcZhXIAl-Uea3kS8-BwwaE
Message-ID: <CAK8P3a1b-fDEpiHoUGvZELfF0BCRYoVJSGr7_qZ8xo1GMz3iUw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] mhi_bus: dev: netdev: add network interface driver
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864308521389559?=
X-GMAIL-MSGID: =?utf-8?q?1598898045845251979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 4:23 AM, Sujeev Dias <sdias@codeaurora.org> wrote:
> MHI based net device driver is used for transferring IP
> traffic between host and modem. Driver allows clients to
> transfer data using standard network interface.
>
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/bus/mhi.txt |  36 ++
>  drivers/bus/Kconfig                           |   1 +
>  drivers/bus/mhi/Makefile                      |   2 +-
>  drivers/bus/mhi/devices/Kconfig               |  10 +
>  drivers/bus/mhi/devices/Makefile              |   1 +
>  drivers/bus/mhi/devices/mhi_netdev.c          | 893 ++++++++++++++++++++++++++

Network drivers go into drivers/net/, not into the bus subsystem.
You also need to Cc the netdev mailing list for review.

>  6 files changed, 942 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bus/mhi/devices/Kconfig
>  create mode 100644 drivers/bus/mhi/devices/Makefile
>  create mode 100644 drivers/bus/mhi/devices/mhi_netdev.c
>
> diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
> index ea1b620..172ae7b 100644
> --- a/Documentation/devicetree/bindings/bus/mhi.txt
> +++ b/Documentation/devicetree/bindings/bus/mhi.txt
> @@ -139,3 +139,39 @@ mhi_controller {
>                 <driver specific properties>
>         };
>  };
> +
> +================
> +Children Devices
> +================
> +
> +MHI netdev properties
> +
> +- mhi,chan
> +  Usage: required
> +  Value type: <string>
> +  Definition: Channel name MHI netdev support
>
> +- mhi,mru
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Largest packet size interface can receive in bytes.
> +
> +- mhi,interface-name
> +  Usage: optional
> +  Value type: <string>
> +  Definition: Interface name to be given so clients can identify it
> +
> +- mhi,recycle-buf
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Set true if interface support recycling buffers.


> +========
> +Example:
> +========
> +
> +mhi_rmnet@0 {
> +       mhi,chan = "IP_HW0";
> +       mhi,interface-name = "rmnet_mhi";
> +       mhi,mru = <0x4000>;
> +};

Who defines the "IP_HW0" and "rmnet_mhi" strings?

Shouldn't there be a "compatible" property?


> +#define MHI_NETDEV_DRIVER_NAME "mhi_netdev"
> +#define WATCHDOG_TIMEOUT (30 * HZ)
> +
> +#ifdef CONFIG_MHI_DEBUG
> +
> +#define MHI_ASSERT(cond, msg) do { \
> +       if (cond) \
> +               panic(msg); \
> +} while (0)
> +
> +#define MSG_VERB(fmt, ...) do { \
> +       if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_VERBOSE) \
> +               pr_err("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
> +} while (0)
> +
> +#define MSG_LOG(fmt, ...) do { \
> +       if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_INFO) \
> +               pr_err("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
> +} while (0)
> +
> +#define MSG_ERR(fmt, ...) do { \
> +       if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_ERROR) \
> +               pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
> +} while (0)
> +

Please remove these macros and use the normal kernel
helpers we have.

> +struct mhi_stats {
> +       u32 rx_int;
> +       u32 tx_full;
> +       u32 tx_pkts;
> +       u32 rx_budget_overflow;
> +       u32 rx_frag;
> +       u32 alloc_failed;
> +};
> +
> +/* important: do not exceed sk_buf->cb (48 bytes) */
> +struct mhi_skb_priv {
> +       void *buf;
> +       size_t size;
> +       struct mhi_netdev *mhi_netdev;
> +};

Shouldn't all three members already be part of an skb?

You initialize them as

> +       u32 cur_mru = mhi_netdev->mru;
> +               skb_priv = (struct mhi_skb_priv *)skb->cb;
> +               skb_priv->buf = skb->data;
> +               skb_priv->size = cur_mru;
> +               skb_priv->mhi_netdev = mhi_netdev;

so I think you can remove the structure completely.

> +struct mhi_netdev {
> +       int alias;
> +       struct mhi_device *mhi_dev;
> +       spinlock_t rx_lock;
> +       bool enabled;
> +       rwlock_t pm_lock; /* state change lock */
> +       int (*rx_queue)(struct mhi_netdev *mhi_netdev, gfp_t gfp_t);
> +       struct work_struct alloc_work;
> +       int wake;
> +
> +       struct sk_buff_head rx_allocated;
> +
> +       u32 mru;
> +       const char *interface_name;
> +       struct napi_struct napi;
> +       struct net_device *ndev;
> +       struct sk_buff *frag_skb;
> +       bool recycle_buf;
> +
> +       struct mhi_stats stats;
> +       struct dentry *dentry;
> +       enum MHI_DEBUG_LEVEL msg_lvl;
> +};
> +
> +struct mhi_netdev_priv {
> +       struct mhi_netdev *mhi_netdev;
> +};

Please kill this intermediate structure and use the mhi_netdev
directly.

> +static struct mhi_driver mhi_netdev_driver;
> +static void mhi_netdev_create_debugfs(struct mhi_netdev *mhi_netdev);

Better remove forward declarations and sort the symbols in their
natural order.

> +static int mhi_netdev_alloc_skb(struct mhi_netdev *mhi_netdev, gfp_t gfp_t)
> +{
> +       u32 cur_mru = mhi_netdev->mru;
> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
> +       struct mhi_skb_priv *skb_priv;
> +       int ret;
> +       struct sk_buff *skb;
> +       int no_tre = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
> +       int i;
> +
> +       for (i = 0; i < no_tre; i++) {
> +               skb = alloc_skb(cur_mru, gfp_t);
> +               if (!skb)
> +                       return -ENOMEM;
> +
> +               read_lock_bh(&mhi_netdev->pm_lock);
> +               if (unlikely(!mhi_netdev->enabled)) {
> +                       MSG_ERR("Interface not enabled\n");
> +                       ret = -EIO;
> +                       goto error_queue;
> +               }

You shouldn't normally get here when the device is disabled,
I think you can remove the pm_lock and enabled members
and instead make sure the netdev itself is stopped at that
point.

> +               spin_lock_bh(&mhi_netdev->rx_lock);
> +               ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE, skb,
> +                                        skb_priv->size, MHI_EOT);
> +               spin_unlock_bh(&mhi_netdev->rx_lock);

What does this spinlock protect?

> +static void mhi_netdev_alloc_work(struct work_struct *work)
> +{
> +       struct mhi_netdev *mhi_netdev = container_of(work, struct mhi_netdev,
> +                                                  alloc_work);
> +       /* sleep about 1 sec and retry, that should be enough time
> +        * for system to reclaim freed memory back.
> +        */
> +       const int sleep_ms =  1000;

That is a long time to wait for in the middle of a work function!

Have you tested that it's actually sufficient to make the driver survive
an out-of-memory situation?

If you do need it at all, maybe use a delayed work queue that reschedules
itself rather than retrying in the work queue.

> +static int mhi_netdev_poll(struct napi_struct *napi, int budget)
> +{
> +       struct net_device *dev = napi->dev;
> +       struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
> +       struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
> +       int rx_work = 0;
> +       int ret;
> +
> +       MSG_VERB("Entered\n");
> +
> +       read_lock_bh(&mhi_netdev->pm_lock);
> +
> +       if (!mhi_netdev->enabled) {
> +               MSG_LOG("interface is disabled!\n");
> +               napi_complete(napi);
> +               read_unlock_bh(&mhi_netdev->pm_lock);
> +               return 0;
> +       }

Again, this shouldn't be required.

> +static int mhi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +       struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
> +       struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
> +       int res = 0;
> +       struct mhi_skb_priv *tx_priv;
> +
> +       MSG_VERB("Entered\n");
> +
> +       tx_priv = (struct mhi_skb_priv *)(skb->cb);
> +       tx_priv->mhi_netdev = mhi_netdev;
> +       read_lock_bh(&mhi_netdev->pm_lock);
> +
> +       if (unlikely(!mhi_netdev->enabled)) {
> +               /* Only reason interface could be disabled and we get data
> +                * is due to an SSR. We do not want to stop the queue and
> +                * return error. Instead we will flush all the uplink packets
> +                * and return successful
> +                */
> +               res = NETDEV_TX_OK;
> +               dev_kfree_skb_any(skb);
> +               goto mhi_xmit_exit;
> +       }
> +
> +       res = mhi_queue_transfer(mhi_dev, DMA_TO_DEVICE, skb, skb->len,
> +                                MHI_EOT);
> +       if (res) {
> +               MSG_VERB("Failed to queue with reason:%d\n", res);
> +               netif_stop_queue(dev);
> +               mhi_netdev->stats.tx_full++;
> +               res = NETDEV_TX_BUSY;
> +               goto mhi_xmit_exit;
> +       }

You don't seem to have any limit on the number of queued
transfers here. Since this is for a modem, it seems absolutely
essential that you keep track of how many packets have been
queued but not sent over the air yet.

Please add the necessary calls to netdev_sent_queue() here
and netdev_completed_queue() in the mhi_netdev_xfer_ul_cb
callback respectively to prevent uncontrolled buffer bloat.

Can you clarify whether mhi_netdev_xfer_ul_cb() is called
after the data has been read by the modem and queued
again in another buffer, or if it only gets called after we know
that the packet has been sent over the air?

> +static int mhi_netdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> +{
> +       int rc = 0;
> +
> +       switch (cmd) {
> +       default:
> +               /* don't fail any IOCTL right now */
> +               rc = 0;
> +               break;
> +       }
> +
> +       return rc;
> +}

That looks wrong. You should return an error for any unknown ioctl,
which is the default behavior you get without an ioctl function.

> +static void mhi_netdev_create_debugfs(struct mhi_netdev *mhi_netdev)
> +{
> +       char node_name[32];
> +       int i;
> +       const umode_t mode = 0600;
> +       struct dentry *file;
> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
> +
> +       const struct {
> +               char *name;
> +               u32 *ptr;
> +       } debugfs_table[] = {
> +               {
> +                       "rx_int",
> +                       &mhi_netdev->stats.rx_int
> +               },
> +               {
> +                       "tx_full",
> +                       &mhi_netdev->stats.tx_full
> +               },
> +               {
> +                       "tx_pkts",
> +                       &mhi_netdev->stats.tx_pkts
> +               },
> +               {
> +                       "rx_budget_overflow",
> +                       &mhi_netdev->stats.rx_budget_overflow
> +               },
> +               {
> +                       "rx_fragmentation",
> +                       &mhi_netdev->stats.rx_frag
> +               },
> +               {
> +                       "alloc_failed",
> +                       &mhi_netdev->stats.alloc_failed
> +               },
> +               {
> +                       NULL, NULL
> +               },
> +       };

Please use the regular network statistics interfaces for this,
don't roll your own.

> +       /* Both tx & rx client handle contain same device info */
> +       snprintf(node_name, sizeof(node_name), "%s_%04x_%02u.%02u.%02u_%u",
> +                mhi_netdev->interface_name, mhi_dev->dev_id, mhi_dev->domain,
> +                mhi_dev->bus, mhi_dev->slot, mhi_netdev->alias);
> +
> +       if (IS_ERR_OR_NULL(dentry))
> +               return;

IS_ERR_OR_NULL() is basically always a bug. debugfs returns NULL
only on success when it is completely disabled, which you were
trying to handle separately.

> +static int mhi_netdev_probe(struct mhi_device *mhi_dev,
> +                           const struct mhi_device_id *id)
> +{
> +       int ret;
> +       struct mhi_netdev *mhi_netdev;
> +       struct device_node *of_node = mhi_dev->dev.of_node;
> +       char node_name[32];
> +
> +       if (!of_node)
> +               return -ENODEV;
> +
> +       mhi_netdev = devm_kzalloc(&mhi_dev->dev, sizeof(*mhi_netdev),
> +                                 GFP_KERNEL);
> +       if (!mhi_netdev)
> +               return -ENOMEM;
> +
> +       mhi_netdev->alias = of_alias_get_id(of_node, "mhi_netdev");
> +       if (mhi_netdev->alias < 0)
> +               return -ENODEV;

Where is that alias documented?

> +       ret = of_property_read_string(of_node, "mhi,interface-name",
> +                                     &mhi_netdev->interface_name);
> +       if (ret)
> +               mhi_netdev->interface_name = mhi_netdev_driver.driver.name;

Don't couple the Linux interface name to what the hardware is
called.

      Arnd
