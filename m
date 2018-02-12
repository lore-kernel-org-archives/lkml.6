Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1166103-1518432791-2-11551955472143967685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432791; b=bzIMYOuxbG7r/9r6LYNgmvnjtrOFb08SNWII47o9nf4W43s
    J+XrlLIZQt1tNdrxQj4MtfQGHcfbzoLF2nWnVH90YRFlR1i1IA8EVLOlmeZ8ELzK
    PB6EU3hCJYpFv3KCrNcLVe/pmWRRGKgYBV3vrZG6v1Kg4gynnXCxpDnHvQQwgHQx
    7f23wYcyakU40xy50Kz0YJr8EPQEivF6unCsSrBTJwdYlyX4B1qbJf1E8DObYCqP
    Y7RpS7nDD4q/RkZE8j1hMMoKAY5Q+r7q/WmyMTG3/E6yIcX5vA/1TCYRstBJqVet
    jIXz+WHH96qlF4uMS5Qh7nM4z+vsdEKsBh8r35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432791; bh=s
    TEQ3YGsu9ieaaizFPa+fA/JvcB306w+Kr35g1UK0nQ=; b=sqIrJd09LIKGmWIP0
    XdkrLI3BqYcBqQRDfVhHQYVHxVSsz+ICutZupKuAx/iKeT3nVeQBp+avYPQF9RpY
    uezV0hfj+fBAELNCbw42y6pRNqqsROgbwVq676EgIEUDD6OCVPiI6Tt7HLrAbQaM
    RtO6xqDgSDU4OcVjFEqJ3wXxF8XNAVA2PH/Y9gnHXY1wt9zyYP3X6WtrFMmqbVVk
    o1sOVtsNWcHfxH/9EDnrDsT1NJy2TTt7iHN7C4QeF2Fcug0JNaTynUhFut1dsFYF
    UpjsUDRRThg/eLulDEqFxOwyQBai86bUhUweNdqP19ZNdcyGxsJq578rEqVp3Cpi
    bP2qA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>,
 <sumit.semwal@linaro.org>
Subject: [PATCH v2 6/9] staging: android: ion: Remove dead code in
 ion_page_pool_free
Date: Mon, 12 Feb 2018 18:43:11 +0800
Message-ID: <1518432194-41536-7-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, Yisheng Xie <xieyisheng1@huawei.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ion_page_pool_add will always return 0, however ion_page_pool_free will
call ion_page_pool_free_pages when ion_page_pool_add's return value is
not 0, so it is a dead code which can be removed.

Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 4452e28..150626f 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -79,13 +79,9 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
 {
-	int ret;
-
 	BUG_ON(pool->order != compound_order(page));
 
-	ret = ion_page_pool_add(pool, page);
-	if (ret)
-		ion_page_pool_free_pages(pool, page);
+	ion_page_pool_add(pool, page);
 }
 
 static int ion_page_pool_total(struct ion_page_pool *pool, bool high)
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
