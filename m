Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FAC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4F2159F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnAE70cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4F2159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJUC7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 22:59:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36082 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJUC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 22:59:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125-v6so29268921oic.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7urOn34lKe3V1mMrHSmfO+TuDHgvUd8JedGvDy9RyQ=;
        b=tnAE70cbGv+zAvKbmJfqAz9kSi0FNvPBt2mfqIVZIiwDd6WTfrBcca4zhmsqGOBc8K
         0y3HGcVNVLAjA96ZFmpgbW1883TQzdxCv+nESDRcIIBh3c4L9NCrvkzdpecw7FXwTE6i
         f856spxDagAgd5+YA8PCfwb7ikHs5tvEEqbzhzfW2QbEiy/6jB9tNEqAnDg+dCTmZF9H
         SgA4o+uHPX24SKllWC4tTRgsvtLVjd9dvoeg5AWp4RCmT7qkk26S1AwmfRrOvP8txJl6
         QVCKZibKnf0T14PhQZTJO3b2mcS84CqVVn/Atc2RRKauxDGqDLUmr1SDrs3aXHOyR2NP
         PhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7urOn34lKe3V1mMrHSmfO+TuDHgvUd8JedGvDy9RyQ=;
        b=TShrx3vrFUNH542fJyxifHaEq6pL1MLEkNcIwCby2lgh2WCoCbJzH7UHdQY6xf37Qz
         EMZL8KH2WkpE+9o7dPqXnJ8RiIJ09kRmjPKTgP3/IXd8jaHztyogQb34v7civFSBGmxC
         pxFehtm83zqOJv3s23SEymyzLSgruSxZTmpqte4zobLU/E1utYCQStVD1PI0AtSa6YUK
         Gy/vAhZXmZZk8rElPnnfFGQb/Hdfy/kXNVUSeNCFrN3zzaULObUAwbAG1II0IzvJFazt
         ivu26Mai59ovwfBqpZwykYhHrzBkXp/D6UNnHrVUyG5I7mn9qlz5cbscUf0PSljwpk2u
         3aVw==
X-Gm-Message-State: ABuFfoitjlomQQv41gb+0ZCKE0Zd5fDRV4OJ7lo74IS2tyviNwPlInhi
        Oey8/LAw+racmoInXzLweKFnzeHn9XZaHD9OWOE=
X-Google-Smtp-Source: ACcGV63npAe4xanBsDPTA5I5btei2k+vVS1lRhmg9ncZTsUhcIdOYXEwqGcuIldfcpyHdokW8jaonFw6HhNMvk8Pecg=
X-Received: by 2002:aca:754b:: with SMTP id q72-v6mr21842199oic.13.1540061265795;
 Sat, 20 Oct 2018 11:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <1539784829-1159-1-git-send-email-wang6495@umn.edu>
 <20181018091319.GT2302@lahna.fi.intel.com> <CAAa=b7f-Q2ySZt2vqa1L2GyTA1FrT7+7_ui-eSLEYgN6iXSTFQ@mail.gmail.com>
In-Reply-To: <CAAa=b7f-Q2ySZt2vqa1L2GyTA1FrT7+7_ui-eSLEYgN6iXSTFQ@mail.gmail.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Sat, 20 Oct 2018 21:47:29 +0300
Message-ID: <CA+CmpXsy1E+WY6cxMmzLZKhVZ5G78NfqPAKirT9qxJJpkYn1=Q@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Fix a missing-check bug
To:     wang6495@umn.edu
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>, kjlu@umn.edu,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 12:25 AM Wenwen Wang <wang6495@umn.edu> wrote:
>
> On Thu, Oct 18, 2018 at 4:13 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi Wenwen,
> >
> > On Wed, Oct 17, 2018 at 09:00:29AM -0500, Wenwen Wang wrote:
> > > In tb_cfg_copy(), the header of the received control package, which is in
> > > the buffer 'pkg->buffer', is firstly parsed through parse_header() to make
> > > sure the header is in the expected format. In parse_header(), the header is
> > > actually checked by invoking check_header(), which checks the 'unknown'
> > > field of the header and the response route acquired through
> > > 'tb_cfg_get_route(header)'. If there is no error in this checking process,
> > > the package, including the header, is then copied to 'req->response' in
> > > tb_cfg_copy() through memcpy() and the parsing result is saved to
> > > 'req->result'.
> > >
> > > The problem here is that the whole parsing and checking process is
> > > conducted directly on the buffer 'pkg->buffer', which is actually a DMA
> > > region and allocated through dma_pool_alloc() in tb_ctl_pkg_alloc(). Given
> > > that the DMA region can also be accessed directly by a device at any time,
> > > it is possible that a malicious device can race to modify the package data
> > > after the parsing and checking process but before memcpy() is invoked in
> > > tb_cfg_copy(). Through this way, the attacker can bypass the parsing and
> > > checking process and inject malicious data. This can potentially cause
> > > undefined behavior of the kernel and introduce unexpected security risk.
> >
> > Here the device doing DMA is the Thunderbolt host controller which is
> > soldered on the motherboard (not anything connected via the TBT ports).
> > In addition the buffers we are dealing here are already marked ready by
> > the host controller hardware so it is not expected to touch them anymore
> > (if it did, then it would be a quite nasty bug).
> >
> > What kind of use-case you had in mind that could possibly inject
> > malicious data to these buffers?
>
> Hi Mika,
>
> Thanks for your response. The current version of the code assumes that
> the Thunderbolt controller behaves as expected, e.g., the host
> controller should not touch the data after it is marked ready.
> However, it is not impossible that the controller is exploited by an
> attacker through a security vulnerability, even though it is soldered
> on the motherboard. In that case, the controller may behave in an
> unexpected way and this bug will offer more opportunities for the
> attacker.


[Re-sending as plain text. Mobile clients aren't good at that,
apparently... Sorry.]

If a device that can do DMA (i.e. accessing the whole physical memory
directly) is compromised, incorrect read length is the least of the
troubles the user should worry about.

On the other hand, this is a performance-sensitive path of the code
and copying each DMA buffer will hurt the performance very much for
sure.

I agree with Mika that it doesn't make much sense to degrade the
performance here just for covering this theoretical attack that can do
much worse things anyway.
