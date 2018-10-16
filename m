Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D7BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4862214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIwdLrh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4862214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQGgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeJQGgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:36:40 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2C221471;
        Tue, 16 Oct 2018 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539729845;
        bh=WraKKlw7FLBAet3clYJlOXNFU0lbilCqu3z92iK5NQM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TIwdLrh3HE0V/LqLYtsELlepSRpUxqnMd/2ZFYqmNOPQtfZkRPjdEmPoLzX1DRe3s
         ueVByw2yDl3NgTGlsqb1XFDgN0LnixOqU5bGiUfEztV2SNwlv49HrJEt6HtTwW/lrT
         EXYYyPDMbc/tXpWpnMoZNE07wNIe/VZ4pogclMhQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535690756-22234-2-git-send-email-aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <1535690756-22234-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972984485.5275.12234542827124661483@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 1/4] clk: bulk: add of_clk_bulk_get()
Date:   Tue, 16 Oct 2018 15:44:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dong Aisheng (2018-08-30 21:45:53)
> 'clock-names' property is optional in DT, so of_clk_bulk_get() is
> introduced here to handle this for DT users without 'clock-names'
> specified. Later clk_bulk_get_all() will be implemented on top of
> it and this API will be kept private until someone proves they need
> it because they don't have a struct device pointer.
> =

> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reported-by: Shawn Guo <shawnguo@kernel.org>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

