Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393798-3-9999904587202945253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393797; b=UtdQ9M0llVoOxYzhPfd83fj4rGODTNQTgRNF2kwk47emXTGuTp
    rXpaPcXK0X0bGnZEQAsdQnfhO7LJ5XATI1tG0hATrZES06HOfmXNQkia2FcYuVqR
    nmaGamKue6a7c069cSn1DpUFbd8VjjMHIUnpmo4NBfZT0GH9HGfgKZKYfuNYE1El
    eDdfRwe9r81SW34oUH0AQ0D3z5jR5EASHM8jMRmEqUpLSSNObYHQ2+zH2NWiLdVR
    pyelZ+Oc9F2zgM09CvIMEjc4QSgfTJPv148V70mIB6d4vkzQMKAFy2qQP7XXdOr1
    xI1V7wcZZ2qf7S+i3EMAAd7Rom1iiqumFFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393797; bh=2qqGh
    6pFk+TkkVaUVNwvbBgfA8Bs9ZumatW9OJMVJco=; b=SUO+xj3+xsjwyIzuM7mG6
    SIu1R8FsrNbAiswgYGg84NfVAVCqqbGR52rxZSeu+7CybAZw2ehR3TtAg4M3x4ER
    HzsyV2G1Qnf3rosr4kb7IRXGcdriA1Yhe/VW583RFdx8MT6Z1bo/7iyKLs0I6Dbl
    cycY0FM8nf3VkfgaZJ47DcZh3KsuzUKscoLzq4T7C2Pk8EGKlyhs+CbJ+mpDGuQo
    Mk/1Gt28APiqY8HRe0Oa/Lo/lzioMVqdhzs+orb63gWgmdvUFe5SsuIqvymv7vQa
    n73Os7nAT3x3CWFL+t37ebSV0UOmMF/r2I/nqhSCdWhs9ZzoFVI1Y9KnmpvK7m1x
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhXLk7OkFJcGWbeNllc5zx1lDx0+hKO5zZwumkfzMr9QXCbl7qx2IZaLNpBfu9nRjIzyBIMfEPRgFLAmLBD4OK7sa98Gm9mcx0te9XVOkgUla9jAx2d
    gjveo5ia0akEBUTaynHyf9a73NgwxWM4erPoGa/e3+UV/kq29teh/Xz8/zmJO/AXvE92FqsFylekNNv+wAR0vui6OvUVnOpY196+L4Xdxvrii7wqF0SgTRCu
    ZF6zuY07vxobl59kWorAgg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=FngGSo6_b4E7jWwQDzkA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 09/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_value_t'.
Date: Fri, 30 Mar 2018 00:07:32 -0700
Message-Id: <20180330070842.25224-9-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:OqvtITKDaIN+0CnPqRi2cxV+syDSAvafcZ1Jk5InvyNu3Xqn4LW
 tTc0aQIiSn/Htz4xnTmzwvwuQ9R3uCbCBYlKlUVcJNU87L82hjDTeqeXwkRO/qdtxffDbOU
 K4TtrcpmP/FWn2KOiqy5oLsgJOYpRB545luX9kbq7yIDo5gUuIZ5NbZ/iR9dqpk4d5oYdfb
 N39uijRjvdnhPeXB5BGPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WRGuMtRdFeo=:633skQmRtFpwYnO7ihvabQ
 bIbxs+a6GWJb0hTJK1Cln/ZaHvD5dIMP1rdA0dcjQ2qOvyt0/ePZOdXU1Nfebs2cnVeG4OVm9
 mBxZE+NVOYCAsM2orkpYBZ1WBMt+RXLIMrpUGWX5IaBXfcBONgeSfWZJdQKJouMbn/FUqRHbS
 48y7yKhghl/1e749QvnChVSk/5VNESvsCeEAp3klOPWRfMrWPftfOMPZOz+i8aBX28cm6kU/K
 84B6RZlLgpn16SDPiF4J5QvJWHIzz1C0lEZwCxD4l0nQ9GrqaU+5nnSF5MKJgWn4PXPYyLFo+
 c7V1ITz1jypzdQ4169oiAK9YRGcfuk5jNpC7o7D7Qld31g0a6G2w4ecO16t8slWDjAg+kfpr8
 71Xwh85l80pxMYhquWzlgJsdu6Xgp17uL82SY1axPOvkt0KQ6qjhBwblJzksBGRJHOB8K7r1p
 ngyOZhxu0NgS8vJQx1F+dRISukgXWfC3A3gf6qoSJ23whjJlZaOGLSklvD/G4MCXQMD+vFXvW
 D3vafobr1g4gGpf+hLJr+9CLvZxyHWBl9JrfIQ4YEmKTt1wGp1c0WAdkkd2gmR/cpcTsd2LD/
 7HXBcX1wFb8R2YTpuTV4RE7+7CEKWaVJX68PQqkRQJYxdkr9YddMegm7qrmnqVXtZAWm1PniT
 Wr+aEcFo4giUd8neoS37j5xb2gab83O9+x5cbb3XBZGEcx63Gk9HK2FswhSXOICXzJPa4CFhH
 v/TB4kvXWkB2m75wcihcBZopjaAizHQ4xMr2Sw==
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mib_value_t' with 'struct
hostif_mib_value'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 6e39d80c6ee9..bc6ed9d767a2 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -147,7 +147,7 @@ struct hostif_mib_get_request {
 	__le32 mib_attribute;
 } __packed;
 
-struct hostif_mib_value_t {
+struct hostif_mib_value {
 	__le16 size;
 	__le16 type;
 #define MIB_VALUE_TYPE_NULL     0
@@ -166,13 +166,13 @@ struct hostif_mib_get_confirm_t {
 #define MIB_READ_ONLY  2
 #define MIB_WRITE_ONLY 3
 	__le32 mib_attribute;
-	struct hostif_mib_value_t mib_value;
+	struct hostif_mib_value mib_value;
 } __packed;
 
 struct hostif_mib_set_request_t {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
-	struct hostif_mib_value_t mib_value;
+	struct hostif_mib_value mib_value;
 } __packed;
 
 struct hostif_mib_set_confirm_t {
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
