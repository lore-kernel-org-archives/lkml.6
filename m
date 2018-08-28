Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B49C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB4B208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZASzkc0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB4B208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH1MDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:03:09 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:54818 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeH1MDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:03:09 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3E4B224E257A;
        Tue, 28 Aug 2018 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535443960; bh=yF3mVHGtlGIB9GktsZktnNLO/I/OW7PLaAIdKBrVQEM=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=ZASzkc0Q9+1oC8IdXFTHs0qlclOrR/LI1sQeJaKEClbPDzcC207ta+hAaqhYeSjHK
         cX/FeAuD/F6GDOXUYuFPyA8tGGtpfYKsaOSXvTdgf5sA8lHgRcOo3E8DL3nQpIw3Sd
         9MGzZ8llKDccCp5d/5fkgULLdrYDn4rPM5u+dMA63WsRbprhDe/qvsw24T8FzH5CAS
         CVQkdj9pDSTf19D3XSHLGJ9xHyyyFAc0dz92ZDjZFTkVY4JuRRpBjSRvzxBU4Q0keP
         EmoSQ8KMJ6BQAUNzQY+QE8C9yKLmdUrcLc6mizzzGsI66HO22P8NKC65DR8oZOsMJD
         lHzm5qKdo2oSA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id B0E3756C6;
        Tue, 28 Aug 2018 01:12:39 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 28 Aug 2018 01:12:39 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 28 Aug 2018 10:12:37 +0200
Received: from [10.0.2.15] (10.107.19.14) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Aug
 2018 10:12:37 +0200
Subject: Re: [PATCH] Revert "net: stmmac: Do not keep rearming the coalesce
 timer in stmmac_xmit"
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>, <netdev@vger.kernel.org>
References: <20180824090440.13411-1-jbrunet@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <d3858ef0-97c7-28b5-db4a-4ac71af52ba5@synopsys.com>
Date:   Tue, 28 Aug 2018 09:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180824090440.13411-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.14]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On 24-08-2018 10:04, Jerome Brunet wrote:
> This reverts commit 4ae0169fd1b3c792b66be58995b7e6b629919ecf.
>
> This change in the handling of the coalesce timer is causing regression on
> (at least) amlogic platforms.
>
> Network will break down very quickly (a few seconds) after starting
> a download. This can easily be reproduced using iperf3 for example.
>
> The problem has been reported on the S805, S905, S912 and A113 SoCs
> (Realtek and Micrel PHYs) and it is likely impacting all Amlogics
> platforms using Gbit ethernet
>
> No problem was seen with the platform using 10/100 only PHYs (GXL internal)
>
> Reverting change brings things back to normal and allows to use network
> again until we better understand the problem with the coalesce timer.
>
>

Apologies for the delayed answer but I was in FTO.

I'm not sure what can be causing this but I have some questions
for you:
    - What do you mean by "network will break down"? Do you see
queue timeout?
    - What do you see in ethtool/ifconfig stats? Can you send me
the stats before and after network break?
    - Is your setup multi-queue/channel?
    - Can you point me to the DT bindings of your setup?

Thanks and Best Regards,
Jose Miguel Abreu
