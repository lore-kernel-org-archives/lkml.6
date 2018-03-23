Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806821-2-12059761831942930977
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806820; b=DtiznY642N5GKqR8peRDihhO4rWiS+BHyzfWV0jFMwjX9Sa
    9/FakLbjO+89OLVnJ21sdYEUgDJTkYv/DCpPEP56/gKPpMLsp92ONVMjruJ2Lx7o
    Y+b4aa/ehCIrV9Bairdcc6Fh16jgakyomRNngLmaYMcrVmRbGSs2u0y0nQiUHh6a
    vMcE/+X8+lBkZfXFJ67P3z4d0LmRX0YF1DT/R2lykgoZVBTTwq9iq3gLcMe0mRoi
    U7VAJ4+qL81SjoFi1JEKIheiw8uoML9tubZK6iyfqDjuoG6FI+HZM4ZeiDQMT3kO
    APXd1gdppf1ome5vu7cFtC09avksSipPLfvVN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806820; bh=ZZPFNlA/LPQU1PIQo63GQAib4e
    eNznMaAe/KlQYaPnk=; b=XoaA1ohzcUmIb2srxMyYAdblMtRuokEavltkCzybGz
    FO+arj/kwa2wBFSmm5jN12f5OfAPL3rZesZcjajMCvDVPTBClqJoxL8u7dfL1Lk3
    PLdowdR8hju76S6i0MB4tb2UKe341nHmINtdMRbcjz4Vy7nr6Keeu3rAummmZ2pg
    /Pf5KcCXclVI0Exw0C/a6kL1taolFXJW6p/XEfeIPAEJPG3ouU7oL32XK7Cm9hKj
    0dO5UEwjH43FKNPUBDSOJ+ucIGNYFjD3lugURuqH0y7zL08lQzNP3R4lAofKQ0Dk
    lOzbDT3wfRcmWSqx7SvTmXySbFfgfcayks1NElqeI7kw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCWJ6y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeCWJ6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 54/84] media: davinci: fix a debug printk
Date: Fri, 23 Mar 2018 10:54:08 +0100
Message-Id: <20180323095420.133273752@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>


[ Upstream commit 4f6c11044f512356cb63d3df0f3b38db79dc6736 ]

Two orthogonal changesets caused a breakage at a printk
inside davinci. Commit a2d17962c9ca
("[media] davinci: Switch from V4L2 OF to V4L2 fwnode")
made davinci to use struct fwnode_handle instead of
struct device_node. Commit 68d9c47b1679
("media: Convert to using %pOF instead of full_name")
changed the printk to not use ->full_name, but, instead,
to rely on %pOF.

With both patches applied, the Kernel will do the wrong
thing, as warned by smatch:
	drivers/media/platform/davinci/vpif_capture.c:1399 vpif_async_bound() error: '%pOF' expects argument of type 'struct device_node*', argument 5 has type 'void*'

So, change the logic to actually print the device name
that was obtained before the print logic.

Fixes: 68d9c47b1679 ("media: Convert to using %pOF instead of full_name")
Fixes: a2d17962c9ca ("[media] davinci: Switch from V4L2 OF to V4L2 fwnode")

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/davinci/vpif_capture.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1397,9 +1397,9 @@ static int vpif_async_bound(struct v4l2_
 			vpif_obj.config->chan_config->inputs[i].subdev_name =
 				(char *)to_of_node(subdev->fwnode)->full_name;
 			vpif_dbg(2, debug,
-				 "%s: setting input %d subdev_name = %pOF\n",
+				 "%s: setting input %d subdev_name = %s\n",
 				 __func__, i,
-				 to_of_node(subdev->fwnode));
+				vpif_obj.config->chan_config->inputs[i].subdev_name);
 			return 0;
 		}
 	}
