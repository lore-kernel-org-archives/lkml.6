Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981368-3-15877563893935368824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981368; b=JHdzVhCiTRPKGRjT/OPXbfNtel0HOYQV/iKkqhAmzW2qj19UZP
    7ugaqFz+J9c7LRvLYcxvBnvJPy9/r/IbWZslMNoBp5drAPmDjGKadS675jlpbb88
    3rGywNvV2WQGCZ7SNC98/Nj5Ln6xaWz3BiVRsraRNTPXSwvSjgqc0kFsO+3FBdXV
    auHF6bMqTDXCIhGc/IWViBgc7TTbcE+SuxbKph/3WeGLTM1YR3K69MQaJKA/wWd7
    r8q8h/IVJ2asvtut1XcDwoSTRcfwU9CyFszM3IJ8/ui35xxnSPGJdGaVzUnGWF0D
    hB0IFsn+CCSDf23xIPRoYVBtw3aJ0k6MSJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981368; bh=GSmLl
    4b0MkBKFFfni5RznILvZ1fVXufI8r3dS5ChagQ=; b=IIl2jLwGewv6K0ADxbm7j
    iOrmZOKtpFoOVcL6HBiVZq4aYF7zjbV9DLFY3CB90FAPM+GiVww+zq61yBOW/RTo
    Ipc+doA2sdTmagxZW0/vGXhSyr9NlBIrey6FNWMu5rcj4Rr3knTZS+uSJj4eiNjD
    TJNWQdSgAyUBas2ID2++Pb728F9xtX8EWOk0REScW8+NGVIicWbVvUN601Not3tZ
    V4PbpJwicQYH/eKNV+wbSlycQvOie4AHeuUP9b/ucjfwR8ttp5o8cc+K8VRtscKT
    Z4SseheiwcOwZgvgTd67RsanaPSLIrFArBLSN/mZ3qlGfASIbP2RQRlapnhWZCys
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPBLSIoPj5nAAsJ9Z7AcUB63Swx8MeYjEbcui+U0tXpmtokZcS4/M8GiUxjOA4v5Cl9DGraVTfOQYrJQbemOKTmo3YjytCX8d4HuahwJ4HQA2JG4eb1O
    gqn9UyRAOBj0EyIbgNs460phPfCwkm3BxSpqjIlrW8SQU9I4fZcv/SIrM7VpJSqOweXulHXhOdO/wfPUl1iZAAi+coF4ghcnVy7PcZixOREZ+jMiRUZdKdnN
    2H7/j4RzCLLnDvgscJNLgg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=rW-rvTo3fQ6n_ti_IpkA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 11/15] staging: bcm2835-camera: Fix comment typos.
Date: Thu, 10 May 2018 12:42:15 -0700
Message-Id: <20180510194220.30675-12-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510194220.30675-1-eric@anholt.net>
References: <20180510194220.30675-1-eric@anholt.net>
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
Cc: Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

Fix a typo flagged by checkpatch, and another in the same line.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-msg-port.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg-port.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg-port.h
index dd4b4ce72081..3b3ed79cadd9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg-port.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg-port.h
@@ -37,7 +37,7 @@ enum mmal_port_type {
  *
  * most elements are informational only, the pointer values for
  * interogation messages are generally provided as additional
- * strucures within the message. When used to set values only teh
+ * structures within the message. When used to set values only the
  * buffer_num, buffer_size and userdata parameters are writable.
  */
 struct mmal_port {
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
