Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159156-2-11186984534709958127
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
    1527159156; b=GCPV58DEunk9hqyrjk/kERbduTR8qLZBvMX1Ej+ymMhOBAkaB8
    Zk+ooxWSh70tnIugjFg4nJqE8UvPU8Iu4SmiF4DuWq9YsI2vZojc4Qu0bDpaGn4M
    cwXDVOfjZGUWk1a2KEooyF8+9rl5lJnKubBrOlvNn2mbM2Xks/qvjvptXEfX04uG
    FLTaToU4j/O5/QANTdALIex60qxO7CkijMSLJN8k7MwF2jbtb7/Ghk20aUQOP5iS
    LXRqMiEuMZo5pd9d4Fnw1PS9iiAQYN0VRaSmkCM6h5rXyk8+avSF5SGS7iZrTYBN
    lbolaN6I2Rp5pTrgMYlrF6HJRcFeVB3n9aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159156; bh=stvuKhHHsC5rbvMq0mQjWrogcaN2En
    iNCE4BffmbGZE=; b=C/HJIqtKR0NQ2NMpzyYv0r3sHlbfY5XqT5K0nBWC/2FOF/
    Xw68sOB6Ahx7KsfJTDBGpAckqcxiyevNA6Cv8qo68bZl16mh5BrQ977euDPiqvjz
    K6gru6Rj4cbLeqa8OAICY3lSlEVCdVIuIS9f8PY1FZnZqDPBUzrkMKC7Ug9x93IG
    3B4kbmOH4S7TH7t2n06suegmBOA78HsXbti28g18ABc9oA22CwrLUcuenY51boKd
    iPZUJAvS10CoHkAj52+yyoB/TSKCLox1NVP5JZf/3Dpijfgxajo35JYMRWRhxUeP
    j42RDJStnCt596pvaSXYRJFoMQIPcRiMt+X/7ObA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=weGgg7a2 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=weGgg7a2 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfH5aSWPBJmP0RH4H8TGCh6HOU1+1uEg5k6hpYNECfHy5GNmWTgiNzuM7ApwBczU/C6zh567JRt5IzYNunX2rcZjT9/1RLcpF1wt4KlCaYlGQc/fD2A/0
    Yu1O6Q1VrllaFlaQp2Ypzy4cvzoG4azfq3rdxjWHyDhD3ArfJqN2ZrSdziOqyT9bEgdqOKIdsSBqnkWV3yXivVHoL3Xx0eQzuz1mRCpkW+/e2tct2P76UdQY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=_xz4Wm3-hpxqGwqU2sUA:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030465AbeEXKwI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030426AbeEXJ5Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 137/165] media: dmxdev: fix error code for invalid ioctls
Date: Thu, 24 May 2018 11:39:03 +0200
Message-Id: <20180524093627.619143722@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit a145f64c6107d3aa5a7cec9f8977d04ac2a896c9 ]

Returning -EINVAL when an ioctl is not implemented is a very
bad idea, as it is hard to distinguish from other error
contitions that an ioctl could lead. Replace it by its
right error code: -ENOTTY.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dmxdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1055,7 +1055,7 @@ static int dvb_demux_do_ioctl(struct fil
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = -ENOTTY;
 		break;
 	}
 	mutex_unlock(&dmxdev->mutex);
