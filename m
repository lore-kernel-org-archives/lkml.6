Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159298-2-16125438505813469047
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
    1527159298; b=VnPqwAElPUAJDKuA2DxHkTiINh77Nc2/Blp0pLqBCYq3FHg3lN
    8ga07ZImqT4Vb3hOw8sDV4Hoob06gqVg1G+k0jhNxPuI8Gt5n1tLOvd8US+R+1rF
    7y1rKzDh2Kae//0f1reLCQl3vjKyO4JziMw2G31cGwY/BwFujPHW6CpsAo5rejID
    uSsqonY82W/hswKow7FAt9Q+zMWPR4EqWbFiSSvAGdBoawNPU2Qko4kR0C0wVRE9
    b0uL+MWpFnmDCEBCMguztMhVtl+0RMF6MUvHUVps0SxcBGcz4QOKSyq+0ZXWzb/1
    JMugZv7BzWQkA4Pw5N44ZPxhfrtml6BlUcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159298; bh=HVSuWlCAqaoa/cSX/tQFa4tkQB5IWN
    SWIR1XRU+9vx4=; b=GsDsfGIcVwPfkFDmOlP1g5G8EYiV/5qBlXbZ1Ut92Ycq6Z
    et3gJ4ZUaFSDWxC7LeLPePjzgRvsa8ODRYeviw53MS8EjVcXGas59wZV/j1j/2sd
    8z1QLp1K7L92ZJ2+GEGCJJw75uknZN+cic+Ej1QRBsj5kuLwycJBHFtg/FWA6UqN
    o/Jxf5/81wwjcg2Mybve83x5aCpwLlvx7CKLuggSg+ArOSxvJOLIopyW762DaC2H
    MNJvLlxZ0c9zIHLpd7gSycu1NF/S41GPAb5bgDNNsENYFoU+Oio97IZaZsdZ3xVO
    5d3ID7ZB4qH6pdRv1hylZYVYjvyrcC/vg9PoUUMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jzyVRC+e x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jzyVRC+e x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFUpYp9l1jJl2cOQKPy7n/BqzKORyg9p/+ROrocN3Fc2QKYjx38FkNczzywAK2mrihlHMVrarhT1aGrDfrasI71imU3ba5Sjkm9SW3R92N2PgaxDy/7r
    8OHP99FTfHIZsTEwP3Y9lN3qNKoXNoJoUubGxu6ZJuE5gLVxcw2YyGwcG3wCpXNcA861r0yi3GDB/T08KcsFkaAVHnAvbjR9wlxByhgX7kdG0MZFONJHChhC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=dSzqc6eA2Q1ZFwKsAiIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968146AbeEXKym (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968445AbeEXJ4q (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 124/165] ASoC: topology: create TLV data for dapm widgets
Date: Thu, 24 May 2018 11:38:50 +0200
Message-Id: <20180524093627.021122807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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
@@ -1276,6 +1276,9 @@ static struct snd_kcontrol_new *soc_tplg
 			kfree(sm);
 			continue;
 		}
+
+		/* create any TLV data */
+		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
 	}
 	return kc;
 
