Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720573-2-3819306494722952133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720572; b=jayWnvxpANwtXLj7bB0PxPsV16CbMu/uBA/+/twGywzVfUO
    ASkkh7oad+GBZ+uZv3WWxGdeYzpob9uom2FtMsKGYsgX+3aeENsDL9BCuQzkCJKT
    O8Z12m4acCdhMW7y5tUUrK/mwfQtKtu0WrN3lgYmKnpG9CMkFFhXpENN0nAUsQPi
    50NzGcUvI4ruU1wDFKIXf2xjBIuFllVXmr9uS/j9N2ZJmknefKx7B/K/2GKkrqDf
    sz2XcVr/EBYAWGe8cV21ElzJK0MggTR33U0ZW1WnDWK528F6x7WC/ltdewnzeDd/
    j1Dj4y74DHOku9XxgX1Sl0eaEkuFWzGfBrnQ0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720572; bh=jC+ztDaLgUWElPUXjWA8TyzU90
    7eysEaIWhwXeH3diY=; b=Jw08b7629L8z64Ayt+KJB0wcbMWdppK8BD/t76Wg3n
    CBh/+SMX5k8pgQYC05MR0jUdijvQ37+FBOY4WxYG2BXMkQvU5LJSOCoEMQC82zBc
    N1R1NgY5LgXpQuZUFJhNtBnDKGlSYPij4WUwHc7+P35anrYK7zUpRPl7VP/30ZXI
    sIeF0KRBhMbMFDxEoZDK5eRWi+y+tzJlF/IwRq70PbBiADBanimUpDQ7lMEll/yV
    QOSUZewnFK75V+Zc471dr9LGJE3ng6o8C/tuBM+JSldtDl4WtmJzkq9OKMenm6ub
    0V10X47rlVXVF25FP+PPfkonMYzZBkeRTWsZWcgVkZKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162294AbeBOStP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:49:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162201AbeBOPVx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 033/108] media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Thu, 15 Feb 2018 16:16:30 +0100
Message-Id: <20180215151227.045243423@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 5331aec1bf9c9da557668174e0a4bfcee39f1121 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/soc_camera/soc_scale_crop.o
see include/linux/module.h for more information

This adds the license as "GPL", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/soc_camera/soc_scale_crop.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/platform/soc_camera/soc_scale_crop.c
+++ b/drivers/media/platform/soc_camera/soc_scale_crop.c
@@ -405,3 +405,7 @@ void soc_camera_calc_client_output(struc
 	mf->height = soc_camera_shift_scale(rect->height, shift, scale_v);
 }
 EXPORT_SYMBOL(soc_camera_calc_client_output);
+
+MODULE_DESCRIPTION("soc-camera scaling-cropping functions");
+MODULE_AUTHOR("Guennadi Liakhovetski <kernel@pengutronix.de>");
+MODULE_LICENSE("GPL");
