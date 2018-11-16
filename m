Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD35C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122402086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122402086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeKQGPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:15:01 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:58805 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeKQGPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:15:01 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id DE8C720027;
        Fri, 16 Nov 2018 21:01:10 +0100 (CET)
Date:   Fri, 16 Nov 2018 21:01:09 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] kbuild: refactor modversions build rules
Message-ID: <20181116200109.GC15240@ravnborg.org>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542270435-11181-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=lYPL5hkgdnwD7H-L1kUA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro

On Thu, Nov 15, 2018 at 05:27:10PM +0900, Masahiro Yamada wrote:
> Let $(CC) compile objects into normal files *.o instead of .tmp_*.o
> whether CONFIG_MODVERSIONS is enabled or not. This will help simplify
> build rules a lot.

Another approach would be to move more of the build stuff to
one or a few build scripts.

Using build scripts makes is much easier to add comments and
still keep it readable.
And when the build logic list a set of serialized actions
they thay can be included in a build script nicely.

But that said - I also like the simplifications you made.
Everytime you trim the core kbuild files it is a win for
readability.

	Sam
