Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CB0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBE120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBE120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeKGXBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:01:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33153 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeKGXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:01:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so20790459qko.0;
        Wed, 07 Nov 2018 05:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QpninoNE36zCkf5LHapN4Id39Bi8tjwIJzWbdJUR7I=;
        b=qdcxXO+JJ1TQ/vokjuZaexHtxdsBuj1Kdig6vzBwHXrwSWnqXYnqjyCsD5TvarJ/C2
         zKAdaZYVo2PVbZw5ZXSJ9d5bSj8FAsstoMw2/1/ko9lsVXsnXaMFc8073RlJeNCh/kfH
         WAPzadUZdmQD9DsYvybZzZQJBUbxQI1nCs6BJY3MVOyFmS9j6eRMIWxzfd/IUdJX5BJ1
         oBeiFPd3ATv7g6HrAV5rTSvBWi87iZ0YNgIgVdeGUIvq8h0U3UBbbpQygTk3wuJ4HQTi
         gMMF5cwUxKy/lkDpAQIpHaG97bba0fMDLyARNwwzJEjayeHCtLdl2sWwDOFkXGiOYI7t
         qsDQ==
X-Gm-Message-State: AGRZ1gICAkUYphNDkPLaHOJQQmvAA+cNc74aAoOeOQ1XF/NgFXw1X0QR
        /OiWlUviJhIDho3fRXHRvLmEPBsEHhUYWm+/nsSvTD9d
X-Google-Smtp-Source: AJdET5f+jdwqXTepqp3WXCNYiTK+rZ84wDobreKZbUTqCPgM2K41oxAfpLVRuUlvRd70drFc8feANARXm7MlEKwVvSg=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr224364qta.152.1541597469754;
 Wed, 07 Nov 2018 05:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-12-elder@linaro.org>
In-Reply-To: <20181107003250.5832-12-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 14:30:53 +0100
Message-ID: <CAK8P3a3vB6wF7KYHpk+ULYGFhEe-pyWYC6fHaaBYeSuWCNooRA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] soc: qcom: ipa: IPA rmnet interface
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:

> Note:  This portion of the driver will be heavily affected by
> planned rework on the data path code.

Ok. I don't think the ioctl interface has a real chance of getting merged
into the kernel. You should generally not require any custom user space
tools for a driver like this.

> diff --git a/drivers/net/ipa/msm_rmnet.h b/drivers/net/ipa/msm_rmnet.h
> new file mode 100644
> index 000000000000..042380fd53fb
> --- /dev/null
> +++ b/drivers/net/ipa/msm_rmnet.h

Just for the record: if we really wanted to define ioctls, this would go
into 'include/linux/uapi/msm_rmnet.h' and get installed into the
/usr/include hierarchy on all machines.

> +
> +#define RMNET_IOCTL_SET_LLP_ETHERNET 0x000089f1 /* Set Ethernet protocol  */
> +#define RMNET_IOCTL_SET_LLP_IP      0x000089f2 /* Set RAWIP protocol     */
> +#define RMNET_IOCTL_GET_LLP         0x000089f3 /* Get link protocol      */
> +#define RMNET_IOCTL_SET_QOS_ENABLE   0x000089f4 /* Set QoS header enabled */
> +#define RMNET_IOCTL_SET_QOS_DISABLE  0x000089f5 /* Set QoS header disabled*/
> +#define RMNET_IOCTL_GET_QOS         0x000089f6 /* Get QoS header state   */
> +#define RMNET_IOCTL_GET_OPMODE      0x000089f7 /* Get operation mode     */

And the commands would be defined using _IOC/_IOR/_IOW macros that
document which arguments they take


> +#define RMNET_IOCTL_OPEN            0x000089f8 /* Open transport port    */
> +#define RMNET_IOCTL_CLOSE           0x000089f9 /* Close transport port   */
> +#define RMNET_IOCTL_FLOW_ENABLE             0x000089fa /* Flow enable            */
> +#define RMNET_IOCTL_FLOW_DISABLE     0x000089fb /* Flow disable                  */
> +#define RMNET_IOCTL_FLOW_SET_HNDL    0x000089fc /* Set flow handle       */
> +#define RMNET_IOCTL_EXTENDED        0x000089fd /* Extended IOCTLs        */

'extended' interfaces are obviously out of the question entirely, those
would all need to be separate commands.


> +/* User space may not have this defined. */
> +#ifndef IFNAMSIZ
> +#define IFNAMSIZ 16
> +#endif

This is in <linux/if.h>

> +struct rmnet_ioctl_extended_s {
> +       u32     extended_ioctl;
> +       union {

And unions in the ioctl interfaces also wouldn't work.

> +static bool initialized;       /* Avoid duplicate initialization */
> +
> +static struct rmnet_ipa_context rmnet_ipa_ctx_struct;
> +static struct rmnet_ipa_context *rmnet_ipa_ctx = &rmnet_ipa_ctx_struct;

Global variables like these should be removed.

> +/** ipa_wwan_xmit() - Transmits an skb.
> + *
> + * @skb: skb to be transmitted
> + * @dev: network device
> + *
> + * Return codes:
> + * NETDEV_TX_OK: Success
> + * NETDEV_TX_BUSY: Error while transmitting the skb. Try again later
> + */
> +static int ipa_wwan_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +       struct ipa_wwan_private *wwan_ptr = netdev_priv(dev);
> +       unsigned int skb_len;
> +       int outstanding;
> +
> +       if (skb->protocol != htons(ETH_P_MAP)) {
> +               dev_kfree_skb_any(skb);
> +               dev->stats.tx_dropped++;
> +               return NETDEV_TX_OK;
> +       }
> +
> +       /* Control packets are sent even if queue is stopped.  We
> +        * always honor the data and control high-water marks.
> +        */
> +       outstanding = atomic_read(&wwan_ptr->outstanding_pkts);
> +       if (!RMNET_MAP_GET_CD_BIT(skb)) {       /* Data packet? */
> +               if (netif_queue_stopped(dev))
> +                       return NETDEV_TX_BUSY;
> +               if (outstanding >= wwan_ptr->outstanding_high)
> +                       return NETDEV_TX_BUSY;
> +       } else if (outstanding >= wwan_ptr->outstanding_high_ctl) {
> +               return NETDEV_TX_BUSY;
> +       }

This seems to be a poor reimplementation of BQL. Better
use netdev_sent_queue() and netdev_completed_queue()
to do the same thing better.

> +/** apps_ipa_packet_receive_notify() - Rx notify
> + *
> + * @priv: driver context
> + * @evt: event type
> + * @data: data provided with event
> + *
> + * IPA will pass a packet to the Linux network stack with skb->data
> + */
> +static void apps_ipa_packet_receive_notify(void *priv, enum ipa_dp_evt_type evt,
> +                                          unsigned long data)
> +{
> +       struct ipa_wwan_private *wwan_ptr;
> +       struct net_device *dev = priv;
> +
> +       wwan_ptr = netdev_priv(dev);
> +       if (evt == IPA_RECEIVE) {
> +               struct sk_buff *skb = (struct sk_buff *)data;
> +               int ret;
> +               unsigned int packet_len = skb->len;
> +
> +               skb->dev = rmnet_ipa_ctx->dev;
> +               skb->protocol = htons(ETH_P_MAP);
> +
> +               ret = netif_receive_skb(skb);
> +               if (ret) {
> +                       pr_err_ratelimited("fail on netif_receive_skb\n");
> +                       dev->stats.rx_dropped++;
> +               }
> +               dev->stats.rx_packets++;
> +               dev->stats.rx_bytes += packet_len;
> +       } else if (evt == IPA_CLIENT_START_POLL) {
> +               napi_schedule(&wwan_ptr->napi);
> +       } else if (evt == IPA_CLIENT_COMP_NAPI) {
> +               napi_complete(&wwan_ptr->napi);
> +       } else {
> +               ipa_err("Invalid evt %d received in wan_ipa_receive\n", evt);
> +       }
> +}

I don't understand the logic here. Why is this a callback function?
You normally want the data path to be as fast as possible, and the
indirection seems like it would get in the way of that.

Since the function doesn't do much interesting work, could
it be moved into the caller?

> +/** handle_ingress_format() - Ingress data format configuration */
> +static int handle_ingress_format(struct net_device *dev,
> +                                struct rmnet_ioctl_extended_s *in)
> +{

Can you describe how this would be called from user space?
I.e. what is the reason we have to configure anything here?


> +
> +       /* Unsupported requests */
> +       case RMNET_IOCTL_SET_MRU:                       /* Set MRU */
> +       case RMNET_IOCTL_GET_MRU:                       /* Get MRU */
> +       case RMNET_IOCTL_GET_AGGREGATION_COUNT:         /* Get agg count */
> +       case RMNET_IOCTL_SET_AGGREGATION_COUNT:         /* Set agg count */
> +       case RMNET_IOCTL_GET_AGGREGATION_SIZE:          /* Get agg size */
> +       case RMNET_IOCTL_SET_AGGREGATION_SIZE:          /* Set agg size */
> +       case RMNET_IOCTL_FLOW_CONTROL:                  /* Do flow control */
> +       case RMNET_IOCTL_GET_DFLT_CONTROL_CHANNEL:      /* For legacy use */
> +       case RMNET_IOCTL_GET_HWSW_MAP:                  /* Get HW/SW map */
> +       case RMNET_IOCTL_SET_RX_HEADROOM:               /* Set RX Headroom */
> +       case RMNET_IOCTL_SET_QOS_VERSION:               /* Set 8/6 byte QoS */
> +       case RMNET_IOCTL_GET_QOS_VERSION:               /* Get 8/6 byte QoS */
> +       case RMNET_IOCTL_GET_SUPPORTED_QOS_MODES:       /* Get QoS modes */
> +       case RMNET_IOCTL_SET_SLEEP_STATE:               /* Set sleep state */
> +       case RMNET_IOCTL_SET_XLAT_DEV_INFO:             /* xlat dev name */
> +       case RMNET_IOCTL_DEREGISTER_DEV:                /* Deregister netdev */
> +               return -ENOTSUPP;       /* Defined, but unsupported command */
> +
> +       default:
> +               return -EINVAL;         /* Invalid (unrecognized) command */
> +       }
> +
> +copy_out:
> +       return copy_to_user(data, &edata, size) ? -EFAULT : 0;
> +}
> +
> +/** ipa_wwan_ioctl() - I/O control for wwan network driver */
> +static int ipa_wwan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> +{
> +       struct rmnet_ioctl_data_s ioctl_data = { };
> +       void __user *data;
> +       size_t size;
> +
> +       data = ifr->ifr_ifru.ifru_data;
> +       size = sizeof(ioctl_data);
> +
> +       switch (cmd) {
> +       /* These features are implied; alternatives are not supported */
> +       case RMNET_IOCTL_SET_LLP_IP:            /* RAW IP protocol */
> +       case RMNET_IOCTL_SET_QOS_DISABLE:       /* QoS header disabled */
> +               return 0;
> +
> +       /* These features are not supported; use alternatives */
> +       case RMNET_IOCTL_SET_LLP_ETHERNET:      /* Ethernet protocol */
> +       case RMNET_IOCTL_SET_QOS_ENABLE:        /* QoS header enabled */
> +       case RMNET_IOCTL_GET_OPMODE:            /* Get operation mode */
> +       case RMNET_IOCTL_FLOW_ENABLE:           /* Flow enable */
> +       case RMNET_IOCTL_FLOW_DISABLE:          /* Flow disable */
> +       case RMNET_IOCTL_FLOW_SET_HNDL:         /* Set flow handle */
> +               return -ENOTSUPP;
> +
> +       case RMNET_IOCTL_GET_LLP:               /* Get link protocol */
> +               ioctl_data.u.operation_mode = RMNET_MODE_LLP_IP;
> +               goto copy_out;
> +
> +       case RMNET_IOCTL_GET_QOS:               /* Get QoS header state */
> +               ioctl_data.u.operation_mode = RMNET_MODE_NONE;
> +               goto copy_out;
> +
> +       case RMNET_IOCTL_OPEN:                  /* Open transport port */
> +       case RMNET_IOCTL_CLOSE:                 /* Close transport port */
> +               return 0;
> +
> +       case RMNET_IOCTL_EXTENDED:              /* Extended IOCTLs */
> +               return ipa_wwan_ioctl_extended(dev, data);
> +
> +       default:
> +               return -EINVAL;
> +       }

It would help to remove everything that is a nop or not implemented
or that returns a constant value here, those are clearly not
relevant for the submission here.

> +
> +static const struct of_device_id rmnet_ipa_dt_match[] = {
> +       {.compatible = "qcom,rmnet-ipa"},
> +       {},
> +};

The match string looks overly generic, surely there must be plans
to have future versions of this that might require identification.

     Arnd
