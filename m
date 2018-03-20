Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1308309-1521548255-5-12486597565969720756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521548255; b=anWHUyvGYOuSwomYV3uFYPLudcK4ShJJQFa7VWqJhG2RKGw
    VdfHxjUDSZl151GFqV1YFdK+uKHACsIJcOngnayNbQCo0WTEhUAcXliQns3+0Oss
    j6KnayFtOTE1bKIpHjOP0JEmY91qP86z75Uu9T6xG/LFPbhTzSzG4CpdQ3OVBatP
    PFllLTDePGV7Mf+j9iiwhA2b+QGCtd7g/J9c3acLWElxhMHD625+oHvqbYr7zBEI
    N8ChmJk0A2ix7wxfsIupMcHYdzR/Aq07/DJG71gcoxghs74XIBMGaUK1K39VmRh4
    1lwUkyNl2NGAjoQYLkXYbE1klwq8B6CWwXrsytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521548255; bh=j
    2uKNmyyjUBVwfkAS0kLWjcZLuJ3emeGD6DZ+Sg6Cr8=; b=l7laxnbJ4NHiSWyCt
    yAiEWCu7JweL2SUWw3yVQ6WLceE9MWpGD2tyaWsCcDiTWiaffgXZKuvk4Vbn7beI
    izIDP0LYnt2riKMAUN9t6GKZk2bvjnp0RQMdMup44IAxyribMMp+EQRq9tnb3Z0Y
    o2tVqTZQaXiZyi/MZ9DdYyiremTv3WE3ZTl6r/NZPhnBsR44hRVhOQ5Ci/gZ+Fea
    Rgb9O9M5aPU8WhvN0oMqsRh3cCo9JAxLizD9Fd1HbWyWhySqnlVDqaJimutCwPjD
    W7/ZrD1T29CFC2dIGGtQd/WqYFczTnvWkrbDgRg0V5rHFddyUZbfVUX1iOtTTkhD
    Eg6AQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iX4CdoE4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oPtGsoG0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iX4CdoE4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oPtGsoG0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvy/I4lThc/deX4BsB0Ltt855yk0HUN0i0qKpsAJpTEv+f/epoc9RUDz+Bo3RHNUvxVTtckJQ==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com, gregkh@linuxfoundation.org,
 ganesh.krishna@microchip.com, dan.carpenter@oracle.com
Subject: [PATCHv3] staging: wilc1000: replace switch statement by simple if
 condition
Date: Tue, 20 Mar 2018 17:44:49 +0530
Message-Id: <20180320121450.4599-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
 linux-kernel@vger.kernel.org,
 HariPrasath Elango <hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

In this case,there is only a single switch case statement.So replacing
by a simple if condition

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 changes since v3:
	*rebase on latest code
	*missed revision history in v2

 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 9d8d5d0..730d64f 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -776,14 +776,8 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (sme->crypto.n_akm_suites) {
-		switch (sme->crypto.akm_suites[0]) {
-		case WLAN_AKM_SUITE_8021X:
+		if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_8021X)
 			auth_type = IEEE8021;
-			break;
-
-		default:
-			break;
-		}
 	}
 
 	curr_channel = nw_info->ch;
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
