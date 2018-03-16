Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215617-2-13508705101274068516
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
    t=1521215616; b=m9yFcuiG7rUrdwmY8FD9ZLv6hpRQlPa+x1dEOJv5OLOLcZV
    zH6NUwO77NxhZo1KlT5E/mGu4Q22YhgukIqYJUMRXh1p8Ycrk5f0HP9GPO2zZ83r
    pvP+oq3FI1UThB7l4j76B9Xi87BuvRO4PIW+5Zpj56gbkcAoOo8X8ieF4sF215Cc
    y+NFl/IRnA93ngOWX0aziRfuTUzVCwfFZm721fpuXxXzvDn0upNt0r0coRq33JXj
    /afqZTy+uVxxpyjRU9X+pdTqgbE23KcHPfPdBmI/CtSyKtMSNEREZ/qFoGZ4VF4o
    boov0myjeuHFoVkZT0LMXWSSXebRFs9uzVnlaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215616; bh=TVBNM0vrtmFVfxhPFWpVvDClA5
    98jN9Sxa7wymBXkRE=; b=mrANhEhHaBNmGrCuFRXWwrG+y8M+tY7Xficlxw7Jy9
    AhkxRrB9tJcEko2ndhunyONVd34xuSOAQjrkr/ANFBCQoKhqioqHkdzVJLdYz/iM
    f+K8JljYXlI4JglqsJHzivLQATxU2t7pyhV5+MEB66RkRUfUYmcGZfKKAVVRa5Bt
    0Zux7WjZuFnrrXeHj0VFEyUVuIIIAcF9vIbaOqkvERZ2sAbfEz+mCJjB2CLo9xKB
    AV8Nc+aI8ud2yDfqNbtfUvcC9HOuvf9Gfz+lzGVk7W2cl28Y8KPqcL3AP1MEkLR2
    Jm0DocIqjlUfjE60tpT8u4zuFuFun9m2yAXNRfFcVJWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeCPPxT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:53:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965350AbeCPPoG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 107/128] media: davinci: vpif_capture: add NULL check on devm_kzalloc return value
Date: Fri, 16 Mar 2018 16:24:08 +0100
Message-Id: <20180316152341.874211000@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 5a18c2434f8bfc8bc2fb0f8af3e44f7408d63e4f ]

Check return value from call to devm_kzalloc() in order to prevent
a NULL pointer dereference.

This issue was detected with the help of Coccinelle.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/davinci/vpif_capture.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1550,6 +1550,8 @@ vpif_capture_get_pdata(struct platform_d
 					    sizeof(*chan->inputs) *
 					    VPIF_CAPTURE_NUM_CHANNELS,
 					    GFP_KERNEL);
+		if (!chan->inputs)
+			return NULL;
 
 		chan->input_count++;
 		chan->inputs[i].input.type = V4L2_INPUT_TYPE_CAMERA;
