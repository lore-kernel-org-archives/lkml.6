Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4136612-1521107850-2-9320894598805459889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521107849; b=Q6BgSG3sn2KhLrIkQMQ3ycgZg7W5yqBax5PzINCTXxEL15r
    WIH35Ly8VaPFsRo1cGX2zUdwW5W6yqGG2jnfraF5L6hWGO9fV1FyE2ayDpSY3O9D
    KjHq5byBfT1ob0Fug5fGlVQst7im4CBzMAz1g1T1OXDpOiAcckv42w1tjo9mSg23
    TWYiVR/OAtbmSzuzx/Bc4kyCkVkLAzMr7Ubm0Gbi1gjMKMhSd5Lyd0gbD2Ve5Mbr
    1IfykfnXAyJe4cmKdbfawBmiIrkgLW0wJulCK3Kl1egPArVLVdk2FjonW1jcqUbS
    XCbMLNPrfgtdPRD+KZRDxxXcROubbteJPNM5ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521107849; bh=mJACmDm5QPr4S5tUjyJ5J922fCv5wwa00yigD6/0VZQ=; b=T
    9FYIRZpAb+Fyye/0Cz87wsxr/XSbHdeffZkhAZ1TKcrnV4oeD5MjGkANN8WTL76/
    mYcFjTPbqwKSNKGTUACOS0XQJxGb/lox1reLJhzgosvj9lFXQ5FnnwtXM+tTbiAT
    bv8ESsoAgU/Ft2Yo8bqVdgfc0xD1QW09eIci+FLWR5YU92UT9XT9mokcxphrntqW
    eNe7Lx8DJHt2+9WmK3+TCkbGFAtxKjogjeHjlXY6bpYcnPSUkQi04Aa3JFlG/pMd
    qLaMjT/TqnbcA/rZ7hWBtUtqax7KpOvAt1DT0qs9UQikU55A9bsFZ3uFuE1wNrIr
    w5h+lYdTvkp3IVhc3UN9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=skidata.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=skidata.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=skidata.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=skidata.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCOJ5Q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 05:57:16 -0400
Received: from mail1.skidata.com ([91.230.2.99]:33709 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeCOJ5O (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 05:57:14 -0400
X-IronPort-AV: E=Sophos;i="5.48,310,1517871600";
   d="scan'208";a="9232732"
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
To: Oliver Neukum <oneukum@suse.com>, Richard Leitner <dev@g0hl1n.net>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC: <bhelgaas@google.com>, <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net> <1521029854.4511.12.camel@suse.com>
 <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
 <1521041253.4511.16.camel@suse.com>
 <377fb9d5-1cc9-7ab8-c965-2fb0a4dc20f3@skidata.com>
 <1521105992.18237.2.camel@suse.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <c9d8b3e5-46d7-dfa2-e053-8589a6a19189@skidata.com>
Date: Thu, 15 Mar 2018 10:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521105992.18237.2.camel@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 03/15/2018 10:26 AM, Oliver Neukum wrote:
> Am Mittwoch, den 14.03.2018, 16:44 +0100 schrieb Richard Leitner:
>> On 03/14/2018 04:27 PM, Oliver Neukum wrote:
>>> Am Mittwoch, den 14.03.2018, 14:31 +0100 schrieb Richard Leitner:
>>>>
>>> Well, but it does not. Removing a redundant definition is a clear
>>> benefit. But you are not removing a definition. You are introducing
>>> a preprocessor constant. Why?
>>> What is its benefit?
>>
>> AFAIK pci_ids.h collects PCI vendor and device IDs in one single 
>> point. As the PCI vendor ID of Netlogic is used in multiple files
>> IMHO it would be a good idea to add it to pci_ids.h and furthermore
>> remove it from arch/mips/include/asm/netlogic/xlp-hal/iomap.h (where
>> it's currently defined).
>>
>> Or am I getting things wrong?
> 
> I think so, yes. We are giving names to constants as a form
> of comment or to change them at multiple places at once and
> consistently.
> 
> So
> 
> #define XYZ_NETDEV_RESET_RETRIES	2
> 
> makes clearly sense. So does
> 
> #define XYZ_MAGIC_VALUE1	0xab4e
> 
> because it tells you that you have a magic value.
> But you will never redefine a PCI vendor ID. In fact you
> must not. And if you have a comparison like
> 
> dev->vID == 0x1234
> 
> if you change this to
> 
> dev->vID == SOME_VENDOR_ID
> 
> what good does this to you? You already knew it was a vendor ID.
> Now you can name it at a glance. So what? If you have a device
> you will have to check whether you have some OEM version. You
> will always go and check the raw number. And if you have a log
> and need to check whether the check will be true, you will have
> a number.
> Using a constant there is nothing but trouble. Yet one more grep.

Thank you for that explanation. But IMHO it was clearer with a
human-readable name in such comparisons...

For example in the following I see at the first glance which
device from which vendor is affected and I don't need any
additional comments or ID databases...
       if (pdev->vendor == PCI_VENDOR_ID_TI &&
           pdev->device == PCI_DEVICE_ID_TI_TUSB73X0)

...but if that's not the preferred way of doing things I'm
perfectly fine with that.

Furthermore to me it sounds you are saying that the complete
pci_ids.h should be thrown over-board?!?

regards;richard.l

