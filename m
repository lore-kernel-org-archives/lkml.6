Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F1921019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182799;
	bh=tl9DCLKXjAhXy9ycBvnviTa/2UvZp7jSj4VYZkcOkmA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vdmkXocgXdDmxUoJv5h7ubDXGkIQ5G339sO6+zZCVcBeHS7Z+wJK/A+dIwyumRNGu
	 xCdye6i6bTMxg8qu4egDesd2GhP2BTznFgzLVGpIQYNFv9NbNkE//k8cwBS85PjHbx
	 hJhp9SNasWPR2ySRXmuDpSqncxAj2i3AlDbaslyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfAVSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfAVSqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:46:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A112D21019;
        Tue, 22 Jan 2019 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182795;
        bh=tl9DCLKXjAhXy9ycBvnviTa/2UvZp7jSj4VYZkcOkmA=;
        h=Date:From:To:Cc:Subject:From;
        b=hzMnRk08UUUJER3sBFFjC/OWuKamTjdtDHi8eRKcqlkCF1ggVJhgGaGsCvvYvlmwB
         eVym28nmG4SfkSsuLSpeqrxIo/p7LLS5qJCEGHaTiXr4ubCXm3lNJcKngh3pynyt8L
         Z49rv483ClfyDwH54U5yDw6QW7yyDExqFqB0NVZE=
Date:   Tue, 22 Jan 2019 19:46:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] stable-kernel-rules.rst: add link to networking patch queue
Message-ID: <20190122184632.GA32510@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The networking maintainer keeps a public list of the patches being
queued up for the next round of stable releases.  Be sure to check there
before asking for a patch to be applied so that you do not waste
people's time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: David S. Miller <davem@davemloft.net>
---

Jon, I can take this through one of my trees if you don't want to, which
ever is easier for you.


diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 0de6f6145cc6..7ba8cd567f84 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -38,6 +38,9 @@ Procedure for submitting patches to the -stable tree
  - If the patch covers files in net/ or drivers/net please follow netdev stable
    submission guidelines as described in
    :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
+   after first checking the stable networking queue at
+   https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
+   to ensure the requested patch is not already queued up.
  - Security patches should not be handled (solely) by the -stable review
    process but should follow the procedures in
    :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
