Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994003-2-1591500491143840302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994002; b=EMQMGqLUn8bh2QGOOwb/edJV1+HosHgY3P458VWxZaWQZqYhvR
    Hoc0VMhwTIIcaPWQOzEp2c3Fdb5Lvs5aiUSJBeN+SibkpSneCxFjUxXsikI76qrj
    qLPIDtlMUrm6MAAV9F0IA+CKirVpudI0AB+jIrKidIOUWG1mh+ExcIkZ7a/nf7D+
    pmaFbmKflKGvBnnNOGcw77lLyDF1XwQ4Rp/JRGN+yBYdaVK4dz+N10exNxoXvEq6
    1VV0ekDytLRDM2uBw5LD6wemfrynOkvIyw9wHlOmD+7vUFJgrcPn6ypFNQD3eYT/
    TLGMcnL6scT0a0WzIzL5ftkx/m7HMYXXNwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525994002; bh=tTKIu
    RL7/JAmV/VGLPVJFda6t1lrwl1dDiIwbgRD/8U=; b=h7jurm6qfOucGHivTcyvM
    IWTrcBcP8otnuhnpmEV3epz40khZ68I8cRR2VJHAh+9mEO/1WsM4sILsTkWvrGL5
    8JLEfEiXuR5f3JIpmTWZunSpyurVQ2UzsN9ncZTGg/5Dv6jL8W2fYMZrh8n5wc+Q
    k49VS4jmUk37JnDGH0yHz9a9eddDQGrxdEqrvs7b8R1gaYv4dMv8a2hkf0zaTmKz
    dN0GhzUpmhCFVanHg3M2pS6E7M4aREPXp4J7uRTXoum2B3A65qmOseQxFrWLfVD9
    AITd8GrTpM97RwtTywixvfSpybHxA0YlUC4+PI/XyS0yxM6g1woggQET0TGjG+hj
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Nga1iJCy x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=fmh72O/F;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Nga1iJCy x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=fmh72O/F;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCLb05LjIICPxitHoyckHo1Vqpu/+Xd58LxCauvN8vcXjrYYcYiVyJ2jjD3vOFaC90U9Eqcx0zkZbNx9pscltXFWJ2OyNWGDeFXt2MF5nk2jhHJhXHbY
    r85d3K2GVn1/i5LgC54MDOEJIYW+6uNuJd263w1G/SdT8TtYBL4s2/nzAPZe5zB9NTQi6P78EacFZOMU9AKdencqfHGOq3T0LQ1VGszytuB2xQBPYWbzWo7T
    y8Q0xm6RLOsyIvu2F6DDfA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=l9Rml2zWq8kA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=FbYjHrOm20jgJ3eHRMkA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZofQ5ZFI9aZckM8rw0j+GvotonHuiPbt78VOyyoKwgpcYTzNT8cCkwueORZx49i11+KiX6SzQ==
From: Stefan Schake <stschake@gmail.com>
To: eric@anholt.net, stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
 linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, dave.stevenson@raspberrypi.org
Subject: [PATCH] staging: bcm2835-camera: Add TODO for removing overlay support
Date: Fri, 11 May 2018 01:12:44 +0200
Message-Id: <1525993965-4317-1-git-send-email-stschake@gmail.com>
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
Cc: Stefan Schake <stschake@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The overlay code is non-functional since it relies on firmware control
of the HVS.

Signed-off-by: Stefan Schake <stschake@gmail.com>
---
Dave, does this match your understanding?

 drivers/staging/vc04_services/bcm2835-camera/TODO | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index 0ab9e88..770fea6 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -32,3 +32,11 @@ We should have VCHI create a platform device once it's initialized,
 and have this driver bind to it, so that we automatically load the
 v4l2 module after VCHI loads.
 
+5) Remove overlay support.
+
+We advertise support for a V4L2 overlay implemented through the
+ril.video_render component. This component is non-functional with an
+upstream kernel since the VC4 DRM driver controls the HVS, not the
+firmware. Once we have dma-buf support, the same functionality with
+improved control can be achieved through the DRM interface. We should
+therefore remove all V4L2 overlay functionality from the driver.
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
