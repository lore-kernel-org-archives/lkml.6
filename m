Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517854703-2-8309537029364360075
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517854703; b=vXCPGp4MrfGqcYh3QdHRssxpe8GhbSWiqYwwhSc0U7RTCob
    ny6VaP2JE6/veiyMMj2UDZv/KEwlGffnc7YqV3ElB0Dzje1/gFyiX0gTjLUPXZqs
    69eOtPX0/peKIJCdyhIssFLeHaR5yYQssTNG3MLZiLJmG3nD9cLPfL+tI4GX53lZ
    3qJpdkli5OjzSkmNocxWx0b2jOYYzRialPHbMIXwisx/OHz8EKkgKpyfjWPRVhkt
    oPgOhcqF+qHpaokKICjkXIBr8/wu2GYnnt4GdUp2p4efXCBwx9/10/xu1Xb/p12/
    uCqZyeZcMI9uygYyygDeyFSC2ejJGhXINfJiGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517854703; bh=JCVdHV007LsAPmCYF8zHY2ZVPg
    ABofn1jp1CnYbpRCI=; b=pw7BEh5EuZtq0qXDHRlVA0USG34ceWF5AQq85rxWD9
    vd9wODFzR7LJlOeD79SPpHIuyp/gYcHF7CbslZ73GUQkvj7ZUBzWxv3gZICwAtxW
    YzlCk0VkYnquSiZygjivZdPEETxIadwLy8aB0JD3fQPSqFaEEuFZfEYeHqg1WM2A
    3ZjGc9eA7/RfUYkUNARW/23R6KiXhgmdHmPrja9C7LKVnCCmY26tHCRcPvyAWzji
    9i7CZiB9GScsX7e+VXqOB3HLgUY/k5jYmT6yAItS3UhFUZP++kAMcx3Mm5roGq2F
    wtk+hSwdb1Y0CFerbjev0bzoYIDH6wX79Mfnco490/+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Dneo7jks x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=XYwbQSyy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Dneo7jks x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=XYwbQSyy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeBESSJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:18:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbeBESSH (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Feb 2018 13:18:07 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DAE4601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date: Mon, 5 Feb 2018 10:17:58 -0800
From: Jack Pham <jackp@codeaurora.org>
To: William Wu <william.wu@rock-chips.com>
Cc: gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, daniel.meng@rock-chips.com,
        fml@rock-chips.com
Subject: Re: [PATCH] usb: gadget: f_fs: get the correct address of comp_desc
Message-ID: <20180205181758.GA22738@usblab-sd-06.qualcomm.com>
References: <1517830418-2648-1-git-send-email-william.wu@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517830418-2648-1-git-send-email-william.wu@rock-chips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi William,

On Mon, Feb 05, 2018 at 07:33:38PM +0800, William Wu wrote:
> Refer to the USB 3.0 spec '9.6.7 SuperSpeed Endpoint Companion',
> the companion descriptor follows the standard endpoint descriptor.
> This descriptor is only defined for SuperSpeed endpoints. The
> f_fs driver gets the address of the companion descriptor via
> 'ds + USB_DT_ENDPOINT_SIZE', and actually, the ds variable is
> a pointer to the struct usb_endpoint_descriptor, so the offset
> of the companion descriptor which we get is USB_DT_ENDPOINT_SIZE *
> sizeof(struct usb_endpoint_descriptor), the wrong offset is 63
> bytes. This cause out-of-bound with the following error log if
> CONFIG_KASAN and CONFIG_SLUB_DEBUG is enabled on Rockchip RK3399
> Evaluation Board.
> 
> android_work: sent uevent USB_STATE=CONNECTED
> configfs-gadget gadget: super-speed config #1: b
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ffs_func_set_alt+0x230/0x398
> Read of size 1 at addr ffffffc0ce2d0b10 by task irq/224-dwc3/364

> Memory state around the buggy address:
>  ffffffc0ce2d0a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffc0ce2d0a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >ffffffc0ce2d0b00: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                          ^
>  ffffffc0ce2d0b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffffffc0ce2d0c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> Disabling lock debugging due to kernel taint
> android_work: sent uevent USB_STATE=CONFIGURED
> 
> This patch adds struct usb_endpoint_descriptor * -> u8 * type conversion
> for ds variable, then we can get the correct address of comp_desc
> with offset USB_DT_ENDPOINT_SIZE bytes.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6756472..f13ead0 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1882,8 +1882,8 @@ static int ffs_func_eps_enable(struct ffs_function *func)
>  		ep->ep->desc = ds;
>  
>  		if (needs_comp_desc) {
> -			comp_desc = (struct usb_ss_ep_comp_descriptor *)(ds +
> -					USB_DT_ENDPOINT_SIZE);
> +			comp_desc = (struct usb_ss_ep_comp_descriptor *)
> +				     ((u8 *)ds + USB_DT_ENDPOINT_SIZE);
>  			ep->ep->maxburst = comp_desc->bMaxBurst + 1;
>  			ep->ep->comp_desc = comp_desc;
>  		}

Please see my alternative fix for this. I proposed changing this
function to use config_ep_by_speed() instead.

https://www.spinics.net/lists/linux-usb/msg165149.html

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
