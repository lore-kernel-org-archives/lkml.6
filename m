Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161649-2-8014468242115365834
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
    1527161648; b=BQYQFEhWO8ModbWQhw/zoQcqMYldmIaxaKfsaSs9JB8Wkf5esN
    uii91c9XDI6ney1zARdiU3Iua3eX1sEE7Kp4xKaNCk61mfvozYRajXGhqevTp4et
    neQFoQtJKSaIOIwj8AaQQc83SjX329dVLOQwhQQKQE4JBMmAZcyy82GnxHAGsHJL
    KpkR1Q4LGzthpLFmeNN5dY1XP3aDyywJHyzrQTinzBFrpFZyJHAAGOB+5diBYk/v
    fzVLEZVHe6eE/amoNb/JT+oUe1Mv0fQTO784sZv7IxHHQ6ZtHPvA6aQNVhGugwKl
    0qtGB1eGX6wca1fC4JcPJJ8gAXJcKj6bvi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161648; bh=TZdnj/OvxHmmXHN97kJZ5+ofVT0Bwu
    +3iPbl6W3Er6A=; b=lf/5frf7SQqTmM/xXxhPOZIzypHcCpuFP2R6+7GiR5m4od
    zKZ2WC3cohvlmsqOWWkmfJuaN7H5aWL0ICnTB5p4MqPuFxP9hj6v2YnYLgclVjL5
    aquYpxz7V4CGaTxZK0BvXOgAxGQX92h4bzHPEpSporvwzTCVI3+tcPdnnaj1hXjd
    5nd1M5J8VYviqtxnsBhwHQl0lxrmLIpgUOgdFdnZKUmPQrBCiHxCXSNv6fZ3jo/G
    gAAyh6ENujkiyqJDFiOc0LuZXG39BMw/S0lNQfT3CLqKFNAuhX3C8THrMJly5rMA
    v2x+UrShOkO2KsxmjWI20cqNk+O552JugehjyLZg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CO3RgCaq x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=CO3RgCaq x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBG9YyjSELtdTycPDwimZqzanpNCmJMMfdjhqAnUrvH7bspOx+6iOYTM9FvO0DdGR6vFR+KXHwvYk8gt8nvbf3VwL2Xdl/aUsK+0pMGuIa27Ub2K6W7y
    B/aEpTal+14AZJXHbV80euINlh5OS/QrMScYYCFfnQ4T/3qGuV8nP9YoEGoOf2ZxwzMTSXggLBrPW0bz1+tla6k+hiRdF09SgR0HwAlBc5ypR5HYdmOtlyzb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=_xz4Wm3-hpxqGwqU2sUA:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967432AbeEXLdy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967574AbeEXJu1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 81/96] media: dmxdev: fix error code for invalid ioctls
Date: Thu, 24 May 2018 11:39:04 +0200
Message-Id: <20180524093610.026366349@linuxfoundation.org>
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
@@ -1071,7 +1071,7 @@ static int dvb_demux_do_ioctl(struct fil
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = -ENOTTY;
 		break;
 	}
 	mutex_unlock(&dmxdev->mutex);
