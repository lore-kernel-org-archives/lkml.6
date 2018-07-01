Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E136C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB8B256CB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg9WPEs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB8B256CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeGAXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 19:44:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35608 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeGAXoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 19:44:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so7027391plt.2;
        Sun, 01 Jul 2018 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cdKT4DuOwYa6e3w0JB7Bx/3NAVIgk3q+LI/WTjuE1QM=;
        b=hg9WPEs3BnKkJ7wnGz2jVjy5by6XQfJnNgS6MF604pI7HhPlhDeJAtR7fxZC0wj1uL
         kGSDz6ZWzIZWHpLKerektQ8DNkv+OsL4sOD3uWX8zvaPoexCet26dCxHJxapjraAQNRl
         AwWQMzkH213BylMIniC5kqacup/V0V+PZj3rnjkHasvY5fAdh/BSIX81pHHImmMLhnSY
         3AKlx+OctP4VstChNonQgCpufNBIAmzLDqIM7GXSKCZnstNPGHdxuSoPEpPi5X2iSO/Y
         TLC1GuUzjC7YUCP9vfzxPFpSjVG0QTS3rEFOkTGegl0aI7aGV7g5luPL56EV5eEIJynM
         Q0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cdKT4DuOwYa6e3w0JB7Bx/3NAVIgk3q+LI/WTjuE1QM=;
        b=XhSumSpyWixEJ6VMfe8t/UK0M2z2z0JxC+O/p5qOJQRhSaC/1vWBAiMYOLbBCM85pm
         CE2gTrKzwZ6D/yYzV6xnmPdLJ/uMpjKi6KPaCHCvteEh8+e1NvsF/mG0dAYFioHBEL/q
         xldQJ2oVgnr0K9vrkbjFnruxWSrF80JpIGyRLN90/2J+bzcBkRPLgJKgFpxs7tCjM3XU
         51IIX3XlUGRthIty3+znq6eQZg28ChMR34Ol4iLlvfi+4VYLRUtUWfn7uDmODSazhdAk
         Zq9YJC1o5rqbibnhd25TSPZQRJKyP2zOECOPOIA7ue6De+mftZFXd0Mo79zIk5/8Fnjx
         ckpw==
X-Gm-Message-State: APt69E15TkIA7kRqSthTpWKSBOgCDNC4h7NPBVUwfnMiFF1LoPzn93hv
        CO6zvkK6PeldrGfbXOXnsNk=
X-Google-Smtp-Source: AAOMgpciOLrgc7dzbb/5Ny7EYi4fwhQDX1P4Nn2bGyE3ae0aq+kYKnL1DhlEk69VHnfZ0Ow7iTM6eQ==
X-Received: by 2002:a17:902:18a:: with SMTP id b10-v6mr11910471plb.62.1530488662378;
        Sun, 01 Jul 2018 16:44:22 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id 86-v6sm37808659pfp.17.2018.07.01.16.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 16:44:21 -0700 (PDT)
Date:   Sun, 1 Jul 2018 16:44:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Message-ID: <20180701234419.GA250349@dtor-ws>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws>
 <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws>
 <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 04:30:44PM -0700, Linus Torvalds wrote:
> On Thu, Jun 21, 2018 at 5:16 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > OK, thank you for the info. Applied.
> 
> Ugh. Dmitry, please be more careful with author names.
> 
> Apparently you aren't in a proper utf-8 locale, and you messed up the
> name in the git repository. So yoiu apparently tried to take KT Liao's
> Chinese name: 廖崇榮, but did so in some wrong locale, and it ended up
> being just '???' in the git repo.
> 
> And I only noticed when I did my shortlog for doing my 4.18-rc3 release notes.
> 
> I don't know what locale or tools you have, but please try to make
> sure everything is utf-8 aware so that these kinds of name corruptions
> don't happen..

Yeah, I noticed that when preparing pull request, but did not want to
rebase the branch that I always keep stable, sorry.

The reason it got messed up is I switched to pulling patches from
patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so I
do not have to add them manually, but unfortunately it does not do
proper UTF-8:

https://patchwork.kernel.org/patch/10431971/

I have since reworked by scripts to only take changelog from patchwork,
and take author name/email from the mail message and using "git
mailinfo" which worked well before. Should not happen again.

Thanks.

-- 
Dmitry
