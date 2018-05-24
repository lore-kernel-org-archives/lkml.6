Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156395-2-14675378161470084242
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
    1527156394; b=e8Hh3h/3oBsT6rSpRz6udIswMQWfxW8BOCE6Jrn0DpUSY7NAj0
    FTp2YccminTXtVfSoDbxrsElLynH7vOgK8W7NlBvO1DACBeRTXSWU7Bg1rc5BUDH
    RKEM1BTmyy0YHQgvWuxrAnK92QanXp2U8RyMDRE+hvua4IkVBcPipXsungtNA7H+
    IGydcHQhrwyhzQ/aqXQDLmwceybYvWDXc6mHI4RyQeLYym3WkeuOMBFof9dm+G25
    qzNd7U8CaOi5EFtbSy1iEeeaFMl0bj7ZdiT/eUHqxizRt7ahOnZF6lG1MWHzb7K6
    NPg2LIJEtEKXPCZu7lcZfqkWLDkQhdxuLz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156394; bh=dIT1LI0FnG8jeZ0km509YJpcqHM0tt
    441VGrvVQkIGI=; b=EsZK+fK9Jf2qLjrK17ajjCXwwHbpmI5wVQiAKg+AO36oEZ
    hjhzSVZRtwaU3rWvp6XTYukIpgVNaxIhbRE65Sp8OQGcjW2mLkHIybHQ1R2JFt+F
    HQjWWuiAEbPGb8p0SE1Yj8vlQoz5RV9X58Y6VrUPKQTrwg0oFjDXCbCZ3YUFJlhR
    JiEkky8xL4JmPANwl3bR0lxKPmemhFnJWs1yQ7iukWRUV8xND09Nt4zgukqhXCU8
    wa3J5KtaujuAHc6jpG/T+Y8RLIW69VAgwTGooAslFM+QdfPw194yH2EU74C/ZdV8
    R/5KD8dDgK1q4k5w+aeuY/eDz+4Gvy65yPzCwoEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=U+RQT1hY x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=U+RQT1hY x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGEF3YKxRM3PDxQIrfYHIzNqzAQdiiQD3Byv8/fjcPFWudzoE5v4HmxxGZJ09p+Z4a62xKYQ1Tv7jxF7f09K4MFNUqq4wNz+/TmXWJ6TB3mHPq3F2GAH
    fFU/Cx8F7ZqVCftmBcsWAnXwHKy3mkT0P3Wm6qRQuL3E0EppTCgNAJfvRdaUom0FU1VGde+1sVUF8dBRQo9msP6LODVyRL3p8hkATU9LbiD+7W6hD/I7G2fj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=vQBBkBfzAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=pwKNJtFcxakrAafEM-oA:9 a=QEXdDO2ut3YA:10
    a=NGXS0kB0m_rannUenejW:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031695AbeEXKGb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031724AbeEXKG3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 134/161] media: ov5645: add missing of_node_put() in error path
Date: Thu, 24 May 2018 11:39:19 +0200
Message-Id: <20180524093034.408896200@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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
