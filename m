Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1103332-1523012979-5-16042314080417054534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523012978; b=VFLDyI34pRzeTof5kguEke5dMgQUQFMA9xKOpV+CE5DOInAgd/
    Xb4AYK/qpaRARusOZECHkmFJUVRn4f7XHixm8R9iQHcwPU62Gg3ALOLgyTI624+P
    7T+PzkadzFYA1mPT9G1f2SiVTfMQXjczsaAiOh2DzjvjTJ+Vaez7nUJd8A0Wvr68
    kfvr3vCjbwPFuxt3Oa41ReFRM0peiDAyYJrqqBFzV2nuP8m6CS2I27SukcdKFI8Z
    UDuIlvYNX7bZFLs+8UW2pGQ79cDxy4WiezyjnM6ueDsMFMnTLEtWLbL0z9B3j+FY
    fkkX5uCnhQk//rtkemrL0Re+WeBby5grTepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:content-type:content-transfer-encoding
    :sender; s=fm2; t=1523012978; bh=s1RMNhfK/Rd8onsKYd82/MGku3wGbw7
    F8aNclO0NmLY=; b=ARyl7iOs/wpWn9t0hjF8TkIZQRNGr8JpTbGO+fpiOsl2FBO
    bFO6hsMwE5pbemkumA1ehWLSNNdmD3onvHNvw7cdBLsdb8fTSn13WSNBK1lEuO6N
    gFQoObPo/W9sbS0V4qIaVVPzYPYGfpEMYk4JEI9JAnAQWu5OjwouNe+gFea7N0hd
    iMeWQypq5sc+xnPEnI6UNC8K83/ILk+w/ZXtP/uc697E74EdYHdzSYeKSZPRCwNi
    Qbg1VbtAZzemfMC6j1QT17it4EAIlyfUOYq/byJtJyPVyxQVvNHITutfb7NcqeCH
    0uq0LGsb20/Aou2g3aRJ1EFyM1DbGvhs6iwyS+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Of2f0Em4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZRX7c6rE;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Of2f0Em4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZRX7c6rE;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHNx3swiMy+IUrpTsdQaWapCUJwiEVXPLzlFiJBmqihT+IJo0f6HeMPGurK+u1ZhFrpWC7TJGM0vff/xVo2rZG0Occ8N50mK7rya8vpQjVyEW+P9Tjd
    osxk2R4jO3sFYyHopz6Oz2Gq9KdlmtaMlMnRbgYDjWQnJw5VeLOcoeLFjBw63b5vQJwkKKh5iy5xCkBoHAgm1y9yxZXEpldP05x0obkzcguObgCXdiBUzP1K
    QOcLKYAB5WCA9cLV5NLNYQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=HEJfwf0tOL4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=K7A12_E0glX_7IQ3QiAA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+03gJ4LNfV7i5OIN/a1otB+T/qcUf4gjwUXzMXYAMkwkNk4+aj9Q+o7InwZ8pxn8Ra+DFPEQ==
Date: Fri, 6 Apr 2018 16:39:22 +0530
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
To: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
 elder@kernel.org, greybus-dev@lists.linaro.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: greybus: Fix warning to limit chars per line
Message-ID: <20180406110922.GA14674@stallman>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wrap comment to fix warning "prefer a maximum 75 chars per line"

Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Acked-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Reviewed-by: Mark Greer <mgreer@animalcreek.com>
---
Changes in v2:
    - use correct format for multiline comment
Changes in v3:
    - include commit log
---
 drivers/staging/greybus/audio_codec.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
index a1d5440..4efd8b3 100644
--- a/drivers/staging/greybus/audio_codec.h
+++ b/drivers/staging/greybus/audio_codec.h
@@ -23,7 +23,10 @@ enum {
 	NUM_CODEC_DAIS,
 };
 
-/* device_type should be same as defined in audio.h (Android media layer) */
+/*
+ * device_type should be same as defined in audio.h
+ * (Android media layer)
+ */
 enum {
 	GBAUDIO_DEVICE_NONE                     = 0x0,
 	/* reserved bits */
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
