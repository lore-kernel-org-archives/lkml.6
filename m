Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD38A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544068;
	bh=6l4Cq8rrkeClX+SxAqIV3/BsQcmI7MAGzbAxeeoyqJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/eSms78bN4Qltu238KQUUC5irQUMfwFvx55/F8DNJzwGXqGfI1y9CDHQFq6aaRME
	 CGDpitJQ2TPEFTWzoGZt0Bn/TesMW/Kvw+M3npo8hpimLW0ov2R8O1XkOFuE6P+POW
	 v7H9fITZwnb8DGfQ4BRnDSDxEuKnC0xu+W8w10aI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD38A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeLKQBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730900AbeLKP5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599B620855;
        Tue, 11 Dec 2018 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543868;
        bh=6l4Cq8rrkeClX+SxAqIV3/BsQcmI7MAGzbAxeeoyqJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0v1cM5266PcQ1IkHRYjNlgnZuBI5T/Pi2dapI/tnu6RSS7q8Ubenh/oy7TS5+On6
         4HfS+CFUq6l0Gbjo63IDXRcufmS+xS4prg5TrJsaXqgADskIFN4Xe6weV5btqEZEFK
         J/RCRtb/UlktAUzk5vZDbwy6o0erMxGTlluy1gqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.19 095/118] Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c"
Date:   Tue, 11 Dec 2018 16:41:54 +0100
Message-Id: <20181211151648.103638389@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
@@ -1566,7 +1566,7 @@ unsigned int OnAssocReq(struct adapter *
 	if (pstat->aid > 0) {
 		DBG_871X("  old AID %d\n", pstat->aid);
 	} else {
-		for (pstat->aid = 1; pstat->aid < NUM_STA; pstat->aid++)
+		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
 				break;
 


