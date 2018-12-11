Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69126C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E6F2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543591;
	bh=tvagHUjmVxhBAr8wkvvz5OHFHq51xkh0OOvlwUozURo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAgYxk5cO5tZQ3CvgcYi8hEAs5/4i+0aACnYClkAILAvj2RYpSPgEaxGw0ffLjmhd
	 aqdrU9qBXXBOZP5tSKqLPdoqun5ArDMo2H8ALj5R8+IGJ2vf4MFjfSGug8QyAcbmUJ
	 7D3rrVeB6nqf4oTfEYj25dqffjqgijqvuDWLFmlA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E6F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeLKPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbeLKPxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B75692146F;
        Tue, 11 Dec 2018 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543586;
        bh=tvagHUjmVxhBAr8wkvvz5OHFHq51xkh0OOvlwUozURo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVz9+D5QjLGox3i/ScRI9Eq1yvzz22VW/pGTKgGbKxuWC0OV0pTnapo/3B4J28W8V
         efmrOxU5D8Y1Dv+AXeosEeRVPiF/bu3Crrowrfw+TMwe410+IDSd7bkLXuP/97tCpT
         mEdfaT5f/EL/DuMyj8CE0HHzfz1xFyZx3LS8K1s8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.14 55/67] Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c"
Date:   Tue, 11 Dec 2018 16:41:55 +0100
Message-Id: <20181211151633.166894987@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Young Xiao <YangX92@hotmail.com>

commit 87e4a5405f087427fbf8b437d2796283dce2b38f upstream.

pstapriv->max_num_sta is always <= NUM_STA, since max_num_sta is either
set in _rtw_init_sta_priv() or rtw_set_beacon().

Fixes: ef9209b642f1 ("staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c")
Signed-off-by: Young Xiao <YangX92@hotmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1574,7 +1574,7 @@ unsigned int OnAssocReq(struct adapter *
 	if (pstat->aid > 0) {
 		DBG_871X("  old AID %d\n", pstat->aid);
 	} else {
-		for (pstat->aid = 1; pstat->aid < NUM_STA; pstat->aid++)
+		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
 				break;
 


