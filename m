Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3381C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A578520843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="RoPgFYaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A578520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeJ2Ks6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:48:58 -0400
Received: from nag.0l.de ([207.154.252.120]:41890 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeJ2Ks6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:48:58 -0400
Date:   Mon, 29 Oct 2018 03:02:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540778546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LKRJVUSoXWi9PqvM8aXY1YNGNk/DTxqEV1e3BE9DNO4=;
        b=RoPgFYaFdnuMhlOxxfA1AhC3N/a8OnsnJC+WxMWGZ/gztS0M/QB6LtBjSZxKDBkHxo+DOa
        GtrEW6Deq4Rl6B0dtzypTMXJ08U7RSrYN1dQ3GKjHgoudPcDUPv+HPvkmLj/u2YrmqpDfl
        +I/GFnqM03zg2SVjPAksmXYkOjOW8kGGsqVX665nGLH33fN1BPCIRueeMw79HrHmTV4Fl0
        zMJmD1F0mdCzq7vw5jScxTlFv7+W9XcoMdGjhonYTdt3HujcoMZuTRe3yoehjDMchkS0F3
        NDy6I87P9sAo8j4JCgzDDr8q9X87fvnpcuvt1TdoqBUHdqJg/MG+8GNmdnDXWg==
From:   Steffen Vogel <post@steffenvogel.de>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 8/9] w1: fix whitespaces of struct declarations
Message-ID: <20181029020225.3i7wc2rg2omofzyb@cam.home.0l.dn42>
References: <20181028220927.56227-1-post@steffenvogel.de>
 <20181028220927.56227-9-post@steffenvogel.de>
 <795912c5ade5a813cf5c70d7085c14c24b553f1d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795912c5ade5a813cf5c70d7085c14c24b553f1d.camel@perches.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540778546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LKRJVUSoXWi9PqvM8aXY1YNGNk/DTxqEV1e3BE9DNO4=;
        b=ZEF6WGwcPoqBMp97l7c/Tk0GSB0ubLhuiXPj0K78hivzEaHff8DIYndg11DMDwPrx5gmgo
        /Wpo+knHy6jaFUTBiEQRcQvmz7eO4As78Iqb0anO2VLDiTj4c2Mmktcn7xoarByp8GBjUk
        PSd8772J8DSSqsjdQq28ntfssE4oSnt/D72jYLHoYLMWvAX4DzU5FnrBxHVflvTyn/+l65
        NsMiIYwoLgLEycQ90X4YHEjCtYCsc7u+TMitFHvQnl05DOvcCdIKzgWkKbZChS+8TQ6Zma
        7rY8zJvghrglMGgdFaAkvSGUCKY+G8H57mvM6dB4oiVplPaf7RGjzQo8lhuIiw==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540778546; a=rsa-sha256;
        cv=none;
        b=nc/cCxFfb3HdDQ25EXOGgYTvws2wpfoRa5fk19uNR6JYSFjgc38PHZa3X8H+/uL/SUAbO8I/38INSZWB3gFmE243WeOqpwwNZhxvgXJnKdvjB0QCxnu0E96m7yqTCFoFjBo146yuqPzRffwyiO6q8Z3cSQawxxS859O43JvMx0rbItw5hJWy+TxTjx1Ftl5DyDXUbcIa3Xz4JJcllomb8ixDNGWrCjsglzY1kV3fAYLkGuIBNn7MEjmGptvsV9KO7qh6SE4e+ET+WQZqI9MF2Bv3MCstj3dl7iUO69EVHvIxRPonI9qpPyYvqCkBnUAZ6SePoOLTCS07ByadNVL2Kg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

v2 of this patch set is almost ready.
I reran checkpatch.pl with '--strict'. So more warnings will be fixed by
the second version.

See my comments below.

On Sun, Oct 28, 2018 at 06:52:23PM -0700, Joe Perches wrote:
> On Sun, 2018-10-28 at 23:09 +0100, Steffen Vogel wrote:
> > This fixes a warning raised by the checkpatch tool.
> 
> checkpatch does not raise any whitespace errors on
> this file.
> 
> It does suggest that braces could be moved.

Ah okay, I considered moving a brace also a whitespace change.
Do you prefer the original indention of the struct members?
I dont see it very often in kernel code.

Cheers,
Steffen
