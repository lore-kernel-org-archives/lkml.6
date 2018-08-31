Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4315DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D937520839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1+sOFBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHaFLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeHaFLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:11:40 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B0120837;
        Fri, 31 Aug 2018 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535677607;
        bh=ULij3a2jM9O7Y3rfSQXhVdn1BC0h+qNF6qcgifUUbgQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=p1+sOFBMBg4enFKkLSTWr5AZhOUlVi9qwhimI1TYLJc3XS8MBxiEL2WWTw2Lns4pU
         le0cwn4lbV/DLYcOLCOHtt7rQPvoHmglzGaF6WMTNKPlc8GHXgt2OgX+wwrApsTDua
         YQGAu09OC3tetUl1OXSEA6bbwB6i6zxyZqLZVqMs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180829231505.22660-2-bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
 <20180829231505.22660-2-bjorn.andersson@linaro.org>
Message-ID: <153567760668.93865.10990310466407439634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] dt-bindings: firmware: scm: Refactor compatibles and clocks
Date:   Thu, 30 Aug 2018 18:06:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-08-29 16:15:03)
> When the binding was written all "future" platforms required three
> clocks, so the default compatible (qcom,scm) was defined to require
> this. But as history shows all "future" platforms actually lack required
> clocks. Given how the binding is written these compatibles have to be
> added as an exception to the default.
> =

> Refactor the description of compatible to define that a platform
> compatible should be given, followed by the fallback of qcom,scm. Also
> refactor the description of the clocks in a way that this does not need
> to be updated as new platform specific compatibles are added.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

