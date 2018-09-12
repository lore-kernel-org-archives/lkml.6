Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1AFC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E62120839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="nm7mIkTB";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="hf+xoj8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E62120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeILT6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:58:38 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:9521 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728410AbeILT6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:37 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CETEHT026401
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:32:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=pp;
 bh=o2kPz3lPGRMkYJdn0FQhaBlh9DR6avWRi6RO9EydLSo=;
 b=nm7mIkTBRUGmceCrX+A7HjGfyVjXSvcD/MkASY8J2xIpN6HbXkMEG1c25VH4vvHqKN1s
 GFmrSA/3d9BGW72q2nvqUC0nmBgNlkOlFwqgNYT5TEug4fAXjRZ/oFD9FsC9sA0ZN4WD
 L6t+8/X8qlQwC61G2h/nRvRWYTFXeQTvOd/dVbBoLAC0lttF/P2r0d1oLNjFe2X53Fr7
 c6o4jAkrLCVfmnPuocgO2kbtl0DY4mUBcm3VO+/u+PUf44S/MGkUKmku/4YfwYPh1jBc
 8pA8EGGPdOuUB4wp+czyZ3V1//VEOfAajq1Rrbniz9iZvBE5Tgsha1x9WY3C1+zXbqM7 BA== 
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        by mx07-00252a01.pphosted.com with ESMTP id 2mc3u0j171-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:32:15 +0100
Received: by mail-wr1-f69.google.com with SMTP id 40-v6so1998385wrb.23
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o2kPz3lPGRMkYJdn0FQhaBlh9DR6avWRi6RO9EydLSo=;
        b=hf+xoj8qka6U4bCf67FzlE/3ay7etMYPEiznDzDVqQJEiu5ZW1l7srX9Ny0stvNNvm
         NkBFrprvrt13orRGXQDmzxJGaAxRwJcV3EKZm5kwX936KY/6OTg8vdeyygdODRSC4xGU
         O3QCvpBOvxX2DwQncIdi5Xfvo4InYZVO/dwY2nRsdWH3qlw+Oo5gS+oyLOJm6oWTVWNb
         Gu3Ulh91bdvTUcshjKFuXmKdFbJ0u30KveqCrPjrz5jjZ0FfcNdBb5EVNvyrWPk/WDSM
         8mFVgUvhQTHs3OHAW+AQ7rpc1KQ5X7V9swwPcREfHi96qChr3UIv+AIJsUAwR+mF0s8f
         KdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o2kPz3lPGRMkYJdn0FQhaBlh9DR6avWRi6RO9EydLSo=;
        b=Besvnw36lMb+ri9J6kH2fHqxy5v9BFrgEQVLj636mLgqtRuUN49NbdhDQrVW8F8nFd
         J3HilgQw9KdqaGELs5q8wV5/S52HSKaVzmfBI1mDuM2d38gIjaYXsyyWDtoNIglIvUpW
         p3gcpuQCh1p3pZruCMKVZbfPv/Yfn4A29Zr9/rIYSduq7okLpQNB/mZObpG+iYUHGk5z
         qOqpw5i3r/lAqBz/m0HUOsQFvqFWirKuQZx3x02DCzH4h9OXJTAU41GWfosHtjHXmvXp
         J7Kd9xUrHN+aN/lEewvKXspE4Us6EDbtV8USyedvwa3A6uqRel+qYJ84ZllLwpTIgw1/
         5JSg==
X-Gm-Message-State: APzg51BtFNEW/btKYwVNY1tQYblkwxxk88nzRu5nM8YUoGx3RcmmG9Fi
        wmfTQzuaLYS8mkahSOTgrgdoNN6DlLRTzD+IuFwfHmWuzF/sz5sDIg/HvpfmbtQwZTPhgiLq56y
        H/TJB4nyq0mTrxWB887wOD2UL
X-Received: by 2002:a1c:7dc7:: with SMTP id y190-v6mr1782866wmc.62.1536762734469;
        Wed, 12 Sep 2018 07:32:14 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdZt79oO0SCzRGPO4BpJZPrCC0tMvsvWX/Q4VT0tBV1ndNkRXWkoqy4KODIV/MNHdwwf0hSgeA==
X-Received: by 2002:a1c:7dc7:: with SMTP id y190-v6mr1782846wmc.62.1536762734099;
        Wed, 12 Sep 2018 07:32:14 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:2381:fdf7:14:e45c:95a2:cfa0:31e0])
        by smtp.gmail.com with ESMTPSA id h82-v6sm948217wme.11.2018.09.12.07.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:32:12 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH 1/2] sc16is7xx: Fix for multi-channel stall
Date:   Wed, 12 Sep 2018 15:31:55 +0100
Message-Id: <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC16IS752 is a dual-channel device. The two channels are largely
independent, but the IRQ signals are wired together as an open-drain,
active low signal which will be driven low while either of the
channels requires attention, which can be for significant periods of
time until operations complete and the interrupt can be acknowledged.
In that respect it is should be treated as a true level-sensitive IRQ.

The kernel, however, needs to be able to exit interrupt context in
order to use I2C or SPI to access the device registers (which may
involve sleeping).  Therefore the interrupt needs to be masked out or
paused in some way.

The usual way to manage sleeping from within an interrupt handler
is to use a threaded interrupt handler - a regular interrupt routine
does the minimum amount of work needed to triage the interrupt before
waking the interrupt service thread. If the threaded IRQ is marked as
IRQF_ONESHOT the kernel will automatically mask out the interrupt
until the thread runs to completion. The sc16is7xx driver used to
use a threaded IRQ, but a patch switched to using a kthread_worker
in order to set realtime priorities on the handler thread and for
other optimisations. The end result is non-threaded IRQ that
schedules some work then returns IRQ_HANDLED, making the kernel
think that all IRQ processing has completed.

The work-around to prevent a constant stream of interrupts is to
mark the interrupt as edge-sensitive rather than level-sensitive,
but interpreting an active-low source as a falling-edge source
requires care to prevent a total cessation of interrupts. Whereas
an edge-triggering source will generate a new edge for every interrupt
condition a level-triggering source will keep the signal at the
interrupting level until it no longer requires attention; in other
words, the host won't see another edge until all interrupt conditions
are cleared. It is therefore vital that the interrupt handler does not
exit with an outstanding interrupt condition, otherwise the kernel
will not receive another interrupt unless some other operation causes
the interrupt state on the device to be cleared.

The existing sc16is7xx driver has a very simple interrupt "thread"
(kthread_work job) that processes interrupts on each channel in turn
until there are no more. If both channels are active and the first
channel starts interrupting while the handler for the second channel
is running then it will not be detected and an IRQ stall ensues. This
could be handled easily if there was a shared IRQ status register, or
a convenient way to determine if the IRQ had been deasserted for any
length of time, but both appear to be lacking.

Avoid this problem (or at least make it much less likely to happen)
by reducing the granularity of per-channel interrupt processing
to one condition per iteration, only exiting the overall loop when
both channels are no longer interrupting.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/tty/serial/sc16is7xx.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 243c960..47b4115 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -657,7 +657,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
-static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
+static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	struct uart_port *port = &s->p[portno].port;
 
@@ -666,7 +666,7 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 
 		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
-			break;
+			return false;
 
 		iir &= SC16IS7XX_IIR_ID_MASK;
 
@@ -688,16 +688,23 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 					    port->line, iir);
 			break;
 		}
-	} while (1);
+	} while (0);
+	return true;
 }
 
 static void sc16is7xx_ist(struct kthread_work *ws)
 {
 	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
-	int i;
 
-	for (i = 0; i < s->devtype->nr_uart; ++i)
-		sc16is7xx_port_irq(s, i);
+	while (1) {
+		bool keep_polling = false;
+		int i;
+
+		for (i = 0; i < s->devtype->nr_uart; ++i)
+			keep_polling |= sc16is7xx_port_irq(s, i);
+		if (!keep_polling)
+			break;
+	}
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
-- 
2.7.4

