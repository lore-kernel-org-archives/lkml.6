Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD33DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F2F2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIYWru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:47:50 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45292 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbeIYWru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:47:50 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8PGdLVr002539;
        Tue, 25 Sep 2018 17:39:22 +0100
Date:   Tue, 25 Sep 2018 17:39:21 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925173921.3b267bb3@alans-desktop>
In-Reply-To: <20180925154627.GC2933@thunk.org>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
        <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
        <20180925003044.239531c7@alans-desktop>
        <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
        <20180925154627.GC2933@thunk.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Unlike O_TMPFILE, this would require file system changes to support,
> so maybe it's not worth having something which automatically cleans up
> files that were in the middle of being written at the time of a system
> crash.

Would it. If you open a file unlink it and write to it and then have a
linkf(fd, path); your underlying fs behaviour isn't really changed it's
just you are allowed to name a file late ?

Alan
