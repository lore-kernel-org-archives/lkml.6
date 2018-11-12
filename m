Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C45C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAA6214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC/prhz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAA6214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbeKLMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729729AbeKLMg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:36:58 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5F720881;
        Mon, 12 Nov 2018 02:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541990756;
        bh=q9uA3w4/X6XjCIEi3RbP1u0ISjpd3VwcliSGlOphrQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TC/prhz+I4m3z++pW+ebGDQ37SqbM8Hu22yF+Lyld5sGHGvDEmXcJh69Ke4cerHOr
         s7ziOoIyq7CCsljBQOyjQs9JTpkZUEbTiKCwoDBh+RvLNyLK50FFkEZVBocQBNs61h
         NDtO6FQ575NC0wBe0m9mEjkKx64ysy9wvddbJ1IE=
Date:   Sun, 11 Nov 2018 21:45:56 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose
 timer node
Message-ID: <20181112024556.GI2642@sasha-vm>
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
 <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:28:08AM +0800, Ryder Lee wrote:
>The crash http://termbin.com/zitb is caused by the timer register
>into system in early pahse during kernel boot, but the clock
>sources didn't get ready at that time.
>
>A better way is to switch to use CLK_OF_DECLARE() in driver for things
>that need them early, but this node is actually useless in MT7622.
>So we drop it.
>
>Fixes: 9cc7f0de9e67 ("arm64: dts: mt7622: add timer, CCI-400 and PMU nodes")
>Cc: stable@vger.kernel.org
>Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

To confirm: the patch this fixes was added in v4.20-rc1, which means
that this current patch doesn't apply to any of the stable trees.

Did we miss something?

--
Thanks,
Sasha
