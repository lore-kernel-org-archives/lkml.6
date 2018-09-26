Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991EFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37D2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFRXczT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F37D2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeI0DHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:07:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36132 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0DHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:07:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id y13-v6so3768004wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wkGCeYtE2WgVZ1DvgQhO4F4mu1Ob35imFAmQvQskoTY=;
        b=dFRXczT9p+P4Gb4hxCIRZOcYO9T3Jn+AOYEz3tJFTbcA/Qs+Kutq8s0MN805H51rYZ
         3HJCpDaYXnTIN6Kh0+yGkRaLUK4sOPQtChyUedIJJCI7u7wP/3oIFdo4qpMmjrOVxpPA
         N/UsFy4BrlRaMqnRceSUBQdvOfHH9Dq9Zvxx6dbMcW+cWq/4lA0MLnf+hnbwseIbQv4+
         0g1Zs9ZxmdnDQ1O61GF+Ta8D1wtHvpvLZeK3Wcu2K7+WCsniRBAmuskfXXeG3GqUHArN
         bgNKavs8x2PPFtMHKefsUMyBb6YGN0ZaNabWNesuNa7tBSHKMiuoeKeJmNF1b0juHl6s
         x+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wkGCeYtE2WgVZ1DvgQhO4F4mu1Ob35imFAmQvQskoTY=;
        b=f3DfH4wIytIzloT67B1ttNS3lKHAKrDYZndnJml0Zkr3CDKGIg2y5hYSUOkIolGvus
         dSO8sr5WYG3C48rdnzQaBvgEhgkA+iQls0u/YmVZ8etITgQiPcL+VUTY3GWdBYslJ2pj
         m0wFJro+ydIhdXOWG4ji7tJHhQ5IJnTBMZ1mlULjC1sjS7N7wHBLqvFmSAwN5H9vO+H4
         7TPchvFql3uEdjblFDbmydns88lsYtZAiZWNkMx8aKEbg3j4QZSL8K/1RS9DP40spywS
         Uclvfnp1T0pf0lqq72H+hK2uANeHeVdXORn2K+sKj+FkWnjOknlPIa60bGxakZfKUWYV
         SJPQ==
X-Gm-Message-State: ABuFfoiTdaCr25jG7nKaQOz2ZRWmac6xH2P4uzWCEtjq8XfjeaXEVTju
        sz9hJ9rNCwt+pznIy0ZJNla2X9VRGnY=
X-Google-Smtp-Source: ACcGV63tbgcYNOZMK/QDdUH16L8liNwT+0VL0wn8zikXAR6CQjSc3c/QqquSkIHUh8QECUPUti9WKA==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr5388140wmd.69.1537995144850;
        Wed, 26 Sep 2018 13:52:24 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id b193-v6sm262323wmb.31.2018.09.26.13.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:52:24 -0700 (PDT)
Message-ID: <5dad38f5158860a4c8da4d122af89d3e84def312.camel@gmail.com>
Subject: Re: [PATCH 0/4] MIPS: Simplify ELF appended dtb handling
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Sep 2018 23:52:22 +0300
In-Reply-To: <20180926203618.bnmo5ys4ay24tbrr@pburton-laptop>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
         <20180926203618.bnmo5ys4ay24tbrr@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 2018-09-26 at 20:36 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Tue, Sep 25, 2018 at 09:08:21PM +0300, Yasha Cherikovsky wrote:
> > Hi,
> > 
> > This patch series simplifies and cleans up the handling of
> > CONFIG_MIPS_ELF_APPENDED_DTB in the MIPS tree.
> > 
> > Specifically, it makes sure that the dtb appears in 'fw_passed_dtb'
> > also under CONFIG_MIPS_ELF_APPENDED_DTB=y.
> > 
> > This allows to remove special platform code that handled the ELF
> > appended dtb case, and replace it with the generic appended dtb
> > case (fw_passed_dtb).
> > 
> > There's also a bonus: platforms that already handle 'fw_passed_dtb',
> > gain now automatic support for detecting a DT blob under
> > CONFIG_MIPS_ELF_APPENDED_DTB=y.
> 
> Thanks - applied to mips-next for 4.20.
> 
> Paul

Thanks!

Yasha

