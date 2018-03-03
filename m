Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055237-5-1818645489048515007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520055237; b=lRJPrZwyxOUyzHBEvNxeS56EAzqzVwybU44eSWo+5e2HpXd
    xM0K17QlGFVvxkZjA+K/E97jH5wRxmn66PhdpMq1IzQs1MN6kMf8AmnFs8mGwfq/
    jgL7JncXsAYYOt+8uxL73S5iaVKQvJGM/CeKeASjiApe7rllcoXdJhO7CnL6/aou
    L5vubNETRispNs+rDi35acRtYvVfkX292sm22+POlBDs2zXFC142BgvVS/mgZ5vT
    EcAMv1+nYdY4kGnY+Zgb3saiyGyc5tNXmIk0Q2FliDOzQlDe4e0AC47D9HwqTJ/O
    8Uc7AovG4oX1OaKfCfoLwofnHZXJL69kFvgW4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055237; bh=y
    i2lzkr6CM9N8K85SWqxN3vlJck94TZAZU9n5fmSw1c=; b=irJ692v3DxAs93Nvr
    5UROpqWfbuOoVOTDIFZP0LHdDkncyxhPTiN9WrLbzj1VeY9KGwpviraJMzhMIPBp
    xa6dbm4QSApmIR7Kd7U/yatcTsTpFJuvgCauY7XQSY4UUGVoue3DJh4DS39chfzy
    Bx0GXaXh0LsgsdR8izDzqKo76bsvUGo3lqmybQTPmkWE//nedJlcWWAIxIqMRK8t
    R/mgiUAel+xo0L1PNxVSVboJxu92WtNFyp4d9PyfxkSaxhfxU97iHFm4CcaIUlxk
    GiXWx5RrPT8527USEMlBorNcj0kzckIGWoocalBrGKy83ypvRpjGObDIbgEFdcdQ
    JxwYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jg1q+kLG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NwJbaHaO;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jg1q+kLG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NwJbaHaO;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtwegsgALx5GtPnEkZ1U82sjpmYnl2Z5fB4nnufRKrFXAbvK9Cjwq6PSaE/5v0r6cQUZKrVZg==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 1/6] staging: rtl8712: Fixed 'tabstop' coding style warning
Date: Sat,  3 Mar 2018 11:02:31 +0530
Message-Id: <1520055156-8388-2-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace a mix of tabs and spaces indentation by tabs only.

Fixed checkpatch warning "Statements should start on a tabstop".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index ae79047..ede99e9 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -161,7 +161,7 @@ struct _adapter {
 	u8	EepromAddressSize;
 	u8	hw_init_completed;
 	struct task_struct *cmdThread;
-	 pid_t evtThread;
+	pid_t evtThread;
 	struct task_struct *xmitThread;
 	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
