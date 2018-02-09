Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184536-2-2870254143302138410
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
    t=1518184536; b=f+x75nODEdJXNakJkCuresMRABQ6keMH1B4NXMkvjK+A6nc
    Mv2JgjmCQoSz6LXkOG1cM5F+YnrE0Bik/uoUDQ25TlmBKrvJ5QvhkS5/AFtFj9u1
    VIdL6Af2Wwr1I5zCmQcdhiI4TngohqIJ/1iudPX7UNM79vAphcl0CJuTZjhKNDXp
    9Ub6m3hPwtN9mNVTTKZ1TIhm6sy7cDIa93fYRJI3n/nADapdrvFAsLNfs/SB06Qn
    dO8bV6VNL7ZnGYMBuLX+f3lUhCzIIzTDjBIWtp8cfSdiV/a3CAiiggiKs3rppZ3h
    oPDddR0dIJF5Ds1x6WWJCopC2zTnmHVnLlaf6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184536; bh=IQTml83wxDiOGzL2Blts/MUdrr
    ZATRtzsXcx4vLnifY=; b=LrexsfyTf1+GzRmPHXlZvMR9uEImg/gS0ky2QqY8MF
    Tp4kjXv+Kn55H/vLAgBzAljJqtZCOu26QRuwmtpa7IHu/oTcRQ30sqiH8U5avWkf
    5YJr06LIGqGjIgzhMGUbHMML0nAfRO0zwwcDHeXAOUyIcQl/vCYtmVSlaAOkNo3k
    XE9B2e+0izs9RwW5eVTqBYjW9k6MvrHm839ZaFYCYzc8WkYk/Q0ggP4bNRFaPTj4
    0KrJ7KHR1N505JjSwLCktBWXnZaOwUiiFJggavLQo4R1uy0hikJOXXmAizRZXLfC
    qAPyvSJBozIJWw7ZdwnQrMtXrqNBs9yuwdur90cAKkgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbeBINpZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeBINpY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 18/22] media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  9 Feb 2018 14:40:07 +0100
Message-Id: <20180209133935.423109512@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -419,3 +419,7 @@ void soc_camera_calc_client_output(struc
 	mf->height = soc_camera_shift_scale(rect->height, shift, scale_v);
 }
 EXPORT_SYMBOL(soc_camera_calc_client_output);
+
+MODULE_DESCRIPTION("soc-camera scaling-cropping functions");
+MODULE_AUTHOR("Guennadi Liakhovetski <kernel@pengutronix.de>");
+MODULE_LICENSE("GPL");
