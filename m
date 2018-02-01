Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3610541-1517489028-2-2053475563270498925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517489028; b=pybtGhxUKyt8BTkpnvdsZAhY/93XuoI5iUDMDKX1aIwyPYR
    QbfhlhCNUwyIhcapn9DZ2AiP+8LpqaMzjmprKvyL3/Oo1HZCXLHvOk7SyzCaokBP
    IuIAk24WcvY6YuNW+ga81htBmo51M69gbjNdjBegD3O2L20UZ9rPlAwx5KvI5Mus
    dKMJutcmf7M76Ji4xGJslAAxd1QBadR8w23mbASYUKmVeCOBjGaEpOjDQzzEpyel
    3Z7RwPPk2i1XPs51uhf3NJinm1PD5wlSSGXIcJ6SqMk7FgAWtNRA094hr/oXtk3b
    GuZt85EFzMuHnujFZ2BeJvhPRjeSVlvKKkapR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517489028; bh=f
    2NZmNle0hz+bYe72iyuNnuPm0PtiZEpl+wpPDv5d7w=; b=qEcJ8SlIGVKfgH9xT
    J4+rjoPkPD7AOs5djdeBaxETho21xCXzmE4nk5J8tYDsQC+3L63C9ptRpslK7yis
    oD2cw9Dhl5S3YVWedfaq/U91TbpgpwDjYdlG/H4znhyUXDTwnLBsQUnVBrfJuXtz
    yOYnRyTadn6tJVU0/Bd+cxRs17olIOtKVcg/aB76vTjQcZ+jIw2MH9oygpYld0N9
    s/E9TBN4DoxAxetfc6i9k3gjdu+pcD3TRRS+OjykSRw3XgwEpiObdQ5Ac+59Pip6
    VRHAZcPMdA8ahAk96mOPCLhfZAdFMNQRv6Pc4lBF6w4CPt2MvtsyYFvQxPCfaFoE
    4wE5A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] staging: android: ion: Remove lable debugfs_done
Date: Thu, 1 Feb 2018 20:34:07 +0800
Message-ID: <1517488447-41252-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
References: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
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
 sumit.semwal@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When failed to create debug_root, we will go on initail other part of
ion, so we can just info this message to user and do not need a lable
to jump.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 3e41644..70a70f5 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -601,12 +601,9 @@ static int ion_device_create(void)
 	}
 
 	idev->debug_root = debugfs_create_dir("ion", NULL);
-	if (!idev->debug_root) {
+	if (!idev->debug_root)
 		pr_err("ion: failed to create debugfs root directory.\n");
-		goto debugfs_done;
-	}
 
-debugfs_done:
 	idev->buffers = RB_ROOT;
 	mutex_init(&idev->buffer_lock);
 	init_rwsem(&idev->lock);
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
