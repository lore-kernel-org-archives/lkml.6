Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1530735-1521554573-2-17191950402761915310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521554572; b=nslZ27fDmrUQwTPQDdT8YgQliL0kxtoaC/cWBqUuj8pqMkM
    kF84IrIRVIkCEJtU0FxRq0nW1ul/W5wtzzdbjXlveWXP10A6FY4kbqwrIUUWgKcR
    qwH/4zhAmoJJhfMtnRWcJB8B9Y4eWREu22Xoh+BbOrCJKEfQtRO0VxstRVjCmZUr
    0nnd3zw+SSB5TsY7M+mL4IlrGsml6wNfWYQVheXBOx+pfuhHH+YHca+RKg/Cagq4
    /dr2jRDsWxBQvscL0kij4TVQS7qpVBcMO+rQMxvHyzwNhwAkKcF7Izfy8x0LJ7Kd
    yqe/AqdpMvHBZK1SLtNyg63FJXAhKLNWIaoQt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521554572; bh=o
    VDpHmo2QiF/Y5PwBaKapSylTlMMVOQSZGUot6HKZTA=; b=gM4o6I+s+IDr4U2GB
    Y7W06PusvUcIx7rFH/dxzV55bSbmlZcfJ8GfpiraJ11dx4WUNySM30gP4MS121pg
    Qah6xx5c/qRb8EzynCDiabrgYLSvRoMKfIn/Tp48x0QAWLhZzWwBz3vji5uWtdqP
    l7OZ0sSufJzkms9Zc3IiJK2a8A6/iTfNu5wM53kKdq8c23iO/EHmZCAxMye6do5n
    aWWephQ3hJbQGuvZL3un2e9IplwAPRMiXfPP4UFcXiiU9dkJ/2P1V5Pe9ce8X+y+
    qAw+hLLY705Gksitltz3CTGhc7u9z61QEVBOEmL+6iQqSROyBuE9HCRS7xkbXS2T
    bW3wA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HiY/bzPn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MhSrwrN+;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HiY/bzPn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MhSrwrN+;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsh7zuGx27C3udE+/TR9i5fIi209TSNSjM2zMEd+IbNAM2nt7Go0Z3mil2QIgdeJYcjabxe9w==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: arnaud.patard@rtp-net.org
Subject: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Date: Tue, 20 Mar 2018 19:32:32 +0530
Message-Id: <20180320140232.26096-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320120344.fyhw4iry4xrtxjpu@mwanda>
References: <20180320120344.fyhw4iry4xrtxjpu@mwanda>
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Pratik Jain <pratik.jain0509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Refactored the function `XGIfb_search_refresh_rate` by removing a level
of `if...else` block nesting. Removed unnecessary parantheses.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/xgifb/XGI_main_26.c | 59 +++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 10107de0119a..aee969aab681 100644
--- a/drivers/staging/xgifb/XGI_main_26.c
+++ b/drivers/staging/xgifb/XGI_main_26.c
@@ -544,41 +544,42 @@ static u8 XGIfb_search_refresh_rate(struct xgifb_video_info *xgifb_info,
 	yres = XGIbios_mode[xgifb_info->mode_idx].yres;
 
 	xgifb_info->rate_idx = 0;
-	while ((XGIfb_vrate[i].idx != 0) && (XGIfb_vrate[i].xres <= xres)) {
-		if ((XGIfb_vrate[i].xres == xres) &&
-		    (XGIfb_vrate[i].yres == yres)) {
-			if (XGIfb_vrate[i].refresh == rate) {
+
+	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres <= xres) {
+		/* Skip values with xres or yres less than specified */
+		if ((XGIfb_vrate[i].yres != yres) ||
+		    (XGIfb_vrate[i].xres < xres)) {
+			i++;
+			continue;
+		}
+		if (XGIfb_vrate[i].refresh == rate) {
+			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
+			break;
+		} else if (XGIfb_vrate[i].refresh > rate) {
+			if (XGIfb_vrate[i].refresh - rate <= 3) {
+				pr_debug("Adjusting rate from %d up to %d\n",
+					rate, XGIfb_vrate[i].refresh);
 				xgifb_info->rate_idx = XGIfb_vrate[i].idx;
-				break;
-			} else if (XGIfb_vrate[i].refresh > rate) {
-				if ((XGIfb_vrate[i].refresh - rate) <= 3) {
-					pr_debug("Adjusting rate from %d up to %d\n",
-						 rate, XGIfb_vrate[i].refresh);
-					xgifb_info->rate_idx =
-						XGIfb_vrate[i].idx;
-					xgifb_info->refresh_rate =
-						XGIfb_vrate[i].refresh;
-				} else if (((rate - XGIfb_vrate[i - 1].refresh)
-						<= 2) && (XGIfb_vrate[i].idx
-						!= 1)) {
-					pr_debug("Adjusting rate from %d down to %d\n",
-						 rate,
-						 XGIfb_vrate[i - 1].refresh);
-					xgifb_info->rate_idx =
-						XGIfb_vrate[i - 1].idx;
-					xgifb_info->refresh_rate =
-						XGIfb_vrate[i - 1].refresh;
-				}
-				break;
-			} else if ((rate - XGIfb_vrate[i].refresh) <= 2) {
+				xgifb_info->refresh_rate =
+					XGIfb_vrate[i].refresh;
+			} else if ((i > 0) &&
+				   (rate - XGIfb_vrate[i - 1].refresh <= 2)) {
 				pr_debug("Adjusting rate from %d down to %d\n",
-					 rate, XGIfb_vrate[i].refresh);
-				xgifb_info->rate_idx = XGIfb_vrate[i].idx;
-				break;
+					rate, XGIfb_vrate[i - 1].refresh);
+				xgifb_info->rate_idx = XGIfb_vrate[i - 1].idx;
+				xgifb_info->refresh_rate =
+					XGIfb_vrate[i - 1].refresh;
 			}
+			break;
+		} else if (rate - XGIfb_vrate[i].refresh <= 2) {
+			pr_debug("Adjusting rate from %d down to %d\n",
+				rate, XGIfb_vrate[i].refresh);
+			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
+			break;
 		}
 		i++;
 	}
+
 	if (xgifb_info->rate_idx > 0)
 		return xgifb_info->rate_idx;
 	pr_info("Unsupported rate %d for %dx%d\n",
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
