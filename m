Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC99C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01D720811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084015;
	bh=3Bpz42GxuMXt/KyfFSZJBbmwlTX6Wr52QtelL6VcUZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MrDMXM4inCP823H0WeIMchQbbVolBZf+lulla3oAJ71G9LYJofxsKfCnOTk3fT/KK
	 JFrEar3FQNZ8bKlq8NErAUgFLraWGe9u8SMiQCZrWdfs2zqNI6Rl/7jKWvnYlRENUk
	 yjsLZw2WUQi9Ltkl8OODVvW05TVSgNkdeWdau1Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394238AbfBMSxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393951AbfBMSmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DBF20811;
        Wed, 13 Feb 2019 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083367;
        bh=3Bpz42GxuMXt/KyfFSZJBbmwlTX6Wr52QtelL6VcUZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJnz8w/xvePFNq3PvOOmFrC+g+rwVkapBLy4tDhAaE1ZcQkYzoA1mVCN5TlBFOoBt
         nFn6ym1wlXMpBHvFmZc+QcswEMq26YtMB4PGw+qjOi/BLzUaWTvIAj4aU22+/z9gv0
         PyajUeZVfRw3UMnmons9iikuznMf8u1V5lYKK+W8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.19 14/44] samples: mei: use /dev/mei0 instead of /dev/mei
Date:   Wed, 13 Feb 2019 19:38:15 +0100
Message-Id: <20190213183652.852110227@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit c4a46acf1db3ce547d290c29e55b3476c78dd76c upstream.

The device was moved from misc device to character devices
to support multiple mei devices.

Cc: <stable@vger.kernel.org> #v4.9+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 samples/mei/mei-amt-version.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -117,7 +117,7 @@ static bool mei_init(struct mei *me, con
 
 	me->verbose = verbose;
 
-	me->fd = open("/dev/mei", O_RDWR);
+	me->fd = open("/dev/mei0", O_RDWR);
 	if (me->fd == -1) {
 		mei_err(me, "Cannot establish a handle to the Intel MEI driver\n");
 		goto err;


