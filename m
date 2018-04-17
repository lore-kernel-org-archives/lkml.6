Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1421059-1523955734-2-17228410224310828592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523955734; b=rogAvQYoI/+TFc9hjvZ+GDM40nwbAWbltxM6qVX4u2G3Ubl46G
    x2gtRMGgmV4lJJxEt54bOX94k933LsjUoPRRKi8VvCWRQ1qJ4HTbjufELI/HIPau
    4FWTtwhoLDmAS623mXjJ4u8ENCsTQp1DC2qgapyGuFyOPomVLpsKRrDKjZ4VFA0Y
    uFfgEv1GM2KAucgn2AXhb7r5cAnqR+Vp72/W0nDk3BuSkLUpcDDqbcqDnuVE2DXR
    jLiGZC5OqDqKaDkmtVyOotWcu20qYGf7cGF9DHoI/nsM8GsTyScP5VvOxj1LnIms
    H8ihesYotIuu9qzobu1VVGpqZRqQoS9rbwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523955734;
    bh=LYfhkt0R1tZgjF+jEGlkE9VCfLv4xrgtI8ehiUq95J4=; b=d1ENoxEpPnTb
    38MudcHaUZQ6P4R0+wdZ4TFaX1MtNAmbHk105YagKZLbuB5C5qSI/DqEAy4lrvmr
    /GlG1HUxPE/jLiRzmrJy/ZG8fMSivC3aAX1craKmcogfd7eJvQr3CP22TSY9T5ZP
    3MRP9dbCa54U3MFbKNzmBKpAsi5Cwvkt5HdOyBW72oY4NxOKmX0TxJK1TlKeOF9Y
    h4PM8r0fSXjZ0oRtltZS8WJvgr5zAtx7eiae/O54ikRKKeI/4IFRaxC/G5VwjvXp
    nxmAtiY9n/4ZnQ9kSBT+8BK3TYPaoegwKvfXt64+PL/W1HqlRU0PYU9nbH0r3wCJ
    bTA4NQNrvA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OwuPhmST;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OwuPhmST;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKV4I7J1px+9ppb1JCnsFGowc9liUJiucjlc4FRDMYVlFNLlsUp6eRypeeiesrH3ulC4JGw1LJyElQCPEl4qh0T2XfHhPXkiYG4vd+HE6HeHoA7V4+Tv
    YtqFayqVXlr3ENdqc1RxbzAiVjNg92kUyJuXpC0qe0ybYRicZSgpFGoBn++j13fv2CPnA/+67TJnwJZMIJbiHJMgysZ6tI59TUNK70Dl0dC5c0jUzCBmr93F
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=uNrX_TNRsFcadDqMuJYA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDQJBq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 05:01:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45789 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeDQJBo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 17 Apr 2018 05:01:44 -0400
X-Google-Smtp-Source: AIpwx4+jLyGAQtcDdy0bCKGaqVAK3Iu9MBIRyQREMEzGS/y4OoW2MdvaOcBYsPtzm2Egl2MuIRJ6tQ==
Subject: Re: [PATCH] usb: always build usb/common/ targets; fixes
 extcon-axp288 build error
To: Randy Dunlap <rdunlap@infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
Date: Tue, 17 Apr 2018 11:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 17-04-18 07:14, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> The extcon-axp288 driver selects USB_ROLE_SWITCH, but the USB
> Makefile does not currently build drivers/usb/common/ (where
> USB_ROLE_SWITCH code is) unless USB_COMMON is set, so modify
> the USB Makefile to always descend into drivers/usb/common/
> to build its configured targets.
> 
> Fixes these build errors:
> 
> ERROR: "usb_role_switch_get" [drivers/extcon/extcon-axp288.ko] undefined!
> ERROR: "usb_role_switch_set_role" [drivers/extcon/extcon-axp288.ko] undefined!
> ERROR: "usb_role_switch_get_role" [drivers/extcon/extcon-axp288.ko] undefined!
> ERROR: "usb_role_switch_put" [drivers/extcon/extcon-axp288.ko] undefined!
> 
> An alternative patch would be to select USB_COMMON in the EXTCON_AXP288
> driver Kconfig entry, but this would build more code in
> drivers/usb/common/ than is necessary.

Ah, that variant of fixing this got posted yesterday and I acked that,
but I agree that this version is better.

Greg, what is your take on this fix?

Chanwoo Choi, please wait with merging the fix from yesterday until
we've a decision which fix to use.

Regards,

Hans



> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: linux-usb@vger.kernel.org
> ---
>   drivers/usb/Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-417-rc1.orig/drivers/usb/Makefile
> +++ lnx-417-rc1/drivers/usb/Makefile
> @@ -60,7 +60,7 @@ obj-$(CONFIG_USB_CHIPIDEA)	+= chipidea/
>   obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>   obj-$(CONFIG_USB_GADGET)	+= gadget/
>   
> -obj-$(CONFIG_USB_COMMON)	+= common/
> +obj-y				+= common/
>   
>   obj-$(CONFIG_USBIP_CORE)	+= usbip/
>   
> 
> 
