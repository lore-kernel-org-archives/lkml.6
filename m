Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161263-2-6326549373031890207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161263; b=JEGKj4KhW+seWNa4y1eN6SWGFniRPqfJObTi0Mbvlj3tqjgcog
    Ztwv/kRophhz3Vdc0Vj9Pi3xIvEtx5lkdVHpAkZ7SqkkUtlLSNFGDEtFfJbc3HD2
    40gWJ4sUk5oxsRvwr1LPU48hxFG1cDyK4D3aw5O16cgzcEYupeYirHMk62QGRUz+
    Krs7NZUIovi6f/59LXN3iqO+g78gHcz1hJC2h+sZHhSFt7rz6oRXG440UyuD70Pe
    bWt/luXhL2wMSLKQFB1ujUmVbmf/2f7sHXUgz+ZwCxZdzg3J+YnbwIm+nKzip8i4
    0NVc15OI6L13hP8IgUK81Vg92M8VcO+MVlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161263; bh=3xD3tXybyLHRs7LBjaXL52lTltq2E6
    9agUbv1bgU9wI=; b=GAxNxf691ixbaqBKsZW1rf0PhJf8gtK9gv6LzLAI7i5DmX
    F6kCwcGf/ScuUP/To+wfU5iz4dlWwglF5+00SSkU3ynmPEAHrg9Yndw4Oczq07Zj
    VGG0Msz9lyMUOfBipOVQjWz2pFMtduCzQB6RJ1TGP7MUAVm0NDvMwnX7kkVBJe45
    jBWmKdnNOl2lJxu0BPa6UU071TLVEx+O2bgNI0/KdI7+3KTohBgszr/a8IvomckE
    8e3vvsrLMIB/CwK3EkLSGvoSlOd4AQVoQ4msh4GsUKpJM1En+cajFopDUznz3lEI
    ZVDOLHDfLvHDg6gmZQfnakAa6q6UUTGkIsKVW5Ww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xoOdzruT x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xoOdzruT x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/iNahVU7+I+nkfSAyqeGHfRkraXbIo1STKl92EgSZn2oPpO5ILd6h56aeIShqqsTZRzJAiW9ub4d2h/WLhK+Jv2CYZ49Fu5i80zdArCpc4YgC6fNxt
    JO8+gBRBVJf8cqImFUCmhqYULQ3uBn0Jjiwuqag2+l3aMKWIUSyH8rgEV3OAC7I3omFnt9H8xMLwQyBkMlmVsCSqQADAD/wtr5Lh99DYvUuEeSthqBrI6fAp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=dSzqc6eA2Q1ZFwKsAiIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967796AbeEXL1O (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967702AbeEXJv1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 68/96] ASoC: topology: create TLV data for dapm widgets
Date: Thu, 24 May 2018 11:38:51 +0200
Message-Id: <20180524093609.315936292@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit bde8b3887add8368ecf0ca71117baf2fd56a6fc9 ]

This patch adds the change required to create the TLV data
for dapm widget kcontrols from topology. This also fixes the following
TLV read error shown in amixer while showing the card control contents.
"amixer: Control hw:1 element TLV read error: No such device or address"

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-topology.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1180,6 +1180,9 @@ static struct snd_kcontrol_new *soc_tplg
 			kfree(sm);
 			continue;
 		}
+
+		/* create any TLV data */
+		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
 	}
 	return kc;
 
