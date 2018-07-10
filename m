Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67D0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D34520883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urIxQrZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeGJLpW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:45:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40057 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeGJLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:45:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so23992872wma.5;
        Tue, 10 Jul 2018 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xx/PLLx6EWLqF4F86zk9igPafRB4/MabVhZpdNyR1k0=;
        b=urIxQrZ/yLPYepz7g3XFZsZ6unhshcb7zg193ATBa3tlf93bV9bYK4VL9lU5NzoY/Y
         2/3dF7XRwBbK1alo9bZ6zRS0qQfyEZRHYrYVslpdZ9tCaHWqjp7cpxxUZMe1pbzkbbEy
         XqVHebbsWKHjtqE9dkvrBKCWdq53NVxdy/+k3Dm+SkCksgUkOF/ppSJObmRqwZ1+IhgM
         a2GIgugAfy2vG8Mm4OcH18rT7NQlW9Om8DYKHvWLpSIH4otHblfkMcprA3h/Xgd01GXR
         jwHQhBDcFqQGmbgyJoSife4ugv565c8IEqJ3TEbZJTGTPJLDq4STzSSdOI+VxrWZFTNj
         1YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xx/PLLx6EWLqF4F86zk9igPafRB4/MabVhZpdNyR1k0=;
        b=SdF17zqh2FWl2BqdmMkE0hknDsWlx2A/RQyHKtHn7oexA/qI3o80AKbo0TdctGrbIZ
         w+FYHcme8AZHR+RX2lZ6lTodNHiv//oNDvziHgFjCzCE4sb1hhqJA6Aka2o1aaW82tpv
         aeueUC7wWwz2VFFI8Oe6kDMK2/GxmGBA3khpC5ImvJMZr6ow3/XyIOjLVx2k8feRL8kF
         gXV50SvPrmbvRVOCNBor9ru8Tg2bd2ienRtY8Ri0AcPRsmb92OZneOhdu0GXWUooepgr
         SCTxqg68fFAEly/tMXiBdIjO0qLFP2osxldKz7wK1b8dQLeqENaMDK+U8OUek7jcyqak
         7pcA==
X-Gm-Message-State: APt69E30yrKqttOVVSjRAEi+6kPR3PSJFrghMSoA7BV9jgkTjvYfXyaY
        ZyVXXevGlyUzAE83EcXZw28=
X-Google-Smtp-Source: AAOMgpeLp5kv2zEFrbElyoK9DR1CApy5MDAHI5cckZgB7tGduEE+PTgt4OGOvz6/G8+WlVmtHc+uKw==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr15414965wmd.6.1531223119023;
        Tue, 10 Jul 2018 04:45:19 -0700 (PDT)
Received: from sch.bme.hu (ecklm-pi.sch.bme.hu. [152.66.179.182])
        by smtp.gmail.com with ESMTPSA id f133-v6sm18752804wme.42.2018.07.10.04.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 04:45:18 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:45:17 +0200
From:   =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without
 NF_TABLES_IPV6
Message-ID: <20180710114517.nxnkav6mimyivh4m@sch.bme.hu>
References: <20180709213537.2748896-1-arnd@arndb.de>
 <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
 <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
 <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
 <20180710105605.evgtmjiq5z46zld6@salvia>
 <20180710111536.hio2xalz7pyxucc6@sch.bme.hu>
 <20180710112459.ielgaydrgd4kxizo@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710112459.ielgaydrgd4kxizo@salvia>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:24:59PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Jul 10, 2018 at 01:15:36PM +0200, Máté Eckl wrote:
> > On Tue, Jul 10, 2018 at 12:56:05PM +0200, Pablo Neira Ayuso wrote:
> [...]
> > This patch only solves the nf_socket and nft_socket modules problem so I can
> > only submit a v2 for 'netfilter: Kconfig: Change IPv6 select dependencies' but
> > you already applied it so it would meen a force push. Should I do this?
> > 
> > I think Arnd's patch solves these problems in case we don't want to force-push
> > or rebase.
> 
> You are refering to these two patches, right?
> 
> https://patchwork.ozlabs.org/patch/941374/
> https://patchwork.ozlabs.org/patch/941696/

Oh, I missed the first one. So basically I should just squash them and resubmit
right? Or even replace ("netfilter: Kconfig: Change IPv6 select
dependencies") with these changes?

> > > I think it's better if we toss your original patch in the tree and
> > > rebase, ie. take the new one that fixes all issues that Arnd is
> > > reporting. It would be good if we can sort out this before I send the
> > > next pull request for net-next stuff.
> > > 
> > > I was afraid of fallout like this when I saw your original patch,
> > > kbuild is always tricky.
> > 
> > This patch is not related to the nft_tproxy module (it seems that you refer to
> > that) as Arnd didn't have that in the tree when doing this. I'll send a v4 fot
> > the tproxy module, but that cannot be related to this one as it is not in tree
> > yet.
> 
> No, I'm refering to 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6
> select dependencies"), that is causing the issues.
> 
> Thanks.
