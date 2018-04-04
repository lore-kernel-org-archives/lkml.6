Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3959850-1522838252-2-8104024878206671667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522838252; b=WrVYX4fe2KeVAqujlnsC6zuCek/QB9Pk0I3/HUV9v+WP4/rVWP
    AIRBd/fcUDz6LqPyRT1mjLieO8PBCiMAns1tLfyYY5FZ9KzjkVBGUFI/QMCCPeUs
    POvFKySMRYz/rE1RG8Qt/RDi7ogSJlENVUrmqgcC88RobZMAgAN3ROEC1FLUCz4r
    HUpk+6LqbGyLuUYL875vsh/zRhhxuHBRdMLf+8ZmXApiYjcCTfmXyGAOytIGCmGc
    2Rx4gdEJmDGcmEQIZ1/8BDnsSU3u25D/aYMz9MRybc5b48oqR9t8bRamhfJUn0NC
    L53adgtW4uEX0WRDvpm49zXiLu06NN2No9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522838252; bh=DxYD5
    LlwOgqLcnKnWfg7Jdq7wwPSlbP9xRSNEQR9V6U=; b=lLTfMBmzVoTpgMhUdiCVv
    V9DO32lKrffVT1x4kNnnz2XYKsGuG8fmWfk0MakK15/7KVXhvSG9PFGbE7wO0+bW
    qlKmhD+QC5No7JB3yFSy0eXdRi76weUkAXL/xbU9PsFTDdLV0XP2N3GiawhNe4GX
    MYACDoeHEPiF4pIAfv0l/fpB+B1JEY7l2UbP55iRp6JWROrj5FonzWLfuqm+fnZM
    KzAju1OvPmpxXU2YJRQWEdEgej+/v3bfUKuDaLyuN+CwME8Pm4N+YtH6xXriRrNK
    du8boYZRMOz2AEt9qfgXQst9gWXt1jjhqZWSx0B1YM7ss01siPR6gVGRFsrNr0qa
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=ffwll.ch header.i=@ffwll.ch header.b=S9+hDo67 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TcSJps1g;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=ffwll.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=ffwll.ch header.i=@ffwll.ch header.b=S9+hDo67 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TcSJps1g;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=ffwll.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInaxIfnGvqz8BsH19hlX24l0qVV8si3aV0jroClEnXPMabf9PGdHG13SBWkPF/RRSQp+p4yfcVtgZ3kxApNneKidgOAdrwFlKX5z7blBW7l57ohDce0
    bTCR6RkdDyzxgbnP+/qnVQctZSYBKDufIRjQg61s3VbvrpudoEhTW1AHZXUl3hdkjSl1cS08hl8m1cBx34thlgS7TmhqhJGDwTr9vzaAKYAjQ/G/DvdYmDy4
    TMUx54qmxVm5aHp+Y5XLIg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
    a=lTbjQzD5AAAA:8 a=e5mUnYsNAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
    a=DDOyTI_5AAAA:8 a=YPFdDlkatZT_ntEAilkA:9 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22 a=w8YF5asEQ23juLwKoPR8:22 a=Vxmtnl_E_bksehYqCbjh:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+zfHItnFlZrzwUu22O0paY0uRYP2CU1izdJIeOfiHMRSp6Ds1pfrRYDbpJfwI3Zi4SVxczkw==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: add dri-devel&linaro-mm for Android ION
Date: Wed,  4 Apr 2018 12:30:37 +0200
Message-Id: <20180404103037.11581-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.16.2
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
Cc: devel@driverdev.osuosl.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Most of the other cross-driver gfx infrastructure (dma_buf, dma_fence)
also gets cross posted to all the relevant gfx/memory lists. Doing the
same for ION means people won't miss relevant patches.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Acked-by: Laura Abbott <labbott@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 555db72d4eb7..d43cdfca3eb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -902,6 +902,8 @@ ANDROID ION DRIVER
 M:	Laura Abbott <labbott@redhat.com>
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 L:	devel@driverdev.osuosl.org
+L:	dri-devel@lists.freedesktop.org
+L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/staging/android/ion
 F:	drivers/staging/android/uapi/ion.h
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
