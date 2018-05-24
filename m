Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159106-2-14447245672697876890
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
    1527159106; b=QVBva0BCFfn4zDlMClWqQWfeay9jmJp7a0IZbTKPRIZagvKmwQ
    PoGZEdEWXm5AUBh2FUczA0zxP+erU67RIlckQV1W3+zC+EmNWDQhehIg+cz5eCwG
    A1eNcAPzOIxHp5Y25HwJjQZTGH1oK/CdhmN5ZzvwbgppsogMC46DjS4fVidN26PA
    0kMzVcil7x571HLDSYGRQH4Hp2qJXm6JGmvz5OJx5O9m71HB2ZJ1NAe4+dvgabEb
    bzrYpTeyQLr3sU5cKxf/EnzJBUqE3BiOYPl+zQxHlzPsmPO9mTjJWECFbJBLNnpQ
    L4r0axDa/D9PiBh28SwTfcbe5xvlm4ahcbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159106; bh=j/v6rHnjU5NgLYlrsP1n9nhzo9uD1e
    3t1nt9kD7HaZk=; b=MwhkEvVFg1rShPwJDmFbWCg0Qr4TfeaZLVjEOPGQKOYKKe
    w5OS+B2KhFiDnPSNLRT/qWy/dtIRy05bnhwwtxAYa255jUUw0jPXwRgEbkl9eI5J
    LKfnqC+rj6GQBxYd94RNlYc2ix905eJM5okEjsLCKyHo7nUXm79xWjYrK/clDeVs
    /8+vU2p4UMZ++xaoK0eLHDtKo3W3YCltGvyFXbvpUUHXJbH8vdpzBT66Hp3c3gdM
    fY2wqyfV90XYKGroMeyRiiXLvOy25kF57G+bALYGeOCY4i+HEv5PH1neb65EVWGy
    rO4rF81kO6e8egctMFxMA4ebPidZPsunToJq1ZsQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=qC9N/3Zo x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=qC9N/3Zo x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfE9ZPxFVegz9nf1WeuC3xhk+OJ7wOFSoiXwRLnIwqwE8QXkbndGgM1RZs/km0Yd4zN2KE61N2TxEKKMK517f6AZ1/Nt2kxvoI4r65K+z6pVJfhXkSC/U
    NxoV8sPz2qVAJJ7JFdc08e6J5/7V1aKWMCxghyrb7dHtMHSGyckAOox0h6wMD6orM4gOfqmN0WWlXcLHBfO5zeKpVWiB1aIbBUUqAf2W01KGZzu2ScaHSk0I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=vQBBkBfzAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=pwKNJtFcxakrAafEM-oA:9 a=QEXdDO2ut3YA:10
    a=NGXS0kB0m_rannUenejW:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030467AbeEXKuG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030470AbeEXJ53 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 139/165] media: ov5645: add missing of_node_put() in error path
Date: Thu, 24 May 2018 11:39:05 +0200
Message-Id: <20180524093627.703247266@linuxfoundation.org>
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

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 06fe932307d58108a11c3e603517dd2a73a57b80 ]

The device node obtained with of_graph_get_next_endpoint() should be
released by calling of_node_put().  But it was not released when
v4l2_fwnode_endpoint_parse() failed.

This change moves the of_node_put() call before the error check and
fixes the issue.

Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Todor Tomov <todor.tomov@linaro.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov5645.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1131,13 +1131,14 @@ static int ov5645_probe(struct i2c_clien
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint),
 					 &ov5645->ep);
+
+	of_node_put(endpoint);
+
 	if (ret < 0) {
 		dev_err(dev, "parsing endpoint node failed\n");
 		return ret;
 	}
 
-	of_node_put(endpoint);
-
 	if (ov5645->ep.bus_type != V4L2_MBUS_CSI2) {
 		dev_err(dev, "invalid bus type, must be CSI2\n");
 		return -EINVAL;
