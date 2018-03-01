Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1971162-1519881628-2-2629564676791465579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519881628; b=wP/v6L1r1FLgGhIemg9021Flrg1rOhosAvfZef2e9jrK6kq
    ynbJR9gggZlpAnMIcwysYRhVVFjhPriPcNUJHorkWkiMM/hVJvLgFh+mPeTaqYwP
    +s955VcexgApIiAlrxjU6/wI8jBVSWJy5jGZHuaO0HiSgu28jJBvmKhuMKKf4iIP
    A1SQqo75mZX54WWq0St0Hq8ESqNlDvZ++izRX6VQOyDfBSADNBOp86VDDXraE+Yf
    r4S4MWOzagPAvuTCThjd23YihcQmyzed/kulpIj09M4ZFSlw1WMbS+zu7syoqoXi
    URh0P+n1uvXQ9cqvm2P2UxL8VoWgB2AYS9Zb4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519881628; bh=3
    j9hdKk8DtiVe5s/z1JoLwL9h3iYOODieEPzazV5Dbg=; b=fNtUw51nOYieCCrVq
    vc+pEAP6m30VjTvfMSah2VSOrvhFxpfutfzEfjSp0+cGyfXnO9yHpp9eXHruitsa
    glnLt/f4GDZNrUSU7JYyZFqNSpyTzcYIdYorFwfEtu3IDN/fTtgpYjCXeruzhalF
    4Y2s5gugdNl5F8IgUC7viDmZowZ56/0VJ12+AEaCi8Fx5UiUMH/EeQt+QRQYYJh6
    Lwqji0ljiC2VYssY04raUvB5OZFQzkiLZBFexKeqthkXP9YJQHph3I7KiE+8FbFr
    rRPvgHDxwOXDEcqxE6D+0+Eomk6Dw5hduuc/EQ+Kb5eUzdt1koVo5/W/hIHUaWs+
    ioTOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 5/5] staging: ks7010: Replace local frame type constants with
 kernel constants.
Date: Wed, 28 Feb 2018 21:19:11 -0800
Message-Id: <20180301051911.1314-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301051911.1314-1-quytelda@tamalin.org>
References: <20180301051911.1314-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:4sRltM6hgsnkOw38Gd3XPIZdbNb0iE8GY1TSG2dBC26lD/rnfly
 ZqTVD1fCTWFUC7tG/EmahYUKHF1KlVHjwaS/YXoxydC7N3dOWXt39C8C1V59qY6dq2JZCdx
 qxNl9+2GGqft7ITRQGpWtSSqtkHNdEUezC266ihCNwT+FRuN1Xv+M+rloWlHwS3DjPhkLTB
 2C/titcolYx8iqOdej0Hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QMvzzCi5HMM=:DjtRcvq5rQn9V0dZG5F45F
 WnXSRe9c6dWFLMSfpApwmEMZLfGjUBK/oQuTaecg6sAk66uRX3XpbOtfmuoie3nLfiiSejbpw
 vaEJTNs07rP/zbqEDtnBelDthSM96x/WlqmDOkC/2vvcBfB6JCGBB6seakXM9GQwiZlaEAY8H
 LFw2VOKAem80ZU/LlwXW4DSeL/cZpTzMxeEMF25Ih9eYx08raj2VtPVFlcm9WjxEb3u7BVhUK
 h/8THIiSD5Ec61Cd9nadqmlXDvVn69bJHk7n4EXqigxd9xrqk2jIq9GUpB/14m7yV53Ti+MJM
 ZefgwZcIeJor+2h7uPwEBHUDjbjhU882hWscyF41vJbPnb741C2ihghcnLanm/+7mj2yj6PEH
 /Q/Omqoc70PSvtX8c4U40E5/nEk7ZQOMjNcPnN9ZtqxcEgij1Tgs4BBDE4s/CuKrZqO54EeWL
 lXzRRrT1uGn2xrnS2dWgEx0OQ2CYKtq19uGBvc9uomcKuddVpZCnCE+fC69Ydm4s3wwYNUk72
 8/jqkSSHR8P4KEhWsUoptaf6/+AK6YRPybo5CXC72tT+urWlP12EBFvtqQEor3jIwYOYbTO1/
 rZQvf8cLX8rdRen/vtsIqRtSjGkh+y3s49MtZAo+Lka5EPwp2ENyuShdFDHDSdNVnfO3rb53D
 H+Ye9qkO9kq93yGbZmysjAKPdB2CEJqjlEEqrp8hdaFnli7n2OJ7eR/QqTzU1Nzl/puUyJYAC
 XzTvsSIiX2pFNQr444oKE5JJFWAlrB13TPxHIQ==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver defined constants FRAME_TYPE_* to represent frame control
field codes; however, these constants are already defined in the header
'linux/ieee80211.h' as  IEEE80211_STYPE_*.  This change removes the locally
defined constants and substitutes the kernel's constants.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index f425975fbcbc..7935ba56bb1d 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -847,7 +847,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 				   priv->aplist.ap[i].bssid, ETH_ALEN) != 0)
 				continue;
 
-			if (ap_info->frame_type == FRAME_TYPE_PROBE_RESP)
+			if (ap_info->frame_type == IEEE80211_STYPE_PROBE_RESP)
 				get_ap_information(priv, ap_info,
 						   &priv->aplist.ap[i]);
 			return;
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 8f08e1e58991..166d83e4885c 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -286,8 +286,6 @@ struct ap_info_t {
 	__le16 capability;	/* +12 */
 	u8 frame_type;	/* +14 */
 	u8 ch_info;	/* +15 */
-#define FRAME_TYPE_BEACON	0x80
-#define FRAME_TYPE_PROBE_RESP	0x50
 	__le16 body_size;	/* +16 */
 	u8 body[1024];	/* +18 */
 	/* +1032 */
@@ -465,8 +463,6 @@ struct last_associate_t {
 
 struct association_request_t {
 	u8 type;
-#define FRAME_TYPE_ASSOC_REQ	0x00
-#define FRAME_TYPE_REASSOC_REQ	0x20
 	u8 pad;
 	__le16 capability;
 	__le16 listen_interval;
@@ -476,8 +472,6 @@ struct association_request_t {
 
 struct association_response_t {
 	u8 type;
-#define FRAME_TYPE_ASSOC_RESP	0x10
-#define FRAME_TYPE_REASSOC_RESP	0x30
 	u8 pad;
 	__le16 capability;
 	__le16 status;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
