Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116439-2-16255817096925111892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116438; b=ZvP4ZMMvLapVLaOMZH6i2qBfUYhglsY5cvyE8gPnyIK6aHPrti
    GgIxD5/TbAJupyGIp6HIvDGL6VzvEFkrr1T+iUKGBHOK4s6dIU73piTry0UTwLU2
    1dy+3h3G/+S/oKeWAuoTSK5zl88ZvpHXf9opzcEbcAQwbVjif+1SJqJpUnZ5+S/a
    u0UtGP4yx/xA1O73UjDxUmMYbcdEja2SMsTA+B8AheHenESIURpa/mQX4OUXlzqN
    W+ZwrdP39peyvnGAhkF45i6UirDJ1HelU514mFjJwU2EAKFP0wC22x48EedyX1Tj
    eNYBMKx8XgGfKVsrHDj47NWn5PUAA2wcOYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116438; bh=xBw8BUfViPWyQp3CfD4Mu1TqLz343t
    wx/1LKE1MVP28=; b=b6y0BFKBaAv5E4jM7qh9NyTWEOH6K9gofbMTW3dgC6s2I8
    O+XFjNIJUylicSiUNfMYRBTWQtsY3qUnCZx7QzVM96hgJhzZfoAmDi1Uknu4llaW
    Dhee7jtc8106r8prt17or8Lkhc8gugMZ0rMss3EB8bwcduRc4U9Fomhib8Ly4w3V
    A3PQTZAjav0T8sHbUD+lX3IvbzA53xEX5dWKB16HbvlmXPOZdLdrP9JR0cY08Jye
    d1TTo5qRaHB33JAt0JDlb9wLbi9BEQkiHbg6z9DsgNuWx1uMsaZLmkGkAn1kNn/7
    rb46f2CpCiMIe+fcLMtRCqyIvdMq0r8Yd4h9YOBw==
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
X-CM-Envelope: MS4wfNJKNVKhUOB7Re/v8fW4RPpU4HCRcYYP7bql4MSf8Af97rlO7UYRALw0LjLXAIQx4fFNUomDYo9tQ04CyFyKV0dOBo1hzgR0tZs7VPDmztLpcvVfofPO
    br3glITvNsCRFbpbkA1O4RiFbtXt/7WRVioOas8x+VmjkmUh0jpR1dmnwjUapy7xHwXxt/OamlUzFlqotqV7v412UMawUUiP1zTxpRX+u3K4gv1k8YlE6yEH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=L2pDD6m2-fKMQEhe2X8A:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeD3T1P (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeD3T1O (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:27:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6E022E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 40/91] ALSA: rme9652: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:22 -0700
Message-Id: <20180430184006.262431681@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
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
