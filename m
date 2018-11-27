Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D131BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901F1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ry3c0q0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901F1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeK0Lg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:36:58 -0500
Received: from m12-15.163.com ([220.181.12.15]:34928 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeK0Lg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=TS4fe
        f9aq7XO/7xzsOLa+pT0EnCnuuUd0avShpHW6Tg=; b=Ry3c0q0H1OytDJEARjcib
        43I2Fvj+6RUFN3/hWR9VGmSpqtqUdjoRG8tJZ971oJqRtKiJoSp43heX6Pdp4MlY
        /Nx9spvYdzBu4Fp8bxrJ69qzX11AqQNhiSMg4YoDWyGLmk8AqWxb4AAh4F8rsTJV
        +NzsaCeBBgUdaevVOZ50kU=
Received: from bp (unknown [106.120.213.96])
        by smtp11 (Coremail) with SMTP id D8CowAA3Y1h+kvxboJZ2AA--.4618S2;
        Tue, 27 Nov 2018 08:40:30 +0800 (CST)
Date:   Tue, 27 Nov 2018 08:40:31 +0800
From:   PanBian <bianpan2016@163.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gfs2: get rid of potential double free
Message-ID: <20181127004031.GA125510@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543221809-86560-1-git-send-email-bianpan2016@163.com>
 <CAHc6FU4H4y8dDhj5crjqApJAq7ZcjS+9GkE8vUK=1myk5Et2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4H4y8dDhj5crjqApJAq7ZcjS+9GkE8vUK=1myk5Et2VA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: D8CowAA3Y1h+kvxboJZ2AA--.4618S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6j2MUUUUU
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZAwMclQHCrrn3wAAsN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:19:48AM +0100, Andreas Gruenbacher wrote:
> Pan,
> 
> On Mon, 26 Nov 2018 at 09:44, Pan Bian <bianpan2016@163.com> wrote:
> 
> > __gfs2_set_acl will not increase the reference count of acl if it fails.
> > In this case, posix_acl_release are called twice, one after
> > __gfs2_set_acl and one in the error handling block. This patch does not
> > release acl when __gfs2_set_acl fails.
> >
> 
> thanks for the bug report and patch; I think this should be fixed more
> clearly as in the patch I've posted earlier today.

I have seen the patch. It is really much clearer. Thank you!

Pan


> 
> Andreas

