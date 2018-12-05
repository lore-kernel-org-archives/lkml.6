Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6141F2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544041831;
	bh=b4oyxS4iMopUp29m2C2NQI+PNAYq+8M0E0GyaLOMv9U=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=EHvgiD2jBoF6HLyCToTNzXKZB7hmDxV8V55qyzuKPOfm1z7FeblD2teu+vJuMAhCm
	 EibuZbCIdM0+cHaV2VXF+qsy5L06jrVz7R1OBdUrj+x9WnNwM/hUIhBhyoaGGE6Zzo
	 Buqgrqhpg5HmDXcQnUP4ljasc0QAyHlBKhUJzVA4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6141F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeLEUaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLEUaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:30:30 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542BE20892;
        Wed,  5 Dec 2018 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544041829;
        bh=b4oyxS4iMopUp29m2C2NQI+PNAYq+8M0E0GyaLOMv9U=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=dxqcjrz6byhUjV+YY09tMOlRnBZSZLW+Btc/O2OxbP9Vu4qdqQjLkCpajGo0AqRov
         K7P97hNaGvz1o5Y+79k70+sbRyBgUx6zsgrGw3x3WjVB8xJt3XKowpZwRbvB0GuaFL
         VHVo+1H6fOzSQHqqDmazP/lZZtl2MjYgDeLVpUQg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ryder Lee <ryder.lee@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <2e828830d051ae641cfd55a6590cb243539d6ca8.1543991319.git.ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
References: <2e828830d051ae641cfd55a6590cb243539d6ca8.1543991319.git.ryder.lee@mediatek.com>
Message-ID: <154404182868.88331.17985605359797731500@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mediatek: fix the PCIe MAC clock parent
Date:   Wed, 05 Dec 2018 12:30:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-12-04 22:41:10)
> The PCIe function doesn't work as the clock tree of MAC layer is wrong.
> Hence fix the clock table.
> =

> Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next

