Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3649697-1526438686-2-14384906228519472361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526438685; b=BSrdIvBtt+i39BRwyJbs2NEn3m1yIupvHyHmbTdsrTShis/wjW
    ltYy1V8B1rrXbmmuTVlZMQPJUVMKr73tEaBuuG99Skq0yn5WmHuyLSb4cjcS1b+O
    gRNLte1kO1JUUL8kBC1VOjKG81ANJuTPkupABemFigSRnyJK7qAxJPRYMTXhcWEl
    e721Uknx6hT1HfFCh9Z7d6kvLWaRI6A/RcPg7ARAszeg5uEEyEC+1DIWj078YpZj
    yszNdXlDEMXx+UU/yPbq+1dTO+IzXZORRl+6u4om2wA/9cqiHq4fJNY2K5uQRfht
    VOwbaeCEwAxQ/v7lu1pdIXE4HZdtBqJcuaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526438685; bh=r786GQshiePF3KmPxcAokZIW2MiAUv
    8EVThwwvl0d9A=; b=KVgwxzGeeBgTqjMZ8DeS7jIhgyqy7bkIIFhiH7Rydr0cTD
    OwW6Qygg+2OwlZaOHFlfMMdvg14D7I3tHqlOU9w4ZWQ8oUmpYL88mtkuwQgbkqnt
    2ty8CtINYeohAAGn8LprSXh7Ze97EsVrJky+BhtfoSwtkWpwA1vfPFNt4/0yltNK
    i/PzrVUZ5ZcqF8z8LTOabgd+f18FqdNIqzDMhAjUhYofgUjJw3FohKNtPG3DEdPs
    /aaB9KU/YZ7GpzixjdR4GBWLAodmpXXkolPvT86HJYrysKGsWL/HlxsKxFebf74D
    EvqinEZw9Zs9uRpO+OTzXfyQsCFjRJIelJIrJqnA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=nifty.com header.i=@nifty.com header.b=b3N/8WW6 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=nifty.com header.i=@nifty.com header.b=b3N/8WW6 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEoDaSB5hQ7CJhjIuVKeyRb/A9qQRCPVUxmokTDrXwA5q/tVvJSmibSrXDlFdyyeu3exEh3v4GTaNsJO2k1wD7iyPa9NW8hZlFxDAa/zFrMCIY4cHrUA
    xE1lbB+lje/FQw9EWoW4d6W7YoUfesVNw2zv+JVe0/Kc0DFPZONzdW/Kxu9EJgKzpbmbR8PTnA0Jn23wR1dpD5PJh7k12iZiBl5BL8O90AZb/SA4uSaP1CZf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=clnCjXsyVNKGVevsFwIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEPCoT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 22:44:19 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:39359 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeEPCoS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 22:44:18 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4G2h6c9023234
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/2] usb: dwc3: support clocks and resets for DWC3 core
Date: Wed, 16 May 2018 11:41:05 +0900
Message-Id: <1526438467-12470-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


In the current design of DWC3 driver,
the DT typically becomes a nested structure like follows:

  dwc3-glue {
          compatible = "foo,dwc3";
          ...

          dwc3 {
                  compatible = "snps,dwc3";
                  ...
          };
  }

The current DWC3 core (drivers/usb/dwc3/core.c) can not handle
clocks / resets at all.

The only solution we have now, is to put DWC3 core node under
the glue layer node, then add clocks and resets there.
Actually, dwc3-of-simple.c exists to handle clocks and resets.

As always for digital circuits, DWC3 core IP itself needs clock input.
This is specific to this IP.  So, supporting clocks and resets in
dwc3/core.c makes sense.

In this version, the number of clocks (and names) is specific
to this IP, with clock names taken from Synopsys datasheet.


Masahiro Yamada (2):
  usb: dwc3: use local copy of resource to fix-up register offset
  usb: dwc3: support clocks and resets for DWC3 core

 Documentation/devicetree/bindings/usb/dwc3.txt |  21 +++++
 drivers/usb/dwc3/core.c                        | 118 +++++++++++++++++++------
 drivers/usb/dwc3/core.h                        |   8 ++
 3 files changed, 122 insertions(+), 25 deletions(-)

-- 
2.7.4

