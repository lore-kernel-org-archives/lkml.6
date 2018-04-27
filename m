Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839939-2-15487055015809073763
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839939; b=JpAccO1/qnMdLWFNfx7kYSwxB0VplmSFrylFPzeuLu6kmLlM6o
    EVkAw/rJAqRdd+VrVxj7KXzrLjDtbwGKcrZGl8yoxtqEouiVDbs3Lxz6nUbGtXAd
    z1zithogLYF3wyjMjR8Xn8ru9fxF/kFDLPMhjkUKQsICp8fiJbs3PPw7bwbugFmM
    UV4kz5tEKaR8xDKe4OhZ0RvCPAjGvc4reCpCQHKjJoZ6zsOJW/VFSTRiuz/IkTux
    VuHGGswzZZR2aaD7oxhc4RrMtR7PQxyAd9aXUp/XFWir5x3v+tQi7YX/DLoEAWjz
    B3FDf0Tx0zq5+ACb/S7dsa3rGx9vRXpweO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839939; bh=q7hhHXPVuFknG5tYJAYb73DXd4r/bF
    xObo9z09qtTlg=; b=O+ceawU6upncW9e0GMj/Z9P46G4KVyxfdaClyUf6xUAI2q
    KX5GOJ9MkDxW7IkWy4FbVOCrBQ2dEWYMEyZ3+CZXwPo8OdOx9bAzmbjrMPn6+kYC
    c1OYSsq08m6Dd1lw9P/gYxMlmTbzSsLZUU4HxjcRmlueNYVQNIsCwzum+nQyqco7
    wpUc35OqGWwofNp4y8hsiyvKctgv8QxQrWIsCFqbl8UvPgEVEvkD30TrTZQIwqni
    skzMPgOo/2NrwGpSmBcjjzkMn2A7ozk0F1PMA1HLVyMG4a1UTmiHWXQYv9PmCYQ1
    MeQggrI271f0lTBj0+cvKmFzSqBftb5FtkqtWigQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBgCcANEtXewVikHR0P+PFdAXoVUGPilk4V60CYX5dpRnVbaDj1m8suA2xg/RseOkuhKd/fiNhr+43BWhko1rNlihFRoePqaFNgKMXYIXX04ieGe/Frz
    L2vA3E+zPjq5/LCL6bA8ZCqXpPhEvAAiYXlu42g3bGR5/TCWiezo6/WPYHm9/BnGEIIvlUtoANnsdd6e3Kh4VxBJ32CzHc+mUFzvsiJ3iLud0TXzzapl/M24
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=wMNdZWldAAAA:8 a=voM4FWlXAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=ag1SF4gXAAAA:8 a=jC3aBCMyrth2RviaqswA:9
    a=QEXdDO2ut3YA:10 a=o72u2rHnfW5qNJ_4I8LD:22 a=FUarYpL4UH3yWsho8X8J:22
    a=IC2XNlieTeVoXbcui8wp:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934623AbeD0OJK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934621AbeD0OJI (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44644218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Jens Axboe <axboe@kernel.dk>,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.14 72/80] block/swim: Rename macros to avoid inconsistent inverted logic
Date: Fri, 27 Apr 2018 15:59:05 +0200
Message-Id: <20180427135736.636590672@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 56a1c5ee54f69dd767fb61d301883dc919ddc259 upstream.

The Sony drive status bits use active-low logic. The swim_readbit()
function converts that to 'C' logic for readability. Hence, the
sense of the names of the status bit macros should not be inverted.

Mostly they are correct. However, the TWOMEG_DRIVE, MFM_MODE and
TWOMEG_MEDIA macros have inverted sense (like MkLinux). Fix this
inconsistency and make the following patches less confusing.

The same problem affects swim3.c so fix that too.

No functional change.

The FDHD drive status bits are documented in sonydriv.cpp from MAME
and in swimiii.h from MkLinux.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c  |    8 ++++----
 drivers/block/swim3.c |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -110,7 +110,7 @@ struct iwm {
 /* Select values for swim_select and swim_readbit */
 
 #define READ_DATA_0	0x074
-#define TWOMEG_DRIVE	0x075
+#define ONEMEG_DRIVE	0x075
 #define SINGLE_SIDED	0x076
 #define DRIVE_PRESENT	0x077
 #define DISK_IN		0x170
@@ -118,9 +118,9 @@ struct iwm {
 #define TRACK_ZERO	0x172
 #define TACHO		0x173
 #define READ_DATA_1	0x174
-#define MFM_MODE	0x175
+#define GCR_MODE	0x175
 #define SEEK_COMPLETE	0x176
-#define ONEMEG_MEDIA	0x177
+#define TWOMEG_MEDIA	0x177
 
 /* Bits in handshake register */
 
@@ -612,7 +612,7 @@ static void setup_medium(struct floppy_s
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, ONEMEG_MEDIA);
+		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -148,7 +148,7 @@ struct swim3 {
 #define MOTOR_ON	2
 #define RELAX		3	/* also eject in progress */
 #define READ_DATA_0	4
-#define TWOMEG_DRIVE	5
+#define ONEMEG_DRIVE	5
 #define SINGLE_SIDED	6	/* drive or diskette is 4MB type? */
 #define DRIVE_PRESENT	7
 #define DISK_IN		8
@@ -156,9 +156,9 @@ struct swim3 {
 #define TRACK_ZERO	10
 #define TACHO		11
 #define READ_DATA_1	12
-#define MFM_MODE	13
+#define GCR_MODE	13
 #define SEEK_COMPLETE	14
-#define ONEMEG_MEDIA	15
+#define TWOMEG_MEDIA	15
 
 /* Definitions of values used in writing and formatting */
 #define DATA_ESCAPE	0x99
