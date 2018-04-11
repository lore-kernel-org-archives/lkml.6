Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476440-2-8457381693766272241
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476439; b=TD/ZuslEchI1G1Veo3PLJ5VfYRklfyg5S4BeB7EnHZhy9SULcx
    G6Fg5Kv5njPXF8KW+A2Yb0tUU9TGH9RoPTnzi6NPk2plhjQSzGz79v64RYBwPq7A
    2yHFommk+9+7Q7idwI5yqsHMRkXj7Vt8O4WWIrL7OOn6Xhtv/72LcyokDfQwOrIR
    6luh1Dy+kAcuO42yFbObf3c9dZwfiWqL1y4VExPXnCRoWZ2WYMdSQvxH72Y397MV
    lEAYOUt4KGpaRik3fPlX4e3KEy27kuBzs8k2XssyVQ2SZhCHAEOzixguZaas3pwX
    Ee5MF+nU5aBF1/hu/gPKvgkCrtEp91hlI6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476439; bh=V5nXwSsRXCAA8H2oTWvSpjn42QdBxV
    MxzcFxm/POoco=; b=LblRuEPxkcA/hnkbz59di8Gus6r8H2LuIKI3mVqx5Ner3+
    XFbNvE4H1FNiYa46oi08Ep5LH1d2iLbNTduwcTiBLfLvg55WPHGXgkdlsKyCed33
    TDreCuyvfBX5x93pso7qMTBa+uzFwNqx03LSOxjQeBuA+Jvef2t4UPrB42V4Bcj4
    n3GraseZEdYNutIJzck4dCS4aG2ATzMjMG7ynpxcxRu717r2ITxBsAQckLMvVQL3
    R8JxYmfZFamI8JJ1a58GjuDf8HDs0iJFIxVcci4HdiXuZ0w3sr8d66ZOQ+W/NGwv
    4HUuSpvHRPabioEPb3JYPigf6VQtG4ScQQuEe1Ng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPn9AcsWIdMLAQCfuOkoWiULGnsn6hFDp4w7xfM9fn6Ynil6Wb7Km/Ohs/RA7wxKi0whdpS5hjNQQtw81d6PxhcvqC1hOFxP1d8f+0Ek+ULdSSMq9x9b
    /rtTi34+KgkT4eq9X8/T7JJ4vM5Ubn/QdM+2Zh0E/y+/CTF0vzrA4Hfu9SsnzHdyt2AA/mhM5Mc2FZHBSS/zINsHxrbs0e+/5qvNtEKF5iPflP8lgZ+uXf//
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=pxHjaVKFZpeEMF968NMA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756551AbeDKTxo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:53:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756487AbeDKS5w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 120/310] i40iw: Correct Q1/XF object count equation
Date: Wed, 11 Apr 2018 20:34:19 +0200
Message-Id: <20180411183627.322584441@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Shiraz Saleem <shiraz.saleem@intel.com>


[ Upstream commit fe99afd1febd74e0ef1fed7e3283f09effe1f4f0 ]

Lower Inbound RDMA Read Queue (Q1) object count by a factor of 2
as it is incorrectly doubled. Also, round up Q1 and Transmit FIFO (XF)
object count to power of 2 to satisfy hardware requirement.

Fixes: 86dbcd0f12e9 ("i40iw: add file to handle cqp calls")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3644,8 +3644,10 @@ enum i40iw_status_code i40iw_config_fpm_
 		hmc_info->hmc_obj[I40IW_HMC_IW_APBVT_ENTRY].cnt = 1;
 		hmc_info->hmc_obj[I40IW_HMC_IW_MR].cnt = mrwanted;
 
-		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt = I40IW_MAX_WQ_ENTRIES * qpwanted;
-		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt = 4 * I40IW_MAX_IRD_SIZE * qpwanted;
+		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =
+			roundup_pow_of_two(I40IW_MAX_WQ_ENTRIES * qpwanted);
+		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =
+			roundup_pow_of_two(2 * I40IW_MAX_IRD_SIZE * qpwanted);
 		hmc_info->hmc_obj[I40IW_HMC_IW_XFFL].cnt =
 			hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt / hmc_fpm_misc->xf_block_size;
 		hmc_info->hmc_obj[I40IW_HMC_IW_Q1FL].cnt =
