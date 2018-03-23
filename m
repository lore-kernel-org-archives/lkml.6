Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804705-2-6126665945424575195
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
    t=1521804704; b=YiXOsUbWIdcA/QAQjbtxkoOKr2t/kvbqou0NoGwcsDVcXVs
    D2/3h0z6QGgU93ld4ySMynS64oq7sn4NCHyjEmzA9wPfmjjnitJCQQSzgRQKiBHs
    PXasjRvzryWd2cZ+1LjPrX01e9L0HTq4NN3C2pDKHt3d6JOyFo60iXgRuHRFLpVI
    qgtwNIF55tn3IVGmStGi1ylK6ampfHuQUDyuA9yDR5N+4Ao1l8iVZsWrwh4WYWKJ
    R5mu0rNcEMw+MUsoNi4wskTH+Mx7JkpQlMfpOl7+BybwAykAgQeaEPLKAEKsJsAG
    NMCjKJ7FMuo+RNWQCgsEFa2Bfiilc+HcENfAxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804704; bh=cYBwezKud9zygmpTuOUgvc6X9J
    13vMDsEKgwXasG5FY=; b=kOqoRlW0X9yFtQWByp1u1hZflJ1w6d+HJai5yt6StD
    NE61QC9EjwvP7FjyxgZdLabeWt8+IVgyELXfhQZ7irk9WuYAgkENcw0U0JNhKyTN
    H5m1nxf75Nv1doNwZqitT5AEpNJ7dfB6BdOaO7Y7jWOn9lJpODV4+0+U7UM+arZj
    SDDUBx7yCYiP13dTdYNMSnP64AehmpfsrAa4AuuXxXnFUoC4djnQmI8X+/mP2B+t
    Lhw11ZvM/XnaJmZ2G49i5JKaFN9Zlb+y4ROu38+h0hxpTVpsm3uqMBF1/k+mhGiC
    ape0O71a96o7GzAl3a23o2GePxcTe/fEJpugkjarmFzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeCWKGG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeCWKGE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linda Knippers <linda.knippers@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 025/177] tools/testing/nvdimm: fix nfit_test shutdown crash
Date: Fri, 23 Mar 2018 10:52:33 +0100
Message-Id: <20180323094206.300215312@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>


[ Upstream commit 8b06b884cd98f7ec8b5028680b99fabfb7b3e192 ]

Keep the nfit_test instances alive until after nfit_test_teardown(), as
we may be doing resource lookups until the final un-registrations have
completed. This fixes crashes of the form.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
 IP: __release_resource+0x12/0x90
 Call Trace:
  remove_resource+0x23/0x40
  __wrap_remove_resource+0x29/0x30 [nfit_test_iomap]
  acpi_nfit_remove_resource+0xe/0x10 [nfit]
  devm_action_release+0xf/0x20
  release_nodes+0x16d/0x2b0
  devres_release_all+0x3c/0x60
  device_release+0x21/0x90
  kobject_release+0x6a/0x170
  kobject_put+0x2f/0x60
  put_device+0x17/0x20
  platform_device_unregister+0x20/0x30
  nfit_test_exit+0x36/0x960 [nfit_test]

Reported-by: Linda Knippers <linda.knippers@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/nvdimm/test/nfit.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1908,6 +1908,7 @@ static __init int nfit_test_init(void)
 			put_device(&pdev->dev);
 			goto err_register;
 		}
+		get_device(&pdev->dev);
 
 		rc = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 		if (rc)
@@ -1926,6 +1927,10 @@ static __init int nfit_test_init(void)
 		if (instances[i])
 			platform_device_unregister(&instances[i]->pdev);
 	nfit_test_teardown();
+	for (i = 0; i < NUM_NFITS; i++)
+		if (instances[i])
+			put_device(&instances[i]->pdev.dev);
+
 	return rc;
 }
 
@@ -1933,10 +1938,13 @@ static __exit void nfit_test_exit(void)
 {
 	int i;
 
-	platform_driver_unregister(&nfit_test_driver);
 	for (i = 0; i < NUM_NFITS; i++)
 		platform_device_unregister(&instances[i]->pdev);
+	platform_driver_unregister(&nfit_test_driver);
 	nfit_test_teardown();
+
+	for (i = 0; i < NUM_NFITS; i++)
+		put_device(&instances[i]->pdev.dev);
 	class_destroy(nfit_test_dimm);
 }
 
