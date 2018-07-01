Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B98C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC67F24BE8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC67F24BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeGAJDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:03:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16168
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751879AbeGAJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:03:32 -0400
X-IronPort-AV: E=Sophos;i="5.51,294,1526335200"; 
   d="scan'208";a="270948469"
Received: from 89-157-201-3.rev.numericable.fr (HELO [192.168.0.15]) ([89.157.201.3])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 11:03:30 +0200
Date:   Sun, 1 Jul 2018 11:03:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     SF Markus Elfring <elfring@users.sourceforge.net>
cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 12/16] treewide: Use array_size() for
 kmalloc()-family
In-Reply-To: <b4c01457-7ea5-e7e3-be8b-f00fba6bac2b@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1807011100110.2748@hadrien>
References: <20180601004233.37822-13-keescook@chromium.org> <b4c01457-7ea5-e7e3-be8b-f00fba6bac2b@users.sourceforge.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1156912627-1530435810=:2748"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-1156912627-1530435810=:2748
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> > // 2-factor product with sizeof(variable)
> > @@
> > identifier alloc =~ "kmalloc|kzalloc|kvmalloc|kvzalloc";
>
> * This regular expression could be optimised to the specification “kv?[mz]alloc”.
>   Extensions will be useful for further function names.
>
> * The repetition of such a constraint in subsequent SmPL rules could be avoided
>   if inheritance will be used for this metavariable.

This is quite incorrect.  Inheritance is only possible when a match of the
previous rule has succeeded.  If a rule never applies in a given file, the
rules that inherit from it won't apply either.  Furthermore, what is
inherited is the value, not the constraint.  If the original binding of
alloc only ever matches kmalloc, then the inherited references will only
match kmalloc too.

julia
--8323329-1156912627-1530435810=:2748--
