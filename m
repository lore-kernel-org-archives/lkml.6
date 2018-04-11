Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479947-2-2445636047886684280
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
    1523479946; b=WaLxQZz+aSDR15uptA6cqSKh6obF+K59vOdF3JOs+vc0oVaFrT
    vlLhpgG6c8y+WSOkadidg7/OSZsguIKpeGnEvbt+sLV7JduB8hozVYSg8SHzxbsv
    Ywr2uzo15UenAgYFuyiBaUx5pJO8MzhSE5/AtyjMjcFhWORC3hb+wZd384upDGzG
    sgoK8CSYmWzT0bH+3l24vAS4KQ8A+fTXsILXhHb19pjHEpiwT3M9yw88vo4sxqpU
    xkv7vgM8G4cIEKrBI5zS4pM7q8Q/B24B6Qas0hwi0nPa8A3lKBcrI5HDdvValTr/
    Bp26/AnRMGH9DRK8YUQuTz2ifSgsBxNf6sWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479946; bh=GYEJuDRc2R4uYT2FMHsVyBw6Ta6A0k
    +1GFcDzscm3cA=; b=GZxU/7BmUQLaX6FsYE+lB3EGNbUZzHbQRh6Uk8DKoGGsnG
    PpfxuBC+OpOiA/FOxZncWBgf+4tjNb3p1GAgVnLd2okncb0ByHwEN4OznXCLnlmP
    dqvYe57BUnIx80r5P3qIb87ycQzWq8bKj2kT0OPASxm54eqljzzDK7JD67a9qpYo
    GA2MmQovTYeHuhxq/XxQG1gwlCWjjULB1bAOcUjMcKJc6Y+MlmDg/yt592R9sql1
    Vmustd8NOfcGRoL1ClJzgkv7FRffFKJKIt+LvuYgFzvXnhnt8bl4s89nvx5SGbw0
    uhrkfmX89+r53g4iU+RrRnUxLOH0zwmMoZk2OQdg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJBMR3ysa3FJv+ckc9LcIYHV77xnO4ATYh+Ei6naSuqZ6GJ7+shYM2tBZx+pTThKAy4qojssizNdNAjWWKjM1wRQAOSjyBFwX9PxHm+AM5houM3e2NvX
    2BgL/c/Fr+sMnGxcSZh741UuAdrxmK1sa8BX5TXOKs4KOUS1a9y+1V/7A8TD1P5Xm3lPDlc5dEs/vKQHuslJtiQ2yx/5KN2G0xR9Re2t8I1OPtFN6TadHC4f
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=DNk3Sm5b7lNBliq03p4A:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeDKUwI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:52:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755532AbeDKSp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 047/190] serial: 8250: omap: Disable DMA for console UART
Date: Wed, 11 Apr 2018 20:34:53 +0200
Message-Id: <20180411183552.940102947@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>


[ Upstream commit 84b40e3b57eef1417479c00490dd4c9f6e5ffdbc ]

Kernel always writes log messages to console via
serial8250_console_write()->serial8250_console_putchar() which directly
accesses UART_TX register _without_ using DMA.

But, if other processes like systemd using same UART port, then these
writes are handled by a different code flow using 8250_omap driver where
there is provision to use DMA.

It seems that it is possible that both DMA and CPU might simultaneously
put data to UART FIFO and lead to potential loss of data due to FIFO
overflow and weird data corruption. This happens when both kernel
console and userspace tries to write simultaneously to the same UART
port. Therefore, disable DMA on kernel console port to avoid potential
race between CPU and DMA.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -608,6 +608,10 @@ static int omap_8250_startup(struct uart
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
+	/* Disable DMA for console UART */
+	if (uart_console(port))
+		up->dma = NULL;
+
 	if (up->dma) {
 		ret = serial8250_request_dma(up);
 		if (ret) {
