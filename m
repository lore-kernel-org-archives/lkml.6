Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0687ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDCE2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDCE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJRGT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:19:58 -0400
Received: from albireo.enyo.de ([5.158.152.32]:49252 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRGT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:19:57 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gCuCf-00067s-1H; Wed, 17 Oct 2018 22:22:09 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gCuCe-0002Pg-Rh; Thu, 18 Oct 2018 00:22:08 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: statx(2) API and documentation
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
        <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
        <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
        <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca>
Date:   Thu, 18 Oct 2018 00:22:08 +0200
In-Reply-To: <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca> (Andreas
        Dilger's message of "Wed, 17 Oct 2018 14:22:57 -0600")
Message-ID: <878t2wb4dr.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Dilger:

>> So what's the point exactly?
>
> Ah, I see your point...  STATX_ALL seems to be mostly useful for the kernel
> to mask off flags that it doesn't currently understand.  It doesn't make
> much sense for applications to specify STATX_ALL, since they don't have any
> way to know what each flag means unless they are hard-coded to check each of
> the STATX_* flags individually.  They should build up a mask of STATX_* flags
> based on what they care about (e.g. "find" should only request attributes
> based on the command-line options given).

Could you remove it from the UAPI header?  I didn't want to put it
into the glibc header, but was overruled.
