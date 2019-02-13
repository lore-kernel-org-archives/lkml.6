Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF3DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B02420811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083703;
	bh=H7mO+5KlV98HYrchyteU7kI7Z3cne0/iMkVBbcGlbsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvC6xMQJD9Ggihkvp3Kbn9cozSqimR+jz6Gv4y9WPrCdVxDqJYrS2X0aS0hZoaIB4
	 rdr6+IFszyKzBh3BRUnuSPWQcYzT60noIKuFgzcwCYptQPokE9GZtKWZMCsjcBi1xk
	 qQMVtUlRt5yPNMC7kREWwWi9AH1gkSXpWWGzn+Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394114AbfBMSsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406462AbfBMSqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5680220835;
        Wed, 13 Feb 2019 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083591;
        bh=H7mO+5KlV98HYrchyteU7kI7Z3cne0/iMkVBbcGlbsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DyQw5ovRJ4lpS1KNHW8rgcIyjewKl+rcbKyTVk4BpGEVyR7QNoDSSBlzfzjCYxLw6
         z0pJw0sdXEVYOTe9V7EM2VbnukzJC2DiHS1AY8WYBdKIFv3n0jm3zsMV7p1kbK8eG0
         q6wjadV7C97u0TDywrxHoCjXoStuWSMVhU4vVfbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.20 16/50] samples: mei: use /dev/mei0 instead of /dev/mei
Date:   Wed, 13 Feb 2019 19:38:21 +0100
Message-Id: <20190213183657.103848264@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


