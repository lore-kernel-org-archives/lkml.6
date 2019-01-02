Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB470C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0E52171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546409122;
	bh=dhnXG1n1S3D6Lqdg7SueDX9GmgsyhXyhS/gqGSl3UsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P9YqTESTQ2epmGvHu860IIDSNgj+2J231nsiJ+wFRXhv6mchSa5dM/xXvV0ukm0ym
	 lVMlmqxpgOfg4UUpXpTiFHSjBCk05g8mfla4du7zCJo4U6IPKqk688eCKRKoOwk7NG
	 TU93aMhF9YVUaW8l2zn1ZTgsq/4Us+TsxTn/snEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfABGFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfABGFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:05:21 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8E62089F;
        Wed,  2 Jan 2019 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546409120;
        bh=dhnXG1n1S3D6Lqdg7SueDX9GmgsyhXyhS/gqGSl3UsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVyh4FiheVwJibjd6MhtNnAonzWy950X8QNFnlPGCGHhYRsP4MItyKvKGgpMQRgoH
         d7Lv/kkc1C7Brs5UP8mtiLV2sddY25J3Hj9j2tUwZo85NZR8vCm28tRjLV09PwOPvM
         noaUN12XLkd+mOSORyjY14Jynla4dXXTloRtTdew=
Date:   Wed, 2 Jan 2019 11:33:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        kernel-janitors@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/20] dmaengine: st_fdma: drop useless LIST_HEAD
Message-ID: <20190102060347.GG7581@vkoul-mobl>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-15-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-15-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-18, 09:57, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> The declarations were introduced with the file, but the declared
> variables were not used.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
> 
> Fixes: 6b4cd727eaf1 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thanks

-- 
~Vinod
