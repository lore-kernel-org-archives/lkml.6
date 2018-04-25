Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585387-1524656252-2-17072869398231370305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656252; b=rqeu4tkchS3YDDbenb4hF6P8sksQ4bF6XpZImTpwqC/Qt79n8H
    MJPelFzfUAuck87OsavM8oojEuRaBODnKUdfSGTo1LLnFGxpednEGmQHS8H+oOIX
    HTRIS1iXyvTXBbdvP7HbGPIju5wsWI6fc4eKzwX+l+0WWLW6Q1kbidVct0fTPEkI
    //3kBaEYPqTul3mpC3QJ0xzvqqE/SfVp9AczjohU594bCfIWs8JQ2HqfXG9jkuyj
    esgOl/DoV9jpgQqo+deLDfkh5l+QfMikRWOSOVTZxe4dgjvPmQLvjT4K/n2hLw4J
    +0yUB8somMtXusNL7Xr57OO7UEPdxGJYUOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656252; bh=NynLDIBlHidOzHUyyXGHd2zKt4Qcx+
    PO9AfQUV6Z/r8=; b=gZbHlGHrYHwe3JxYHfiXVE7SgHxTat2gqpT8NrDfF6D268
    SXnVdbK7m/nFWOcW6qpB7jj56xto2lHw+8D5cso1A5Ud9msfFtoFy525JmckHPBq
    Z1/6K4w6KCe4LnPVncafB2uFVfsyYiM1UqKRXblc2WGIGG1SnP2RV/wlzBwmWB7T
    YZGSLQAhfgNE91rWJK5IkZswv8GwkcmrrblrJZ6oky3MN/9X6AoqVhyGlJ6R43og
    st9N4V36UksYv7h35Xp9exuJjILrYc3sS6ZCH46Urvy7G1QxzvMD5MQDlyy53tz+
    WuwJ+jZZY6TUWZZM1b39/aQ3R0ho9Nsog3Jl+2kQ==
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
X-CM-Envelope: MS4wfPr9g+Vya4K6v6l4JXKXJQXJMJUEnsWZ8nBLuFzWSnMx6qwudCUuY9Ftn+S7k5c6yCHHBbLUw39ooWQrBmaK+w5RdALYmq8e+qXiWZnOMzSSTKF+SNck
    JatS74rWyDXThyiylSpr4iWj6T/PB0+UUv7YrbCvW3fwE/UCrsMOHKj7iZiO3aX/0TweF3FJ8NUQbrYzlM5ReaKyas32ZFfX9MpT+syLH5mbhSVR+i1x1o05
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
    a=bGqfTJUBWilyF4UDXlYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeDYLge (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:36:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeDYKdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:33:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.16 10/26] drm/i915/gvt: throw error on unhandled vfio ioctls
Date: Wed, 25 Apr 2018 12:33:19 +0200
Message-Id: <20180425103315.261058445@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

From: Gerd Hoffmann <kraxel@redhat.com>

commit 9f591ae60e1be026901398ef99eede91237aa3a1 upstream.

On unknown/unhandled ioctls the driver should return an error, so
userspace knows it tried to use something unsupported.

Cc: stable@vger.kernel.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/kvmgt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1284,7 +1284,7 @@ static long intel_vgpu_ioctl(struct mdev
 
 	}
 
-	return 0;
+	return -ENOTTY;
 }
 
 static ssize_t
