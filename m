Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D59204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8HWRvfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D59204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJHXIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:08:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHXIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9mBzGy029tyhnKrS8HodWd4RQQR/5F2zXrnGrCGTGqA=; b=V8HWRvfgLQA8T9bk9WVyQdYAW
        U0nSX8ZOPfZhl2sQo5iYFRN7zCRniwssdsArVRGDxwhp3G6zUIipwrV1E8fnqBzU3tyqGdW78GV1+
        BdHYSEIzojf6x36RZK65Ib1TODdX1V836FYH+BZ1miTL6nR+ylIBia+XbZEkMMNjxFQ2YyFfA2wg5
        32MB2AOWY0MFwOJCS2F7FeIAadVavuMnE/UliYTIqWXuOY3DETJ/cRkY8dBpEK7akr6cHvGfxuzjn
        0+Yq85aiN+b99YUig1IdC2Sr+rtAd2yNy/bEaGrJqmAYb37DI9zLbHZxXx2XrRX/TgQ7Ycd5yjaXD
        IOOt8WDSA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9Xsv-0001xd-QA; Mon, 08 Oct 2018 15:55:53 +0000
Subject: Re: [PATCH] x86/defconfig: Enable CONFIG_USB_XHCI_HCD
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1810081117030.28294-100000@netrider.rowland.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dbd4eafe-79c5-7f18-5291-2a79eba685a8@infradead.org>
Date:   Mon, 8 Oct 2018 08:55:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1810081117030.28294-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 8:20 AM, Alan Stern wrote:
> On Mon, 8 Oct 2018, Greg Kroah-Hartman wrote:
> 
>> On Mon, Oct 08, 2018 at 12:32:23PM +0200, Adam Borowski wrote:
>>> A spanking new machine I just got has all but one USB ports wired as 3.0.
>>> Booting defconfig resulted in no keyboard or mouse, which was pretty
>>> uncool.  Let's enable that -- USB3 is ubiquitous rather than an oddity.
>>> As 'y' not 'm' -- recovering from initrd problems needs a keyboard.
>>>
>>> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
>>> ---
>>>  arch/x86/configs/x86_64_defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> defconfig for x86 actually still works?  That's amazing in itself :)
>>
>>> diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
>>> index e32fc1f274d8..ac9ae487cfeb 100644
>>> --- a/arch/x86/configs/x86_64_defconfig
>>> +++ b/arch/x86/configs/x86_64_defconfig
>>> @@ -243,6 +243,7 @@ CONFIG_USB_HIDDEV=y
>>>  CONFIG_USB=y
>>>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>>>  CONFIG_USB_MON=y
>>> +CONFIG_USB_XHCI_HCD=y
>>>  CONFIG_USB_EHCI_HCD=y
>>>  CONFIG_USB_EHCI_TT_NEWSCHED=y
>>>  CONFIG_USB_OHCI_HCD=y
>>
>> You can probably turn ehci and ohci off if you have xhci in the
>> "default" system now.
> 
> Heh.  My office PC has both EHCI and xHCI controllers, but it uses xHCI
> _only_ for SuperSpeed devices, and only on some of the ports.  Not a
> combination I have heard of anywhere else.  Enabling xHCI without EHCI
> on that computer would be a bad idea.  :-)

Yeah, I have some mixed HCD usages as well.

-- 
~Randy
