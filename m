Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055236-2-9384624578423800249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520055236; b=wbfOUx9k5akyJ0NoH3qmi3Emj6Y3RapgAPsN/A7Ik6SSRE4
    GxrOBJfgspkvIJZzVsPXAYHBVcanmT2VgzwQ0KjalRsR1cqWaXJiKRg4w7I4mW3G
    iDV2Ekz+PgD4dk9u234gcWVReNDsX5gzSPtNvKDw36qf5jCOFgDijROPMVqKLSQp
    1zv3wpvxQMBwwOacWtbhj/B4X2dCaKSvyyrIeAVvAKFfoJfWrp1MU1ElDRW9A6D7
    Gv+NrMiU3CDfjm11PmX9elmnU4ernQHDEtbXp310s7W8P2H/NtTKCsSeOWUMy9o+
    JmGSqSEhhE0HQfOpCgJCpuzai9yA5u58DpOqO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055236; bh=f
    n7TuNZMl7Vnch4K/32vQDa/TLn0MUAjxMiTuED1kAM=; b=d0IKHoHrJgrPJRROB
    O1D1k1K9FYz6AR/xDZZJQVaEBjJX51iZ+QCrAwSQ5b5CbI1v41cN/svA1wJ1k1zO
    m9hVo6sx9nJHE0hL8QmEkR/Ro98nN+tXOiExIxozczZw0HHyDlSSSc4hyOJZRZh1
    5E++SFO36je05G8EQvb0pPAAT71gokyhslB/l137D2ayDDmG5D9RC5P/G9a2UxER
    jYWxAFtO1UKr7PDXZbshr3iL/Mygvhoa9M8MBC0TfIBWJUrf92Fn8L6SwbKV2bfJ
    t1fj80fuKeUdotNBGOvVGB3O0SCqEQLSHRQY1iTs6kP0YBqsOBmUShlzDpNXNj4y
    k1Gpw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhHnAjh8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SJZqcp4N;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhHnAjh8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SJZqcp4N;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtCm/sY74DVniVzqh8d0ku6UxJFXMKa+CsfhR3W3YBBXaNiX8tZTpHqxcjS/oQvkm/p57DY1g==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 2/6] staging: rtl8712: match alignment with open parenthesis
Date: Sat,  3 Mar 2018 11:02:32 +0530
Message-Id: <1520055156-8388-3-git-send-email-arushisinghal19971997@gmail.com>
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

Delete/Add tabs and spaces to align the code to fix the
checkpatch issue: "CHECK: Alignment should match open parenthesis".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtl8712/mlme_linux.c | 2 +-
 drivers/staging/rtl8712/os_intfs.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index 3c7c4a4..baaa52f 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -36,7 +36,7 @@ static void sitesurvey_ctrl_handler(struct timer_list *t)
 {
 	struct _adapter *adapter =
 		from_timer(adapter, t,
-			mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
+			   mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
 
 	_r8712_sitesurvey_ctrl_handler(adapter);
 	mod_timer(&adapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer,
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index e7df5d7..d6d27da 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -230,7 +230,7 @@ struct net_device *r8712_init_netdev(void)
 static u32 start_drv_threads(struct _adapter *padapter)
 {
 	padapter->cmdThread = kthread_run(r8712_cmd_thread, padapter, "%s",
-			      padapter->pnetdev->name);
+					  padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmdThread))
 		return _FAIL;
 	return _SUCCESS;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
