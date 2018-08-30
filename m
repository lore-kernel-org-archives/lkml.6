Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E01720835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA8Izxc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E01720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHaCEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeHaCEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:04:05 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4297D20835;
        Thu, 30 Aug 2018 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535666388;
        bh=k5nNplanJXLD8R25ZN3tUA/rqQJoY7qYnig+55I1ieA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qA8Izxc9IyS+soTEIO3C3BZAr5aWrLHilBOnTOWTKCTl2lqDq/LfR95sIa9G4Yh/g
         2pzdVAAM6+OH1NZ+XZxyMPwa2DHLoBTBEq/Inpg5EdQ/dhlF8w9kmhGD8pwsMBN5Hn
         Vu2X5hrlYnTu5BUvJ/WmqBeUvtnXwBqdHLG78Y8E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180830173437.63601-1-dianders@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180830173437.63601-1-dianders@chromium.org>
Message-ID: <153566638758.93865.13101841945914366899@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Allocate space for NULL terimation in DFS table
Date:   Thu, 30 Aug 2018 14:59:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-30 10:34:37)
> The table allocated in clk_rcg2_dfs_populate_freq_table() is
> eventually iterated over by qcom_find_freq() which assumes that the
> table is NULL terminated.  Allocate one extra space in the array for
> the NULL termination.  Initting of the NULL termination is implicit
> due to kcalloc().
> =

> Fixes: cc4f6944d0e3 ("clk: qcom: Add support for RCG to register for DFS")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

