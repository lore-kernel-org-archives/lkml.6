Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296D3C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C8820865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C8820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeJLUyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:54:44 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56537 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:54:44 -0400
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAxOP-00076X-G9; Fri, 12 Oct 2018 14:22:13 +0100
Subject: Re: [PATCH 4/7] net: qmi_wwan: add usbnet -> priv function
To:     =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        steve.glendinning@shawell.net
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
 <20181012091642.21294-5-ben.dooks@codethink.co.uk>
 <87woqn30ly.fsf@miraculix.mork.no>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <f7c121eb-fcce-f32f-7c0e-9c142b9ec570@codethink.co.uk>
Date:   Fri, 12 Oct 2018 14:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87woqn30ly.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 11:44, Bjørn Mork wrote:
> Ben Dooks <ben.dooks@codethink.co.uk> writes:
> 
>> +static inline struct qmi_wwan_state *usbnet_to_qmi(struct usbnet *usb)
>> +{
>> +	return (void *) &usb->data;
>> +}
> 
> 
> checkpatch doesn't like this, and it is also inconsistent with the
> coding style elsewhere in the driver.

Thank you for pointing this out, will fix in v2.

> CHECK: No space is necessary after a cast
> #30: FILE: drivers/net/usb/qmi_wwan.c:81:
> +       return (void *) &usb->data;
> 
> total: 0 errors, 0 warnings, 1 checks, 115 lines checked
> 
> 
> And as for consistency:  I realize that "dev" is a very generic name,
> but it's used consistendly for all struct usbnet pointers in the driver:

Ok, I'll change it.

> 
> bjorn@miraculix:/usr/local/src/git/linux$ git grep 'struct usbnet' drivers/net/usb/qmi_wwan.c
> drivers/net/usb/qmi_wwan.c:static struct net_device *qmimux_find_dev(struct usbnet *dev, u8 mux_id)
> drivers/net/usb/qmi_wwan.c:static bool qmimux_has_slaves(struct usbnet *dev)
> drivers/net/usb/qmi_wwan.c:static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = netdev_priv(net);
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = netdev_priv(to_net_dev(d));
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = netdev_priv(to_net_dev(d));
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = netdev_priv(to_net_dev(d));
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = netdev_priv(to_net_dev(d));
> drivers/net/usb/qmi_wwan.c:static int qmi_wwan_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> drivers/net/usb/qmi_wwan.c:static int qmi_wwan_manage_power(struct usbnet *dev, int on)
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = usb_get_intfdata(intf);
> drivers/net/usb/qmi_wwan.c:static int qmi_wwan_register_subdriver(struct usbnet *dev)
> drivers/net/usb/qmi_wwan.c:static int qmi_wwan_change_dtr(struct usbnet *dev, bool on)
> drivers/net/usb/qmi_wwan.c:static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
> drivers/net/usb/qmi_wwan.c:     BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data) <
> drivers/net/usb/qmi_wwan.c:static void qmi_wwan_unbind(struct usbnet *dev, struct usb_interface *intf)
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = usb_get_intfdata(intf);
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = usb_get_intfdata(intf);
> drivers/net/usb/qmi_wwan.c:     struct usbnet *dev = usb_get_intfdata(intf);
> 
> The name was chosen to be consistent with the cdc_ether usage. I'd
> prefer it if this function could use the "dev" name, to avoid confusing
> things unnecessarly with yet another generic name like "usb". Which
> isn't used anywhere else in the driver, and could just as easily refer
> to a struct usb_device or struct usb_interface.

Ok, should be fairly easy to change this.

> (yes, I know there are a couple of "struct usb_device *dev" cases. But
> I'd rather see those renamed TBH)

I'd rather not touch that at the moment, this is already gaining complexity.

> I also don't see why this function should be qmi_wwan specific. No need
> to duplicate the same function in every minidriver, when you can do with
> two generic helpers (maybe with more meaningful names):

I personally prefer the return type to be specifically the private
data type for the driver. It makes it a bit easier to spot when
you don't get the cast right.

The functions below are the idea I am working towards for the
usbnet driver, I was trying to avoid doing everything in one
go. Making the accessor functions means the next round of changes
can be much smaller, touching 1-2 areas per driver.

> static inline void *usbnet_priv(const struct usbnet *dev)
> {
>          return (void *)&dev->data;
> }
> 
> static inline void *usbnet_priv0(const struct usbnet * *dev)
> {
> 	return (void *)dev->data[0];
> }

This is probably the end-game of the patch series, just need to
look at a couple of issues and see if there's anything better
than can be done.

I might also add a usbnet_set_privdata(dev, data) or something
like usbnet_alloc_privdata(dev, sizeof(data).

Note, there's also the fun here of the usbnet having private data
for itself, and these sub-drivers also having their own private
data... this probably needs to be named carefully.

> Please fix the checkpatch warning and consider the other comments.
> 
> Personally I don't really think it makes the code any easier to read.
> But if you want it, then I'm fine this. I guess I've grown too used to
> seeing those casts ;-)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
