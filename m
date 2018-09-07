Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52FDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C2C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jlJOS+8t";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iQtfZ3kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C2C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeIGOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:55:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:55:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CC9E96081C; Fri,  7 Sep 2018 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536315293;
        bh=qDntGwJzHvy08e2yrK+JdJXtSBifSl5Ps+daquZnAi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jlJOS+8tjaphTkLmbKRD2v9rCSyB7bFt2C5yZdn2yMRqu4a2cmNmO2tqP160K/Rzi
         eQ5wgDsvbl/GQqHP2YdTastp4x+XZOVPJ2rG/BHG1i/rh4x6UBicwig3xW9+ovioS8
         ZscCasaKyCOIJdj/OfJY1kPJPNCP2PNu7GQKf/To=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 30CAC6081C;
        Fri,  7 Sep 2018 10:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536315292;
        bh=qDntGwJzHvy08e2yrK+JdJXtSBifSl5Ps+daquZnAi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQtfZ3kqqRyrVbfRX5Eyhddqi1+DXzZ/O/ay+maClceCisYg+5N6TB+kEFmPo2jUn
         hW608Dv5Z7/4mWaV1gqTHhD6Rtrk9lzKBZjz4P25cieRlJfdN/lOzglDH6Wv3LaYeT
         jX5tezP0X54rWnrtTN9EQ9JEslHs4a8BGGASE4Qg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Sep 2018 15:44:52 +0530
From:   dkota@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>, dkota@codeaurora.org
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
In-Reply-To: <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
 <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
Message-ID: <b87df0b445cacd3755280aa8a6b2c3cb@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When spi_alloc_master() fails you don't want spi_master_put().
Agree, will update it.

--Dilip
