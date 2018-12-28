Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B797C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2B320866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026354;
	bh=/0YTMIQVyQ7DV6Ya3EDVN+WNCRGoSLgZtNfbh+tjEdQ=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=LR9IrsfVU/FGxLHpMqZDyv+pZj2GDKfkieg/U78yPRFAyd3S2ert3ooepZDltSlp+
	 J1QSFdcXSbTzNsI+vgEnUuDPJLf3QxlHT/U/HRQkb0NMfvZ2AWodOsMEqOuxGZ3aBT
	 OIzWZlAQeUR248qHBDhsxrJbzbtvv7dEAgxtoUgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbeL1Tpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbeL1Tpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:45:52 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD80520866;
        Fri, 28 Dec 2018 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546026352;
        bh=/0YTMIQVyQ7DV6Ya3EDVN+WNCRGoSLgZtNfbh+tjEdQ=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=XXOi4bQXA2puUvBOLTfsRGVfPEexZ24zP1C+OY23dQ17BaO0T5wHR89/s2IoOIbth
         27ybWWWCmm2pqXWMp1NFDAhjHqY0fTlTmvsF6saT9O5W/Wy46VbxcnC7Z1b5yUKOvc
         Il/XQbMWfOpwD1L0j/23LSmJrVPD1+vvw6IURLj4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, mturquette@baylibre.com
Message-ID: <154602635108.179992.6419792316378761847@swboyd.mtv.corp.google.com>
References: <20181226135013.5580-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: dove: fix refcount leak in dove_clk_init()
Cc:     gregory.clement@bootlin.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135013.5580-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:45:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:50:13)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

