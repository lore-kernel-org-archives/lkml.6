Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521625867-2-16361790138526727516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521625866; b=ne+bfunJ6W7U5WGAlqf9IQehYcdxB36UOjBpIuaig3kupCn
    xuQhTQmMNLTvfH5Rm+6WQl99KCEc5lx/2uZEjcx+nMqSFJFMkKPY4bPm0YhNxquA
    XWzxX/RVaR6ZYnAyXcCTQrUlFg8QnRjN90ZBvxZ3Z3I3Xsa9QAbP6fRowZSOaNeD
    X/9cJvhV7NSVFQADjqcN3tOBjiTH3CjByRM7xAOlSw86q9F5zk1ASS6QstNSgheG
    +ZtU500DdrgwJ8toXUWMLcFPWy5TMdtfH1quM78KpWLPCJH9NW4JxWzr4k4KZ6J0
    TPkiZi5bB55URp/GEDTzhthkvBWT1dp5zkWiclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521625866; bh=0
    wDxGz7t0VD8ipyvYhSKWkyLllf3IJiDxW8psBXC4LU=; b=G8bmoCIZwM6h4l+iD
    lYUnuExyU7CU3aV7Ho0150OfZGVHLT2d/qXc3P9MrjDai/6rs2plXHjKtIvC+u2W
    FmI2GqL+5HILjFzqgCa3pvUvjufXBQKYJwj9HD3VglHXO/srpYfaueJbNcXEkyfl
    P6Dr2ewZVE6RI9Gn/Qlxd/cH8GdYo8guJ4bC4KegibU0TAp0W+Amg+61RuHFrHz0
    L6yW3q+yGVa2SU1DnPTE5R36STWBkmgD/QzQxOtm51AAlxGP43nj0y5SSJeXoKHi
    8YHgFqN7STZkRWTx2D6/D3Sf+yM9mthVPM6wJUkcm/7bB9O3kgjSAj89mQsWwWcA
    eWD3Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hZJszEBO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J26r4ZfH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hZJszEBO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J26r4ZfH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvjUzav9hb7hXaUSnJcCnR8jDeJbn0xMtZo01JPiPmIVz0j8CknJPTYh50lVyGmbVmouclqXw==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: arnaud.patard@rtp-net.org
Subject: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Date: Wed, 21 Mar 2018 15:20:43 +0530
Message-Id: <20180321095043.16369-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321092458.76v5jujepp2inmov@mwanda>
References: <20180321092458.76v5jujepp2inmov@mwanda>
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
of `if...else` block nesting. Removed unnecessary parantheses. Removed
potential bug of array underflow.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/xgifb/XGI_main_26.c | 59 +++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 10107de0119a..eca0b50f0df6 100644
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
+		    (XGIfb_vrate[i].xres != xres)) {
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
+			} else if ((XGIfb_vrate[i].idx != 1) &&
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
