Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE3AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673E1222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892905;
	bh=Smd0ryja7EsfElnSa1Ojr1aJgnNMXO2cTp3wIpKhzhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uXhwHkPSb3NDAWeAP5CUmwIBOIG9NU4J5NbhR1tmCvw5TNFhWL9K0i2TFXyE290mj
	 PlUMNTX3yRQrivbPS1GOk39VlYYofx0oirmVi9l4hcC0QBaS89p40g6fOapcUEdrUK
	 BblMBBQj/VI9cfzkhvdpdWBB0Vpqigl6kIRnfrus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfBKNsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfBKNsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:48:23 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92127222AE;
        Mon, 11 Feb 2019 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892902;
        bh=Smd0ryja7EsfElnSa1Ojr1aJgnNMXO2cTp3wIpKhzhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LAvNzt1E5Su96TKnWP6Ln3u980SNsuP3jAt9LaPxroE6Pg1reaRqQk0NxLpXSSGj4
         AcU9tHiDD0PPFC9f0PrxEu1oj6L/2P/I5tIMIsMIg+RH6iu7QVILcpsIHQ8DTQyeS5
         kU1rKkMrtniS6zUlc+s4z3d1iLl2prqQzndsLPSM=
Received: by mail-lf1-f51.google.com with SMTP id q11so7799329lfd.3;
        Mon, 11 Feb 2019 05:48:22 -0800 (PST)
X-Gm-Message-State: AHQUAuaAyJp97OAIxYP0vVEqMUbZL1JBdjeCe5gUASBAHEJjU1RrGwmX
        ByhoQb9eNCuD7frERAJyo5iPk2XXJxUqMAL12K8=
X-Google-Smtp-Source: AHgI3IZYJ/HCUyDjFT/MBZUPuGA6KvOUkkDvyqTQ49eDDRew5g1qANeXgcGdM/BRqhrgArL6hKG2AbqHJTuXe9V3ym4=
X-Received: by 2002:a19:4948:: with SMTP id l8mr200818lfj.156.1549892900776;
 Mon, 11 Feb 2019 05:48:20 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170134epcas2p1a22a5c2f680f33fe562fa22f3aec9e6a@epcas2p1.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-15-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-15-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:48:09 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdPNNcocL21Q-uR56CCujHuQqRBZ2EzhmnTX2OW3FhiJw@mail.gmail.com>
Message-ID: <CAJKOXPdPNNcocL21Q-uR56CCujHuQqRBZ2EzhmnTX2OW3FhiJw@mail.gmail.com>
Subject: Re: [PATCH 14/22] ASoC: samsung: i2s: Move IP variant data to common
 driver data structure
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> The IP variant data is another thing common for both DAIs, move it
> to the driver's common data structure.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 42 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
