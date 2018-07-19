Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2743ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDD0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFByDv5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDD0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeGSGSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:18:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeGSGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5MFmkYms5yYCQAfbSF4ap4/5S3nC+L+o3f0D7TeVZOc=; b=eFByDv5su/J87YK+Dq5oSrXM5
        4JgdSeRBW/MaLHPCkZOHfmx8BVVCOuKMVQ8jkpcyez3foqirKKGzIy9dowiOLqONVEVB3B2SGxKmE
        8SQYfo9N2rmQIh4efyeydnlBEiBNJ0DFveP62JAb1eLJoid4IV2kO3kZ3/J8cDr0s8jl3ysNdNuR1
        43kMOTVA+/Img+uH2aH8ZiDj2SckKXytz+XSJs8lh5Jnapxa+DxhGUSwzot62NL+ovpLAk4E5KJGs
        Y6h1xeiCycu9W4m64q7t9ahmU9Bm2L5Knh7VVp//SSveyrT8P1oVKP8xW7IMAmfT+o1yDeSu53vyi
        hFWOCOnow==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg1d1-00023e-Qt; Thu, 19 Jul 2018 05:37:27 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: arch/arc/ allmodconfig
Message-ID: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
Date:   Wed, 18 Jul 2018 22:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I try to (cross-)build arch/arc/ allmodconfig, I get a syntax error here:

./arch/arc/plat-eznps/mtm.c: In function 'mtm_enable_core':
../arch/arc/plat-eznps/mtm.c:113:30: error: storage size of 'dpc' isn't known
  struct nps_host_reg_aux_dpc dpc;
                              ^~~

There is no struct nps_host_reg_aux_dpc in the kernel tree.

Can you do something about this, please?

thanks,
-- 
~Randy
