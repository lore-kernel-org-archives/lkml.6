Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ACFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3442082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3442082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeLIVCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:02:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38288 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:02:24 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gW6DV-0007v2-5b; Sun, 09 Dec 2018 21:02:21 +0000
Date:   Sun, 9 Dec 2018 21:02:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209210220.GB2217@ZenIV.linux.org.uk>
References: <20181209204449.18906-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209204449.18906-1-tycho@tycho.ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 01:44:49PM -0700, Tycho Andersen wrote:
> While working on some additional copy_to_user() checks for sparse, I
> noticed that sparse's current copy_to_user() checks are not triggered. This
> is because copy_to_user() is declared as __always_inline, and sparse
> specifically looks for a call instruction to copy_to_user() when it tries
> to apply the checks.
> 
> A quick fix is to explicitly not inline when __CHECKER__ is defined, so
> that sparse will be able to analyze all the copy_{to,from}_user calls.
> There may be some refactoring in sparse that we can do to fix this,
> although it's not immediately obvious to me how, hence the RFC-ness of this
> patch.

Which sparse checks do not trigger?  Explain, please - as it is, I had been
unable to guess what could "specifically looks for a call instruction" refer
to.
