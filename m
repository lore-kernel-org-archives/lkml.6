Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F0DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8918B21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="UuuAsBUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8918B21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeI1Dcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:32:47 -0400
Received: from sonic309-21.consmr.mail.gq1.yahoo.com ([98.137.65.147]:37556
        "EHLO sonic309-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbeI1Dcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538082753; bh=keDMkEhzcD51A892wLdsvfwC5PK0PU9UdcNVrUpnll4=; h=To:From:In-Reply-To:Cc:References:Subject:Date:From:Subject; b=UuuAsBUds/E5NlDdLbxpi5d68SrrVBevYBND10zR+ikF2sCzGgs18QTWJJSVjTzW4J1T2UmDKk2QWJ98e0t1cnLHXi9P8gjfOZlbZepBGURD59xLG4z8yeUEctaE36JbETAE2I+veMRtm0WLoxNQ2jbBIo9FcOrYEu8Lp91eurmrVkn5mI7ER/P8IspCYZ0P9TbONIZ7ah0YblzlAXLEf3IqmqST4/kU3t0evXO0BlzlxFaYYyyFFEQggMMNAAiBfZvW20qqQfSQ2yDmv4eSyGxCt0yvGXvaIxUE41CagLf7xHSK702U4/jMIuoLsT/f1vLb6zLCI5BOFB7oXSSbFA==
X-YMail-OSG: mz815SkVM1mVVVMjRd2X5Iq_ZJQLvQVHbYRedlEGy4IcDNjgUyOVRemfXDl_2sA
 Ad8rRbVQPzrDTykgI4URVIbGfPIbyGwbY1s7RmTd92tDp_fxZF3nO.CtUVrgKd58OIKUh4LAOV_C
 4Z3zkUAoMcVufnuloAjJkXz9oqKPtLZlN22kKMlOY_OPZsCWkx4bgul6hDpV0V2jhhBkmlnfdjOw
 P7O_Ftplw9JX2vqqT6q702mRLVNN987LTvPr0zf0flF.jOU9eNyIjZwaZWshUieO3XEzYOZATg6s
 40M2bJy8UQIW8lp5uGvmL4PHe_xi9EhaCnFM8TD9KnvLIONtB7ZppevyTsR1CP_pPjLAOMI0K8xg
 xX7prmApzeLpt0m8Cbb.aLnndyidUc.xXAoTYFHhXFgWX2J8aEEO.hyI8z14.Cnhr76M9x2YMUgI
 28YjIA5aFQyf99rKTUV0iCsYyAXf8pe35XaBAFyHQaaippGtltnlXq04p0tNgh0eNuNrs4vcNvgj
 XJ17tlw8xumJx8sKSHTtmpQUxiwdp9O04mLJRqJWhHOQuaeWzk8pkgPdGgUR3j.2g4SjCbTq7RQt
 Q1olFiVlvtDf.vhegdk9eq7SUztIXQQ5W6RNpFJ8WYaR75BHQ7TzYO9xGweYojI261tnDBtuCdlC
 pHThq6jvZsO0JWer59q4aUCxjawysNklPNjnoPjdjlFLYd5cwcRRY9Jh7jWvwvf35uC8KRiXWGLV
 7p_yz4oHK85dpa94w2HLSa98UGuS1_Esm7S08wOXJZc7WiL8.ASqKZwDqoU.Wy5NjYaKNIfbMfjk
 MguAZqE9IK5xc0zU_JJp2AOzLDfwzZniynOwmTs5BHWWHkY6C0Av.QVlQvFT7zyte7Dehv2Lo3MW
 1RBk.96AK.0q7jcLbnZhrKgYRA23Vc2huApeo9toLkqZQB9wnMeNVAQua_UjvnglVU3NrIHPFUiq
 0DnuRUsWlDPx23UAp5NpwfM8PHdgKgf9ommIYXxVQHJ7SOIMg1KqQKfcu7dXwSUsCq54SPsUEThT
 lKAzeyC2B
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Sep 2018 21:12:33 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4a3511c8987175a4c5587e660d0d6381;
          Thu, 27 Sep 2018 21:12:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dan Streetman <ddstreet@ieee.org>
From:   Alex Xu <alex_y_xu@yahoo.ca>
In-Reply-To: <CALZtONA9r6=gnK-5a++tjaReqEnRzrBb3hzYMTFNXZ13z+UOWQ@mail.gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1538079759.qxp8zh3nwh.astroid@alex-archsus.none>
 <CALZtONA9r6=gnK-5a++tjaReqEnRzrBb3hzYMTFNXZ13z+UOWQ@mail.gmail.com>
Message-ID: <153808275043.724.15980761008814866300@pink.alxu.ca>
User-Agent: alot/0.7
Subject: Re: [PATCH] mm: fix z3fold warnings on CONFIG_SMP=n
Date:   Thu, 27 Sep 2018 21:12:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan Streetman (2018-09-27 20:41:21)
> On Thu, Sep 27, 2018 at 4:27 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wr=
ote:
> >
> > Spinlocks are always lockable on UP systems, even if they were just
> > locked.
> =

> i think it would be much better to just use either
> assert_spin_locked() or just spin_is_locked(), instead of an #ifdef.
> =


I wrote a longer response and then learned about the WARN_ON_SMP macro,
so I'll just use that instead.

Original response below:

I thought about using assert_spin_locked, but I wanted to keep the
existing behavior, and it seems to make sense to try to lock the page if
we forgot to lock it earlier? Maybe not though; I don't understand this
code completely. I did write a version of z3fold_page_ensure_locked with
"if (assert_spin_locked(...))" but not only did that look even worse, it
doesn't even work, because assert_spin_locked is a statement on UP
systems, not an expression. It might be worth adding a
ensure_spin_locked function that does that though...

spin_is_locked currently still always returns 0 "on CONFIG_SMP=3Dn builds
with CONFIG_DEBUG_SPINLOCK=3Dn", so that would just return us to the same
problem of checking CONFIG_SMP.
