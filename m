Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520576499-2-17092797893133287760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520576498; b=UAwZnwmQqQQuBjfJmiq7kDH2YXahdTmepNI3lZBRMXByft/
    7QqAbtHJmfHq8eFkWiEr7vUY8uCKfBD8x2965h7bky8PgisZM5lUDrDkGwihrIyr
    ewxoKnjhbOx+SWM89EK/Fmye62K8n3EdjRVAaGB1sYyLalanO59LUuce9aCqqZA9
    /FjpcEfa2jjpK3m+D4xEFZxxaQPIyOBHYk3ZXfKNhgROkG4JPFqOv0qlGPGzCRFJ
    wJMoT4aRW0nqmEzmbnwDqKsOoumNIsiAeXdQKEnSgDbSzqYEAqZikFtbF02cHGWv
    gFLO6BSyP5mrJkaaO9i1IW1y6bWoHD7nmqkLMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520576498; bh=1
    B1Fs5fBdlsZVJumOd3wqWYO+qwVowi911x9XcBhvJQ=; b=QfrDVXjOsPUSLFV48
    wW+bsm7Ij+WuXNAhOaTFIex97r2aqHFLUA/jdOs5MNiWebC3n/jLC4ZnshItLJy/
    H5zfXwz8e2uHCeR1QE9/zJ52bPNj2DpCHtvIhM9dyQg2hUZi5kPl3Y+i5+JduIcI
    ldkDMJImgR+fb08sbeSbTef+AoKE/AYckqxyHc3hpWBfxL55lNItrPCB3J42Tj30
    TY6pPtOjrlO/1jq1Bp5cojTjdsMNe2fT7NZhYKuXb6uqFS3VNYlS0aM9aAK2PLPI
    fYpbWLuhtKlTon8mSLmbWmicps0RvyMbSDt9qn60bvLb8pIxOaadYwWcTI1TUgcB
    CWiGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnKpbick x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=XA1o/XXj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnKpbick x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=XA1o/XXj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:6yeiWpBOpze9JZTtv3vj5ALx8JAOgxyH081BVMxhNIsZSIixYXudTw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] staging: vchiq_arm: Clear VLA warning
Date: Fri,  9 Mar 2018 17:21:10 +1100
Message-Id: <1520576470-20628-1-git-send-email-me@tobin.cc>
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
Cc: Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  The
array here is fixed (declared with a const variable) but it appears
like VLA to the compiler.  We can use a pre-processor define to quiet
the compiler.

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

The name of this constant may need changing, there is already a
pre-processor constant VCHIQ_MAX_SERVICES

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f5cefda49b22..c972869a0333 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -3434,13 +3434,15 @@ vchiq_release_service(VCHIQ_SERVICE_HANDLE_T handle)
 	return ret;
 }
 
+/* Only dump 64 services */
+#define VCHIQ_LOCAL_MAX_SERVICES 64
+
 void
 vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 {
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	int i, j = 0;
-	/* Only dump 64 services */
-	static const int local_max_services = 64;
+
 	/* If there's more than 64 services, only dump ones with
 	 * non-zero counts */
 	int only_nonzero = 0;
@@ -3455,7 +3457,7 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 		int fourcc;
 		int clientid;
 		int use_count;
-	} service_data[local_max_services];
+	} service_data[VCHIQ_LOCAL_MAX_SERVICES];
 
 	if (!arm_state)
 		return;
@@ -3466,10 +3468,10 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 	peer_count = arm_state->peer_use_count;
 	vc_use_count = arm_state->videocore_use_count;
 	active_services = state->unused_service;
-	if (active_services > local_max_services)
+	if (active_services > VCHIQ_LOCAL_MAX_SERVICES)
 		only_nonzero = 1;
 
-	for (i = 0; (i < active_services) && (j < local_max_services); i++) {
+	for (i = 0; (i < active_services) && (j < VCHIQ_LOCAL_MAX_SERVICES); i++) {
 		VCHIQ_SERVICE_T *service_ptr = state->services[i];
 
 		if (!service_ptr)
@@ -3499,7 +3501,7 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 		vchiq_log_warning(vchiq_susp_log_level, "Too many active "
 			"services (%d).  Only dumping up to first %d services "
 			"with non-zero use-count", active_services,
-			local_max_services);
+			VCHIQ_LOCAL_MAX_SERVICES);
 
 	for (i = 0; i < j; i++) {
 		vchiq_log_warning(vchiq_susp_log_level,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
