Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4028164-1523371844-2-7804198048749822381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523371843; b=oo0yCm/AezlJcGaod1VjzTM7OwmqwqgxVPn5EETlUArr3gK8gU
    UOExx8TuMeoR/WtM9ETi+FTx4FPSksOiW8NGCdYKTuP7BOfl9Q558X9zydnZYzHm
    E0NH/9O89pS0e2fAw7TimcX4MmRhiaDabf5xkKXuctAN6eneARdXImL8jEIJ/7pk
    frQz7TZouJctpngAWN33XxcxvcLN+SkVeoYDbCbOTzX3AG69FjA5j+W7kiWZuXmf
    AGIeL8a3ra0vIstLBuh/93shfdnQxF8b6ZYyhbgtySakPPGn+SSjjg6EgCT/rG7F
    hvNe58j/AzZiB21MYqSiEgwrn5Cas2UOEAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523371843; bh=aAzt+
    CKH3AVuAyj8Luv6MM0h15YXIX1gBfqPfXvDU1E=; b=ffgsTq5OPJQyg1isuSw/F
    YQpxWzRhvqviRMGUDFMBm8dqgX4k4widLzl0/Mj8yC5Ti9M+6JHduTmXwL6ZZ9i3
    LXxLOH0y90Xrk1G/GQTxuaGwi+flu5KG+SlvrtCc1XwcgQ1vbFQn5QvRfeQq9u/E
    GoaKRPhtF4/cueyfwbEjlJnNNrTQ0wxwZIyEtLTXvskobwtY9rNDb7lOGvmF9IZF
    ScAQNSWQdHpoFTEoCzrMnw89RyPbVICVuJVkbd9jzxD4CFuB/B60RehOhwhHGUFY
    hrCzANLPD3TIr0vUCzRm1avKhr8CkAwW5ZWloineN8Pi8+CChLoTyROG42w5jgxO
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KIokrD5K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o4ra4+UY;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KIokrD5K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o4ra4+UY;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNWkulXxkLvCpKx2lpT/g099G2ebYberT8l64/wQXr4+DLPoV9Qdxb4DLdOlGRJ9Yw+9qZPkrcj7kUknsWOHG66y8FhvQf9WFWLesZhKjVW3ydTQQHjD
    P+3bHY8G44mRaQjJgU5mh8Q6MrTFwjQsG7auTz8dqsKRUSeYNpJsSd+LeC5/Kg3Ikf1ZBJnSdpwSEzwQZGkPkdk/KmS5aNdvUHAdN8NoTKwDAx9EOC/GzIL8
    5sx9lOx4xYZF7QyrX+MHaw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=8JIjIOzEf4AA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=M0ud_3F98hEB2rtAdiIA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/bjCi8OCoKKP9ZcBCCmlN3oyUdAWSVQxH9vJeeZfSVVhKjQ9C7yiPnJDAuXcx3MYaf5oRQ5Q==
From: Eyal Ilsar <edilsar@gmail.com>
To: aditya.shankar@microchip.com, ganesh.krishna@microchip.com,
 gregkh@linuxfoundation.org
Subject: [PATCH] staging: wilc1000: Remove unnecessary braces {} around single
 statement block
Date: Wed, 11 Apr 2018 00:49:55 +1000
Message-Id: <1523371795-5090-1-git-send-email-edilsar@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary braces {} around an 'if' statement block with a single 
statement. Issue found by checkpatch.
Signed-off-by: Eyal Ilsar<edilsar@gmail.com>
---
This is part of my take on the Eudyptula challenge

 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 205304c..325afe1 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -284,9 +284,8 @@ static void remove_network_from_shadow(struct timer_list *unused)
 		}
 	}
 
-	if (last_scanned_cnt != 0) {
+	if (last_scanned_cnt != 0)
 		mod_timer(&hAgingTimer, jiffies + msecs_to_jiffies(AGING_TIME));
-	}
 }
 
 static void clear_duringIP(struct timer_list *unused)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
