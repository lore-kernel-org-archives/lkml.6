Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519833757-2-744950245132416483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833756; b=r5mBjrl0CKJ3cF9FmYJSAlWmBqpA3o8ByLzWMzjYcEvbBik
    LzQfhy+9Asx4b06TZCyXbxtN+s4tqcL7PKNcXMMYqD65yXYBstiyb0NecjOgIWGK
    MC5vRS0qpIWJbTcae2nVPxXkSzGcNQVgHMCfQL0ORXF+Rqg0M0FXM5MYLLg3wsYO
    VfZ30uHveT1mO7CqsGrHjd+PT5XY01CAbNvEEmQ2sIRSRBcNK2zyuP84ctAuiWBs
    St9M1TNZEVw1MHLqiMdCEFfWCjeV4i2meiv/dRRPgG6iKYOLAL1cxKO9aR95QUtK
    4L7W2FhozD/lmHmLg0N9dC3IgczxBy8zRm9oNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1519833756; bh=4O94G
    +tAVhF3uJVUqYDyQI5JIjy3IoFnUg/W852V3TE=; b=KBdrDjiUzex3uxzZGFnJl
    2pUfKNp1kSOE3DcEj2yXpPYc5tySgNv8zbsFN4+1GY8JbjZgCjp4ttfuK3klchnS
    1B2N9CBQ9MQh0HRnTIgBoil0X4BE0VsqZg+kZZc4+GMbfeAnAhIKvtGo0fATCFDi
    xCU2Q5C/lW8zz063V/xgUwpSxDIjqeSVz38auf3zUBgRzivHNqS6xNfxTawvZQkg
    jtnYcC2gooZtSqVY8H+NrQ/mru1ZId2eyUGif7qfpyDPDm0/NsxZVqMmS8iSZbhb
    eYdTJ5eCiEqI6pR0beDwEociaWcTD+TFr4JIf882BHrDXLPk5+gYxGdX9kh4JRx1
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ihmkm+T5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ihmkm+T5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeB1QBu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:01:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33962 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752828AbeB1QBr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 11:01:47 -0500
X-Google-Smtp-Source: AH8x225Hl3OWCyK9bGo7vz6GEozOqHmrfQG7oj2oEvLVjFfq6GytPAWDnNwnOaZuRyZTvI2PtuPVGQ==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v4] usb: core: Add "quirks" parameter for usbcore
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180228144729.GE20414@bombadil.infradead.org>
Date: Thu, 1 Mar 2018 00:01:40 +0800
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <C206D522-1345-420A-90AD-FCBB4FE129B6@canonical.com>
References: <20180226150457.22299-1-kai.heng.feng@canonical.com>
 <20180228144729.GE20414@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 28 Feb 2018, at 10:47 PM, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 26, 2018 at 11:04:57PM +0800, Kai-Heng Feng wrote:
>> +static char quirks_param[128];
>> +module_param_string(quirks, quirks_param, sizeof(quirks_param), 0644);
>> +MODULE_PARM_DESC(quirks, "Add/modify USB quirks by specifying  
>> quirks=vendorID:productID:quirks");
>> +
>> +static char quirks_param_orig[128];
>
>> +static u32 usb_detect_dynamic_quirks(struct usb_device *udev)
>> +{
>> +	u16 vid = le16_to_cpu(udev->descriptor.idVendor);
>> +	u16 pid = le16_to_cpu(udev->descriptor.idProduct);
>> +	struct quirk_entry *quirk;
>> +
>> +	mutex_lock(&quirk_mutex);
>> +	if (strcmp(quirks_param, quirks_param_orig) != 0) {
>> +		strcpy(quirks_param_orig, quirks_param);
>
> What happens if the user is writing to quirks_param at the same time
> that you memcpy it?
>
> I think you're going about this wrong by trying to use the
> module_param_string machinery.  You should be using module_param_cb()
> to build the quirks list when the user writes it (and then translate
> back into a string when the user wants to read from it.

Thanks! module_param_cb() is exactly what I want.
I’ll use it in next version.

> Also, you won't need to use a linked list for this; you can just allocate
> an array of quirks.
>

I use linked list because the total quirks number is known after the entire  
string gets parsed.
Do you suggest that I should just alloc a predefined number (like 16) quirk  
entries, instead of doing it dynamically?

Kai-Heng
