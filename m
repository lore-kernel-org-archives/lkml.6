Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F658C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52E020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Al6vaxjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52E020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeGZIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:45:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37820 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeGZIpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:45:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so628293ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pUcKOyY1SzmiBcRc9amn/zOnoC+kJ5Epq3eip381wX0=;
        b=Al6vaxjEJXinDrvX0ejp1Cej+5cKpPTtUVd1pnKSWu2L3HilofOqrapLI9eqAqeY2s
         C4ZjBYJAedCG87Wcn3rDej0lTu+prnywiS8ZPK8dSX4hJYvn+N1NvsDleoEz9cOHi/bD
         8JCMsl6oYnRA72AEYuT7+3FrXnSTQSGpHLLs1xq/gQ8s4zr3kCZEbOe96GsZ+rzc0n7h
         hzjKmMLGr/47KeLSuiwlGlCC20pDgCbPG536KMllcNokSmFcvGqtMMaZ3oVscTqNr/zw
         pJR+qX3MtCZKAmnHuh1/+oLwuiMYy7mivza6iPNkWtLGTU89/NLoOy1DwZRslWKt16zV
         XAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUcKOyY1SzmiBcRc9amn/zOnoC+kJ5Epq3eip381wX0=;
        b=L+hiKOxCQC/9l7s1hVbABgKzrd1pMC66wGciaYdUJ4/Ih/EUGp5aYOSPaPBafZYaZg
         ysz4UdBZKlZPKtLMMFcY6MxIN5E149qW4Zi6FWUAxTrHCUBuwi5GgWyeXQC1DhRqQ85G
         OBbeUsC+jv4OWALraeC611o3B8hTzi6qc3vubObjqcW1yUSfT4w3+lOEo1fnsZzdf270
         dN/VXP7VaQzEklEosxGUYdNX/OcigkVj3doTIA+GL5e+9x/PaW8z12qbbD4mPt649HlR
         PJzCnZTtJsjm1KrwYcjs44MEODFAhJp1n7PGSkTMmm2H9BjhdeexciQrrWD2h9vNvhL2
         eBJg==
X-Gm-Message-State: AOUpUlGRbCi8NfHwhrPP/J7tkKFPY7u9BrC66YmxhiQTIEL2GzD1Rpf8
        sg1JS6AwAWpV/PJWLmGHtJPHBQ==
X-Google-Smtp-Source: AAOMgpfF++BKC1YHev15q+X1LyYhZg9qGDh8jm2hzrw7jdacnBNAOYIrfG5W4JgZSAgPOkY1HV55Rg==
X-Received: by 2002:a2e:9854:: with SMTP id e20-v6mr658967ljj.143.1532590188601;
        Thu, 26 Jul 2018 00:29:48 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x8-v6sm101586lji.53.2018.07.26.00.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:29:47 -0700 (PDT)
Date:   Wed, 25 Jul 2018 23:52:08 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: sprd: Add SC27XX breathing light
 controller device
Message-ID: <20180726065208.yalawbgabym3evzy@localhost>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:10:16PM +0800, Baolin Wang wrote:
> The SC27xx breathing light controller can support 3 outputs:
> red LED, green LED and blue LED.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied 1-5, thanks. If you send a series like this, feel free to send a cover
letter as well, to let us know what you want done to them. I'm presuming you
wanted them applied in this case.


-Olof
