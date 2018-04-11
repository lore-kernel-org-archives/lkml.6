Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523474057-2-6241227410780742645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474056; b=RjveBdvGjEgeb1ouHGoFJymHoP+/06Zc2TJuZtQ+cAg+f48Zyr
    W38ZnUKlPtmpkpErPoCgSFCMs+c7pEdp7bL+miyCtiUlKb+MF82Erjkd2pwni+cF
    eTzRblBS48yMz+Erzv2EfZn/o+XsuM5YLJdIcwKtvQXGzNrRAP0LP2A+hq4Aws6T
    8pyFUXdxOQlrpUHdI5ZAf65uXxQ1EpJeiyedr5eOUOiItaZf6/E50d54GNpNXPvk
    FhuEej+gJg0XzM8KpWHaNZT5cKg0l9AeygvV1Ck6ivNhwbiUDePBpINfn434zOKB
    nd1RTpEU8XwhTAVd7G11enZJrXXEIm+LIaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523474056; bh=yWNXxUtR2CTglYd00gh5NHXJ0Xwbsq
    wprOklhWpZ0GI=; b=Qw0n/ctoHrPURoUGoV3ZXrRXiuh+ljEvswga52BhfzvUnW
    tf2hoL7YlMZVrfst3Fr58kanKGmfsrHH9f0/I5ELHEXvaAbd1HN1r2JS6Ws/mGjl
    qSzOi2so//cQa6Wso+WiFcYT5DIZNN3M1CNo/qP3YzBY7E6FW7qZLqJKSbHOnHOJ
    eHiN/TzsdSP3k/RZmoIGsi9O4a2OI4YNGkCNShMLFDEZAX1eCNdXMq6uierTTuGu
    z4kraXbVRzXCuvU2gmK2Vrjf54vPQ6eS/IqSRT8Yseqjv+bCCqhcoJHdshgqnMec
    Rlq6ubn7ZKqoZJcp3oD/MtFTOkbM0dfVidNFWhBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfN9RPCGlXEPPQmRPfcFFDnY9P9OwTCUtW4mQm7xZ3JodS6DyGp+nJhlfpZQGhBRmldVRFH+VKA3AnaUcMhcb+4PdFW/mVN26toLTyXplJc8AmsAnysCp
    i3S4b/Dz0ag4J7KXsEg2gFRIb6wDWMvW6hRGSI5S0+JTIYP0Y7HCXmRk72LOeZaYhzlAYR7ANs/WRFT+z99sou09I04NGh9NNZxvTbAAGHmmfYrFAmG0BvRj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=D3-RsOQh37YrPmCKYXoA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeDKTFo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:05:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeDKTFl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 252/310] s390/dasd: fix hanging safe offline
Date: Wed, 11 Apr 2018 20:36:31 +0200
Message-Id: <20180411183633.278275747@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Stefan Haberland <sth@linux.vnet.ibm.com>


[ Upstream commit e8ac01555d9e464249e8bb122337d6d6e5589ccc ]

The safe offline processing may hang forever because it waits for I/O
which can not be started because of the offline flag that prevents new
I/O from being started.

Allow I/O to be started during safe offline processing because in this
special case we take care that the queues are empty before throwing away
the device.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1950,8 +1950,12 @@ static int __dasd_device_is_unusable(str
 {
 	int mask = ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM);
 
-	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
-		/* dasd is being set offline. */
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags) &&
+	    !test_bit(DASD_FLAG_SAFE_OFFLINE_RUNNING, &device->flags)) {
+		/*
+		 * dasd is being set offline
+		 * but it is no safe offline where we have to allow I/O
+		 */
 		return 1;
 	}
 	if (device->stopped) {
