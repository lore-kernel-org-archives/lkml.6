Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1630703-1521031530-2-12403373768346548984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521031529; b=moN+fOre3CbereipZZCjbhcJO25ESxYKOLuNdwSZWHHk37q
    f34iIocuSg+H9ITM6FOQDSJKrJJeehAb9qK/SeZnGCMEWGZsyZ8tJpQE7tVax7UE
    L4ZfacdNK0b5Lw1B0j7XLILs0Arza7Nf4FgC6oVzRCtt3ZpFt+qn6q29z+BJXRp8
    4juOhxMwf5T4KA73Owf/wCzLuY4g7voVMLKEaTiM0vtEMRNPwEWSNO1jL+RdczW6
    xnucwEe6PNxEYmV6bIg7HtxK0qY9VOKFLYWs+6j6+ejiS3jwk6D2lq/t0cbqgS7l
    WlpTfeb5JLmcylAMKFQrsewNBMMO6zEaTsG7yhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521031529; bh=X
    ZGJW//WoNdKmGBdwT88Qb48B+K+YjuTUemGEYj4ciQ=; b=sHjmEZRsqUAALz6qf
    6mrmYXvrEUNa+cYiyJUK3NUKqd3rwLVI0FVXgPhLEHEO5vjiwqJLScz4+G6hTuhd
    xnYwnzGiphVqW33uxxke1u+RwbgRXhPYbS90bXt7VZGr5o4VqEKYWlsk8dHnXwcQ
    CSSrvLUHA1+mfX2U1aSjgA/dGLIqCqz5gFO7j80Ds7EIcdzEJTGJbw4Gb2BdApzB
    SBnr3UCbfEsuOQOZa5x62SXshP5lqafxPuYmzkRcYo73FGHlnxFtRWBSs4KqFkP1
    RFel0Ak69fiMRLTN6wLCmBbOecfzZjO0/t6rJw87VR9aEqIQQ1g6Co6nA6AFmnqA
    VJ4XQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=S+sz/mc5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kGHKXydY;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=S+sz/mc5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kGHKXydY;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Google-Smtp-Source: AG47ELtf8dmgwVZIaj9eY7cQ0fBCgPucqSt/I58caJvR0OSzchvJU9v7AuoXBJIFg6i/5n3NLxF1IQ==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com, gregkh@linuxfoundation.org,
 ganesh.krishna@microchip.com
Subject: [PATCH 1/7] staging: wilc1000: Fix code block alignment
Date: Wed, 14 Mar 2018 18:14:59 +0530
Message-Id: <064c29efeaa5076d2ed441406cdd8eedcf7c01ec.1521030891.git.hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
In-Reply-To: <cover.1521030891.git.hariprasath.elango@gmail.com>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
In-Reply-To: <cover.1521030891.git.hariprasath.elango@gmail.com>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
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
 linux-kernel@vger.kernel.org, hariprasath.elango@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Fix the code alignment for a block of code to adhere to coding
guidelines

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/linux_wlan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index fe19bf3..1af3c14 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -861,10 +861,10 @@ static int wilc_mac_open(struct net_device *ndev)
 			break;
 		}
 	}
-			wilc_get_mac_address(vif, mac_add);
-			netdev_dbg(ndev, "Mac address: %pM\n", mac_add);
-			memcpy(wl->vif[i]->src_addr, mac_add, ETH_ALEN);
 
+	wilc_get_mac_address(vif, mac_add);
+	netdev_dbg(ndev, "Mac address: %pM\n", mac_add);
+	memcpy(wl->vif[i]->src_addr, mac_add, ETH_ALEN);
 	memcpy(ndev->dev_addr, wl->vif[i]->src_addr, ETH_ALEN);
 
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
