Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3296075-1523346192-2-15168892945427408950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523346192; b=bXqEtr8AkYfETTMrDkgmwFbBLNTNryWncYhX/Pr525EWO/iC3t
    CskME+z3zCwiqBrxurJr1+fRbsAKsgmIxeIux3K1RIm13//nN42jCMLJCx2jXwqS
    UeDQMsVkkdCgVVR7cFe2Oa8+Adw1spVfNrWIqoAIFNv38+BioF1qao6WHyL6ofMM
    HqtBVzguH5QsF1eqtiUNHj0Cezsca+FOEvjibEWYZdFj7AuNnuUxUU+qMo/r0P9T
    QnNQPCAfFR6fSVcj3t5oKGmPg61vPK6JWG1XSclyH4C7Ew9BPiGyjbQOzY2Knr9j
    up8Jz9b9U96kA0BBVkxbWVR9g5WVCxUEqH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523346192;
    bh=nkFyV66SIGCBYGs8u+oWk/ZElxaAjebCVAh8kEbZ+Dc=; b=SrkPxho8OjJb
    o68RaQYoxW5sro0DVcMwV0vXwKuVbrNNLJ8jheKDhYFF43ai+nHJH/NIUJb+//2U
    6Q6uAFtwGf5B75I499Tns0Y3ERgHq9HLQ9qBQEVtrpnAaR3F5WXxOwqqz94y0w7o
    ZmuOr/7T3ympvQ02auqTVhsenLmCZSARXnjEBkVTljNVXZxUQlPwdPdMtyoOOLuI
    a56jNMv9DFQWbbCMkYtAc/67eoiRTvBmwuz2EExuRk3CdNFqvw3ZLnl8kajK8arn
    6a9tzVbM/7cs/1p61051S0j9E335mcynBLlLLaQ6D2f0pWMl/0oZwAYdS4QpC6Zr
    fTpae2mAKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP58a/DX5gKvTYfkj9343qBhTGdQpEjpNV4FGbk5/T8Bm9COirmvFGWd75VdxqS/xC1iChmYKHX1VbVwMFq4uL4lwiUGy3yGfw1tWzxiQimrhv2qpBxA
    vzPxLFDVHMREBAhoY8bFuxk5ECmBWokyi2kUZVdUawRB8kgHfFec83xmlwNeThK48tUsgPSgKAIF4+6/lrrGPXGQqOfjG+oulOUj9E8eXwbz+DKMS35fMCoI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=0CRObFi6RYgMA9mn9C0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeDJHm6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:42:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:57471 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752172AbeDJHm5 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 03:42:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="32180976"
Subject: Re: [PATCH] xhci: Fix USB ports for Dell Inspiron 5775
To: Kai Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20180318151110.15308-1-kai.heng.feng@canonical.com>
 <7DBCE486-BE04-422B-9902-B9403AD85B37@canonical.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <b78a3067-8c7c-811a-2d64-4a23ff6b6250@linux.intel.com>
Date: Tue, 10 Apr 2018 10:46:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7DBCE486-BE04-422B-9902-B9403AD85B37@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10.04.2018 07:56, Kai Heng Feng wrote:
> Hi Matthias,
> 
>> On Mar 18, 2018, at 11:11 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> The Dell Inspiron 5775 is a Raven Ridge. The Enable Slot command timed
>> out when a USB device gets plugged:
>> [ 212.156326] xhci_hcd 0000:03:00.3: Error while assigning device slot ID
>> [ 212.156340] xhci_hcd 0000:03:00.3: Max number of devices this xHCI host supports is 64.
>> [ 212.156348] usb usb2-port3: couldn't allocate usb_device
>>
>> AMD suggests that a delay before xHC suspends can fix the issue.
>>
>> I can confirm it fixes the issue, so use the suspend delay quirk for
>> Raven Ridge's xHC.
> 
> I am hoping this patch can get merged in v4.17...
> 
> Thanks,
> Kai-Heng
> 

Added to queue, sending after rc1

-Mathias
