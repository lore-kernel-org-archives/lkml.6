Return-Path: <sdias@codeaurora.org>
X-Google-Smtp-Source: AB8JxZpAZLaS+fpN/nkQ85RAlpABM/f104Smj9clgsd22Ywb6OF5w11QhwLBXjqnVQ6CKClQ/x04
ARC-Seal: i=1; a=rsa-sha256; t=1524931730; cv=none;
        d=google.com; s=arc-20160816;
        b=Y/gX49HkqlLDM3eTGpgXbue+XAJgeomqd4VIglpSuCVolysiimxBojojHFyv+CYy+X
         sB0DzmRt7iW2yV8zNuZeRKKIQqOQIENl+fVoG05hE9ekEs0dK8gCWJy1/M9Hcm9smMAb
         gLCrqDN6fsNQ2ayi9fTh34sA+Iojs7KLkU7ibCWsfNv/RkeAiUHU+BHQsYNManpgrG3A
         ntT4gvLyB7/qy85uaLqyzMMLDeYKLA/SbQlLWZR79HSuJhhh2ewJ9UYIDwG63G4XcQp/
         Bf61qft6AY6w+FqT/ZV9meNfIfNnWwrgb42VgSG6h9WSJFm9bKvA5xldlZq65u9ojx6S
         RHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=yXqs1sTOvVKLOzJoyhKKeM44UErI8IE4/wpSxqWdWDE=;
        b=DfHfWNa1bbyS96cb4VAqxEmtLrO1UXSYSCYKTmeOYkQpjdT+DjUI07C1TNVRujsEbW
         +6MG+Dq2sHj+JEXpZZ1JiBXybqDtEYSyafjyElptffl6SE6ahHeItLhU428XIo+y0NJh
         puEm26U7F81aafF1x3w0NipyWxX6YFMxcnCPjBMA1ogu9S6WytQDtjAMABztmEjItxRp
         U7wSQM/UYiWI1SoiCRWgVF2goa6Vl4ScL1WopRmnwXZp2BRo+1csxlJwrB9H+TSzYvAj
         HZ7KD2X8rTIKeG7iEUr+IXwlTn4yzDc9BeRYznnkKAezhAeurfhT+R+DjMfTIAGcwdlD
         BFmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Jsad0rsq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nMuZSWZA;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Jsad0rsq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nMuZSWZA;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 858F3602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
 <CAK8P3a0wRwRDw86Ex7Ynn+nnnHJ6oEZFfrtrqGtOhJNpTfrTNQ@mail.gmail.com>
From: Sujeev Dias <sdias@codeaurora.org>
Message-ID: <8e4f6387-df06-8219-b58f-4848cfc45917@codeaurora.org>
Date: Sat, 28 Apr 2018 09:08:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0wRwRDw86Ex7Ynn+nnnHJ6oEZFfrtrqGtOhJNpTfrTNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864306474861315?=
X-GMAIL-MSGID: =?utf-8?q?1599006814228111871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/27/2018 05:18 AM, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 4:23 AM, Sujeev Dias <sdias@codeaurora.org> wrote:
>
>> diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
>> new file mode 100644
>> index 0000000..ea1b620
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/mhi.txt
>> @@ -0,0 +1,141 @@
>> +MHI Host Interface
>> +
>> +MHI used by the host to control and communicate with modem over
>> +high speed peripheral bus.
>> +
>> +==============
>> +Node Structure
>> +==============
>> +
>> +Main node properties:
>> +
>> +- mhi,max-channels
>> +  Usage: required
>> +  Value type: <u32>
>> +  Definition: Maximum number of channels supported by this controller
>> +
>> +- mhi,chan-cfg
>> +  Usage: required
>> +  Value type: Array of <u32>
>> +  Definition: Array of tuples describe channel configuration.
>> +       1st element: Physical channel number
>> +       2nd element: Transfer ring length in elements
>> +       3rd element: Event ring associated with this channel
>> +       4th element: Channel direction as defined by enum dma_data_direction
>> +               1 = UL data transfer
>> +               2 = DL data transfer
>> +       5th element: Channel doorbell mode configuration as defined by
>> +       enum MHI_BRSTMODE
>> +               2 = burst mode disabled
>> +               3 = burst mode enabled
>> +       6th element: mhi doorbell configuration, valid only when burst mode
>> +       enabled.
>> +               0 = Use default (device specific) polling configuration
>> +               For UL channels, value specifies the timer to poll MHI context
>> +               in milliseconds.
>> +               For DL channels, the threshold to poll the MHI context
>> +               in multiple of eight ring element.
>> +       7th element: Channel execution enviornment as defined by enum MHI_EE
>> +               1 = Bootloader stage
>> +               2 = AMSS mode
>> +       8th element: data transfer type accepted as defined by enum
>> +       MHI_XFER_TYPE
>> +               0 = accept cpu address for buffer
>> +               1 = accept skb
>> +               2 = accept scatterlist
>> +               3 = offload channel, does not accept any transfer type
>> +       9th element: Bitwise configuration settings for the channel
>> +               Bit mask:
>> +               BIT(0) : LPM notify, this channel master requre lpm enter/exit
>> +               notifications.
>> +               BIT(1) : Offload channel, MHI host only involved in setting up
>> +               the data pipe. Not involved in active data transfer.
>> +               BIT(2) : Must switch to doorbell mode whenever MHI M0 state
>> +               transition happens.
>> +               BIT(3) : MHI bus driver pre-allocate buffer for this channel.
>> +               If set, clients not allowed to queue buffers. Valid only for DL
>> +               direction.
>> +
>> +- mhi,chan-names
>> +  Usage: required
>> +  Value type: Array of <string>
>> +  Definition: Channel names configured in mhi,chan-cfg.
> I think the top-level structure would be better done by requiring
> a child for each channel and moving the mhi,chan-cfg
> into the children nodes, either as separate properties, or
> some of the fields combined into a 'reg' property.
>
>> +- mhi,fw-name
>> +  Usage: optional
>> +  Value type: <string>
>> +  Definition: Firmware image name to upload
> The device tree should have no knowledge of a firmware file name.
>
> What you should do instead is to have the driver generate the file
> name from the "compatible" property. You could use a lookup table
> in the driver, or have some algorithmic way of doing that, but you
> want the driver to have some form of intelligence to let it pick
> a different firmware image, e.g. when you have added new
> capabilities to the driver and the firmware but want to use an
> existing device tree.
>
>> +Data structures
>> +---------------
>> +Host memory : Directly accessed by the host to manage the MHI data structures
>> +and buffers. The device accesses the host memory over the PCIe interface.
>> +
>> +Channel context array : All channel configurations are organized in channel
>> +context data array.
>> +
>> +struct __packed mhi_chan_ctxt;
>> +struct mhi_ctxt.chan_ctxt;
>> +
>> +Transfer rings : Used by host to schedule work items for a channel and organized
>> +as a circular queue of transfer descriptors (TD).
>> +
>> +struct __packed mhi_tre;
>> +struct mhi_chan.tre_ring;
>> +
> This looks like you reinvented virtio. What are the reasons for not just
> using virtio directly as we do for other modem interfaces?
>
>> +static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
>> +                          void *buf,
>> +                          size_t size)
>> +{
>> +       u32 tx_status, val;
>> +       int i, ret;
>> +       void __iomem *base = mhi_cntrl->bhi;
>> +       rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
>> +       dma_addr_t phys = dma_map_single(mhi_cntrl->dev, buf, size,
>> +                                        DMA_TO_DEVICE);
> Please don't name a dma address 'phys', it's very confusing ;-)
>
>> +struct mhi_bus mhi_bus;
> One global instance? I suspec this duplicates data that is already
> in the bus_type structure, so just use that instead.
>
>> +void mhi_init_debugfs(struct mhi_controller *mhi_cntrl)
>> +{
>> +       struct dentry *dentry;
>> +       char node[32];
>> +
>> +       if (!mhi_cntrl->parent)
>> +               return;
>> +
>> +       snprintf(node, sizeof(node), "%04x_%02u:%02u.%02u",
>> +                mhi_cntrl->dev_id, mhi_cntrl->domain, mhi_cntrl->bus,
>> +                mhi_cntrl->slot);
>> +
>> +       dentry = debugfs_create_dir(node, mhi_cntrl->parent);
>> +       if (IS_ERR_OR_NULL(dentry))
>> +               return;
> Using IS_ERR_OR_NULL() just means that you have misunderstood
> the interface, you want IS_ERR() here.
>
>> +#if defined(CONFIG_OF)
>> +static int of_parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>> +                          struct device_node *of_node)
> Why the #ifdef? Do you ever build this on architectures that don't support
> CONFIG_OF yet? Which ones?
>
>> +struct __packed mhi_event_ctxt {
>> +       u32 reserved : 8;
>> +       u32 intmodc : 8;
>> +       u32 intmodt : 16;
>> +       u32 ertype;
>> +       u32 msivec;
>> +       u64 rbase;
>> +       u64 rlen;
>> +       u64 rp;
>> +       u64 wp;
>> +};
> I would generally only mark those members as __packed that
> don't already have natural alignment, such as
>
> struct mhi_event_ctxt {
>         u32 reserved : 8;
>         u32 intmodc : 8;
>         u32 intmodt : 16;
>         u32 ertype;
>         u32 msivec;
>         u64 rbase __packed __aligned(4);
>         u64 rlen__packed __aligned(4);
>         u64 rp __packed __aligned(4);
>         u64 wp__packed __aligned(4);
> };
>
> This clarifies where the hardware designers screwed up
> without forcing bytewise access to the structures.
>
>> +
>> +#ifdef CONFIG_MHI_DEBUG
>> +
>> +#define MHI_ASSERT(cond, msg) do { \
>> +       if (cond) \
>> +               panic(msg); \
>> +} while (0)
>> +
>> +#else
>> +
>> +#define MHI_ASSERT(cond, msg) do { \
>> +       if (cond) { \
>> +               MHI_ERR(msg); \
>> +               WARN_ON(cond); \
>> +       } \
>> +} while (0)
> Remove these.
>
>> +struct mhi_controller {
>> +       struct list_head node;
>> +
>> +       /* device node for iommu ops */
>> +       struct device *dev;
>> +       struct device_node *of_node;
> Hmm, shouldn't the mhi_controller itself be a device that
> is a child of ->dev? It feels like
Originally I did thought about it but I did not see any value of doing 
that.  Not only that, I would need
the parent device for all memory allocation and mapping since children 
device doesn't inherit parent
iommu settings.
>> +       /* mmio base */
>> +       void __iomem *regs;
>> +       void __iomem *bhi;
>> +       void __iomem *wake_db;
>> +
>> +       /* device topology */
>> +       u32 dev_id;
>> +       u32 domain;
>> +       u32 bus;
>> +       u32 slot;
> These are even stranger. This looks PCI specific, but if you have
> a pci_dev then you know all of them while for the case you don't have
> a pci_dev, they don't make sense.
 From MHI bus point of view, this is a memory mapped device.  Not 
technically tied to a
pci device. I would like to keep that abstraction.
>> +       /* kernel log level */
>> +       enum MHI_DEBUG_LEVEL klog_lvl;
>> +
>> +       /* private log level controller driver to set */
>> +       enum MHI_DEBUG_LEVEL log_lvl;
>> +
>> +       /* controller specific data */
>> +       void *priv_data;
>> +       void *log_buf;
>> +       struct dentry *dentry;
>> +       struct dentry *parent;
> All the debugfs stuff is a bit worrying.  It seems so pervasive in
> the driver that it's hard to tell if any of it is actually used for more
> than just debugging. It might be better to split that out of the
> series and add back the debug files one at a time in separate
> patches that each explain why the files are still required.
> If you have successfully debugged a problem with one
> file, it may have seemed useful but maybe it's not needed
> for any future bugs.
>
> You might also be able to get more value out of tracepoints
> than debugfs files.
>
>> +};
>> +
>> +/**
>> + * struct mhi_device - mhi device structure associated bind to channel
>> + * @dev: Device associated with the channels
>> + * @mtu: Maximum # of bytes controller support
>> + * @ul_chan_id: MHI channel id for UL transfer
>> + * @dl_chan_id: MHI channel id for DL transfer
>> + * @priv: Driver private data
>> + */
>> +struct mhi_device {
>> +       struct device dev;
>> +       u32 dev_id;
>> +       u32 domain;
>> +       u32 bus;
>> +       u32 slot;
> Again, shouldn't the pci stuff be part of the parent or grandparent
> device?
This is for clients, they are absolutely not pcie aware at all. To them 
this is just
a unique way to identify the physical device.
>> +
>> +#if defined(CONFIG_MHI_BUS)
> In what situation would you include this header without enabling
> CONFIG_MHI_BUS?
>   
>> +
>> +#ifdef CONFIG_MHI_DEBUG
>> +
>> +#define MHI_VERB(fmt, ...) do { \
>> +               if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_VERBOSE) \
>> +                       pr_debug("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
>> +} while (0)
>> +
>> +#else
>> +
>> +#define MHI_VERB(fmt, ...)
>> +
>> +#endif
>> +
>> +#define MHI_LOG(fmt, ...) do { \
>> +               if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_INFO) \
>> +                       pr_info("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
>> +} while (0)
>> +
>> +#define MHI_ERR(fmt, ...) do { \
>> +               if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_ERROR) \
>> +                       pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
>> +#define MHI_CRITICAL(fmt, ...) do { \
>> +               if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_CRITICAL) \
>> +                       pr_alert("[C][%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
> Again, these all should be removed. Just use dev_err() etc.
>
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index 7d361be..1e11e30 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -734,4 +734,15 @@ struct tb_service_id {
>>   #define TBSVC_MATCH_PROTOCOL_VERSION   0x0004
>>   #define TBSVC_MATCH_PROTOCOL_REVISION  0x0008
>>
>> +
>> +/**
>> + * struct mhi_device_id - MHI device identification
>> + * @chan: MHI channel name
>> + * @driver_data: driver data;
>> + */
>> +struct mhi_device_id {
>> +       const char *chan;
>> +       kernel_ulong_t driver_data;
>> +};
> I think you have to use a fixed-length string here, otherwise
> module autoloading cannot work.
>
>        Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Thank you
Sujeev

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
