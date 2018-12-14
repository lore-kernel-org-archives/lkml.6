Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18080C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AD720892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AD720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeLNCOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:14:02 -0500
Received: from mx.socionext.com ([202.248.49.38]:13783 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbeLNCOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:14:02 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 14 Dec 2018 11:13:59 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 0D5C660062;
        Fri, 14 Dec 2018 11:14:00 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 14 Dec 2018 11:14:00 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id A8ABA4035E;
        Fri, 14 Dec 2018 11:13:59 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 81D1B120B02;
        Fri, 14 Dec 2018 11:13:59 +0900 (JST)
Date:   Fri, 14 Dec 2018 11:13:59 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: About graph node issue without 'reg' property
Cc:     Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
In-Reply-To: <87tvjh7zj2.wl-kuninori.morimoto.gx@renesas.com>
References: <20181213182739.GZ10669@sirena.org.uk> <87tvjh7zj2.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <20181214111358.FB47.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san, Mark,

On Fri, 14 Dec 2018 09:05:02 +0900 <kuninori.morimoto.gx@renesas.com> wrote:

> 
> Hi Hayashi-san
> 
> Sorry for my buggy patch.
> I and Tony could confirm that my posted patch can solve
> this issue. I will re-post it again as v3 patch-series.
> I'm happy if you can test it (and give it Tested-by).
> 
> 	https://patchwork.kernel.org/patch/10727943/

Thank you for your great effort, and sorry my cross-post before your RFC patch
because I didn't catch it.

I confirmed your RFC patch solved the issue.
I'll also test your v3 patch-series on my environment.

> > [1  <text/plain; us-ascii (quoted-printable)>]
> > On Thu, Dec 13, 2018 at 04:24:28PM +0000, Mark Brown wrote:
> > > On Thu, Dec 13, 2018 at 07:39:45PM +0900, Kunihiko Hayashi wrote:
> > > 
> > > > Maybe I think that we'd better add 'reg' properties to each port,
> > > > however, there might be same matter in other SoCs, so I'm not sure
> > > > whether your patch breaks the backword compatibility or
> > > > our devicetrees are wrong.
> > 
> > > > I'd be glad if I could hear something about this issue from you.
> > 
> > > There's an ongoing thread between Morimoto-san and Tony Lindgren around
> > > the graph card including this issue, there Morimoto-san proposed some
> > > code which would let the reg property be optional.  Device trees should
> > > still be updated but that way we wouldn't actually break anything which
> > > would be good.

Yes. It's desiable to add the reg property in spite of the fixes.
I'll update our devicetrees.

Thank you,

> > 
> > There's a patch now - "[PATCH][RFC] ASoC: simple-card-utils: fixup
> > asoc_simple_card_get_dai_id() ID method".
> > [2 signature.asc <application/pgp-signature (7bit)>]
> > No public key for 24D68B725D5487D0 created at 2018-12-14T03:27:38+0900 using RSA


---
Best Regards,
Kunihiko Hayashi


