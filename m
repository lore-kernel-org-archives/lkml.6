Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-826942-1524473301-2-7558937868160678799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524473300; b=N3SuRhO7Ap80UzlarX2o1wrzbSWUY9xZ3zvagkSU4FVVjMg/xe
    kgWMN3/eeUXOLhT+hNPs0/kBKZ7EyHWC7XZLl/+Ps+dnTu2R+CiZv6rYGthJbISD
    z66fvrcBQq4yLexaDqZoOOCN8PnAerckuzIO6aLZrZVJNadJE08FnNgNeFZOJcE5
    GAC4RTkFAM/GRIjyehz0mfgUQwqOYpPfu58T/M8BFBRuSna2mnnGNihOUd+Gjysd
    dYG9kPfVyQyHNt73YSv4vkR6Y8wvkDOTLjRljCKBbkQMQw8erfmpCmDU3ZXgo6yW
    Wqr06E6oE7ZtrGgAgbfLE6RK+66/HoAPS8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524473300; bh=06lUeXtbzV2DSCPaZPa+PMv1ha/bpE
    wIZQu2tSRidxQ=; b=HuX3ZXdxrgcX5IPceiQ0sLf7gihlWs/mRmIFpgfXWZqZv+
    k8UmPScuVLz3ACS3Fb8odmsTZ1hdW3gOVAi33kCmIG2hQjb7oCwWIQj6hceNt4if
    ZYDB7CKrEWpORjVdtEHnLwGjSHqrO90P9MBxNscC39+SDyDWSna07DggeqJCY5NG
    GnaTEuYTv6wzzh7VFfPQgko6YhkPBUG5fzVD7blmI+ypfsyiozZtturnP2jQiODs
    KTGQmxqL59s4Ov9z7cwMwZOiMy6CcgmrGoWYjo8ZTCsFdzpKyNmZnRKCHTA2IDuO
    yj9iMzh4jTbToL5YsID8xFemGTTmcdER9becQdRw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHkYZJRSXOMzUP5Y2wJxMoyDCzpzQVb3scjrQgcLU0ycAO2Qa02p50vBUr+nZUrtlvxwKOKkyyNTvMTQuwErReX+px4w2OcZ8JDLgCoaIRsgnReQW/5r
    7qANDlsfZDHcW1So4H6XboPIuj/tktjDAizP2c6gcU9e0dWtK3xhPwBxLWCaLCzRLANf9u+CbA9gm/EPZKLhIaiyOl9B+SwsE41u5AxrwNcLUjVnsQADdZAu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Am4ss40yAAAA:8 a=VwQbUJbxAAAA:8 a=a-UNBS3gXmUoaw306sAA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeDWIsR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 04:48:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeDWIsQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 04:48:16 -0400
Date: Mon, 23 Apr 2018 10:48:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk
 is also passed
Message-ID: <20180423084810.GA11893@kroah.com>
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
 <20180423080641.GA20149@kroah.com>
 <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:37:12AM +0200, Michal Simek wrote:
> On 23.4.2018 10:06, Greg Kroah-Hartman wrote:
> > On Tue, Apr 10, 2018 at 03:33:30PM +0200, Michal Simek wrote:
> >> Baudrate calculation depends on requested baudrate and uart clock.
> >> This patch is checking that uartclk is also passed.
> >>
> >> The same logic is used 8250_early.c/init_port function.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >>  drivers/tty/serial/xilinx_uartps.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> >> index b9b2bc76bcac..a654cda203c7 100644
> >> --- a/drivers/tty/serial/xilinx_uartps.c
> >> +++ b/drivers/tty/serial/xilinx_uartps.c
> >> @@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
> >>  	/* only set baud if specified on command line - otherwise
> >>  	 * assume it has been initialized by a boot loader.
> >>  	 */
> >> -	if (device->baud) {
> >> +	if (port->uartclk && device->baud) {
> >>  		u32 cd = 0, bdiv = 0;
> >>  		u32 mr;
> >>  		int div8;
> >> -- 
> >> 1.9.1
> > 
> > This patch conflicts with the previous patch you sent: Subject: [PATCH]
> > serial: xuartps: Fix the early_console junk character issue
> > 
> > So, which one should I apply?
> > 
> > I've dropped both from my review queue now, please resend the one(s) you
> > want applied, in a patch series if needed.
> 
> First of all thanks for dropping. I forget that I have sent it in past.
> 
> Both patches are targeting the same problem. The first one is more
> destructive.
> 
> And this one is what 8250 is doing.
> 
> I have also sent
> "[PATCH] earlycon: Initialize port->uartclk based on clock-frequency
> property" which is filling uartclk based on DT to do proper divider
> calculation.
> 
> It means when patch above is applied we can keep divider calculation in
> the driver because it is using right values. If not we need to remove
> that baudrate calculation because it is not correct (uartclk is
> hardcoded to BASE_BAUD * 16 in of_setup_earlycon).
> And it is really a question if "port->uartclk = BASE_BAUD * 16" should
> be in of_setup_earlycon.

Ok, but what should I do here?  My patch queue for serial drivers is now
empty, so if you didn't get an automated email saying your patch was
applied, please resend what you think needs to be applied.

thanks,

greg k-h
