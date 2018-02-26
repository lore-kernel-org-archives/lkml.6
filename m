Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2826656-1519648072-2-15417281115148581243
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519648072; b=GNGoc3eGLwzWsVVtpE8CkiCyiLvuCIPHFvbsuLuiLkASNEt
    ReuM6++wocZpsOEVJ0zGSrfrc8uOze2VRP+HJKGERCkuFROMVeXT5vcxmTAbD0go
    Bog7hiaa5svFAiq47gYVeTCZuFHlxqwqwWfyW6vXv5iaOG1zVPMoSPC7TKZfWSA+
    eXhYhLn5qiakPZNFsR/nEG0rMetkQElJ/6oqROVWFvOlVQye09deWOM8zXW1LEHJ
    e0X4sHxGZnwJsXEPWUcf87/ZLU7mgfJhAiYAtcoawx4l4lwze4WCYFBHIeFp5DPe
    p0uYUqQ5cAkqC858Y6CEhda9PO1dtiaUWJZIstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519648072; bh=CMpPx78HuCarPDsaiB4iAXnypBLRF0YfRpShGjhY3nQ=; b=V
    FrUWgxsnIFBQ81MPMAab6vWjbdq4Nsa7p8iN+L6tgV/5OtDpRISHEkriX1hWOvkB
    1iYkwoYo+U11LdEdOLsLEZqhVWqfmoUxV0zRM9NX9ewi1PuSF9EwH7b0cKqaLj35
    hECEQ/xEaOi6SvDEMnXRZX0bBCjDnNNxHDitF/tAPBXMqFM0Xf3CBvRAuLqjTS8j
    Lfsf3UBDNXuUgvpXRiOiiGI/nItA73Ae9dJtTF5QbxfQOx5mahpMan42UIizTZrX
    +LG3sD25+4p6wawuhXYcRfpVXdk1rh6kNvSsrnYtMa5OL8L0UqO1fOwFB94K1LSm
    DUfrybZLH5uuAcNPrxxkw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeBZM1t (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 07:27:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:12635 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbeBZM1s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 07:27:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="207024855"
Message-ID: <1519648063.10722.185.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
        ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date: Mon, 26 Feb 2018 14:27:43 +0200
In-Reply-To: <1519647669.10722.184.camel@linux.intel.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
         <1519638828.10722.153.camel@linux.intel.com>
         <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
         <1519644517.10722.179.camel@linux.intel.com>
         <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
         <1519647669.10722.184.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-26 at 14:21 +0200, Andy Shevchenko wrote:
> On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:


> >    Device (LPC0.CON0) {
> >      Name (_HID, "HISI1031")

> >      // Name (_CID, "PNP0501") // cannot support PNP


One more question. What is the problem with this CID? Do you have a race
condition in enumeration?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
