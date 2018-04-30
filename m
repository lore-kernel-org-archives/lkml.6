Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116394-2-15167110432550638655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES rosk.us-asciien,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116393; b=MNSlintwjFmEZaM7jZ+1WLNf7CmRr+OJY3FRe6pbFPKir7H+ve
    UXu389RptNWMwtxvi42Ish7CiTMKO+KuM6amTQWXRtTtzhFDXG7hIpMunOVawNBT
    MdLevUikn/txmstW6LZ8AM0KTkr+NcPyyZulyLSJTQenWbl9RJvoKfCHAybhNM4H
    +bSOfLPbCjyvcH5gDDXRHYF7dDOnGtZWMUCF3UPwpOlrfDdNA1oQqpWd5Qz7TeJS
    jENMJ4VA1d/29VBE9sHcgpNemq9XhptMFeZXEpmRm3Gq9AfSTrhtvF05mcqGWWgl
    zz9EyO7jbyBmvmNCXIt2cSeBPXrktrELGkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116393; bh=EW2TPUBtaO7XayPYNm+DAcdwZcrE8P
    pa55aCfKFEvbY=; b=LAzDDkg3Q6770pe8iYc4hCQ96HyHlWcz0HWmwsmZze4Q0D
    rBF4+6whlPfUfiKSIamnydhzgDjQG9krP96Gzw5vGgy/FLFRtMlbr3HYSrNhn8Li
    p6R9het9LecSZ5IkNFGykNN1vYUo8XFXiz5xM89nI0M/J9U5A1kgWD275JzbJZmv
    6aXoFiP8K0sejAc39WK2BZrjh063sYqjyjDD07QqpUtWZ3I4lZ19wgr2QT+CsYzD
    PeNZF5AJk9iRlUzcseSw6CacEzi/geo3hmFfwl1qtcyBFxjy9CdJa0tdYV1zNCGk
    NN0zTrhfMfeqod3PNtcDSs0OIqXgFxKLLG7Y356g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfHY1lgPxxvq/npUUhrVul5VEOCWUeLK5ubPF+C/PpFk7zLz5KAhUdX+EkU1JUdkMJZNHVR9HJf3txGkEIm/19IhSXYCd8FERVDgjtNDnwyWuLXxOd4hb
    9cJqjieTS0zftaiRcJKXEls/V0oFFWilfHsruyExDODPSK+pjF0xTaxtTWQdKuQHd/SkK8IOxSTjqOvA0JjMrh0wofX0sDnPor5Q7bxkZgUhx35et9PUYtuK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=Gooc-wqmhnjxwfxg1NYA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755661AbeD3T0a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755628AbeD3T01 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266FF22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 27/61] ALSA: asihpi: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:30 -0700
Message-Id: <20180430183953.719547376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f9d94b57e30fd1575b4935045b32d738668aa74b upstream.

As recently Smatch suggested, a couple of places in ASIHPI driver may
expand the array directly from the user-space value with speculation:
  sound/pci/asihpi/hpimsginit.c:70 hpi_init_response() warn: potential spectre issue 'res_size' (local cap)
  sound/pci/asihpi/hpioctl.c:189 asihpi_hpi_ioctl() warn: potential spectre issue 'adapters'

This patch puts array_index_nospec() for hardening against them.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/asihpi/hpimsginit.c |   13 +++++++++----
 sound/pci/asihpi/hpioctl.c    |    4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -23,6 +23,7 @@
 
 #include "hpi_internal.h"
 #include "hpimsginit.h"
+#include <linux/nospec.h>
 
 /* The actual message size for each object type */
 static u16 msg_size[HPI_OBJ_MAXINDEX + 1] = HPI_MESSAGE_SIZE_BY_OBJECT;
@@ -39,10 +40,12 @@ static void hpi_init_message(struct hpi_
 {
 	u16 size;
 
-	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
+	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
+		object = array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
 		size = msg_size[object];
-	else
+	} else {
 		size = sizeof(*phm);
+	}
 
 	memset(phm, 0, size);
 	phm->size = size;
@@ -66,10 +69,12 @@ void hpi_init_response(struct hpi_respon
 {
 	u16 size;
 
-	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
+	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
+		object = array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
 		size = res_size[object];
-	else
+	} else {
 		size = sizeof(*phr);
+	}
 
 	memset(phr, 0, sizeof(*phr));
 	phr->size = size;
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -33,6 +33,7 @@
 #include <linux/stringify.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+#include <linux/nospec.h>
 
 #ifdef MODULE_FIRMWARE
 MODULE_FIRMWARE("asihpi/dsp5000.bin");
@@ -182,7 +183,8 @@ long asihpi_hpi_ioctl(struct file *file,
 		struct hpi_adapter *pa = NULL;
 
 		if (hm->h.adapter_index < ARRAY_SIZE(adapters))
-			pa = &adapters[hm->h.adapter_index];
+			pa = &adapters[array_index_nospec(hm->h.adapter_index,
+							  ARRAY_SIZE(adapters))];
 
 		if (!pa || !pa->adapter || !pa->adapter->type) {
 			hpi_init_response(&hr->r0, hm->h.object,
