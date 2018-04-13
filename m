Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-97873-1523643840-2-1864987417085723552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523643839; b=U6+koKHBUmqmjSwlhEentSYbihhrxMRtg4Lav5OjpXRBM8iUQ0
    OvXA6fxsVTmQ4knFNg0wRB0IfPso7XyACq5eBne9CS10XaRLQIf/lCQJdL6bvXs9
    nI5oqR+1bSTOD8ia768ArLVnVEbB+rfDQefivI83xrqTRrdFpzMqDB+rzXgJPDFb
    E0/zz3mQVg4NVq3Ln9TZBjUYb8KyBjStu3TYKs0aBxIscPIkuQ9UE7PjdIy6GUAY
    pwnHaduduaKmaGES3D4iWv4SdoNnwvu/hvEePaqsTKvcwZ19/HhsV7Ko9NkM/hZ3
    4D5enfBJBtbRe4XTPtJkPuidD6K+gezsQ3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523643839; bh=75uRvDXl0sv0RRFpcL3sZZ/wxm/XZi
    SC/rS8VmH3KSY=; b=wMD3OAMekV2ZTEp0fb4enFNL1psgstrZ8sP90G1spOdx2U
    ehtGj+RVEYNyD3FsGcMjFz9j+Sj6IIBDY3k5pqOT29kzY/gOGmlZq9UXw8Lk3OQ8
    LzECddLiW1UpeX3mtlaUyR9lhUHdq4KBong7Pj15J2s6It0Val9P45iJWMDxapFe
    N3t8MFPAUHBnRDKeK4XpQJQMVmybQS5Z8+ubu3pJkb9IvuVIXZBhUSRz8/QaOgIK
    7X+E6FPmNa6jxQV+evIXpft2JipHxlKL3EjI5h/hvYadDjCGSYDeqrdMlbie4C6p
    nfYLR69bc4mcu8eG1jph646XzSVu/Z/Ym66VhP/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=JQU1qfU3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=JQU1qfU3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=JQU1qfU3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=JQU1qfU3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH0XPIz1tgR6LYlrmf9i7Ha99Wmh2NE3hDH2tgwIZOTu0RxjRjygL/2xypyxbN8SfffexPyiaevqvRa4fYGxcUh0+1nlD5r3u6V0Fs9H/E2F28Sylp9Q
    IbeWYW2sMKF3OA6piyCnkf8JW8x+Nd+isTP5uTdqvzDLSm0vuAO/JC4au4VwSwIM/2qW42rAZ7TnbXjFTIdBW8V50LTfsBhQhsTCoP8YaDkosH67WmdFcW5K
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=7_eyI1_GT4GRkRkZ_X4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeDMSXa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 14:23:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeDMSX3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 14:23:29 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2DD260717
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date: Fri, 13 Apr 2018 11:23:23 -0700
From: Jack Pham <jackp@codeaurora.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] usb: dwc3: Add Qualcomm DWC3 glue driver
Message-ID: <20180413182323.GA11810@usblab-sd-06.qualcomm.com>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
 <1523638285-5742-3-git-send-email-mgautam@codeaurora.org>
 <20180413173322.GA30306@usblab-sd-06.qualcomm.com>
 <076ce053-c51d-0a53-507a-faa7481e8dcc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076ce053-c51d-0a53-507a-faa7481e8dcc@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 11:32:04PM +0530, Manu Gautam wrote:
> On 4/13/2018 11:03 PM, Jack Pham wrote:
> > Are the extcon phandles bound to the glue node? I don't see the
> > description in the bindings doc in PATCH 1/3. And if so, would it be
> > a duplicate of the child node's extcon binding? Then again, the
> > alternative would be to grab it directly from the child (i.e.
> > qcom->dwc3->dev.of_node) which I'm not sure is ok to do or not.
> >
> 
> Yes these are bound to glue node. I missed to add it to documentation, will do
> so.

Ok thanks.

> I kept it separate for couple of reasons - one is to not peek too-much into child
> node. Another reason is that doing so allows to have extcon in "peripheral"
> only mode as well (not just drd mode which is the case with dwc3 core).
> It allows to notify h/w when vbus is not there in device mode which IMO is
> right thing to do.

Ah, makes sense. extcon for the child is only needed for dual-role.

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
