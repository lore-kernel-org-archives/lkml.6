Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-887406-1521798460-2-9672587794065797220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521798459; b=qYqlmR9Lblf1nRWjBcJSLY6xdjaHVbkXL7z/i76wa88EMgd
    2Sj8r9U0ic+ev5xWDKxoBX86BrTT1dpPIb+jsOT3YkPdWYfDhV+XZ9YpOQTkBG22
    4B43Nisepwfl3BKgFk++mx3PCaM4H+cW2zNMfC8NwNb4Yaan8Y+6D9rZ6/m7QaGb
    pBGm8dJWPgOW/GNFD89B0l1afAyCwd1VqFkAl7UgnO7IMOJPcAOqP7wnNvnxZASj
    M+5dA2DGuiJu2xtpMzAEjhcHzExmHrWsfJ+wIUvH0CMD5XneNrVRL/EJdYtJ14+T
    0Ja5mBR3I8a7jB9uTAGym4blh012o/d1ITaPahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521798459; bh=z
    DXitOF/njrHi9gYvd+6V/yaY4j69p7GTJH4h1rOreA=; b=LentJr1uEc8BWbCIh
    vLS1VGgcEY38lm5anlYJed272ChP6QR8xYFWS2shj5rPKYD/783/EIyBxvr++2Y0
    ilGdAZhE0xGIbRTYxDS7PlgbELRQfXE0KLc1wOpH9x+77SahxQDlvVu8p+uZJD8M
    9bBUaoPEPadmsQECEJ9rOQwyP37LtceJ6DZbobUQ6+D94P5BT44y67G62J35l4mb
    tJPVMAsYHPEuZQKpNn/79jwBrtx4GrPmKsTTScYcuamhYYGGcGVfYJo/CB8S0fm+
    YgGuN5jaCAkxpcdu15oyAu7OZNe5HEtGTyedalipro0t/k4ulQgamOJp/JDu2jfi
    ULnGw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Mar 2018 10:47:25 +0100
Message-Id: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removes TODO for tx_fifo_lock as tx_fifo is modified from
both pi433_tx_thread and pi433_write.

Fixes checkpatch warning:

  CHECK: struct mutex definition without comment

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d1e0ddbc79ce..f6f106a3ff8e 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -87,7 +87,7 @@ struct pi433_device {
 
 	/* tx related values */
 	STRUCT_KFIFO_REC_1(MSG_FIFO_SIZE) tx_fifo;
-	struct mutex		tx_fifo_lock; // TODO: check, whether necessary or obsolete
+	struct mutex		tx_fifo_lock; /* serialize access to tx_fifo */
 	struct task_struct	*tx_task_struct;
 	wait_queue_head_t	tx_wait_queue;
 	u8			free_in_fifo;
@@ -100,7 +100,7 @@ struct pi433_device {
 	u32			rx_bytes_to_drop;
 	u32			rx_bytes_dropped;
 	unsigned int		rx_position;
-	struct mutex		rx_lock;
+	struct mutex		rx_lock; /* serialize read requests */
 	wait_queue_head_t	rx_wait_queue;
 
 	/* fifo wait queue */
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
