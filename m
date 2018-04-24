Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3069549-1524575746-2-9239932206783484281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524575743; b=aHqGb+LQOCMeAi0xmwK2KOCRPsnb2PYc8VbO6vQhqYiCKJOJOO
    hVBVtE49aexTms6qtT1swPD8YXHRn4fCSN5RD0oHjAUNwn2KCtJs/Whd2BPx6+/H
    S3aTMUebk70ZLdtToQMohKIli1rr2FNXdTI86xYOm75BZb/ur4bbDO+670npP95h
    3av7FEoW4dtVOLENne8K3F9RJnUrB+s4pe1f+vUpBaTSyOQTUHPeg96RTwN5GNKg
    m5XFONzE/3tE/f6qb+TLNmryZqqgxPR7S8HTfVDABklIn5WT5r8F0aPpqZYnaeJI
    S4a4MlyU5Rrz4PzXp/XNG4vvU3DNvip6zn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524575743; bh=f8h3h
    Jsbvxa/eBOVrJyzOY4+kmfZxHfd+rYDrWf5QHk=; b=c3qF4yeyoDEbIzSPKlhJA
    n90ai9AoWf9+2VJY9rdOFzDp7/8bv4BieGs2EjRtw60aeX/NIFEYeoTU8/HgcL+O
    gkoUd8R4jWJ460lOzNp1rWObYGFPYQcKwxcvpVUoeea5VFz1JVDhKEnRd7hRulwY
    HlVQaAUxlX6NhZOUtAH/Ummol+YHorkZe1Lx3gztqBIAycPTtnB+1Nub2QZkbxnR
    GbuWs+PI2I8wI3QUyRDbgyB0oM0OVVsRZHiyGah5SW4KF2prwHhs6faFbE1rrf9M
    pTNSzypzwEB1UQ1oLh4vxWLyYVHuYV67WtTtvqfpaf9k37aTQpIvEFNM0wsut86a
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C3Cr/bUE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Xh8inzRR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C3Cr/bUE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Xh8inzRR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDYOQjTsC/hkYmLMEXMsBaINvlEA74kiKSxAiu0Deir9NISWO6VIMal3dwDteXl71gHy5TH/xXj9jlqRr76lZi+HSyVOQSnawJ1VKcIi2RddkmT4SIXH
    nIzFQKGENPMtDUd1IWTjQl7qfQNaTXywI6BPn+sJns9hcl/G1Rxt2txK6xtM7d1JI3QbB9X1KFtd240YjDQbgBJgcv354XmnrcFQVSQaXfBSh/eb5Qsv5Xb/
    qfxjwq1IVavyuodFKcYv1A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=UWLGKgljVrAA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Q8IEYpU5icKUUe0q5IcA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/E0hQXVIthp6brV+8cyzNRqAFF7rEU0boCEPtsAGzDlyw9BuTxkAhq3T7EbbkNWbUuPjzX+w==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vboxvideo: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:26 +0200
Message-Id: <20180424131532.2559-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: devel@driverdev.osuosl.org, Michael Thayer <michael.thayer@oracle.com>,
 Paolo Cretaro <paolocretaro@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Packard <keithp@keithp.com>, Cihangir Akturk <cakturk@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Peter Rosin <peda@axentia.se>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method uses an 'int' for it.

Fix this by using 'enum drm_mode_status' in the driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/vboxvideo/vbox_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index b265fe924..5c7ea2378 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -573,7 +573,7 @@ static int vbox_get_modes(struct drm_connector *connector)
 	return num_modes;
 }
 
-static int vbox_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status vbox_mode_valid(struct drm_connector *connector,
 			   struct drm_display_mode *mode)
 {
 	return MODE_OK;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
