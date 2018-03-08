Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988500-1520514765-2-393783757805717949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520514765; b=DgfC2Qg//D1ekouovCOS+t/hk7qY16jOFVhBE8yAX2vCNH0
    ztE2HYED9653HobEzdef8MKn/6lJFSRyfWeE8NgOQEzLCVlUNdwgadC6Oi2nEABT
    0cxSgX1OZqukNYPXNOSqgokpSZVZ0jC2oEpK8i5jVtH0mMBRQWoa9S+J5RbBO1Cj
    IqHAtOkSyyTBRpejgJ+DLBY/M8fD9TKUpIt5H+g6csK780dW1f9y7f8fKbgD/VKy
    3lGhKPvwdp7Ourw8NXHQfdwCjoyv4oKX262y5ZqtJG2GszlakzBdH5XdJMLrF654
    F72TVYiHqoq3K0o2I2d3LR8JQtW21h2fwaE2GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520514765; bh=XJOakrEsBsPmhQBCm1+rzFaEfcmyY40tfTDMgi+se1s=; b=S
    QligoWxQKD9lYYJjKc5KAiBRISGjFPKBW8MnouUP1ZCFapRAs5P13hC7RPNsb1iK
    1I/KnybGRe+e6hAsXsSDpWRHJ6scdyI+xMNuy/KU5gBRzmWuXFWEHs31TxL/oqPd
    1dHzCS0TL6iTpAMlPqFBiA237iQJZue9D2AYCTUZh0g/MxWzQjVwmxUTCl9RXEpk
    JlradDG5byR7b1O4RnXJdM0+V1KZUDhxPzaIxLRWT8/u26LPdhNN875uNiV1zjSW
    XZm6k7cdeX+xvYd6++4flqtslOnoVsE9L1xY80LmDvKaAYg5iP/6/loIV1SkP2c2
    np+VXjiEL0bD9RoeyucLQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755756AbeCHNLS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:11:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:29743 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbeCHNLS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 08:11:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="23526025"
Subject: Re: [PATCH v2] xhci: Fix front USB ports on ASUS PRIME B350M-A
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180219190621.6632-1-kai.heng.feng@canonical.com>
 <c32af5ea-c8ca-b68b-790e-102c7a8f89f6@linux.intel.com>
 <8579E16A-AA34-4876-9B62-D023B8FC2212@canonical.com>
 <108BCB45-433E-46FE-B8C6-53D2838480F8@canonical.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <352a3f06-f125-b181-8e78-0abf2e80eabe@linux.intel.com>
Date: Thu, 8 Mar 2018 15:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <108BCB45-433E-46FE-B8C6-53D2838480F8@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07.03.2018 08:09, Kai Heng Feng wrote:
> Hi Matthias,
> 
> Do you have any concern about this patch?
> 

Adding patch and sending forward

Thanks
-Mathias
