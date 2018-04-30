Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116502-2-284615151389146561
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
    1525116501; b=JXCgtXINE2rNZq/QxgXztpoHf/5oRyEFgfEAB+Ct+G4pxlhlCx
    s+tZ4xHeiabdY5lLz/fpbrdLYAG+1I2ySEhBL3m5lE1tT01pDvLn8gUqC6M9lzxZ
    yCytDPVdWMOvnyVRQKZRpWGwf7TOIo4mJCb1rd+n8fxnB59LxXO8vsjS9/RNJjyd
    mBzLSpFoRuuyPkWWWPQYkvxf9n+a7KP1JPqrRBdKNLM8c43mBayfj9LEpJn0mn9N
    wPQsCljnPCBuPUyfkUpV/3nsP2yMNghEBjEYwPqbVjPQ21SmgorRZUXk7HjMUS2w
    fpiWT/zxOTFZE42u8JU1FWW54oSeIA4I2xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116501; bh=GVxOIDHi+K6xlg+Wj3xP4gUGFSY8in
    CHN5ClMbD2kaE=; b=cSdYtEICYFh6UcfP4NEsK0iVtKpg8u0MkMYwNIbNhioSUx
    XvR5J0o3yeuYbXSMV7ey73hvXgiqIiOenPCtkDXD7QAQScETMDxXwB5gelujsbJ+
    VS2+aHQJTXd8w+utG/yXbLAAAHKJ/aut9RQfhhzNyvC2oMLrozpzC97ZmhXHFJ7G
    R2vxMQ/eCNVOmqD2OrDRqTxnahWWJMlXTNBUojoeXCFXiA8J9vPQ2Q1kudsqmlz3
    nJIEKJ4PkfljYcoltqJKfhOIgaF4zSKFYjINxqWLOx2oOJsieK7wWZ9Hisk/qjvS
    f5kJkjunVfx4WrBC1T5s/2HVtV+smxLZQBleLXQA==
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
X-CM-Envelope: MS4wfONjxDyKqfO/W5gEPYJugo0wBXjzpfoiPoadVa5uWFFSA0Z34+FPM7UzSn1mvwpuAUUssr5OOuGjvFuck/2i1YmrYVdjztEL6plyHJnSmy+KRgZAQ++2
    y+2DDu0TZQN17h2CDvyCCyYi7pKXWaFPXtkBVq29Oph0qoJVXMp6YzSnGa5SVN0eWdFqcMllMLpjjd33tp4c6HoEdLy0jdLBDXetxVc/M/jteUWTg4Nc5Bzq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=L2pDD6m2-fKMQEhe2X8A:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756241AbeD3T2S (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755602AbeD3T2O (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD5B22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 044/113] ALSA: rme9652: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:15 -0700
Message-Id: <20180430184016.910864220@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f526afcd8f71945c23ce581d7864ace93de8a4f7 upstream.

As recently Smatch suggested, one place in RME9652 driver may expand
the array directly from the user-space value with speculation:
  sound/pci/rme9652/rme9652.c:2074 snd_rme9652_channel_info() warn: potential spectre issue 'rme9652->channel_map' (local cap)

This patch puts array_index_nospec() for hardening against it.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/rme9652/rme9652.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -2071,9 +2072,10 @@ static int snd_rme9652_channel_info(stru
 	if (snd_BUG_ON(info->channel >= RME9652_NCHANNELS))
 		return -EINVAL;
 
-	if ((chn = rme9652->channel_map[info->channel]) < 0) {
+	chn = rme9652->channel_map[array_index_nospec(info->channel,
+						      RME9652_NCHANNELS)];
+	if (chn < 0)
 		return -EINVAL;
-	}
 
 	info->offset = chn * RME9652_CHANNEL_BUFFER_BYTES;
 	info->first = 0;
