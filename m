Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652736-2-16503222160933261284
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
    1524652736; b=U9ZWVkLDPgCfiLDMVW199SOx4RXFeD+bjjqwIbz5WwgOtu34fE
    HVCsGI1LnUdHMV9PDLEg18DiC4OCtPuQjSoKqx3+HNA9d8QVeFry86yC9uuEFqmS
    gQEvBrNvL7SUVfAZgxTU3igtT8njgoaNB8Deca5aHa7vs3s0UUr6F6rJxlYgsbBT
    Sgp+uOe/1ahjdlRdMLvy12DNhyl2ouPW/lo/oz4ckrYb/LAZEaWXlVjwEWQ1FmRt
    Gl7YiFdVKJfVhszIVhJXwBMIbgm7FEDeqCF+WNbQWvjVBEPUsGH0keS8+uAvurs5
    uR+rZSDWs54g9ktm+T6DTBoCTlH1YwgwspHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652736; bh=DTWRJFmKZsJJ9SCRCXAp42KYAwwDZ1
    xz5cRzWl3RqE4=; b=I/XXFFG1S7+iAfDm1wLxKyDwXPqvcqP8InIXIOfByUp6hi
    Ir8ofcBiekyEH2Jrr7U0Lc/vNbMEKDmV8Ix0rwoweQsh9j38JNe8XngsUqwKwkxT
    9sqZ+8FiQF7O/mZxA7blOB0AIqkn/3oaUPWP4+S0v3uYaQaBAO/OhSWwtuZ62/+W
    CwaJvnEb/br+Pb/NXMvGyc6uEPXOfoS1LeZFMuPad3Kfo1DL93+GS4qbVQpZprmO
    WHih6f7NemZoZk9PvuciRWMKvE6lLAsCByzwk17XIxZ43jn5VZIahem/bw5dOh/7
    m6e2ezBc1avjuQ7JTErvrXnKaV9yCLwytmyK7+ug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfAGs+O2Xf4xNAfKjEVQNCiiSWZ/fcGIySvFDCdOpSE33uN/wmVk5yRWsM5my+x7x1ZookbAwGqOgMlR19aAzBu9AaNe2h0Gz7P009xNITTfoMsg+6a0t
    0ICFRO9ZjG+/Kg6lNR/IL+cvhJnlke2sQW02aw271oa4IgvcC7TyIUbPJ4yUo8WiqUGeZMuxnQ41OuquLky3g14PmXVaaOFzYshlyElKsYbSBm/o5hkau3E+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=alC0domXPAuWEL2TSGoA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeDYKit (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:38:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbeDYKip (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:38:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, mulhern <amulhern@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 046/183] dm thin: fix documentation relative to low water mark threshold
Date: Wed, 25 Apr 2018 12:34:26 +0200
Message-Id: <20180425103244.414480542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: mulhern <amulhern@redhat.com>


[ Upstream commit 9b28a1102efc75d81298198166ead87d643a29ce ]

Fixes:
1. The use of "exceeds" when the opposite of exceeds, falls below,
was meant.
2. Properly speaking, a table can not exceed a threshold.

It emphasizes the important point, which is that it is the userspace
daemon's responsibility to check for low free space when a device
is resumed, since it won't get a special event indicating low free
space in that situation.

Signed-off-by: mulhern <amulhern@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/device-mapper/thin-provisioning.txt |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/Documentation/device-mapper/thin-provisioning.txt
+++ b/Documentation/device-mapper/thin-provisioning.txt
@@ -112,9 +112,11 @@ $low_water_mark is expressed in blocks o
 free space on the data device drops below this level then a dm event
 will be triggered which a userspace daemon should catch allowing it to
 extend the pool device.  Only one such event will be sent.
-Resuming a device with a new table itself triggers an event so the
-userspace daemon can use this to detect a situation where a new table
-already exceeds the threshold.
+
+No special event is triggered if a just resumed device's free space is below
+the low water mark. However, resuming a device always triggers an
+event; a userspace daemon should verify that free space exceeds the low
+water mark when handling this event.
 
 A low water mark for the metadata device is maintained in the kernel and
 will trigger a dm event if free space on the metadata device drops below
