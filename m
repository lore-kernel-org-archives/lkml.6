Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6D2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5XbMNKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfANPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:17:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46945 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:17:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so23240890wrt.13;
        Mon, 14 Jan 2019 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L4Y7CUEcdbVgZnYHWkQUard9aV1Vb23Vb5S5Cl/wdX4=;
        b=c5XbMNKmDXBjLkKWm/pkdFCC2OJOY5JBJn8lxfIrBEUfw5Gh7Z9yns6W9LuarFgQ5y
         pqWOuhBZ+xT/OTy8ohGsBw8rMS3JFVMvETeCvt5Dm5JboSa/QeGVoDFoKpGRq7s7VIiA
         81l3j3+xQHGOtiIayqLwuLGJsDCCil4QU95FfrmqsxRhapV98PSm5AL37mYET30mKcBa
         G1nOHTO+ws9XJ/CX46RIqwp8WBklJetQt4G6twypkco1iy0CIbD3Gyk26x/RXqdTYe4Q
         ao3LZQRx1R9oL/pftWngfqQWg4b0HpGUWIIZHYuAdjd7ahuY/yow4ZPW6o+KFjSuypYs
         PRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L4Y7CUEcdbVgZnYHWkQUard9aV1Vb23Vb5S5Cl/wdX4=;
        b=TZYwynHR06CfcM+/KljJ02owu9EuB2B78BtxVgirqKq4hXmDjeLNkvbg9v8+O4bX1+
         /e+IZV7msNPH0FA/hD5Y9gKNihL2KUaE0a6JKb58is09FO//V+gXNSD/B+AkjzHQQg/7
         /LEGCug6EV7QhG+CETOlMsucTIZM8fvRi9OGBJBzsGKIksJ50VGlearZE76JueCjLe5Q
         DoKV+eCR3GAXZa+Z0qCQhBKQFqvhXSMlhkx3971z7dWNZ9dUnXbOsytoa/WqzxxTYBp6
         oQi9wBc5ORBoK7S8XMt1a1+BmqiFbvNrEB83s+pBCrsTq8ezkTdC04iNifFiZPXYOeGN
         ENAA==
X-Gm-Message-State: AJcUukflZiKSinEWOpYL2/Frl0u6JlgI85ZHtA0fRoT5YHhHhKxo4uEr
        EWiZBf3vVmiU2SjKlT3wE8o=
X-Google-Smtp-Source: ALg8bN5hklqMfrtaD9rf9YFtpxdjiozOCz+y+Z/OnZyykK51cT4jSa7r8bjRK5NPBGPK3NBTQp0yMQ==
X-Received: by 2002:adf:8544:: with SMTP id 62mr25939692wrh.1.1547479030856;
        Mon, 14 Jan 2019 07:17:10 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h131sm40989406wmd.17.2019.01.14.07.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 07:17:10 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:17:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mpluskal@suse.com, base-system@gentoo.org,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20190114151709.xemy2h4gtgtsos3d@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181227221748.zsz6bwqqia7ybfwj@pali>
 <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com>
 <2431182.t5fd7Oadsi@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2431182.t5fd7Oadsi@blindfold>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 January 2019 16:39:04 Richard Weinberger wrote:
> Am Dienstag, 8. Januar 2019, 16:32:55 CET schrieb Andy Shevchenko:
> > On Fri, Dec 28, 2018 at 12:18 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > On Monday 17 December 2018 10:50:04 Pali Rohár wrote:
> > > > On Wednesday 12 December 2018 14:57:36 Pali Rohár wrote:
> > 
> > > > Thanks for review of #94! As next you can take #92 from list.
> > >
> > > Andreas, can you look at next pull requests?
> > 
> > Looking from a side how slow this is being processed I think the best
> > option to fork and abandon the old project if author / maintainer by
> > some reason wouldn't like to give a push rights.
> 
> +1

I really do not want to create fork or become new "maintainer" of this
project.

If somebody else want to take project or create fork, I can prepare
patches and send them to new place. But still I would like to see code
review of patches from other people. dosfstools is a project which is
used by lot of people and is de-facto standard for FAT32 Linux support.
So breaking something should be prevented as much as possible.

Richard or Andy, if Andreas really do not have time for dosfstools, what
about you to take maintenance of dosfstools?

-- 
Pali Rohár
pali.rohar@gmail.com
