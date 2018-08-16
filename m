Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F77520657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F77520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbeHPGfF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:35:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:30585 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeHPGfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:35:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 20:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,246,1531810800"; 
   d="scan'208";a="83725622"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2018 20:39:38 -0700
Received: from pgsmsx110.gar.corp.intel.com (10.221.44.111) by
 PGSMSX107.gar.corp.intel.com (10.221.44.105) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 16 Aug 2018 11:39:37 +0800
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.221]) by
 PGSMSX110.gar.corp.intel.com ([169.254.13.194]) with mapi id 14.03.0319.002;
 Thu, 16 Aug 2018 11:39:37 +0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     David Miller <davem@davemloft.net>
CC:     "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Hean Loong" <hean.loong.ong@intel.com>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>
Subject: RE: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
Thread-Topic: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
Thread-Index: AQHUMtDFYnhmIYgh9E6ESFb7g+bMN6S9XxMAgAKwr9A=
Date:   Thu, 16 Aug 2018 03:39:36 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C04507691FD8@PGSMSX101.gar.corp.intel.com>
References: <1534142494-11541-1-git-send-email-joyce.ooi@intel.com>
 <20180813.094806.2117966073798365808.davem@davemloft.net>
In-Reply-To: <20180813.094806.2117966073798365808.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDI2ZDNmYTctYjVjZi00ZTk1LWIxNmEtZWVkYzdkNjBlNjdmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNEZReDI3OUhtQU5kcGp3VDdQYzJpYU1WMTR3U1pvN29EUUNvODEwdXp6QnZkTStMOW1OR200Z2R4YnJnUmZ1MCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, August 14, 2018 12:48 AM
> To: Ooi, Joyce <joyce.ooi@intel.com>
> Cc: peppe.cavallaro@st.com; alexandre.torgue@st.com;
> joabreu@synopsys.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> Ong, Hean Loong <hean.loong.ong@intel.com>; Vandervennet, Yves
> <yves.vandervennet@intel.com>
> Subject: Re: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
> register
> 
> From: "Ooi, Joyce" <joyce.ooi@intel.com>
> Date: Sun, 12 Aug 2018 23:41:34 -0700
> 
> > As there is restriction to access to EMAC System Manager registers in
> > the kernel for Intel Stratix10, the use of SMC calls are required and
> > added in dwmac-socfpga driver.
> >
> > Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> > ---
> > This patch is dependent on https://lkml.org/lkml/2018/7/26/624
> 
> I guess I cannot apply this to my networking tree then.
> 
> I would suggest that you make a helper in a header file which dos the special
> SMC EMAC accesses, or alternatively the regular regmap access, based upon the
> CPP ifdef.
Could you please explain what you mean by 'a helper in a header file'?

Thanks.
> 
> That way you won't have to put all of those CPP tests in the foo.c code.
> 
> Thanks.
