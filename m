Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174264-2-12395929588044161275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174264; b=btQc3rb7EJCanTpHO7IQs0ejQFrnlVn17tQtkWvCBte0n88
    KDVsQXgrBm7XIVHxTqijgQB3kzp9ng38Sj9HVJVT0v4u+ndYsJi8CMns0R5I3lZF
    RBMPRbjJ5bJIcBEabZPf7Ee3kW5f4xHeSz+iwty9dCRNHYynzhOmX4jaljyHbnw4
    lGjdPLZz8rzo0uqvBoyrAsW9Oqp8mewgnIhS5AzOdUaE0gSKdih2L4tgLlaVEZhD
    k+V663a9BeVZmI0dO9cPch+VY2AN8Tk8F5Fl61TgZJRqPvDp544O/GW1t1CISOse
    BTtRqZwsszqz9k1RHSQwcEdxhZTai6+ERgOcWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174264; bh=yoz920NDlS2VHNQYWTOboxGluI
    MSEysA6fnVr40PUJc=; b=oqlew/9dzxxNqf5tnfXxlpTL5kCAB0Nc1T4ZoibU/X
    /8K85RQPlxZNERs1QgaMIUpwSIwdHPNhvencCzWv6dwYb1gsCKwt8jA5K8ayAgQz
    +lMzmeG/WgbFsTPZ9OEZKaE+KtqCnb350SsN9G7JeLS7xKHBlTRqziUnmZxDTMSO
    eXTD5/ascUYekeGJyW8kp5X6XTAqdKxQ+6EHbo5PuDxBZrUkcsMQtg9Vwgv1DlEY
    7wzG35gj8/kyHNWwUrKZ2aubCDVFEm4/bpW4gzPZl6cJLAFUWRqbuPKC68C6bvZA
    5xIBt2WJACtke7X27BtFxsr35VONPJLqiydXX4ID3XuA==
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
X-CM-Envelope: MS4wfOQpgwk4w9wgYBvQhcZ2q22IEzQkn7sEvOxRU7Z5OJqzSy1JYvxnnmeZwHaoVVTToejOTzaaJaQJpDcl/+usX930apLr0uikxQdyGh1QC2qk+gVKnO8+
    4LYVay9O/0/Lfvlc6tQVRb+uxePvvKaaGUmZ6DsZFisf+tBahF3FFC+r7RMnvL41iUPmLphLtb0IJo0JKpM3cMx8DRtRyBtGaUQMUyCAOq72BvT3e57HOrSp
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=Buo6U9zYcnrzya0507EA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeC0SKw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:10:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeC0Q2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:28:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 03/43] ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
Date: Tue, 27 Mar 2018 18:27:07 +0200
Message-Id: <20180327162716.590782270@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Marinushkin <k.marinushkin@gmail.com>

commit a6618f4aedb2b60932d766bd82ae7ce866e842aa upstream.

Currently, the offsets in the UAC2 processing unit descriptor are
calculated incorrectly. It causes an issue when connecting the device which
provides such a feature:

~~~~
[84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
~~~~

After this patch is applied, the UAC2 processing unit inits w/o this error.

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/usb/audio.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -369,7 +369,7 @@ static inline __u8 uac_processing_unit_b
 {
 	return (protocol == UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
@@ -377,7 +377,7 @@ static inline __u8 *uac_processing_unit_
 {
 	return (protocol == UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
