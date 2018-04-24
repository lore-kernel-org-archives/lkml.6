Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1982094-1524528708-2-10842765846209308641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524528707; b=sYhRaggm8f5s4JsP+EfQzzp97FZ0MQvVW8k2pN+Gsm/zdivkon
    bWHEMhYdVHkJ1Lr9RWe+rQugrHKnBW3p2wOLcrb+BRRAa2Zb45aQ8UON2i/QNLdQ
    /WtF8I0edtx+EqEwHGfr7eM2v0oOqAp2b1FNURW9eKROtRABU0i8CXfo7zLk2LJC
    PcrjaKBy6JoKuWjnzqih3I5iFz0raji33TPPm97xln1sm5wmn2qH457RGxDOJsrL
    pzchoxEnpGDhmw2JpM8bdhKNULv9xDW+icDj7iAkwhO5ymGtIgAEdRUTphvYlwcU
    IHWuV/eKgIGDlKKjQuIaEcjCazMdWMpfcT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524528707;
    bh=nFZqnFFeSCQOf1X8jAckYqrFrT/OcVyDaZExnpcTecY=; b=EgOq++4TXrdH
    r7Ab+c72S1+8sxj4XanjRMHtJEkOIl4akyEQxIThvFAUIveykUNzAMlTNaNKrawx
    YCOlW8CjOUpXsb4BXwZsn0gN3cmT7ouc/belYsNfi+0xVhWvuAc5p1Kid7b7COuG
    ZCVQfFgHtQC7s6cH3b+JX+E1cfvnwK2R4bZ0mBG+UAr3EnI1KUNLQBTOx3s3Tmct
    Vx0ChSxLOrmW0vh4zTARBNOP3BEzqwmAdsua4He8ed5A8QAKx3JSK4OtTHYHVu6c
    tueT2Twllc75zHp+76jk+RcnNakBqailES3sVU0qEuGP+4hlpvKEqI2jX+IR7S3L
    nmQzeIr/jw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Fm+70TqO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=XIR8metf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Fm+70TqO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=XIR8metf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHMQIRvb/OFOmq+pYfFQF0g86tNaX1lVHwUKi9GTRqH1ghfwhE9wXDcks0WgqzRamBoGta/4GDom0r3c+xHqi5ctkbYpAIZ83DcB/oAwpP3EKUFP+sj+
    L2N39aVL68OujRSBnJy0cVzd2HWfMZxE9AMqS+4V/NvTlkhmSj7RTAbajv7DDu/qlQWMWld9eL3p/67W6zDQNTOnpaOcWYBBuGvyLCm8MvE3D1CZigAyoTDs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=23XFzgCW9ElbEluqwq0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeDXALo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 20:11:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeDXALm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 20:11:42 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6687F6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v2 0/2] usb: dwc3: support clocks and resets for DWC3 core
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <31be9c49-7562-1c06-7bf9-bafaea2f1c16@codeaurora.org>
Date: Mon, 23 Apr 2018 17:11:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

HI,


On 4/19/2018 4:03 AM, Masahiro Yamada wrote:
> In the current design of DWC3 driver,
> the DT typically becomes a nested structure like follows:
>
>   dwc3-glue {
>           compatible = "foo,dwc3";
>           ...
>
>           dwc3 {
>                   compatible = "snps,dwc3";
>                   ...
>           };
>   }
>
> The current DWC3 core (drivers/usb/dwc3/core.c) can not handle
> clocks / resets at all.
>
> The only solution we have now, is to put DWC3 core node under
> the glue layer node, then add clocks and resets there.
> Actually, dwc3-of-simple.c exists to handle clocks and resets.
>
> As always for digital circuits, DWC3 core IP itself needs clock input.
> This is specific to this IP.  So, supporting clocks and resets in
> dwc3/core.c makes sense.

Why can't dwc3-of-simple be used with this IP?
Adding core/reset handling in both core and glue drivers might
only add to confusion and I cant think of a reason why having a parent
node representing dwc3-of-simple glue would be any concern.
Or are you planning to remove dwc3-of-simple.c driver?

>
> In this version, the number of clocks (and names) is specific
> to this IP, with clock names taken from Synopsys datasheet.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

