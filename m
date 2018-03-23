Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803553-2-8469723480103160829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803553; b=Ag4ISX8lyJAmqjBA56UoLmlwzG+nDJU2STd7pdK1tpNF+Sf
    vWxbnBOe3w07DnLPHFbQc3O9w4F8AeLqLfXLTpOm4a5jce2FnpNDBDZvBjvs27Eu
    bSY9T9c92fIRqJEs7Zpz5Fgd9XGNFjhl28D3FYHSszOGT3Z5ZZgC/QTnfZSa8LcM
    BsUtrylIaA4qpi+UimgdEHhSjhDl449tGIVxds1DvQlkpk+tRGZOT9ulqCPadeXD
    x0ieSKAINBpnk+zFpELGVrAblZacPBeKf4o/fvucnqdyJQXVWWqd8tlbnH42T5/v
    rNTNQki04ZZ7EbkExRroOveRcMy/x4TYDNyfSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803553; bh=Rr3O0LyOrbafJvOIU/TPz0aunR
    mhnbeDtGWIZ3+HHH8=; b=nD0jjHFim4jVM92Fvt4poJyZrBUYuaogwFuchGjIch
    iM+hZu+ItqKC1FZ6Zgx/Kj97Szx3Kg4Io0NrXn7js2jVs1Bh1pCRoFdqrl9SwmOx
    wQrL2Kvtvce7xFcoJiHSZQWmQt5blhpk+JGl9XaJVno+oSxsl5oro6P3VaAMavKo
    HZg4EetTzfOk1HroDQgO5owXOsHG7sDUE0Fjskeuher+oUhpwgYdJWBWy6u21KzI
    IqHoo5cl3d2YXFH25nI3BgoVXXAVZ/yOlJmSPuFC4Qp5uxAYFhOdX7OMDbE7xBHY
    WKyW1gHzohPmkoZmcyzyTeTvC+BBB7hQ8tMylXZdQctg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeCWLMS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:12:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeCWKKu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maksim Salau <maksim.salau@gmail.com>,
        Bernie Thompson <bernie@plugable.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 121/177] video: fbdev: udlfb: Fix buffer on stack
Date: Fri, 23 Mar 2018 10:54:09 +0100
Message-Id: <20180323094210.589704842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Maksim Salau <maksim.salau@gmail.com>


[ Upstream commit 45f580c42e5c125d55dbd8099750a1998de3d917 ]

Allocate buffers on HEAP instead of STACK for local array
that is to be sent using usb_control_msg().

Signed-off-by: Maksim Salau <maksim.salau@gmail.com>
Cc: Bernie Thompson <bernie@plugable.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1487,15 +1487,25 @@ static struct device_attribute fb_device
 static int dlfb_select_std_channel(struct dlfb_data *dev)
 {
 	int ret;
-	u8 set_def_chn[] = {	   0x57, 0xCD, 0xDC, 0xA7,
+	void *buf;
+	static const u8 set_def_chn[] = {
+				0x57, 0xCD, 0xDC, 0xA7,
 				0x1C, 0x88, 0x5E, 0x15,
 				0x60, 0xFE, 0xC6, 0x97,
 				0x16, 0x3D, 0x47, 0xF2  };
 
+	buf = kmemdup(set_def_chn, sizeof(set_def_chn), GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
 	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 			NR_USB_REQUEST_CHANNEL,
 			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
-			set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+
+	kfree(buf);
+
 	return ret;
 }
 
