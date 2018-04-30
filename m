Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116282-2-3712696876800736764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116281; b=d/FbP/t0VBpt0VYu8RDo1gNCVbWinMJLrgh93E4s24BxGeOAiA
    qVfC9dENfdltFFLoaepy381g+0YkPm8felpInb1D7gH5aYbOV6FwQUrwnFPwT4e9
    VSIT2PjODPczG7Q0tH39L8plKKZo7BuvNthR3K8H1kg0eDflMOCIyM0ufTHQhkGP
    aOaohr5sXcfRlZUyPihZdkeK7emo77vOB0kNrwoFygpfE5EF0o7Xmr7pLjbb1o7N
    x2ohVj5ZQlcnUiXORhfdpn04d1jJuCFjeI31sZt4v17baNbqvFipzPN0cPbmfRiK
    wHFNhRSOFPZSxYSwiuYmJJ4UPPjm417EjNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116281; bh=IVriPagwk7WORQvhoBp/UU3o4vHe5B
    xMVScvSsG4d1s=; b=kSj10ypygSTPeMcLBLOdywaH+Nsj1YyD3VUhAk9MRJ2Q4M
    lXv6yfLqyjwZrHED4mTV2L5eSUrCAUaEPwhNtnLdE2IyJO8q072k5nega3FjZkle
    PU+McrXS77r/ejKc3uC4owb8Nr9ZJ0PRpljC8vCONF9xcUw10CypOR6MC54k6Ddv
    44psgJ5pp58n+uYRWNwnXGcwDOFGd+yVnLSrIu8Fcng0HtJOKDKwMtyzUBq8+KY0
    wYHQvxFzm1dJUrMaoV5tKvkcaX61VhLolACUHLviDYwxXakmCgWg/z3tETfAs1zo
    vY1TY58XzlTuGqmFAVuVCBdoaposZdBaj5pOLN8w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCNJ1IwrhqiFOKk0nvckl/uXubaA4oikMGhMf6F9FqB86ggkNUBDuUaOEejzUPIvIfSUrdDo0PppKjGcYD6QM7heBiuvI1Y6ur6m66UmwkLaSZys6B46
    HTBt/sUUzvxar3gy9xLzK4wN4zp/AxjUo0kg83BJZQlyG5JdR8j4VM8vqKo/HY9JH4QQXTbaBDzfwolmSwBs2aUQVMzDSqnAVsUrkzYDEk8tXz2T4vK8YB8r
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=YsvZ5-EkTph6n4u5spgA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeD3TY2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755214AbeD3TYF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:24:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D333722DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamil Lulko <kamilx.lulko@intel.com>,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 3.18 08/25] usb: core: Add quirk for HP v222w 16GB Mini
Date: Mon, 30 Apr 2018 12:23:15 -0700
Message-Id: <20180430183911.163738386@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamil Lulko <kamilx.lulko@intel.com>

commit 3180dabe08e3653bf0a838553905d88f3773f29c upstream.

Add DELAY_INIT quirk to fix the following problem with HP
v222w 16GB Mini:

usb 1-3: unable to read config index 0 descriptor/start: -110
usb 1-3: can't read configurations, error -110
usb 1-3: can't set config #1, error -110

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -41,6 +41,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* HP v222w 16GB Mini USB Drive */
+	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 
