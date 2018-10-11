Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE644C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E24020835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="EQOmwqtn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCa6MtUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E24020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJKL6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:58:19 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35773 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbeJKL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:58:19 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 07:58:17 EDT
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 51A2A8A2;
        Thu, 11 Oct 2018 00:25:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Oct 2018 00:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=h9SUux+cT+tZkMI0MVd5CIpOK2
        clWEkLehVIZsh3thE=; b=EQOmwqtn3HRS/mFR6Zb4gGSOI57q0gHZ6cht+3CgcW
        WSDK68Ed3ZsAH6+iLU2jXBNvRo+XeNDh2IUkyXLNUfOcnpGn0Tp9upFPfyLF3An6
        mk2703AuhpUSVR4XkX9oDRG5A0oEwIcCP+xSmd1c3OV2F2EdylRLMKP9e+zHdL0d
        9agfKZroiArV3b8S73mXFPF4QenV/l/EtczyJZLJ6n5mEdNsTprFtXHskTW1foEV
        9dKcUEXrIZWYfGfvOhIDh6mvBsjS4SXdr7eY3tWttJUns2jdGpo3u4k0MjvdG7eX
        3bohhhSj7YonXiJJaxjMgZhNFeUrE6BWvX+l0IVsh3KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=h9SUux+cT+tZkMI0MVd5CIpOK2clWEkLehVIZsh3t
        hE=; b=GCa6MtUvSsi5FH+y1N4HMxcjH7PbkKW/b7SEqnQ8m/sn4W8vbeTgm6fo7
        VPOY8AtIqtkerOMVDGxLAvFnucWIYyU56WITCpDup9qNqzSOk1C97ctgSghZifdF
        qeKTieU9sEYxfv2fXBwT0b0+apOoSKKbBoB6wp5Bjs+2XZIUz46QC47SOaq11oPl
        0yws/y0WTWVaFQ3lmJLdHkQpa92FLhFYvZf78jWOE88kyRUgV2uUXezReNR/hboj
        NrsbnYLxK1P70XzkSz1f40ASXvziPCfSvt9+k28Mdw2I7UtrjLk4pnqiKN+Sm4c5
        QNTjTgWI9vLGsFHNEPBaSVFCo1tsA==
X-ME-Sender: <xms:uNC-W_KNqWNCH5mgwXFlUX-IqzjtC1ExN3Bknll66MCrsNVbqVmRsQ>
X-ME-Proxy: <xmx:uNC-W8JefETX6lhWKVYfAHU677V2SCe9E0t3wz3s_UcG_zsEe7zfow>
    <xmx:uNC-W8SE9uoQ7H1K038jyoCAcmTXC8pm2l3gF7LrU0Rfs4PEFJRpDA>
    <xmx:uNC-W6j9xN3kkjwKvU6aQIHh4mBO3uYKMI_eBYJ4SANZAliNvGhElA>
    <xmx:uNC-W9ovmoM-m1QhYFhTWIazaqGoSjwhkBqODCFuBfMcgg6Ow3sbww>
    <xmx:uNC-WxnqtRLfMI9gpjqPAdjayVobfohuUq0-YNyPh11_imhV4KFUWA>
    <xmx:uNC-WzGb-OQrmJshkDGbhghrAZYfmjQY3R_5GzSxuXbNHxLmC0LmJg>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27DA4102ED;
        Thu, 11 Oct 2018 00:25:25 -0400 (EDT)
Message-ID: <8548f1872badb35588d5506da21f0d89bea71127.camel@mendozajonas.com>
Subject: Re: [RFC PATCH 2/2] net/ncsi: Configure multi-package,
 multi-channel modes with failover
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Thu, 11 Oct 2018 15:25:21 +1100
In-Reply-To: <d97bb52a060a40cf8e03a49eb82a285f@AUSX13MPS302.AMER.DELL.COM>
References: <20181009035815.5246-1-sam@mendozajonas.com>
         <20181009035815.5246-2-sam@mendozajonas.com>
         <d97bb52a060a40cf8e03a49eb82a285f@AUSX13MPS302.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-10 at 22:36 +0000, Justin.Lee1@Dell.com wrote:
> Hi Samuel,
> 
> I am still testing your change and have some comments below.
> 
> Thanks,
> Justin
> 
> 
> > This patch extends the ncsi-netlink interface with two new commands and
> > three new attributes to configure multiple packages and/or channels at
> > once, and configure specific failover modes.
> > 
> > NCSI_CMD_SET_PACKAGE mask and NCSI_CMD_SET_CHANNEL_MASK set a whitelist
> > of packages or channels allowed to be configured with the
> > NCSI_ATTR_PACKAGE_MASK and NCSI_ATTR_CHANNEL_MASK attributes
> > respectively. If one of these whitelists is set only packages or
> > channels matching the whitelist are considered for the channel queue in
> > ncsi_choose_active_channel().
> > 
> > These commands may also use the NCSI_ATTR_MULTI_FLAG to signal that
> > multiple packages or channels may be configured simultaneously. NCSI
> > hardware arbitration (HWA) must be available in order to enable
> > multi-package mode. Multi-channel mode is always available.
> > 
> > If the NCSI_ATTR_CHANNEL_ID attribute is present in the
> > NCSI_CMD_SET_CHANNEL_MASK command the it sets the preferred channel as
> > with the NCSI_CMD_SET_INTERFACE command. The combination of preferred
> > channel and channel whitelist defines a primary channel and the allowed
> > failover channels.
> > If the NCSI_ATTR_MULTI_FLAG attribute is also present then the preferred
> > channel is configured for Tx/Rx and the other channels are enabled only
> > for Rx.
> > 
> > Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> > ---
> >  include/uapi/linux/ncsi.h |  16 +++
> >  net/ncsi/internal.h       |  11 +-
> >  net/ncsi/ncsi-aen.c       |   2 +-
> >  net/ncsi/ncsi-manage.c    | 138 ++++++++++++++++--------
> >  net/ncsi/ncsi-netlink.c   | 217 +++++++++++++++++++++++++++++++++-----
> >  net/ncsi/ncsi-rsp.c       |   2 +-
> >  6 files changed, 312 insertions(+), 74 deletions(-)
> > 
> > diff --git a/include/uapi/linux/ncsi.h b/include/uapi/linux/ncsi.h
> > index 4c292ecbb748..035fba1693f9 100644
> > --- a/include/uapi/linux/ncsi.h
> > +++ b/include/uapi/linux/ncsi.h
> > @@ -23,6 +23,13 @@
> >   *	optionally the preferred NCSI_ATTR_CHANNEL_ID.
> >   * @NCSI_CMD_CLEAR_INTERFACE: clear any preferred package/channel combination.
> >   *	Requires NCSI_ATTR_IFINDEX.
> > + * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed packages.
> > + * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed channels.
> > + *	Requires NCSI_ATTR_IFINDEX and NCSI_ATTR_PACKAGE_MASK.
> > + * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed channels.
> > + *	Requires NCSI_ATTR_IFINDEX, NCSI_ATTR_PACKAGE_ID, and
> > + *	NCSI_ATTR_CHANNEL_MASK. If NCSI_ATTR_CHANNEL_ID is present it sets
> > + *	the primary channel.
> >   * @NCSI_CMD_MAX: highest command number
> >   */
> 
> There are some typo in the description.
> * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed packages.
>  *	Requires NCSI_ATTR_IFINDEX and NCSI_ATTR_PACKAGE_MASK.
>  * @NCSI_CMD_SET_CHANNEL_MASK: set a whitelist of allowed channels.
>  *	Requires NCSI_ATTR_IFINDEX, NCSI_ATTR_PACKAGE_ID, and
>  *	NCSI_ATTR_CHANNEL_MASK. If NCSI_ATTR_CHANNEL_ID is present it sets
>  *	the primary channel.

Haha, yes I threw that in at the end, thanks for catching it.

> 
> >  enum ncsi_nl_commands {
> > @@ -30,6 +37,8 @@ enum ncsi_nl_commands {
> >  	NCSI_CMD_PKG_INFO,
> >  	NCSI_CMD_SET_INTERFACE,
> >  	NCSI_CMD_CLEAR_INTERFACE,
> > +	NCSI_CMD_SET_PACKAGE_MASK,
> > +	NCSI_CMD_SET_CHANNEL_MASK,
> >  
> >  	__NCSI_CMD_AFTER_LAST,
> >  	NCSI_CMD_MAX = __NCSI_CMD_AFTER_LAST - 1
> > @@ -43,6 +52,10 @@ enum ncsi_nl_commands {
> >   * @NCSI_ATTR_PACKAGE_LIST: nested array of NCSI_PKG_ATTR attributes
> >   * @NCSI_ATTR_PACKAGE_ID: package ID
> >   * @NCSI_ATTR_CHANNEL_ID: channel ID
> > + * @NCSI_ATTR_MULTI_FLAG: flag to signal that multi-mode should be enabled with
> > + *	NCSI_CMD_SET_PACKAGE_MASK or NCSI_CMD_SET_CHANNEL_MASK.
> > + * @NCSI_ATTR_PACKAGE_MASK: 32-bit mask of allowed packages.
> > + * @NCSI_ATTR_CHANNEL_MASK: 32-bit mask of allowed channels.
> >   * @NCSI_ATTR_MAX: highest attribute number
> >   */
> >  enum ncsi_nl_attrs {
> > @@ -51,6 +64,9 @@ enum ncsi_nl_attrs {
> >  	NCSI_ATTR_PACKAGE_LIST,
> >  	NCSI_ATTR_PACKAGE_ID,
> >  	NCSI_ATTR_CHANNEL_ID,
> > +	NCSI_ATTR_MULTI_FLAG,
> > +	NCSI_ATTR_PACKAGE_MASK,
> > +	NCSI_ATTR_CHANNEL_MASK,
> 
> Is there a case that we might set these two masks at the same time?
> If not, maybe we can just have one generic MASK attribute.
> 

I thought of this too: not yet, but I wonder if we might in the future.
I'll have a think about it.

> >  
> >  	__NCSI_ATTR_AFTER_LAST,
> >  	NCSI_ATTR_MAX = __NCSI_ATTR_AFTER_LAST - 1
> > diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> > index 3d0a33b874f5..8437474d0a78 100644
> > --- a/net/ncsi/internal.h
> > +++ b/net/ncsi/internal.h
> > @@ -213,6 +213,10 @@ struct ncsi_package {
> >  	unsigned int         channel_num; /* Number of channels     */
> >  	struct list_head     channels;    /* List of chanels        */
> >  	struct list_head     node;        /* Form list of packages  */
> > +
> > +	bool                 multi_channel; /* Enable multiple channels  */
> > +	u32                  channel_whitelist; /* Channels to configure */
> > +	struct ncsi_channel  *preferred_channel; /* Primary channel      */
> >  };
> >  
> >  struct ncsi_request {
> > @@ -280,8 +284,6 @@ struct ncsi_dev_priv {
> >  	unsigned int        package_num;     /* Number of packages         */
> >  	struct list_head    packages;        /* List of packages           */
> >  	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
> > -	struct ncsi_package *force_package;  /* Force a specific package   */
> > -	struct ncsi_channel *force_channel;  /* Force a specific channel   */
> >  	struct ncsi_request requests[256];   /* Request table              */
> >  	unsigned int        request_id;      /* Last used request ID       */
> >  #define NCSI_REQ_START_IDX	1
> > @@ -294,6 +296,9 @@ struct ncsi_dev_priv {
> >  	struct list_head    node;            /* Form NCSI device list      */
> >  #define NCSI_MAX_VLAN_VIDS	15
> >  	struct list_head    vlan_vids;       /* List of active VLAN IDs */
> > +
> > +	bool                multi_package;   /* Enable multiple packages   */
> > +	u32                 package_whitelist; /* Packages to configure    */
> >  };
> >  
> >  struct ncsi_cmd_arg {
> > @@ -345,6 +350,8 @@ struct ncsi_request *ncsi_alloc_request(struct ncsi_dev_priv *ndp,
> >  void ncsi_free_request(struct ncsi_request *nr);
> >  struct ncsi_dev *ncsi_find_dev(struct net_device *dev);
> >  int ncsi_process_next_channel(struct ncsi_dev_priv *ndp);
> > +bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
> > +			  struct ncsi_channel *channel);
> >  
> >  /* Packet handlers */
> >  u32 ncsi_calculate_checksum(unsigned char *data, int len);
> > diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
> > index 65f47a648be3..eac56aee30c4 100644
> > --- a/net/ncsi/ncsi-aen.c
> > +++ b/net/ncsi/ncsi-aen.c
> > @@ -86,7 +86,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
> >  	    !(state == NCSI_CHANNEL_ACTIVE && !(data & 0x1)))
> >  		return 0;
> >  
> > -	if (state == NCSI_CHANNEL_ACTIVE)
> > +	if (state == NCSI_CHANNEL_ACTIVE && ncsi_channel_is_last(ndp, nc))
> >  		ndp->flags |= NCSI_DEV_RESHUFFLE;
> >  
> >  	ncsi_stop_channel_monitor(nc);
> > diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> > index 665bee25ec44..6a55df700bcb 100644
> > --- a/net/ncsi/ncsi-manage.c
> > +++ b/net/ncsi/ncsi-manage.c
> > @@ -27,6 +27,24 @@
> >  LIST_HEAD(ncsi_dev_list);
> >  DEFINE_SPINLOCK(ncsi_dev_lock);
> >  
> > +/* Returns true if the given channel is the last channel available */
> > +bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
> > +			  struct ncsi_channel *channel)
> > +{
> > +	struct ncsi_package *np;
> > +	struct ncsi_channel *nc;
> > +
> > +	NCSI_FOR_EACH_PACKAGE(ndp, np)
> > +		NCSI_FOR_EACH_CHANNEL(np, nc) {
> > +			if (nc == channel)
> > +				continue;
> > +			if (nc->state == NCSI_CHANNEL_ACTIVE)
> > +				return false;
> > +		}
> > +
> > +	return true;
> > +}
> > +
> >  static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
> >  {
> >  	struct ncsi_dev *nd = &ndp->ndev;
> > @@ -266,6 +284,7 @@ struct ncsi_package *ncsi_add_package(struct ncsi_dev_priv *ndp,
> >  	np->ndp = ndp;
> >  	spin_lock_init(&np->lock);
> >  	INIT_LIST_HEAD(&np->channels);
> > +	np->channel_whitelist = UINT_MAX;
> >  
> >  	spin_lock_irqsave(&ndp->lock, flags);
> >  	tmp = ncsi_find_package(ndp, id);
> > @@ -633,6 +652,34 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
> >  	return 0;
> >  }
> >  
> > +/* Determine if a given channel should be the Tx channel */
> > +bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc)
> > +{
> > +	struct ncsi_package *np = nc->package;
> > +	struct ncsi_channel *channel;
> > +	struct ncsi_channel_mode *ncm;
> > +
> > +	NCSI_FOR_EACH_CHANNEL(np, channel) {
> > +		ncm = &channel->modes[NCSI_MODE_TX_ENABLE];
> > +		/* Another channel is already Tx */
> > +		if (ncm->enable)
> > +			return false;
> > +	}
> > +
> > +	if (!np->preferred_channel)
> > +		return true;
> > +
> > +	if (np->preferred_channel == nc)
> > +		return true;
> > +
> > +	/* The preferred channel is not in the queue and not active */
> > +	if (list_empty(&np->preferred_channel->link) &&
> > +	    np->preferred_channel->state != NCSI_CHANNEL_ACTIVE)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
> >  {
> >  	struct ncsi_dev *nd = &ndp->ndev;
> > @@ -745,18 +792,22 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
> >  		} else if (nd->state == ncsi_dev_state_config_ebf) {
> >  			nca.type = NCSI_PKT_CMD_EBF;
> >  			nca.dwords[0] = nc->caps[NCSI_CAP_BC].cap;
> > -			nd->state = ncsi_dev_state_config_ecnt;
> > +			if (ncsi_channel_is_tx(ndp, nc))
> > +				nd->state = ncsi_dev_state_config_ecnt;
> > +			else
> > +				nd->state = ncsi_dev_state_config_ec;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >  			if (ndp->inet6_addr_num > 0 &&
> >  			    (nc->caps[NCSI_CAP_GENERIC].cap &
> >  			     NCSI_CAP_GENERIC_MC))
> >  				nd->state = ncsi_dev_state_config_egmf;
> > -			else
> > -				nd->state = ncsi_dev_state_config_ecnt;
> >  		} else if (nd->state == ncsi_dev_state_config_egmf) {
> >  			nca.type = NCSI_PKT_CMD_EGMF;
> >  			nca.dwords[0] = nc->caps[NCSI_CAP_MC].cap;
> > -			nd->state = ncsi_dev_state_config_ecnt;
> > +			if (ncsi_channel_is_tx(ndp, nc))
> > +				nd->state = ncsi_dev_state_config_ecnt;
> > +			else
> > +				nd->state = ncsi_dev_state_config_ec;
> >  #endif /* CONFIG_IPV6 */
> >  		} else if (nd->state == ncsi_dev_state_config_ecnt) {
> >  			nca.type = NCSI_PKT_CMD_ECNT;
> > @@ -840,43 +891,35 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
> >  
> >  static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
> >  {
> > -	struct ncsi_package *np, *force_package;
> > -	struct ncsi_channel *nc, *found, *hot_nc, *force_channel;
> > +	struct ncsi_package *np;
> > +	struct ncsi_channel *nc, *found, *hot_nc;
> >  	struct ncsi_channel_mode *ncm;
> > -	unsigned long flags;
> > +	unsigned long flags, cflags;
> > +	bool with_link;
> >  
> >  	spin_lock_irqsave(&ndp->lock, flags);
> >  	hot_nc = ndp->hot_channel;
> > -	force_channel = ndp->force_channel;
> > -	force_package = ndp->force_package;
> >  	spin_unlock_irqrestore(&ndp->lock, flags);
> >  
> > -	/* Force a specific channel whether or not it has link if we have been
> > -	 * configured to do so
> > -	 */
> > -	if (force_package && force_channel) {
> > -		found = force_channel;
> > -		ncm = &found->modes[NCSI_MODE_LINK];
> > -		if (!(ncm->data[2] & 0x1))
> > -			netdev_info(ndp->ndev.dev,
> > -				    "NCSI: Channel %u forced, but it is link down\n",
> > -				    found->id);
> > -		goto out;
> > -	}
> > -
> > -	/* The search is done once an inactive channel with up
> > -	 * link is found.
> > +	/* By default the search is done once an inactive channel with up
> > +	 * link is found, unless a preferred channel is set.
> > +	 * If multi_package or multi_channel are configured all channels in the
> > +	 * whitelist with link are added to the channel queue.
> >  	 */
> >  	found = NULL;
> > +	with_link = false;
> >  	NCSI_FOR_EACH_PACKAGE(ndp, np) {
> > -		if (ndp->force_package && np != ndp->force_package)
> > +		if (!(ndp->package_whitelist & (0x1 << np->id)))
> >  			continue;
> >  		NCSI_FOR_EACH_CHANNEL(np, nc) {
> > -			spin_lock_irqsave(&nc->lock, flags);
> > +			if (!(np->channel_whitelist & (0x1 << nc->id)))
> > +				continue;
> > +
> > +			spin_lock_irqsave(&nc->lock, cflags);
> >  
> >  			if (!list_empty(&nc->link) ||
> >  			    nc->state != NCSI_CHANNEL_INACTIVE) {
> > -				spin_unlock_irqrestore(&nc->lock, flags);
> > +				spin_unlock_irqrestore(&nc->lock, cflags);
> >  				continue;
> >  			}
> >  
> > @@ -888,32 +931,42 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
> >  
> >  			ncm = &nc->modes[NCSI_MODE_LINK];
> >  			if (ncm->data[2] & 0x1) {
> 
> This data will not be updated if the channel monitor for it is not running.
> If I move the cable from the current configured channel to the other channel,
> NC-SI module will not detect the link status as the other channel is not configured
> and AEN will not happen.
> Is it per design that NC-SI module will always use the first interface with the link?

We'll check the link state of every channel at init, and per-package on
suspend events, but you're right that we only get AENs right now from
configured channels. There's probably no reason why we could at least
enable AENs on all channels even if we don't use them for network, maybe
during the package probe step.

> 
> > -				spin_unlock_irqrestore(&nc->lock, flags);
> >  				found = nc;
> > -				goto out;
> > +				with_link = true;
> > +
> > +				spin_lock_irqsave(&ndp->lock, flags);
> > +				list_add_tail_rcu(&found->link,
> > +						  &ndp->channel_queue);
> > +				spin_unlock_irqrestore(&ndp->lock, flags);
> > +
> > +				netdev_dbg(ndp->ndev.dev,
> > +					   "NCSI: Channel %u added to queue (link %s)\n",
> > +					   found->id,
> > +					   ncm->data[2] & 0x1 ? "up" : "down");
> >  			}
> > +			spin_unlock_irqrestore(&nc->lock, cflags);
> >  
> > -			spin_unlock_irqrestore(&nc->lock, flags);
> > +			if (with_link && !np->multi_channel)
> > +				break;
> >  		}
> > +		if (with_link && !ndp->multi_package)
> > +			break;
> >  	}
> >  
> > -	if (!found) {
> > +	if (!with_link && found) {
> > +		netdev_info(ndp->ndev.dev,
> > +			    "NCSI: No channel with link found, configuring channel %u\n",
> > +			    found->id);
> > +		spin_lock_irqsave(&ndp->lock, flags);
> > +		list_add_tail_rcu(&found->link, &ndp->channel_queue);
> > +		spin_unlock_irqrestore(&ndp->lock, flags);
> > +	} else if (!found) {
> >  		netdev_warn(ndp->ndev.dev,
> > -			    "NCSI: No channel found with link\n");
> > +			    "NCSI: No channel found to configure!\n");
> >  		ncsi_report_link(ndp, true);
> >  		return -ENODEV;
> >  	}
> >  
> > -	ncm = &found->modes[NCSI_MODE_LINK];
> > -	netdev_dbg(ndp->ndev.dev,
> > -		   "NCSI: Channel %u added to queue (link %s)\n",
> > -		   found->id, ncm->data[2] & 0x1 ? "up" : "down");
> > -
> > -out:
> > -	spin_lock_irqsave(&ndp->lock, flags);
> > -	list_add_tail_rcu(&found->link, &ndp->channel_queue);
> > -	spin_unlock_irqrestore(&ndp->lock, flags);
> > -
> >  	return ncsi_process_next_channel(ndp);
> >  }
> >  
> > @@ -1428,6 +1481,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
> >  	INIT_LIST_HEAD(&ndp->channel_queue);
> >  	INIT_LIST_HEAD(&ndp->vlan_vids);
> >  	INIT_WORK(&ndp->work, ncsi_dev_work);
> > +	ndp->package_whitelist = UINT_MAX;
> >  
> >  	/* Initialize private NCSI device */
> >  	spin_lock_init(&ndp->lock);
> > diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> > index 32cb7751d216..33a091e6f466 100644
> > --- a/net/ncsi/ncsi-netlink.c
> > +++ b/net/ncsi/ncsi-netlink.c
> 
> Is the following missed in the patch?
> static const struct nla_policy ncsi_genl_policy[NCSI_ATTR_MAX + 1] = {
> ...
> 	[NCSI_ATTR_MULTI_FLAG] =	{ .type = NLA_FLAG },
> 	[NCSI_ATTR_PACKAGE_MASK] =	{ .type = NLA_U32 },
> 	[NCSI_ATTR_CHANNEL_MASK] =	{ .type = NLA_U32 },

Oops, added.

> 
> > @@ -67,7 +67,7 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
> >  	nla_put_u32(skb, NCSI_CHANNEL_ATTR_LINK_STATE, m->data[2]);
> >  	if (nc->state == NCSI_CHANNEL_ACTIVE)
> >  		nla_put_flag(skb, NCSI_CHANNEL_ATTR_ACTIVE);
> > -	if (ndp->force_channel == nc)
> > +	if (nc == nc->package->preferred_channel)
> >  		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
> >  
> >  	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
> > @@ -112,7 +112,7 @@ static int ncsi_write_package_info(struct sk_buff *skb,
> >  		if (!pnest)
> >  			return -ENOMEM;
> >  		nla_put_u32(skb, NCSI_PKG_ATTR_ID, np->id);
> > -		if (ndp->force_package == np)
> > +		if ((0x1 << np->id) == ndp->package_whitelist)
> >  			nla_put_flag(skb, NCSI_PKG_ATTR_FORCED);
> >  		cnest = nla_nest_start(skb, NCSI_PKG_ATTR_CHANNEL_LIST);
> >  		if (!cnest) {
> > @@ -288,45 +288,54 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
> >  	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
> >  	package = NULL;
> >  
> > -	spin_lock_irqsave(&ndp->lock, flags);
> > -
> >  	NCSI_FOR_EACH_PACKAGE(ndp, np)
> >  		if (np->id == package_id)
> >  			package = np;
> >  	if (!package) {
> >  		/* The user has set a package that does not exist */
> > -		spin_unlock_irqrestore(&ndp->lock, flags);
> >  		return -ERANGE;
> >  	}
> >  
> >  	channel = NULL;
> > -	if (!info->attrs[NCSI_ATTR_CHANNEL_ID]) {
> > -		/* Allow any channel */
> > -		channel_id = NCSI_RESERVED_CHANNEL;
> > -	} else {
> > +	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
> >  		channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
> >  		NCSI_FOR_EACH_CHANNEL(package, nc)
> > -			if (nc->id == channel_id)
> > +			if (nc->id == channel_id) {
> >  				channel = nc;
> > +				break;
> > +			}
> > +		if (!channel) {
> > +			netdev_info(ndp->ndev.dev,
> > +				    "NCSI: Channel %u does not exist!\n",
> > +				    channel_id);
> > +			return -ERANGE;
> > +		}
> >  	}
> >  
> > -	if (channel_id != NCSI_RESERVED_CHANNEL && !channel) {
> > -		/* The user has set a channel that does not exist on this
> > -		 * package
> > -		 */
> > -		spin_unlock_irqrestore(&ndp->lock, flags);
> > -		netdev_info(ndp->ndev.dev, "NCSI: Channel %u does not exist!\n",
> > -			    channel_id);
> > -		return -ERANGE;
> > -	}
> > -
> > -	ndp->force_package = package;
> > -	ndp->force_channel = channel;
> > +	spin_lock_irqsave(&ndp->lock, flags);
> > +	ndp->package_whitelist = 0x1 << package->id;
> > +	ndp->multi_package = false;
> >  	spin_unlock_irqrestore(&ndp->lock, flags);
> >  
> > -	netdev_info(ndp->ndev.dev, "Set package 0x%x, channel 0x%x%s as preferred\n",
> > -		    package_id, channel_id,
> > -		    channel_id == NCSI_RESERVED_CHANNEL ? " (any)" : "");
> > +	spin_lock_irqsave(&package->lock, flags);
> > +	package->multi_channel = false;
> > +	if (channel) {
> > +		package->channel_whitelist = 0x1 << channel->id;
> > +		package->preferred_channel = channel;
> > +	} else {
> > +		/* Allow any channel */
> > +		package->channel_whitelist = UINT_MAX;
> > +		package->preferred_channel = NULL;
> > +	}
> > +	spin_unlock_irqrestore(&package->lock, flags);
> > +
> > +	if (channel)
> > +		netdev_info(ndp->ndev.dev,
> > +			    "Set package 0x%x, channel 0x%x as preferred\n",
> > +			    package_id, channel_id);
> > +	else
> > +		netdev_info(ndp->ndev.dev, "Set package 0x%x as preferred\n",
> > +			    package_id);
> >  
> >  	/* Bounce the NCSI channel to set changes */
> >  	ncsi_stop_dev(&ndp->ndev);
> > @@ -338,6 +347,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
> >  static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
> >  {
> >  	struct ncsi_dev_priv *ndp;
> > +	struct ncsi_package *np;
> >  	unsigned long flags;
> >  
> >  	if (!info || !info->attrs)
> > @@ -351,11 +361,19 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
> >  	if (!ndp)
> >  		return -ENODEV;
> >  
> > -	/* Clear any override */
> > +	/* Reset any whitelists and disable multi mode */
> >  	spin_lock_irqsave(&ndp->lock, flags);
> > -	ndp->force_package = NULL;
> > -	ndp->force_channel = NULL;
> > +	ndp->package_whitelist = UINT_MAX;
> > +	ndp->multi_package = false;
> >  	spin_unlock_irqrestore(&ndp->lock, flags);
> > +
> > +	NCSI_FOR_EACH_PACKAGE(ndp, np) {
> > +		spin_lock_irqsave(&np->lock, flags);
> > +		np->multi_channel = false;
> > +		np->channel_whitelist = UINT_MAX;
> > +		np->preferred_channel = NULL;
> > +		spin_unlock_irqrestore(&np->lock, flags);
> > +	}
> >  	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
> >  
> >  	/* Bounce the NCSI channel to set changes */
> > @@ -365,6 +383,137 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
> >  	return 0;
> >  }
> >  
> > +static int ncsi_set_package_mask_nl(struct sk_buff *msg,
> > +				    struct genl_info *info)
> > +{
> > +	struct ncsi_dev_priv *ndp;
> > +	unsigned long flags;
> > +	int rc;
> > +
> > +	if (!info || !info->attrs)
> > +		return -EINVAL;
> > +
> > +	if (!info->attrs[NCSI_ATTR_IFINDEX])
> > +		return -EINVAL;
> > +
> > +	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
> > +		return -EINVAL;
> > +
> > +	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
> > +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> > +	if (!ndp)
> > +		return -ENODEV;
> > +
> > +	spin_lock_irqsave(&ndp->lock, flags);
> > +	ndp->package_whitelist =
> > +		nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_MASK]);
> > +
> > +	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
> > +		if (ndp->flags & NCSI_DEV_HWA) {
> > +			ndp->multi_package = true;
> > +			rc = 0;
> > +		} else {
> > +			netdev_err(ndp->ndev.dev,
> > +				   "NCSI: Can't use multiple packages without HWA\n");
> > +			rc = -EPERM;
> > +		}
> > +	} else {
> > +		rc = 0;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&ndp->lock, flags);
> > +
> > +	if (!rc) {
> > +		/* Bounce the NCSI channel to set changes */
> > +		ncsi_stop_dev(&ndp->ndev);
> > +		ncsi_start_dev(&ndp->ndev);
> 
> Is it possible to delay the restart? If we have two packages, we might send
> set_package_mask command once and set_channel_mask command twice.
> We will see the unnecessary reconfigurations in a very short period time.

We could probably do with a better way of bouncing the link here too. I
suppose we could schedule the actual link 'bounce' to occur a second or
two later, and delay if we receive new configuration in that time.
Perhaps something outside of the scope of this patch though.

> 
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
> > +				    struct genl_info *info)
> > +{
> > +	struct ncsi_package *np, *package;
> > +	struct ncsi_channel *nc, *channel;
> > +	struct ncsi_dev_priv *ndp;
> > +	unsigned long flags;
> > +	u32 package_id, channel_id;
> > +
> > +	if (!info || !info->attrs)
> > +		return -EINVAL;
> > +
> > +	if (!info->attrs[NCSI_ATTR_IFINDEX])
> > +		return -EINVAL;
> > +
> > +	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
> > +		return -EINVAL;
> > +
> > +	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
> > +		return -EINVAL;
> > +
> > +	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
> > +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> > +	if (!ndp)
> > +		return -ENODEV;
> > +
> > +	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
> > +	package = NULL;
> > +	NCSI_FOR_EACH_PACKAGE(ndp, np)
> > +		if (np->id == package_id) {
> > +			package = np;
> > +			break;
> > +		}
> > +	if (!package)
> > +		return -ERANGE;
> > +
> > +	spin_lock_irqsave(&package->lock, flags);
> > +
> > +	channel = NULL;
> > +	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
> > +		channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
> > +		NCSI_FOR_EACH_CHANNEL(np, nc)
> > +			if (nc->id == channel_id) {
> > +				channel = nc;
> > +				break;
> > +			}
> > +		if (!channel) {
> > +			spin_unlock_irqrestore(&package->lock, flags);
> > +			return -ERANGE;
> > +		}
> > +		netdev_dbg(ndp->ndev.dev,
> > +			   "NCSI: Channel %u set as preferred channel\n",
> > +			   channel->id);
> > +	}
> > +
> > +	package->channel_whitelist =
> > +		nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_MASK]);
> > +	if (package->channel_whitelist == 0)
> > +		netdev_dbg(ndp->ndev.dev,
> > +			   "NCSI: Package %u set to all channels disabled\n",
> > +			   package->id);
> > +
> > +	package->preferred_channel = channel;
> > +
> > +	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
> > +		package->multi_channel = true;
> > +		netdev_info(ndp->ndev.dev,
> > +			    "NCSI: Multi-channel enabled on package %u\n",
> > +			    package_id);
> > +	} else {
> > +		package->multi_channel = false;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&package->lock, flags);
> > +
> > +	/* Bounce the NCSI channel to set changes */
> > +	ncsi_stop_dev(&ndp->ndev);
> > +	ncsi_start_dev(&ndp->ndev);
> 
> Same question as set_package_mask function.
> Is it possible to delay the restart? If we have two packages, we might send
> set_package_mask command once and set_channel_mask command twice.
> We will see the unnecessary reconfigurations in a very short period time.
> 
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct genl_ops ncsi_ops[] = {
> >  	{
> >  		.cmd = NCSI_CMD_PKG_INFO,
> > @@ -385,6 +534,18 @@ static const struct genl_ops ncsi_ops[] = {
> >  		.doit = ncsi_clear_interface_nl,
> >  		.flags = GENL_ADMIN_PERM,
> >  	},
> > +	{
> > +		.cmd = NCSI_CMD_SET_PACKAGE_MASK,
> > +		.policy = ncsi_genl_policy,
> > +		.doit = ncsi_set_package_mask_nl,
> > +		.flags = GENL_ADMIN_PERM,
> > +	},
> > +	{
> > +		.cmd = NCSI_CMD_SET_CHANNEL_MASK,
> > +		.policy = ncsi_genl_policy,
> > +		.doit = ncsi_set_channel_mask_nl,
> > +		.flags = GENL_ADMIN_PERM,
> > +	},
> >  };
> >  
> >  static struct genl_family ncsi_genl_family __ro_after_init = {
> > diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> > index d66b34749027..02ce7626b579 100644
> > --- a/net/ncsi/ncsi-rsp.c
> > +++ b/net/ncsi/ncsi-rsp.c
> > @@ -241,7 +241,7 @@ static int ncsi_rsp_handler_dcnt(struct ncsi_request *nr)
> >  	if (!ncm->enable)
> >  		return 0;
> >  
> > -	ncm->enable = 1;
> > +	ncm->enable = 0;
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.19.0
> 
> 


