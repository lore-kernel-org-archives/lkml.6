Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2657151-1518094533-2-2759944477763482534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518094532; b=Lt6ypxBkeDLMVlwN94SNy3K518hM0Vw0iDCF8K0iN19cdAx
    dEEGHLon5WfayW7b1/+Q6ylMZZ9ZQ9gX23KcgvFiyzivW4ak4Vy74GAe2PX70T/Z
    Q26fBHmwjD8omrboroCZovdmsM9aJOUTk3W+cwjd4q4JmQbkdCtpSMVl0tLltMGF
    M/2W7C9AMEXCTHnEP7EYnkR/niKt1w0ZGwX9CFIckXyzkeeFO3nXpyAjUczHiDi8
    AoofjLM5+4f+qlymfH58LqN+Ck0odoXL5xy7bciCQs8+h+/2wfLsH2/Eoh6OcdIy
    5s/QCfF/VSIq+a/vmXZ1YDL++d+9I3TKPjL7P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518094532; bh=mRFfYJycPfrQAucp164pp3mujeLGRFwCVnQyeb5ruK4=; b=c
    kuz8ns+t8UwBr65X/5CRgZB0/BdWHGbfTz4fc7De3GCq3z32qUckUPRmOy3YeK+m
    uG+Ko5P7BdwIavsfw5KuC3zGz78UsPc17G4wtrDBh+Y9meng9Ucc84D+pueX9GjZ
    +lPZ6+KAapAvX9A/Ra21czdE3DaYo+Ff6plEosnjs95yn55Zv7k7PZ+4PS7RXN50
    NlCllczI5jHBQsltVMw2sPzm5CRmHPHrCheDoUoo2jv2T/E0bmqjMlmK9VQxGYvS
    8D6YEvD+dKDy65Q2Yd+UMnPhXIn2feQORi0kRzHjyubp+dZzcsZZpgoM5ryIyfSb
    RflTP3NvH5Cvhox/+PANw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XpHj96ZE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XpHj96ZE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeBHMz3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 07:55:29 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:25225 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHMz2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Feb 2018 07:55:28 -0500
From: Vignesh R <vigneshr@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] 8250_omap: Fix issues with throttling of 8250 port
Date: Thu, 8 Feb 2018 18:25:40 +0530
Message-ID: <20180208125542.15649-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series contains couple of fixes related to throttling of 8250 uart
port when tty buffer is under pressure.


Vignesh R (2):
  serial: 8250: Don't service RX FIFO if interrupts are disabled
  serial: 8250: 8250_omap: Fix throttling when DMA is enabled

 drivers/tty/serial/8250/8250_omap.c | 11 ++++++++++-
 drivers/tty/serial/8250/8250_port.c |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.16.1

