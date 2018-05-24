Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162032-2-9522312539664208145
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
    1527162031; b=CoZh3A4nOkAQDdvomDuvzXntlweT310JnK2xM0eDJfOqggoOjA
    FpsP1R177Evfhk5yeczO99sNigWNvkBsiMQF2QoARUUZa5t9p1AR7wtdErE34+9S
    6ZeZ+pj3zEU04rgTTAZvJouatnn1hpsKgwg1kNj0gMxigArr9T8vVc02uQyIuUnW
    mWoQHiMHLwwP63sRBVcVeE2qzyZeABm+rvn7S1EPhHMYfAQnawzvfsdveB0ZK3LL
    D3h9i+oTKdkzQPps8AN5+udGMDNtsuyEfksyIygXa0gtE6wIYu4RN1BidJ38605I
    YLVNgohVjZ5nkUwt53DEPcEEN8lN2yXTAjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162031; bh=zHo9V7tam3X+oPb47tCPhUb/tBQhmn
    378JgCY5noqpQ=; b=EbzC3OUrLQxiWhlzM8/dTzC7PKONhdi1KbTOjmmrGPk5Fn
    Tesqm3vzrI5UjuXUQFoHr37oTz5aheS4qtTPU6noz+d3agvcL6GBXtVmCQOTLmvI
    R4A7RW56DYip4M4IghEsg+mdvrnVooAvL3r01TFItwKl+D+p6fSkRVAy3XTGmIgG
    qn8EQM1VE/N5TMs29xRRklDzk+6iSbKIpasOjroZkZtNURlJqyQA1pwXaRMcXPZj
    4XKuKVEOSr7yahyZiEEvK/AxvXrqa/xYAnWcZEZLnWfB8ob5UNxixQXgxbmXhMLJ
    YOqXbzt39d9AB8RrjaEJ1HlE7t05fbxCOjr0EcPA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=b7OH1gAi x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=b7OH1gAi x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFNs4oPFvoDbGQQRYKh9t/mF6t6bEptyRyFTiEns576kHwlbJDBz8Uroy4nnKaa0+hQKydMlC0WCarxraJDOKL+bWk/uNFE2QUYwRhKLf9v49b7boPP3
    sVHvQ0eiAlT/s7m0mImICurkSvCa18IOAnHJ1Ax++DBBcSyTG8XWa1wsZTd5BCRYigwlFRl6StGaFVq1+Kqx96faZ+h3vDeUD+3fyfAl2k+VsFhWyP6mgpMw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xq3W2uTSAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=VwoBRhHq2TX8QzjGAlQA:9 a=qzdL_S3FjlUl77DU:21 a=DGC3x8MQNSjrJErm:21
    a=QEXdDO2ut3YA:10 a=P5L7wpMTXyg1GfFA3Gwx:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967273AbeEXJst (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966976AbeEXJsq (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 45/96] media: em28xx: USB bulk packet size fix
Date: Thu, 24 May 2018 11:38:28 +0200
Message-Id: <20180524093608.084797265@linuxfoundation.org>
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

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit c7c7e8d7803406daa21e96d00c357de8b77b6764 ]

Hauppauge em28xx bulk devices exhibit continuity errors and corrupted
packets, when run in VMWare virtual machines. Unknown if other
manufacturers bulk models exhibit the same issue. KVM/Qemu is unaffected.

According to documentation the maximum packet multiplier for em28xx in bulk
transfer mode is 256 * 188 bytes. This changes the size of bulk transfers
to maximum supported value and have a bonus beneficial alignment.

Before:

After:

This sets up USB to expect just as many bytes as the em28xx is set to emit.

Successful usage under load afterwards natively and in both VMWare
and KVM/Qemu virtual machines.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Reviewed-by: Michael Ira Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx.h
+++ b/drivers/media/usb/em28xx/em28xx.h
@@ -189,7 +189,7 @@
    USB 2.0 spec says bulk packet size is always 512 bytes
  */
 #define EM28XX_BULK_PACKET_MULTIPLIER 384
-#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 384
+#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 94
 
 #define EM28XX_INTERLACED_DEFAULT 1
 
