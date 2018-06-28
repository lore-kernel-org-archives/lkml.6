Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933D5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370A82770D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KpX4GH4r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Inp4IhfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370A82770D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967660AbeF1SEV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:04:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965570AbeF1SEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:04:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C3B0606FC; Thu, 28 Jun 2018 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530209059;
        bh=j1/to6wexcZULsBCjnOabjKY2e/RZVaylMGBHOYZ31Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KpX4GH4ryPuYyWOG0EIWHsthilSl8wfM5T9AWUUxIZJktxuDBbc39i031Y/ccv3QV
         Kc068lvejWxOGbvNoH0j1HDxt+yGgGLGJT9ZfRT19SWIcYyv90W45+StteQ0MoH1Q7
         5FOMuZnjQg+euDtjiTg/7mFgEaDykXE6uv6wxFsU=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F54F606FC;
        Thu, 28 Jun 2018 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530209058;
        bh=j1/to6wexcZULsBCjnOabjKY2e/RZVaylMGBHOYZ31Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Inp4IhfRRAsTCD2uq1p7VPn3XRsvs3xWYzTrNhK1NUz5lbk7SO691ZKhIK7iWEr3A
         Bt5s7DtE6OHevMX7ieWt/myHGtCtymSl8uqZtRiW2fL2L6KStYxu/pyX2dU2Xu7Zwc
         rznmmS2XIHX+gB3NTi+rgnOABhM4nBFwXsKocT+4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F54F606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
To:     Mark Brown <broonie@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
 <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
 <20180627150126.GC5263@sirena.org.uk>
 <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
 <20180628101813.GD14040@sirena.org.uk>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <87cc8c77-7b39-1746-4680-cb26d602e62e@codeaurora.org>
Date:   Thu, 28 Jun 2018 11:04:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180628101813.GD14040@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 06/28/2018 03:18 AM, Mark Brown wrote:
> On Wed, Jun 27, 2018 at 09:28:03AM -0700, Doug Anderson wrote:
> 
>> OK, great.  I guess I'm confused about the "|| COMPILE_TEST" causing
>> problems then?  I was worried that anyone trying to do "COMPILE_TEST"
>> on your tree (or linuxnext if RPMh isn't there) would get failures due
>> to the lack of header files.  I guess if it's a problem you could just
>> gut the "|| COMPILE_TEST" and it could be added back in later?
> 
> Ugh, yes - that'll break things.  In that case I can't apply this
> without a signed tag from Andy's tree with the dependency stuff in.
> 

Do you have any remaining concerns with the qcom-rpmh-regulator binding
and driver patches that would keep you from applying them (other than the
dependency patches being applied first)?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
