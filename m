Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518720094-2-6657272406450080148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720093; b=DF86GHBmiNwezfr1RKhJK74/Ywmx3cZuUjQniLT4ANsMrz9
    UfqnhYxWAeHQXTat2O2oIXLv5Vh+wW7pCIyEZjaylcqU19/8EkRY41cTbpRuquRq
    sagNpcyAv9WCqMH1Fje0hwzI2R3Dc9+SsZgQ/S8H2xnOLHk38VAiWP/imNbO+Ojs
    9CAEjrBUDNjFXm1ivn4IFC6son5z4NDq0TDYqIR/WPDGjjhKR/OGUsUAxx2WAe1M
    TdoCgkZyuS030TTYHvHAMKXI2gRIczKo3vszXR+JE09XRjw+9qwd8LAImTyQ4rCU
    I3ktBR/P5HxQQ9CN5s4GsIaj9dHMAKZli/pLwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720093; bh=Ml3OnsOmnO2S0F7Iu75tTXOm70
    zw119UW3lVp0p4P8k=; b=YgrCDlxPu95TgVif/EfLEYbjNBv8BvDNVsYmGPnlHk
    fBGqOILlSs191kT5IHsbn9FPk7rCcQC7Thmyr5zxlK9VNFMk7bah1ai12ozC7PBp
    SXy81zT9Kpvf8f50kfkLq1hU7uMToCdMV1HTv8qz1xMY7KNR0F4UnXiA58LoYpsa
    osaHYTVmEfOhOKfOTjXaieuHiwCPSaiHDq4WVWlyJPawUUaoNb2Y9zDCKlim53kI
    HF0zTCaVp+wbNuyuJ7EE9PXD1d7MFu4tfkW3PbicedDmkhvGLFoeHKj4tQND6GLs
    0BSks3y1jqpJTF4iqhaMo4jnzSVPuuJnVdJXjNSXDZgQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162802AbeBOSlQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:41:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162745AbeBOPXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dimitrios Katsaros <patcherwork@gmail.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 072/108] vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
Date: Thu, 15 Feb 2018 16:17:09 +0100
Message-Id: <20180215151232.377226916@linuxfoundation.org>
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

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

commit 3171cc2b4eb9831ab4df1d80d0410a945b8bc84e upstream.

According to the doc, V4L2_BUF_FLAG_DONE is cleared after DQBUF:

V4L2_BUF_FLAG_DONE 0x00000004  ... After calling the VIDIOC_QBUF or
VIDIOC_DQBUF it is always cleared ...

Unfortunately, it seems that videobuf2 keeps it set after DQBUF. This
can be tested with vivid and dev_debug:

[257604.338082] video1: VIDIOC_DQBUF: 71:33:25.00260479 index=3,
type=vid-cap, flags=0x00002004, field=none, sequence=163,
memory=userptr, bytesused=460800, offset/userptr=0x344b000,
length=460800

This patch forces FLAG_DONE to 0 after calling DQBUF.

Reported-by: Dimitrios Katsaros <patcherwork@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/videobuf2-v4l2.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/media/v4l2-core/videobuf2-v4l2.c
+++ b/drivers/media/v4l2-core/videobuf2-v4l2.c
@@ -593,6 +593,12 @@ static int vb2_internal_dqbuf(struct vb2
 			b->flags & V4L2_BUF_FLAG_LAST)
 		q->last_buffer_dequeued = true;
 
+	/*
+	 *  After calling the VIDIOC_DQBUF V4L2_BUF_FLAG_DONE must be
+	 *  cleared.
+	 */
+	b->flags &= ~V4L2_BUF_FLAG_DONE;
+
 	return ret;
 }
 
