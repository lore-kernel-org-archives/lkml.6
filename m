Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELuMuGWL1CjpMI3eSpo35Mg6lTcLxGu3Q2EzYlXM6hRwUQn6BxTm4IoFQda6Rqon/z1s8KDP
ARC-Seal: i=1; a=rsa-sha256; t=1520260238; cv=none;
        d=google.com; s=arc-20160816;
        b=crNxDbVtMTf2/AFFwc8i357uuLr7LIZh6ZaxHf4Y7jbXzZvtEjmEFuKKskU2w6opuV
         u950yiZG4df6tMS/PDG6VH64W1aXfZzv9T8LHl7w6YxKIruOBUmtwZiI0BjckTI+bG8W
         ThAxZXdkERhooqkwvbDsATzpORO1ZfOtVBxFLBIcrnBgKIj0k1ou6MQjo+IxP6E+IvE7
         O7yLycMegaLOGooRIN/E3Izf7kW/OLnpq3ePcto+eKU8g30iqUG8Rwh09OQJHfiE3TcJ
         t1/zkA6AkHxFbDV1fjsfyxxwadWg/KHDi8UJWBuqASXnJzHCnayc9bMo8gi+Vp2YwRXG
         Eupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=NIqDXiDjZGwT3m+ZTbn5emmhGi7H9dg9WAEc9Y/42sQ=;
        b=SeJzGV/lXId4sO6TLqpkJFu5geKz+ibFKZS549JrBhaJKkIb6Nii59Ez4cxuAXHyem
         bRZKqRXrQkNbD/PYlnpwisXAymacRl8TkNDlknjk16L8pQvlMhj09jQL1mRKpieAfQ1J
         MNooXtrHuPKxp0TsQrGR1bDJRzG8nd5/FY+0xZfXyrga5OfyT9/dNrUiMP+lu6b4HTEd
         kkkOqGnudiQ84VQnHl0hNhzrExL5UFtk8YB/9DqkEDApHhv58f1Rz/KlOXPP5ErlgJgW
         I3oTKJDa/U5X5iXsCnMelRzsYjZeb4qiykJefBJnbC2pp0lUirmFBfd3zqQyAYtN6Ffj
         c/Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 ALKML <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
 Alexey Klimov <klimov.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
 <20180305145253.00004247@huawei.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <9d6e431e-fa07-63b6-81fc-6b00c7e8267e@arm.com>
Date: Mon, 5 Mar 2018 14:30:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305145253.00004247@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209576065765675?=
X-GMAIL-MSGID: =?utf-8?q?1594108400555741655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/18 13:52, Jonathan Cameron wrote:
> On Fri, 23 Feb 2018 16:23:33 +0000
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> The SCMI is intended to allow OSPM to manage various functions that are
>> provided by the hardware platform it is running on, including power and
>> performance functions. SCMI provides two levels of abstraction, protocols
>> and transports. Protocols define individual groups of system control and
>> management messages. A protocol specification describes the messages
>> that it supports. Transports describe the method by which protocol
>> messages are communicated between agents and the platform.
>>
>> This patch adds basic infrastructure to manage the message allocation,
>> initialisation, packing/unpacking and shared memory management.
>>
> Hi Sudeep,
> 
> A bit of a drive by review as I was curious and happen to have been looking
> at the spec.  Anyhow my main comments in here are about consistency of naming.
> In many ways it doesn't matter what naming convention you go with, but it is
> good to make sure you then use it consistently.
> 

Thanks for having a look at this. I just sent a pull request last
Friday. I will address all the issues here, but if it's not a fix, it
may need to wait a bit longer, I can try sending second PR but chances
of getting it in are more if there are fixes.

>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> <snip>
>> +
>> +#include <linux/completion.h>
>> +#include <linux/scmi_protocol.h>
>> +#include <linux/types.h>
>> +
>> +/**
>> + * struct scmi_msg_hdr - Message(Tx/Rx) header
>> + *
>> + * @id: The identifier of the command being sent
>> + * @protocol_id: The identifier of the protocol used to send @id command
>> + * @seq: The token to identify the message. when a message/command returns,
>> + *       the platform returns the whole message header unmodified including
>> + *	 the token.
> Something looks odd with indenting here...
> 

Will check.

>> + */
>> +struct scmi_msg_hdr {
>> +	u8 id;
> I think this is called message_id in the spec, would it be worth
> matching that here?
> 

I dropped message as the structure is named scmi_msg_hdr, I can change
if it needs to align with specification to that extent :)

>> +	u8 protocol_id;
>> +	u16 seq;
>> +	u32 status;
>> +	bool poll_completion;
>> +};
> status and poll completion could do with documenting.
> 

Sure

>> +
>> +/**
>> + * struct scmi_msg - Message(Tx/Rx) structure
>> + *
>> + * @buf: Buffer pointer
>> + * @len: Length of data in the Buffer
>> + */
>> +struct scmi_msg {
>> +	void *buf;
>> +	size_t len;
>> +};
>> +
>> +/**
>> + * struct scmi_xfer - Structure representing a message flow
>> + *
>> + * @hdr: Transmit message header
>> + * @tx: Transmit message
>> + * @rx: Receive message, the buffer should be pre-allocated to store
>> + *	message. If request-ACK protocol is used, we can reuse the same
>> + *	buffer for the rx path as we use for the tx path.
>> + * @done: completion event
>> + */
>> +
> No blank line here.

Will remove

>> +struct scmi_xfer {
>> +	void *con_priv;
>> +	struct scmi_msg_hdr hdr;
>> +	struct scmi_msg tx;
>> +	struct scmi_msg rx;
>> +	struct completion done;
>> +};
>> +
>> +void scmi_one_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
>> +int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
>> +int scmi_one_xfer_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
>> +		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
>> +int scmi_handle_put(const struct scmi_handle *handle);
>> +struct scmi_handle *scmi_handle_get(struct device *dev);
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> new file mode 100644
>> index 000000000000..fa0e9cf31f4c
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -0,0 +1,689 @@
>> +/*
>> + * System Control and Management Interface (SCMI) Message Protocol driver
>> + *
>> + * SCMI Message Protocol is used between the System Control Processor(SCP)
>> + * and the Application Processors(AP). The Message Handling Unit(MHU)
>> + * provides a mechanism for inter-processor communication between SCP's
>> + * Cortex M3 and AP.
>> + *
>> + * SCP offers control and management of the core/cluster power states,
>> + * various power domain DVFS including the core/cluster, certain system
>> + * clocks configuration, thermal sensors and many others.
>> + *
>> + * Copyright (C) 2017 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/bitmap.h>
>> +#include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/semaphore.h>
>> +#include <linux/slab.h>
>> +
>> +#include "common.h"
>> +
>> +#define MSG_ID_SHIFT		0
>> +#define MSG_ID_MASK		0xff
>> +#define MSG_TYPE_SHIFT		8
>> +#define MSG_TYPE_MASK		0x3
> 
> Interesting to note you don't specify type in your header structure
> above but do have it here.  I guess that is because it is always 0
> when you care about.  Might be nice to be consistent though?
> 

Since it was not used elsewhere, I didn't move it to header, I can if
needed.

>> +#define MSG_PROTOCOL_ID_SHIFT	10
>> +#define MSG_PROTOCOL_ID_MASK	0xff
>> +#define MSG_TOKEN_ID_SHIFT	18
>> +#define MSG_TOKEN_ID_MASK	0x3ff
>> +#define MSG_XTRACT_TOKEN(header)	\
>> +	(((header) >> MSG_TOKEN_ID_SHIFT) & MSG_TOKEN_ID_MASK)
>> +
>> +enum scmi_error_codes {
>> +	SCMI_SUCCESS = 0,	/* Success */
>> +	SCMI_ERR_SUPPORT = -1,	/* Not supported */
>> +	SCMI_ERR_PARAMS = -2,	/* Invalid Parameters */
>> +	SCMI_ERR_ACCESS = -3,	/* Invalid access/permission denied */
>> +	SCMI_ERR_ENTRY = -4,	/* Not found */
>> +	SCMI_ERR_RANGE = -5,	/* Value out of range */
>> +	SCMI_ERR_BUSY = -6,	/* Device busy */
>> +	SCMI_ERR_COMMS = -7,	/* Communication Error */
>> +	SCMI_ERR_GENERIC = -8,	/* Generic Error */
>> +	SCMI_ERR_HARDWARE = -9,	/* Hardware Error */
>> +	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
>> +	SCMI_ERR_MAX
>> +};
>> +
>> +/* List of all  SCMI devices active in system */
>> +static LIST_HEAD(scmi_list);
>> +/* Protection for the entire list */
>> +static DEFINE_MUTEX(scmi_list_mutex);
>> +
>> +/**
>> + * struct scmi_xfers_info - Structure to manage transfer information
>> + *
>> + * @xfer_block: Preallocated Message array
>> + * @xfer_alloc_table: Bitmap table for allocated messages.
>> + *	Index of this bitmap table is also used for message
>> + *	sequence identifier.
>> + * @xfer_lock: Protection for message allocation
>> + */
>> +struct scmi_xfers_info {
>> +	struct scmi_xfer *xfer_block;
>> +	unsigned long *xfer_alloc_table;
>> +	/* protect transfer allocation */
> This is here as warning suppression as it's clearly documented
> above.  Personally I've always just marked those downs as false
> positives rather than having the ugliness of documenting it twice.
>  

Indeed, I added documentation later and failed to see this and delete.

>> +	spinlock_t xfer_lock;
>> +};
>> +
>> +/**
>> + * struct scmi_desc - Description of SoC integration
>> + *
>> + * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
>> + * @max_msg: Maximum number of messages that can be pending
>> + *	simultaneously in the system
>> + * @max_msg_size: Maximum size of data per message that can be handled.
>> + */
>> +struct scmi_desc {
>> +	int max_rx_timeout_ms;
>> +	int max_msg;
>> +	int max_msg_size;
>> +};
>> +
>> +/**
>> + * struct scmi_info - Structure representing a  SCMI instance
>> + *
>> + * @dev: Device pointer
>> + * @desc: SoC description for this instance
>> + * @handle: Instance of SCMI handle to send to clients
>> + * @cl: Mailbox Client
>> + * @tx_chan: Transmit mailbox channel
>> + * @tx_payload: Transmit mailbox channel payload area
>> + * @minfo: Message info
>> + * @node: list head
> Nitpick of the day :) Inconsistent capitalization.  Also
> useful to know which list this is for...

Thanks again

>> + * @users: Number of users of this instance
>> + */
>> +struct scmi_info {
>> +	struct device *dev;
>> +	const struct scmi_desc *desc;
>> +	struct scmi_handle handle;
>> +	struct mbox_client cl;
>> +	struct mbox_chan *tx_chan;
>> +	void __iomem *tx_payload;
>> +	struct scmi_xfers_info minfo;
>> +	struct list_head node;
>> +	int users;
>> +};
>> +
>> +#define client_to_scmi_info(c)	container_of(c, struct scmi_info, cl)
>> +#define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
>> +
>> +/*
>> + * SCMI specification requires all parameters, message headers, return
>> + * arguments or any protocol data to be expressed in little endian
>> + * format only.
>> + */
>> +struct scmi_shared_mem {
>> +	__le32 reserved;
>> +	__le32 channel_status;
>> +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR	BIT(1)
>> +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE	BIT(0)
>> +	__le32 reserved1[2];
>> +	__le32 flags;
>> +#define SCMI_SHMEM_FLAG_INTR_ENABLED	BIT(0)
>> +	__le32 length;
>> +	__le32 msg_header;
>> +	u8 msg_payload[0];
>> +};
>> +
>> +static const int scmi_linux_errmap[] = {
>> +	/* better than switch case as long as return value is continuous */
>> +	0,			/* SCMI_SUCCESS */
>> +	-EOPNOTSUPP,		/* SCMI_ERR_SUPPORT */
>> +	-EINVAL,		/* SCMI_ERR_PARAM */
>> +	-EACCES,		/* SCMI_ERR_ACCESS */
>> +	-ENOENT,		/* SCMI_ERR_ENTRY */
>> +	-ERANGE,		/* SCMI_ERR_RANGE */
>> +	-EBUSY,			/* SCMI_ERR_BUSY */
>> +	-ECOMM,			/* SCMI_ERR_COMMS */
>> +	-EIO,			/* SCMI_ERR_GENERIC */
>> +	-EREMOTEIO,		/* SCMI_ERR_HARDWARE */
>> +	-EPROTO,		/* SCMI_ERR_PROTOCOL */
>> +};
>> +
>> +static inline int scmi_to_linux_errno(int errno)
>> +{
>> +	if (errno < SCMI_SUCCESS && errno > SCMI_ERR_MAX)
>> +		return scmi_linux_errmap[-errno];
>> +	return -EIO;
>> +}
>> +
>> +/**
>> + * scmi_dump_header_dbg() - Helper to dump a message header.
>> + *
>> + * @dev: Device pointer corresponding to the SCMI entity
>> + * @hdr: pointer to header.
>> + */
>> +static inline void scmi_dump_header_dbg(struct device *dev,
>> +					struct scmi_msg_hdr *hdr)
>> +{
>> +	dev_dbg(dev, "Command ID: %x Sequence ID: %x Protocol: %x\n",
>> +		hdr->id, hdr->seq, hdr->protocol_id);
>> +}
>> +
>> +static void scmi_fetch_response(struct scmi_xfer *xfer,
>> +				struct scmi_shared_mem __iomem *mem)
>> +{
>> +	xfer->hdr.status = ioread32(mem->msg_payload);
>> +	/* Skip the length of header and statues in payload area i.e 8 bytes*/
>> +	xfer->rx.len = min_t(size_t, xfer->rx.len, ioread32(&mem->length) - 8);
>> +
>> +	/* Take a copy to the rx buffer.. */
>> +	memcpy_fromio(xfer->rx.buf, mem->msg_payload + 4, xfer->rx.len);
>> +}
>> +
>> +/**
>> + * scmi_rx_callback() - mailbox client callback for receive messages
>> + *
>> + * @cl: client pointer
>> + * @m: mailbox message
>> + *
>> + * Processes one received message to appropriate transfer information and
>> + * signals completion of the transfer.
>> + *
>> + * NOTE: This function will be invoked in IRQ context, hence should be
>> + * as optimal as possible.
>> + */
>> +static void scmi_rx_callback(struct mbox_client *cl, void *m)
>> +{
>> +	u16 xfer_id;
>> +	struct scmi_xfer *xfer;
>> +	struct scmi_info *info = client_to_scmi_info(cl);
>> +	struct scmi_xfers_info *minfo = &info->minfo;
>> +	struct device *dev = info->dev;
>> +	struct scmi_shared_mem __iomem *mem = info->tx_payload;
>> +
>> +	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
>> +
>> +	/*
>> +	 * Are we even expecting this?
>> +	 */
> Single line comment syntax probably better here.  Also the error text
> makes it obvious anyway so not sure this comment adds much...
> 

Leftovers, I might have deleted something else here :(

>> +	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
>> +		dev_err(dev, "message for %d is not expected!\n", xfer_id);
>> +		return;
>> +	}
>> +
>> +	xfer = &minfo->xfer_block[xfer_id];
>> +
>> +	scmi_dump_header_dbg(dev, &xfer->hdr);
>> +	/* Is the message of valid length? */
>> +	if (xfer->rx.len > info->desc->max_msg_size) {
>> +		dev_err(dev, "unable to handle %zu xfer(max %d)\n",
>> +			xfer->rx.len, info->desc->max_msg_size);
>> +		return;
>> +	}
>> +
>> +	scmi_fetch_response(xfer, mem);
>> +	complete(&xfer->done);
>> +}
>> +
>> +/**
>> + * pack_scmi_header() - packs and returns 32-bit header
>> + *
>> + * @hdr: pointer to header containing all the information on message id,
>> + *	protocol id and sequence id.
>> + */
>> +static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
>> +{
>> +	return ((hdr->id & MSG_ID_MASK) << MSG_ID_SHIFT) |
>> +	   ((hdr->seq & MSG_TOKEN_ID_MASK) << MSG_TOKEN_ID_SHIFT) |
>> +	   ((hdr->protocol_id & MSG_PROTOCOL_ID_MASK) << MSG_PROTOCOL_ID_SHIFT);
>> +}
>> +
>> +/**
>> + * scmi_tx_prepare() - mailbox client callback to prepare for the transfer
>> + *
>> + * @cl: client pointer
>> + * @m: mailbox message
>> + *
>> + * This function prepares the shared memory which contains the header and the
>> + * payload.
>> + */
>> +static void scmi_tx_prepare(struct mbox_client *cl, void *m)
>> +{
>> +	struct scmi_xfer *t = m;
>> +	struct scmi_info *info = client_to_scmi_info(cl);
>> +	struct scmi_shared_mem __iomem *mem = info->tx_payload;
>> +
>> +	/* Mark channel busy + clear error */
>> +	iowrite32(0x0, &mem->channel_status);
>> +	iowrite32(t->hdr.poll_completion ? 0 : SCMI_SHMEM_FLAG_INTR_ENABLED,
>> +		  &mem->flags);
>> +	iowrite32(sizeof(mem->msg_header) + t->tx.len, &mem->length);
>> +	iowrite32(pack_scmi_header(&t->hdr), &mem->msg_header);
>> +	if (t->tx.buf)
>> +		memcpy_toio(mem->msg_payload, t->tx.buf, t->tx.len);
>> +}
>> +
>> +/**
>> + * scmi_one_xfer_get() - Allocate one message
>> + *
>> + * @handle: SCMI entity handle
>> + *
>> + * Helper function which is used by various command functions that are
>> + * exposed to clients of this driver for allocating a message traffic event.
>> + *
>> + * This function can sleep depending on pending requests already in the system
>> + * for the SCMI entity. Further, this also holds a spinlock to maintain
>> + * integrity of internal data structures.
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +static struct scmi_xfer *scmi_one_xfer_get(const struct scmi_handle *handle)
> Maybe it's just me, but I think this would be more clearly named as
> scmi_xfer_alloc.
> 

Agreed to some extent. The reason I didn't have it as alloc as they are
preallocated and this just returns a reference to free slot in that
preallocated array.

> I'd assume we were dealing with one anyway as it's not called scmi_xfers_get
> and the get to my mind implies a reference counter rather than allocating
> an xfer for use...
> 

Ah OK, I get your concerne with _get/_put but _alloc/_free is equally
bad then in the contect of preallocated buffers.

>> +{
>> +	u16 xfer_id;
>> +	struct scmi_xfer *xfer;
>> +	unsigned long flags, bit_pos;
>> +	struct scmi_info *info = handle_to_scmi_info(handle);
>> +	struct scmi_xfers_info *minfo = &info->minfo;
>> +
>> +	/* Keep the locked section as small as possible */
>> +	spin_lock_irqsave(&minfo->xfer_lock, flags);
>> +	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
>> +				      info->desc->max_msg);
>> +	if (bit_pos == info->desc->max_msg) {
>> +		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +	set_bit(bit_pos, minfo->xfer_alloc_table);
>> +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>> +
>> +	xfer_id = bit_pos;
>> +
>> +	xfer = &minfo->xfer_block[xfer_id];
>> +	xfer->hdr.seq = xfer_id;
>> +	reinit_completion(&xfer->done);
>> +
>> +	return xfer;
>> +}
>> +
>> +/**
>> + * scmi_one_xfer_put() - Release a message
>> + *
>> + * @minfo: transfer info pointer
>> + * @xfer: message that was reserved by scmi_one_xfer_get
>> + *
>> + * This holds a spinlock to maintain integrity of internal data structures.
>> + */
>> +void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>> +{
>> +	unsigned long flags;
>> +	struct scmi_info *info = handle_to_scmi_info(handle);
>> +	struct scmi_xfers_info *minfo = &info->minfo;
>> +
>> +	/*
>> +	 * Keep the locked section as small as possible
>> +	 * NOTE: we might escape with smp_mb and no lock here..
>> +	 * but just be conservative and symmetric.
>> +	 */
>> +	spin_lock_irqsave(&minfo->xfer_lock, flags);
>> +	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
>> +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>> +}
>> +
>> +/**
>> + * scmi_do_xfer() - Do one transfer
> This kind of makes my point above about no need for _one_ in naming.
> You never put it here!
> 

Ah I can drop _one_

>> + *
>> + * @info: Pointer to SCMI entity information
>> + * @xfer: Transfer to initiate and wait for response
>> + *
>> + * Return: -ETIMEDOUT in case of no response, if transmit error,
>> + *   return corresponding error, else if all goes well,
>> + *   return 0.
>> + */
>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>> +{
>> +	int ret;
>> +	int timeout;
>> +	struct scmi_info *info = handle_to_scmi_info(handle);
>> +	struct device *dev = info->dev;
>> +
>> +	ret = mbox_send_message(info->tx_chan, xfer);
>> +	if (ret < 0) {
>> +		dev_dbg(dev, "mbox send fail %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* mbox_send_message returns non-negative value on success, so reset */
>> +	ret = 0;
>> +
>> +	/* And we wait for the response. */
>> +	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
>> +	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
>> +		dev_err(dev, "mbox timed out in resp(caller: %pS)\n",
>> +			(void *)_RET_IP_);
>> +		ret = -ETIMEDOUT;
>> +	} else if (xfer->hdr.status) {
>> +		ret = scmi_to_linux_errno(xfer->hdr.status);
>> +	}
>> +	/*
>> +	 * NOTE: we might prefer not to need the mailbox ticker to manage the
>> +	 * transfer queueing since the protocol layer queues things by itself.
>> +	 * Unfortunately, we have to kick the mailbox framework after we have
>> +	 * received our message.
>> +	 */
>> +	mbox_client_txdone(info->tx_chan, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * scmi_one_xfer_init() - Allocate and initialise one message
> Could perhaps make the alloc part of this clear in the name?
> 

Sure _alloc_init ?

>> + *
>> + * @handle: SCMI entity handle
>> + * @msg_id: Message identifier
>> + * @msg_prot_id: Protocol identifier for the message
> It's called prot_id.  Run the kernel-doc script on this an it'll probably
> point out little inconsistencies like this.
> 

OK

>> + * @tx_size: transmit message size
>> + * @rx_size: receive message size
>> + * @p: pointer to the allocated and initialised message
> This is a pointer we want to set to this, it's not a pointer to it when
> first called.
> 

Yes

>> + *
>> + * This function allocates the message using @scmi_one_xfer_get and
>> + * initialise the header.
> If we are describing it, should describe everything - also sets the
> lengths.
> 

Sure

>> + *
>> + * Return: 0 if all went fine with @p pointing to message, else
>> + *	corresponding error.
>> + */
>> +int scmi_one_xfer_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
>> +		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
>> +{
>> +	int ret;
>> +	struct scmi_xfer *xfer;
>> +	struct scmi_info *info = handle_to_scmi_info(handle);
>> +	struct device *dev = info->dev;
>> +
>> +	/* Ensure we have sane transfer sizes */
>> +	if (rx_size > info->desc->max_msg_size ||
>> +	    tx_size > info->desc->max_msg_size)
>> +		return -ERANGE;
>> +
>> +	xfer = scmi_one_xfer_get(handle);
>> +	if (IS_ERR(xfer)) {
>> +		ret = PTR_ERR(xfer);
>> +		dev_err(dev, "failed to get free message slot(%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	xfer->tx.len = tx_size;
>> +	xfer->rx.len = rx_size ? : info->desc->max_msg_size;
>> +	xfer->hdr.id = msg_id;
>> +	xfer->hdr.protocol_id = prot_id;
>> +	xfer->hdr.poll_completion = false;
>> +
>> +	*p = xfer;
> blank line here perhaps.
> 

OK

>> +	return 0;
>> +}
>> +
>> +/**
>> + * scmi_handle_get() - Get the  SCMI handle for a device
> Spacing before SCMI is odd.
> 

Yes

> BTW this is what I'd expect a _get function to be doing - it's
> retrieving the thing in question and incrementing a reference
> counter to keep it around.
> 

No individual protocol drivers are doing that.

>> + *
>> + * @dev: pointer to device for which we want SCMI handle
>> + *
>> + * NOTE: The function does not track individual clients of the framework
>> + * and is expected to be maintained by caller of  SCMI protocol library.
>> + * scmi_handle_put must be balanced with successful scmi_handle_get
>> + *
>> + * Return: pointer to handle if successful, NULL on error
>> + */
>> +struct scmi_handle *scmi_handle_get(struct device *dev)
>> +{
>> +	struct list_head *p;
>> +	struct scmi_info *info;
>> +	struct scmi_handle *handle = NULL;
>> +
>> +	mutex_lock(&scmi_list_mutex);
>> +	list_for_each(p, &scmi_list) {
>> +		info = list_entry(p, struct scmi_info, node);
>> +		if (dev->parent == info->dev) {
>> +			handle = &info->handle;
>> +			info->users++;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&scmi_list_mutex);
>> +
>> +	return handle;
>> +}
>> +
>> +/**
>> + * scmi_handle_put() - Release the handle acquired by scmi_handle_get
>> + *
>> + * @handle: handle acquired by scmi_handle_get
>> + *
>> + * NOTE: The function does not track individual clients of the framework
>> + * and is expected to be maintained by caller of  SCMI protocol library.
> Again, odd spacing before SCMI..
> 

OK

>> + * scmi_handle_put must be balanced with successful scmi_handle_get
>> + *
>> + * Return: 0 is successfully released
>> + *	if null was passed, it returns -EINVAL;
>> + */
>> +int scmi_handle_put(const struct scmi_handle *handle)
>> +{
>> +	struct scmi_info *info;
>> +
>> +	if (!handle)
>> +		return -EINVAL;
>> +
>> +	info = handle_to_scmi_info(handle);
>> +	mutex_lock(&scmi_list_mutex);
>> +	if (!WARN_ON(!info->users))
>> +		info->users--;
>> +	mutex_unlock(&scmi_list_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct scmi_desc scmi_generic_desc = {
>> +	.max_rx_timeout_ms = 30,	/* we may increase this if required */
> Inconsistent capitalization of comment. Doesn't really matter which but looks
> a bit odd here with it different on two lines next to each other.
> 

Will fix

>> +	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
>> +	.max_msg_size = 128,
>> +};
>> +
>> +/* Each compatible listed below must have descriptor associated with it */
>> +static const struct of_device_id scmi_of_match[] = {
>> +	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
>> +	{ /* Sentinel */ },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, scmi_of_match);
>> +
>> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
>> +{
>> +	int i;
>> +	struct scmi_xfer *xfer;
>> +	struct device *dev = sinfo->dev;
>> +	const struct scmi_desc *desc = sinfo->desc;
>> +	struct scmi_xfers_info *info = &sinfo->minfo;
>> +
>> +	/* Pre-allocated messages, no more than what hdr.seq can support */
>> +	if (WARN_ON(desc->max_msg >= (MSG_TOKEN_ID_MASK + 1))) {
>> +		dev_err(dev, "Maximum message of %d exceeds supported %d\n",
>> +			desc->max_msg, MSG_TOKEN_ID_MASK + 1);
>> +		return -EINVAL;
>> +	}
>> +
>> +	info->xfer_block = devm_kcalloc(dev, desc->max_msg,
>> +					sizeof(*info->xfer_block), GFP_KERNEL);
>> +	if (!info->xfer_block)
>> +		return -ENOMEM;
>> +
>> +	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(desc->max_msg),
>> +					      sizeof(long), GFP_KERNEL);
>> +	if (!info->xfer_alloc_table)
>> +		return -ENOMEM;
> Hmm. I wonder if it is worth adding a devm_bitmap_alloc?
> 

OK

>> +
>> +	bitmap_zero(info->xfer_alloc_table, desc->max_msg);
> kcalloc zeros the memory.
> 
>> +
>> +	/* Pre-initialize the buffer pointer to pre-allocated buffers */
>> +	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
>> +		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
>> +					    GFP_KERNEL);
>> +		if (!xfer->rx.buf)
>> +			return -ENOMEM;
>> +
>> +		xfer->tx.buf = xfer->rx.buf;
>> +		init_completion(&xfer->done);
>> +	}
>> +
>> +	spin_lock_init(&info->xfer_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scmi_mailbox_check(struct device_node *np)
>> +{
>> +	struct of_phandle_args arg;
>> +
>> +	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
>> +}
>> +
>> +static int scmi_mbox_free_channel(struct scmi_info *info)
> Some of the naming in here could do with being adjusted to be obviously
> 'balanced'.  The moment I see a free I expect a matched alloc but in this
> case the alloc is done in scmi_mbox_chan_setup which at very least
> should be scmi_mbox_setup_channel and should really imply that it is
> doing allocation as well.
> 

That's inline with mailbox APIs.

>> +{
>> +	if (!IS_ERR_OR_NULL(info->tx_chan)) {
>> +		mbox_free_channel(info->tx_chan);
>> +		info->tx_chan = NULL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int scmi_remove(struct platform_device *pdev)
>> +{
>> +	int ret = 0;
>> +	struct scmi_info *info = platform_get_drvdata(pdev);
>> +
>> +	mutex_lock(&scmi_list_mutex);
>> +	if (info->users)
>> +		ret = -EBUSY;
>> +	else
>> +		list_del(&info->node);
>> +	mutex_unlock(&scmi_list_mutex);
>> +
>> +	if (!ret)
> This would have a more readable flow if you just did
> if (ret)
> 	return ret;
> 
> return sci_mbox_free_channel(info)
> 

OK
-- 
-- 
Regards,
Sudeep
