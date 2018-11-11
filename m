Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2548FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E131E2154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LspKnwSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E131E2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbeKLIYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbeKLIYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A422154B;
        Sun, 11 Nov 2018 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975672;
        bh=DSc/qJS1Prtj4+DOKSUNmjPrXr+8+h3lxzAPkT4QBfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LspKnwSuHdkLz92tskBu/IWxrcj7aImKJ+Yo9XXjvbWt/m1KQjJcdbkza3M2MxVSn
         v6k1jSFSXFdhn4kG2YnGAPhEJxxyyBKKyWCw0wTi5XBLqy4UFYBblA67KHJFqui1RO
         ukcMb+aCXioyCqkzGHjwEvDglJPkhNyiTFjcU7aY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 086/141] ASoC: intel: skylake: Add missing break in skl_tplg_get_token()
Date:   Sun, 11 Nov 2018 14:25:45 -0800
Message-Id: <20181111221640.122728282@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 9c80c5a8831471e0a3e139aad1b0d4c0fdc50b2f upstream.

skl_tplg_get_token() misses a break in the big switch() block for
SKL_TKN_U8_CORE_ID entry.
Spotted nicely by -Wimplicit-fallthrough compiler option.

Fixes: 6277e83292a2 ("ASoC: Intel: Skylake: Parse vendor tokens to build module data")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-topology.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1780,6 +1780,7 @@ static int skl_tplg_get_token(struct dev
 
 	case SKL_TKN_U8_CORE_ID:
 		mconfig->core_id = tkn_elem->value;
+		break;
 
 	case SKL_TKN_U8_MOD_TYPE:
 		mconfig->m_type = tkn_elem->value;


