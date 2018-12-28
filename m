Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F76E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999801;
	bh=DeGWKLMnwDZHJOGB2FtI7wd65UOGDYEYn3BUjUPxNlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xiX3bCU9LmCxm3hsLesoGEWaFg2beMq0mYtG6s+D2+p0Mue86V26lpsACna0LbEfY
	 IUtBGoc5a7Z6gwAqSfc4yS+g74sd5LAN6h6W6gUFMVg1hr3SdloVpt+6pdrhd29quj
	 yIporGF71ZT2tuflzEMvKEttyV7WEnqxW6qdK1b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeL1MXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbeL1MOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFFB2184B;
        Fri, 28 Dec 2018 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999286;
        bh=DeGWKLMnwDZHJOGB2FtI7wd65UOGDYEYn3BUjUPxNlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVQNpyNbLzJ9NINpAILygeiHNC5XlH/EErJqYSr51cayD4Vkg2LIFP1LZEXoki3ct
         XbPn9Jesq1DcRzxj1WboEG6P1y2R3gOBdPVBN/V8jedse/a0THVB0ocEsmCy2DFMjw
         kjiMWeG+WDkmoAab0QvdPrIhMxUVr9NQnrjXfKPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 36/46] iwlwifi: mvm: dont send GEO_TX_POWER_LIMIT to old firmwares
Date:   Fri, 28 Dec 2018 12:52:30 +0100
Message-Id: <20181228113126.967185612@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit eca1e56ceedd9cc185eb18baf307d3ff2e4af376 upstream.

Old firmware versions don't support this command. Sending it
to any firmware before -41.ucode will crash the firmware.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=201975

Fixes: 66e839030fd6 ("iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE")
CC: <stable@vger.kernel.org> #4.19+
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -868,6 +868,15 @@ static int iwl_mvm_sar_geo_init(struct i
 	int ret, i, j;
 	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 
+	/*
+	 * This command is not supported on earlier firmware versions.
+	 * Unfortunately, we don't have a TLV API flag to rely on, so
+	 * rely on the major version which is in the first byte of
+	 * ucode_ver.
+	 */
+	if (IWL_UCODE_SERIAL(mvm->fw->ucode_ver) < 41)
+		return 0;
+
 	ret = iwl_mvm_sar_get_wgds_table(mvm);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,


