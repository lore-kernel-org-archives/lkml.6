Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA9BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1887A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeLMKjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:39:47 -0500
Received: from mx.socionext.com ([202.248.49.38]:6330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeLMKjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:39:47 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2018 19:39:46 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 527DD180081;
        Thu, 13 Dec 2018 19:39:46 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 13 Dec 2018 19:39:46 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id AFDEE403A4;
        Thu, 13 Dec 2018 19:39:45 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 8CC0E120B02;
        Thu, 13 Dec 2018 19:39:45 +0900 (JST)
Date:   Thu, 13 Dec 2018 19:39:45 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: ASoC: About graph node issue without 'reg' property
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Message-Id: <20181213193944.CCC9.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Morimoto-san, Mark,

I found that your commit b6f3fc005a2c ("ASoC: simple-card-utils:
fixup asoc_simple_card_get_dai_id() counting") replaced with
of_graph_parse_endpoint(), that needs 'reg' property in each port
that has an endpoint.

Currently devicetrees for UniPhier SoCs have also audio graph nodes [1],
and these graph nodes include an endpoint for each port.
Although the port doesn't have 'reg' property, it has worked fine before.
And after applying the commit, it doesn't work.

It is written in Documentation/devicetree/bindings/graph.txt
that common scheme is to include the 'reg' property.

Maybe I think that we'd better add 'reg' properties to each port,
however, there might be same matter in other SoCs, so I'm not sure
whether your patch breaks the backword compatibility or
our devicetrees are wrong.

I'd be glad if I could hear something about this issue from you.

Thank you,

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi#n348

---
Best Regards,
Kunihiko Hayashi


