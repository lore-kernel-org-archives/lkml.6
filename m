Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3237508-1519660655-2-14474676653164714730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519660654; b=W0q2b1lLrGKA5W6pSSZ3/L4ceM5XZmAHIt5OI46uGJpK+Un
    /uFLTx5yQX2s9RcSOjvN69tkSLIZYXW7ioHfIc3/dQCfT2ITb2/mMSZQrN2rGZng
    PUitfLVEARgjhMX58zFfP9gLZdV613P4NlKUdE97mpjctFpdifZPcHfl0oz/E4WO
    90YVyiIO2BcHrUZB+8IZ1qR77+oBl/LPiXWqGV1Jd0K92uBK88W7+JuPpp10iUhg
    10p8xLrZhYUriiL4obzSeL0fIcy+Ad/RPNevadmZeCOYm4wTv9bU66zjGgrfb3rQ
    60s1isJAtPyjLM1Qk3bMTT39VTcHY24HUn4DKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519660654; bh=OUtNQ2uKRquu13lU3S1CUEfkyb
    q7iOvaxR8U+g7nf6Q=; b=ccrLPluYkDDFX9E2YM7OEI8VERSrS46tA5TjDAvSxV
    IpW+/E8OOv9RxVRH4v08a9rns/9GWGYSCB70noP8I61hnHFjU2bNmwlvsaKZV1IF
    D2343cBRBSxwNQbPo/3X1O6iR/2VXTn1ZrzR4dfs0eGxhcBDca7B4w/VNKamsL0k
    8n8e4a2CDvkz5jngey1RCcc9GSDt9t42rkg307Q4sohQJVU89bY6L1jQIs0hC1QN
    ewOyql7Bhrm7QkxI3pSlcUDRkiXJIb8a4hHMfLThSSBRi+Uj+vbbn5MZNwlrnGCF
    nDdPmUg0HjTO3ptGZlsVDj+Npg6D/wTxBrjbxSlORCQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=YoFs9HWi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=YoFs9HWi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeBZP5X (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:57:23 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:48383 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeBZP5V (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 10:57:21 -0500
Date: Mon, 26 Feb 2018 09:57:16 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <linux-omap@vger.kernel.org>, <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading
 vbus registers
Message-ID: <20180226155716.GB20609@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org,
        tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180226105609.22514-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180226105609.22514-1-merlijn@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, Feb 26, 2018 at 11:56:08AM +0100, Merlijn Wajer wrote:
> Without pm_runtime_{get,put}_sync calls in place, reading
> vbus status via /sys causes the following error:
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> pgd = b333e822
> [fa0ab060] *pgd=48011452(bad)
> 
> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
> 
> Solution was suggested by Tony Lindgren <tony@atomide.com>.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  drivers/usb/musb/musb_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index eef4ad578b31..ceaa40ef0e73 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1760,6 +1760,8 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	val = musb->a_wait_bcon;
>  	vbus = musb_platform_get_vbus_status(musb);
>  	if (vbus < 0) {
> +		pm_runtime_get_sync(dev);
> +
>  		/* Use default MUSB method by means of DEVCTL register */
>  		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>  		if ((devctl & MUSB_DEVCTL_VBUS)
> @@ -1767,6 +1769,8 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
>  			vbus = 1;
>  		else
>  			vbus = 0;
> +
> +		pm_runtime_put_sync(dev);
>  	}
>  	spin_unlock_irqrestore(&musb->lock, flags);

Thanks for the patch, but I got spinlock deadlock when testing it. I
think the function pair should be at the outside scope of the
spin_lock/unlock, doesn't it?

Regards,
-Bin.
