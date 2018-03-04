Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2908601-1520178580-2-10135545326170819756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520178580; b=TXlvrb4MvlF8j8bpkzwZQspUV2HSLtO9IEp9zxhVgv2iyK2
    YxWK/i5hMXFiqzN7o127W7yg/4njpkcLfpubRKBxgvXku8YgYl1SEcJ/gJrWdYQ3
    wbUIVAbvarSQ7ZBya4CRToy0RwU1613NJidveoJ2CGO8B0TtKYi0MysylD6UiGWT
    x1xeT0feCmonoLulpM46CYtPVfHqNreATyfjTfj1fqEAd2aBkL99Yx6ziuoeL00w
    3Mzmj1DC6dBKspCRvoO2oRiurdMrbkyvL2Nrtzu/Fss7IiWieAGbWeAO9wGBK140
    5La6E/9ia4KSUz8q0y4zIs9U10Zb4d3UuqbutGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520178580; bh=2
    TMs2LfNsG9mxmq3Q7qg7TeNuvr3oENtFCBVogRhNi4=; b=FqYJ7j5FcU/4zwuOL
    09cQP1djB0+z/IL4vhtb1w0NwhxqjFLPmH59OdYlNO/TTZsDmMbsVH3dTA1NS+mO
    EXpYM+viTe21poYDLpu+Y4WQdhAahEpTnD7sfSUIvdibyQsIgpMnpaiu8BGKoo/b
    2LPfx0oCAlQBlFKsNuqrNnxq8uYAC4hXM1MF5Om9rYc7tSqFA5mYbrctTjSUl3NH
    qabivjdASFKJr27/VK8xyOC5B7K6HJN+rDyWwiXSeIHg64EKNHKfUP7F6IqlKk8/
    aAKHVD86tvYbr0H7/VubCJ0ZoptrQEvqLlA5r/4QHXY/Wgu05ViAeeymx/Eu9TDw
    bjvaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=n2Xcv5nL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XyUB/NSu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=n2Xcv5nL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XyUB/NSu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsfeFJRg7gp6hrs7H0BsLbtLWUT/LqTEL5XMWHOZIEI0qucSFOUdYdzyz3N3VWG58M3p5pr8Q==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: alan@linux.intel.com
Subject: [PATCH 3/3] staging: media: Replace "dont" with "don't"
Date: Sun,  4 Mar 2018 21:18:27 +0530
Message-Id: <1520178507-25141-4-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace "dont" with "don't".
"Dont" is not same as "Do not" or "Don't".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c b/drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c
index e36c2a3..f21075c 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c
@@ -450,7 +450,7 @@ static void mmu_l1_unmap(struct isp_mmu *mmu, phys_addr_t l1_pt,
 			ptr = end;
 		}
 		/*
-		 * use the same L2 page next time, so we dont
+		 * use the same L2 page next time, so we don't
 		 * need to invalidate and free this PT.
 		 */
 		/*      atomisp_set_pte(l1_pt, idx, NULL_PTE); */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
