Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36DAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625DE20666
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNS7pjCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625DE20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeKBI7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeKBI7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:59:15 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A6320666;
        Thu,  1 Nov 2018 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541116447;
        bh=Mo2s9ad1IU4he15B8yrhFR8iFRHQW5qp72l7p9bKPqI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lNS7pjCaUJ3ihaegPj0BAKB6Wr1WyXGI4fIch/uuMnB01DaYtFgfpZuJ+PYBcmtQe
         CqPWpxHFzxxlCFVwIFW5y5HYg0Mu4kPnUGUtnlmmK2dE5KYG0Fu21PvluYynUE1IXd
         ipfBa0IMWXqsokBQW+3c9B4LdwLPI47oO8/ugrXo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alan Tull <atull@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181101131549.24497-1-ricardo.ribalda@gmail.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
References: <20181101131549.24497-1-ricardo.ribalda@gmail.com>
Message-ID: <154111644708.88331.6842371975986185473@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: fixed-factor: fix of_node_get-put imbalance
Date:   Thu, 01 Nov 2018 16:54:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Ribalda Delgado (2018-11-01 06:15:49)
> When the fixed factor clock is created by devicetree,
> of_clk_add_provider is called.  Add a call to
> of_clk_del_provider in the remove function to balance
> it out.
> =

> Reported-by: Alan Tull <atull@kernel.org>
> Fixes: 971451b3b15d ("clk: fixed-factor: Convert into a module platform d=
river")
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---

Looks good. I'll queue this up for clk-fixes next week.

