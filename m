Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8032422CB2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="up02WcgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8032422CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeGFPMT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932345AbeGFPMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:12:17 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B95322CB2;
        Fri,  6 Jul 2018 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530889937;
        bh=BJhp1QdL1Eh5QCqBU8nNsm+FthbYJ3MTDLVuH9Sbg1E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=up02WcgKon1I20uMLmFGAATNM2K8tJpjCr/pnO+sh2pACTXLW9RInkgNZgIaCrb1X
         MA5insD6YryWNH0qPNoPa5hb+DF+QKM/PV/+x17v+NI8KvL2Ml1dXEzMmn0nIRt4eP
         muKdgfZ4v5idOZb+/VafnAxUyM3C5HaUY38aOSUY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180704130103.31790-1-geert+renesas@glider.be>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20180704130103.31790-1-geert+renesas@glider.be>
Message-ID: <153088993646.143105.11674939438681531758@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: Really show symbolic clock flags in debugfs
Date:   Fri, 06 Jul 2018 08:12:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2018-07-04 06:01:03)
> The last-minute fold-in of the ENTRY() macro did change behavior:
> instead of printing the symbolic name (e.g. "CLK_IS_BASIC"), it prints
> the expansion of it (e.g. "(1UL << (5))").
> =

> Use "#" instead of  __stringify() to fix this.

Do we need the stringify.h include anymore then?

