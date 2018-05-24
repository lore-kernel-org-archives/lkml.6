Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162139-2-18015980329822467381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162139; b=ELdRqUpr1sufrHofaIMGU8zRu8lUIXLrKwLOpVaxkxQB4tg4QQ
    RDFGuTCFRHeOLFcBH5kCmm3boyX7jWtLQ4Y5t/7rta4yTmn3gLvWrLxyprF4REQr
    KjECbBozokZnKV+fmaME2dL7FymPQkxPJ0nxs9JEnxPJV0EViy6y9p3v8XqqBO/z
    KrT04cg4tW4ry0+clNIZgHM6rwFZ8WGy4wzs8xpRaoMQyfHRN7C8YrEBbI3bGEDs
    /6tRgZfRL+oBYRzycDK4+EE18YEHzF82VLTdkyxmbnMDVXNs4FgKBX5wAisvWwzY
    8EMoDOF+w5r41HlyNGhXyCcKI15P3XGDUwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162139; bh=VUqJEGJxozgJ2qCyNrgFwLliKWfswn
    183I5LyIjXnjI=; b=HcjUnK5QibSsWVS71Kgnt4V+XXOeroVxmActJNjYXxO+Qp
    xrDhOPxYEwqKshxErcT8+7eO8Od4We9kwcNkFLmfvI230dTCMnf+Gcv+upY3zysv
    BntnGaOUcTQ80FoiRWiv3J3Mfcop3yJTR0D0EvIDDUZQd2SxCdMxanJ5CtM5aRFn
    Tqg6XQkPso7P9OhZXf7PPSOCUdmaMr6vkvuQhkbmvw+PsDoDUTnsdtsazxY27Msc
    w6sCetMlHOgWlb2L/PZBkQGSMX4xvNPMyQjQkJ/10D1sfrT5JTb6fDRup+d0+lNW
    XncNcogIjGn4YCDGcCRx2xeaAcy1+LDZwtnBkgag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=remQvxvZ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=remQvxvZ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKq2vXR2v6pqOMZlClbaW7Rbjk1NpGrKe+7RJ8UzE9cc9tjL9SxejO9AOp/OGB16Wjeqev2Nn5lHMFIHj5h2W11mGEcxN2OEfmLoKTQ4b2+MIzqpnhoL
    JAWnNhLwn9Kzr6D073xyqY7i/gUxdaUglNvHv6i7dcxhme0kM9sGAXWja+0p6P/U5qOeSicl9h0jqb+7JMB064C6/xHGcX4iH545Vu0abSk0wRrGVSuyNCso
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=N9Og8pMog36rpUuX43cA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967123AbeEXLmE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967232AbeEXJsc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 41/96] usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS
Date: Thu, 24 May 2018 11:38:24 +0200
Message-Id: <20180524093607.887097559@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 946ef68ad4e45aa048a5fb41ce8823ed29da866a ]

Some UDC drivers (like the DWC3) expect that the response to a setup()
request is queued from within the setup function itself so that it is
available as soon as setup() has completed.

Upon receiving a setup request the function fs driver creates an event that
is made available to userspace. And only once userspace has acknowledged
that event the response to the setup request is queued.

So it violates the requirement of those UDC drivers and random failures can
be observed. This is basically a race condition and if userspace is able to
read the event and queue the response fast enough all is good. But if it is
not, for example because other processes are currently scheduled to run,
the USB host that sent the setup request will observe an error.

To avoid this the gadget framework provides the USB_GADGET_DELAYED_STATUS
return code. If a setup() callback returns this value the UDC driver is
aware that response is not yet available and can uses the appropriate
methods to handle this case.

Since in the case of function fs the response will never be available when
the setup() function returns make sure that this status code is used.

This fixed random occasional failures that were previously observed on a
DWC3 based system under high system load.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3239,7 +3239,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return 0;
+	return USB_GADGET_DELAYED_STATUS;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,
