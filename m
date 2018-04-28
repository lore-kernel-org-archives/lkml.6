Return-Path: <sdias@codeaurora.org>
X-Google-Smtp-Source: AB8JxZpCJGp16KAtKKA4zH7yX92ZzVOyfeFU4wlu7x1NsiUF7so0MV7GekylLTPubjplbjBfZP/y
ARC-Seal: i=1; a=rsa-sha256; t=1524929162; cv=none;
        d=google.com; s=arc-20160816;
        b=gB/b/VOH6biAfS34MYoEhchrVgpWVdv5kd2uQ4TptsXH1iZGuxzJzRO0SHb623TfCI
         LdEaDmIg2sScIz131DSmQ6wFiNkJBr+9r+xuaxwv6PEOM4hYj26cKD9gnZy+oAliMJ7P
         GvTPrGWBeHH5ACsxo5bejgmIU1r1oaxuAIH8eGpFBc6MNdChbnqEXVoXQe8foijWKGqv
         K698eXRSE9sLH8kWUxYQwaoK2aKwXf5OX5sQ9D150cnVH0YhMv040HSGgjQhwm3Xnb7t
         FpcjQCAW2ZGxonmiDOnMqmmFxUR68TpefuFJ2CX2K9gRmaLzsP4b1l1NPnJ04UNPsn5F
         Tc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=qgCfi3X55E/+YKh0CwGlDUR7gulWj5bo29eZhxZMi8Q=;
        b=VxNJw/0nBeizjuOQ2FghgsofMImipYej/qetkeaBOT6Fc+2WHeoLsaJkGiHfJAnZPI
         kFiXbAmi8eygHGT5BsBpRZ8x9kgP81h95fzq9QF56ys0X27MpAAuze6WhucIQeutD7rH
         MwWctzqiuDzZ7nUjBTlallcz5n2gViJWg3OrJdfuR8rt+BPRIaTpzlIY55ybVpbtwMs7
         jDegm075tmafLSscWNBKIs+SjG2uAaNeH2CEWCn3XeW4omWFjhWzkY8514WptXPJnXLs
         DmTSnsD7wWYCEDfpi35uoivUTPop4hUUQ0koKmUr9vndGfie7PN802Dg0ugmBp42iHpb
         CQRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZNPcXsml;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=a7mwlReB;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZNPcXsml;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=a7mwlReB;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2EDD60556
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
Subject: Re: [PATCH v1 3/4] mhi_bus: dev: netdev: add network interface driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-4-git-send-email-sdias@codeaurora.org>
 <CAK8P3a1b-fDEpiHoUGvZELfF0BCRYoVJSGr7_qZ8xo1GMz3iUw@mail.gmail.com>
From: Sujeev Dias <sdias@codeaurora.org>
Message-ID: <22d8fc11-b06a-f512-9533-ec4695b006ba@codeaurora.org>
Date: Sat, 28 Apr 2018 08:25:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1b-fDEpiHoUGvZELfF0BCRYoVJSGr7_qZ8xo1GMz3iUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864308521389559?=
X-GMAIL-MSGID: =?utf-8?q?1599004121887175650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/27/2018 04:19 AM, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 4:23 AM, Sujeev Dias <sdias@codeaurora.org> wrote:
>> MHI based net device driver is used for transferring IP
>> traffic between host and modem. Driver allows clients to
>> transfer data using standard network interface.
>>
>> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/bus/mhi.txt |  36 ++
>>   drivers/bus/Kconfig                           |   1 +
>>   drivers/bus/mhi/Makefile                      |   2 +-
>>   drivers/bus/mhi/devices/Kconfig               |  10 +
>>   drivers/bus/mhi/devices/Makefile              |   1 +
>>   drivers/bus/mhi/devices/mhi_netdev.c          | 893 ++++++++++++++++++++++++++
> Network drivers go into drivers/net/, not into the bus subsystem.
> You also need to Cc the netdev mailing list for review.
will do, thanks.
>>   6 files changed, 942 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/bus/mhi/devices/Kconfig
>>   create mode 100644 drivers/bus/mhi/devices/Makefile
>>   create mode 100644 drivers/bus/mhi/devices/mhi_netdev.c
>>
>> diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
>> index ea1b620..172ae7b 100644
>> --- a/Documentation/devicetree/bindings/bus/mhi.txt
>> +++ b/Documentation/devicetree/bindings/bus/mhi.txt
>> @@ -139,3 +139,39 @@ mhi_controller {
>>                  <driver specific properties>
>>          };
>>   };
>> +
>> +================
>> +Children Devices
>> +================
>> +
>> +MHI netdev properties
>> +
>> +- mhi,chan
>> +  Usage: required
>> +  Value type: <string>
>> +  Definition: Channel name MHI netdev support
>>
>> +- mhi,mru
>> +  Usage: required
>> +  Value type: <u32>
>> +  Definition: Largest packet size interface can receive in bytes.
>> +
>> +- mhi,interface-name
>> +  Usage: optional
>> +  Value type: <string>
>> +  Definition: Interface name to be given so clients can identify it
>> +
>> +- mhi,recycle-buf
>> +  Usage: optional
>> +  Value type: <bool>
>> +  Definition: Set true if interface support recycling buffers.
>
>> +========
>> +Example:
>> +========
>> +
>> +mhi_rmnet@0 {
>> +       mhi,chan = "IP_HW0";
>> +       mhi,interface-name = "rmnet_mhi";
>> +       mhi,mru = <0x4000>;
>> +};
> Who defines the "IP_HW0" and "rmnet_mhi" strings?
>
> Shouldn't there be a "compatible" property?
>
IP_HW0 is the a dedicated channel for IP traffic.  It's defined  by MHI 
specification.  Supported channel names are fixed and
dedicated per device. Interface name is a network iface name given so 
clients can identify the netdevice under /net/.

Similar how pci framework bind DT based on bdf with pci end point 
driver, MHI bus uses mhi,chan property to bind children
DT node before calling probe.
mhi_main.c/mhi_create_device()

mhi_main.c/mhi_create_device()
  /* add if there is a matching DT node */
controller = mhi_cntrl->of_node;
  for_each_available_child_of_node(controller, node) {
      ret = of_property_read_string(node, "mhi,chan",
                        &dt_name);
      if (ret)
          continue;
      if (!strcmp(mhi_dev->chan_name, dt_name))
           mhi_dev->dev.of_node = node;
>> +#define MHI_NETDEV_DRIVER_NAME "mhi_netdev"
>> +#define WATCHDOG_TIMEOUT (30 * HZ)
>> +
>> +#ifdef CONFIG_MHI_DEBUG
>> +
>> +#define MHI_ASSERT(cond, msg) do { \
>> +       if (cond) \
>> +               panic(msg); \
>> +} while (0)
>> +
>> +#define MSG_VERB(fmt, ...) do { \
>> +       if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_VERBOSE) \
>> +               pr_err("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
>> +} while (0)
>> +
>> +#define MSG_LOG(fmt, ...) do { \
>> +       if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_INFO) \
>> +               pr_err("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
>> +} while (0)
>> +
>> +#define MSG_ERR(fmt, ...) do { \
>> +       if (mhi_netdev->msg_lvl <= MHI_MSG_LVL_ERROR) \
>> +               pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
> Please remove these macros and use the normal kernel
> helpers we have.
Will do on next patch set.
>> +struct mhi_stats {
>> +       u32 rx_int;
>> +       u32 tx_full;
>> +       u32 tx_pkts;
>> +       u32 rx_budget_overflow;
>> +       u32 rx_frag;
>> +       u32 alloc_failed;
>> +};
>> +
>> +/* important: do not exceed sk_buf->cb (48 bytes) */
>> +struct mhi_skb_priv {
>> +       void *buf;
>> +       size_t size;
>> +       struct mhi_netdev *mhi_netdev;
>> +};
> Shouldn't all three members already be part of an skb?
>
> You initialize them as
>
>> +       u32 cur_mru = mhi_netdev->mru;
>> +               skb_priv = (struct mhi_skb_priv *)skb->cb;
>> +               skb_priv->buf = skb->data;
>> +               skb_priv->size = cur_mru;
>> +               skb_priv->mhi_netdev = mhi_netdev;
> so I think you can remove the structure completely.
Will confirm and remove it if it's not needed.
>> +struct mhi_netdev {
>> +       int alias;
>> +       struct mhi_device *mhi_dev;
>> +       spinlock_t rx_lock;
>> +       bool enabled;
>> +       rwlock_t pm_lock; /* state change lock */
>> +       int (*rx_queue)(struct mhi_netdev *mhi_netdev, gfp_t gfp_t);
>> +       struct work_struct alloc_work;
>> +       int wake;
>> +
>> +       struct sk_buff_head rx_allocated;
>> +
>> +       u32 mru;
>> +       const char *interface_name;
>> +       struct napi_struct napi;
>> +       struct net_device *ndev;
>> +       struct sk_buff *frag_skb;
>> +       bool recycle_buf;
>> +
>> +       struct mhi_stats stats;
>> +       struct dentry *dentry;
>> +       enum MHI_DEBUG_LEVEL msg_lvl;
>> +};
>> +
>> +struct mhi_netdev_priv {
>> +       struct mhi_netdev *mhi_netdev;
>> +};
> Please kill this intermediate structure and use the mhi_netdev
> directly.
>
>> +static struct mhi_driver mhi_netdev_driver;
>> +static void mhi_netdev_create_debugfs(struct mhi_netdev *mhi_netdev);
> Better remove forward declarations and sort the symbols in their
> natural order.
>
>> +static int mhi_netdev_alloc_skb(struct mhi_netdev *mhi_netdev, gfp_t gfp_t)
>> +{
>> +       u32 cur_mru = mhi_netdev->mru;
>> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
>> +       struct mhi_skb_priv *skb_priv;
>> +       int ret;
>> +       struct sk_buff *skb;
>> +       int no_tre = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
>> +       int i;
>> +
>> +       for (i = 0; i < no_tre; i++) {
>> +               skb = alloc_skb(cur_mru, gfp_t);
>> +               if (!skb)
>> +                       return -ENOMEM;
>> +
>> +               read_lock_bh(&mhi_netdev->pm_lock);
>> +               if (unlikely(!mhi_netdev->enabled)) {
>> +                       MSG_ERR("Interface not enabled\n");
>> +                       ret = -EIO;
>> +                       goto error_queue;
>> +               }
> You shouldn't normally get here when the device is disabled,
> I think you can remove the pm_lock and enabled members
> and instead make sure the netdev itself is stopped at that
> point.
I will need to think about this a bit more, will address in next patch set.
>> +               spin_lock_bh(&mhi_netdev->rx_lock);
>> +               ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE, skb,
>> +                                        skb_priv->size, MHI_EOT);
>> +               spin_unlock_bh(&mhi_netdev->rx_lock);
> What does this spinlock protect?
This should answer by your next question, reason is I have this lock is 
because
mhi_netdev_allocwork could be running in parallel while mhi_netdev_poll also
calling mhi_netdev_alloc_skb().  I couldn't think of a simpler way to
protect each other than using this lock. I will put a comment
>> +static void mhi_netdev_alloc_work(struct work_struct *work)
>> +{
>> +       struct mhi_netdev *mhi_netdev = container_of(work, struct mhi_netdev,
>> +                                                  alloc_work);
>> +       /* sleep about 1 sec and retry, that should be enough time
>> +        * for system to reclaim freed memory back.
>> +        */
>> +       const int sleep_ms =  1000;
> That is a long time to wait for in the middle of a work function!
>
> Have you tested that it's actually sufficient to make the driver survive
> an out-of-memory situation?
>
> If you do need it at all, maybe use a delayed work queue that reschedules
> itself rather than retrying in the work queue.
When system running for days, we have seeing  out of
memory issues and re-trying does helps.  I like your suggestion,
will use a delayed work queue.
>> +static int mhi_netdev_poll(struct napi_struct *napi, int budget)
>> +{
>> +       struct net_device *dev = napi->dev;
>> +       struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
>> +       struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
>> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
>> +       int rx_work = 0;
>> +       int ret;
>> +
>> +       MSG_VERB("Entered\n");
>> +
>> +       read_lock_bh(&mhi_netdev->pm_lock);
>> +
>> +       if (!mhi_netdev->enabled) {
>> +               MSG_LOG("interface is disabled!\n");
>> +               napi_complete(napi);
>> +               read_unlock_bh(&mhi_netdev->pm_lock);
>> +               return 0;
>> +       }
> Again, this shouldn't be required.
>
Without the lock how can I synchronize mhi_netdev_poll with remove()? 
Remove can happens anytime
asynchronously whenever modem powers off. I may not needed the check, 
but I may need to keep the lock.
>> +static int mhi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +       struct mhi_netdev_priv *mhi_netdev_priv = netdev_priv(dev);
>> +       struct mhi_netdev *mhi_netdev = mhi_netdev_priv->mhi_netdev;
>> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
>> +       int res = 0;
>> +       struct mhi_skb_priv *tx_priv;
>> +
>> +       MSG_VERB("Entered\n");
>> +
>> +       tx_priv = (struct mhi_skb_priv *)(skb->cb);
>> +       tx_priv->mhi_netdev = mhi_netdev;
>> +       read_lock_bh(&mhi_netdev->pm_lock);
>> +
>> +       if (unlikely(!mhi_netdev->enabled)) {
>> +               /* Only reason interface could be disabled and we get data
>> +                * is due to an SSR. We do not want to stop the queue and
>> +                * return error. Instead we will flush all the uplink packets
>> +                * and return successful
>> +                */
>> +               res = NETDEV_TX_OK;
>> +               dev_kfree_skb_any(skb);
>> +               goto mhi_xmit_exit;
>> +       }
>> +
>> +       res = mhi_queue_transfer(mhi_dev, DMA_TO_DEVICE, skb, skb->len,
>> +                                MHI_EOT);
>> +       if (res) {
>> +               MSG_VERB("Failed to queue with reason:%d\n", res);
>> +               netif_stop_queue(dev);
>> +               mhi_netdev->stats.tx_full++;
>> +               res = NETDEV_TX_BUSY;
>> +               goto mhi_xmit_exit;
>> +       }
> You don't seem to have any limit on the number of queued
> transfers here. Since this is for a modem, it seems absolutely
> essential that you keep track of how many packets have been
> queued but not sent over the air yet.
>
> Please add the necessary calls to netdev_sent_queue() here
> and netdev_completed_queue() in the mhi_netdev_xfer_ul_cb
> callback respectively to prevent uncontrolled buffer bloat.
>
> Can you clarify whether mhi_netdev_xfer_ul_cb() is called
> after the data has been read by the modem and queued
> again in another buffer, or if it only gets called after we know
> that the packet has been sent over the air?
Callback comes immediately after modem read the buffer from host DDR to
local DDR. Data goes thru multiple layers in modem before actually goes out
over the air.
>> +static int mhi_netdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> +{
>> +       int rc = 0;
>> +
>> +       switch (cmd) {
>> +       default:
>> +               /* don't fail any IOCTL right now */
>> +               rc = 0;
>> +               break;
>> +       }
>> +
>> +       return rc;
>> +}
> That looks wrong. You should return an error for any unknown ioctl,
> which is the default behavior you get without an ioctl function.
I will remove the ioctl, will add a separate patch for supported IOCTLs.
>> +static void mhi_netdev_create_debugfs(struct mhi_netdev *mhi_netdev)
>> +{
>> +       char node_name[32];
>> +       int i;
>> +       const umode_t mode = 0600;
>> +       struct dentry *file;
>> +       struct mhi_device *mhi_dev = mhi_netdev->mhi_dev;
>> +
>> +       const struct {
>> +               char *name;
>> +               u32 *ptr;
>> +       } debugfs_table[] = {
>> +               {
>> +                       "rx_int",
>> +                       &mhi_netdev->stats.rx_int
>> +               },
>> +               {
>> +                       "tx_full",
>> +                       &mhi_netdev->stats.tx_full
>> +               },
>> +               {
>> +                       "tx_pkts",
>> +                       &mhi_netdev->stats.tx_pkts
>> +               },
>> +               {
>> +                       "rx_budget_overflow",
>> +                       &mhi_netdev->stats.rx_budget_overflow
>> +               },
>> +               {
>> +                       "rx_fragmentation",
>> +                       &mhi_netdev->stats.rx_frag
>> +               },
>> +               {
>> +                       "alloc_failed",
>> +                       &mhi_netdev->stats.alloc_failed
>> +               },
>> +               {
>> +                       NULL, NULL
>> +               },
>> +       };
> Please use the regular network statistics interfaces for this,
> don't roll your own.
>> +       /* Both tx & rx client handle contain same device info */
>> +       snprintf(node_name, sizeof(node_name), "%s_%04x_%02u.%02u.%02u_%u",
>> +                mhi_netdev->interface_name, mhi_dev->dev_id, mhi_dev->domain,
>> +                mhi_dev->bus, mhi_dev->slot, mhi_netdev->alias);
>> +
>> +       if (IS_ERR_OR_NULL(dentry))
>> +               return;
> IS_ERR_OR_NULL() is basically always a bug. debugfs returns NULL
> only on success when it is completely disabled, which you were
> trying to handle separately.
>
>> +static int mhi_netdev_probe(struct mhi_device *mhi_dev,
>> +                           const struct mhi_device_id *id)
>> +{
>> +       int ret;
>> +       struct mhi_netdev *mhi_netdev;
>> +       struct device_node *of_node = mhi_dev->dev.of_node;
>> +       char node_name[32];
>> +
>> +       if (!of_node)
>> +               return -ENODEV;
>> +
>> +       mhi_netdev = devm_kzalloc(&mhi_dev->dev, sizeof(*mhi_netdev),
>> +                                 GFP_KERNEL);
>> +       if (!mhi_netdev)
>> +               return -ENOMEM;
>> +
>> +       mhi_netdev->alias = of_alias_get_id(of_node, "mhi_netdev");
>> +       if (mhi_netdev->alias < 0)
>> +               return -ENODEV;
> Where is that alias documented?
Will add to documentation.
>> +       ret = of_property_read_string(of_node, "mhi,interface-name",
>> +                                     &mhi_netdev->interface_name);
>> +       if (ret)
>> +               mhi_netdev->interface_name = mhi_netdev_driver.driver.name;
> Don't couple the Linux interface name to what the hardware is
> called.
>
>        Arnd

Thanks for all comments Arnd

Sujeev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
