Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F35C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F554222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893510;
	bh=zmv4r+NLmZxOFASsb09PpVfDh3InXO5LV/tznupQY3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QN+82tjgFLPokMXUDzLyqVdpVjiMQ0Ec8QBj4eOeWaXTt9AWWVw7oop7naJiPOi90
	 4yxKrFd6z5FunCt/JkKWJ093geODCxMgxVEzNQmH1EbfVudp2S8fwm63qoWmnEOzfc
	 nbC15I0HvQVbx/Bs5wzP6bIOPtumbjUBIo6qzMqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfBKN63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:58:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKN62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:58:28 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F221222B7;
        Mon, 11 Feb 2019 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549893507;
        bh=zmv4r+NLmZxOFASsb09PpVfDh3InXO5LV/tznupQY3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ukwNucQFtjewKrOvHTPJ+gO1Jzewe6jjfptchLmHaX8zxiC33zqMSA5D6izyJhUZK
         lPgwTPguT6ZQ9F2R7MmQTJp4mKe6wjPLVYVb72UEw6quwz4sxs18Ska7Zz+jzId5Rn
         aD4/QyV+LutRIdzd8Ubq9/EIJsM9V7VR2MQcyO+w=
Received: by mail-lj1-f172.google.com with SMTP id r10-v6so8839708ljj.4;
        Mon, 11 Feb 2019 05:58:27 -0800 (PST)
X-Gm-Message-State: AHQUAuZpAQnoYowJcyZ4Kui+Q8Sz45f8d3ASnOkGYIXclAHewYFfWWWz
        q/tIY6kmC0/mvssVEMbaGVsQ9TherDJyfXig5Is=
X-Google-Smtp-Source: AHgI3IbDkq3MPxAOV/ge4dC9dc2y6EVvYb4KDDKBjW3e6y821vsHdxBs2s+6K02JanPbhV3l/Zx6BYPZai1tXqWyKkE=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr21943545lja.184.1549893505677;
 Mon, 11 Feb 2019 05:58:25 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170148epcas2p2e0f4a1e154cb8cd52d257978a669e84c@epcas2p2.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-19-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-19-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:58:14 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcoFaYJ_M_rDJvpGen6NiQuyO4CbanHtU24LZ5vrTujTQ@mail.gmail.com>
Message-ID: <CAJKOXPcoFaYJ_M_rDJvpGen6NiQuyO4CbanHtU24LZ5vrTujTQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] ASoC: samsung: Specify DMA channel names through
 custom DMA config
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
> This is a part of conversion of Samsung platforms to use the custom DMA
> config for specifying DMA channel names, in addition to passing custom
> DMA device for the secondary CPU DAI's "PCM" component for some variants
> of the I2S controller.
>
> We also don't set the SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME any more
> as setting it wouldn't allow to specify DMA channels through the custom
> DMA config.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/dmaengine.c   | 12 ++++--------
>  sound/soc/samsung/i2s.c         |  2 +-
>  sound/soc/samsung/s3c2412-i2s.c |  2 +-
>  sound/soc/samsung/s3c24xx-i2s.c |  2 +-
>  4 files changed, 7 insertions(+), 11 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
