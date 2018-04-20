Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222762-1524248587-2-2606990177097755333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248587; b=nZcEzA5UR4dXgZmP+2i3m+a8n47jPB+FDpdk5JeQuQG1lU3/bL
    XDECo/LMHAJrzcvj8qIhWAK9P+BPWn+tg0WiMbo8QiP8NKHxvpVWSM1zqluKnwcO
    yF7AEqmAP42X/hgwR69+v9Jdz6X3b061JMYUvYqZqdc5pdUxgyL2g5l9dibtFv6s
    yeGcQOZu/Ns0OfK7nbmaon0luiJ9hGuLrj/3T3z9pKTdFGQawmY0L8VQxWQiCijL
    qrZw5xiXC4YPRct0FsYou9fVomTW76KtlEV2HS3QK9NsFOPre0664BG7DVl59fn0
    aea6fzk0atQmXNHF2rAyhTiff5ZQ2JGVGOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1524248587; bh=c7TkkEMgl6DCQwPDOO6EZI39TbcqHIMvOoGLySHjfxo=; b=g
    KU/22mRlSNDGVeUvOoXtPZGdRe7VtC8+JSDHCwV5guqvP3oeYoBc1hsrNUMWjKbH
    bNXeKkWWe1GO2ApweoOaFvYTXwArckQ4pZaSqzzs1CslwZ2UXyn3MMMx5w/VRRFR
    rDqpka1JUoihAYsTvXQUxQIYGH2tYpyF4v4ZTPHQH1JmzfQAZpZ60RJm0Elx5PwG
    0mDfWhs8jn9rg7l0wHeO2RkW3cmMn4Ci/y+DJF4rQ7e8byhotYhfrHyprc/lNF9q
    hGQfUtTI8WZFCp7VgljHPAr9d2cgkuwnrKCce8mi7rS0lpNbO/vyu1py9KWUAZGA
    qBKRmu9bBTcHaH2rYSG/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHojeyfWGnfZu0HXt3fhnXGH+VjJfDh8zMJf1Yg07fI1KdhI8lbpHXEahjzhiUNzlQFARJpqEO99+7pbK3wl9Q9nbrnS2mp3dHrox+JJqF0ITvHN1XTI
    W2R0fXoQj1HS7fjHGRfphxpmlaDht0AQSENsVGH53wubjX5Jy6dFHh1JYWwAD8U8up3SCwPqZFDdsSFOXPKwlueeJhUStNuRil6hZlJc2MZh2nlhqSbQ/2P2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=JoGhda2fW756_afSkkoA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeDTSWx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:22:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49790 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753587AbeDTSWw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 20 Apr 2018 14:22:52 -0400
Date: Fri, 20 Apr 2018 14:22:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
cc: gregkh@linuxfoundation.org, <martin.blumenstingl@googlemail.com>,
        <ravisadineni@google.com>, <chunfeng.yun@mediatek.com>,
        <johan@kernel.org>, <arvind.yadav.cs@gmail.com>, <dtor@google.com>,
        <anton.bondarenko.sama@gmail.com>, <f.fainelli@gmail.com>,
        <keescook@chromium.org>, <mathias.nyman@linux.intel.com>,
        <felipe.balbi@linux.intel.com>, <ekorenevsky@gmail.com>,
        <peter.chen@nxp.com>, <joe@perches.com>, <tbroch@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rajatja@google.com>, <bleung@google.com>
Subject: Re: [PATCH V5] USB: Increment wakeup count on remote wakeup.
In-Reply-To: <20180420180821.194380-1-ravisadineni@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1804201422250.1407-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018, Ravi Chandra Sadineni wrote:

> On chromebooks we depend on wakeup count to identify the wakeup source.
> But currently USB devices do not increment the wakeup count when they
> trigger the remote wake. This patch addresses the same.
> 
> Resume condition is reported differently on USB 2.0 and USB 3.0 devices.
> 
> On USB 2.0 devices, a wake capable device, if wake enabled, drives
> resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
> The upstream facing port then sets C_PORT_SUSPEND bit and reports a
> port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
> has resumed before driving the resume signal from the host and
> C_PORT_SUSPEND is set, then the device attached to the given port might
> be the reason for the last system wakeup. Increment the wakeup count for
> the same.
> 
> On USB 3.0 devices, a function may signal that it wants to exit from device
> suspend by sending a Function Wake Device Notification to the host (USB3.0
> spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
> wakeup count.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> 
> V5: Added the description of changes between different versions of patches.
> V4: Moved the wakeup count increment logic to the existing if which is
> safegaurded by hcd_root_hub_lock spinlock.
> V3: Added a gaurd to check if rh_registered is set before accessing
> root_hub pointer.
> V2: Fixed the build failure error due to uninitialized dev pointer.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

