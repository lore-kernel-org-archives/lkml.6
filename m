Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD88DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C721924
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfBSHEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:04:34 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9642 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbfBSHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:04:34 -0500
X-IronPort-AV: E=Sophos;i="5.58,387,1544482800"; 
   d="scan'208";a="369952150"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 08:04:32 +0100
Date:   Tue, 19 Feb 2019 08:04:31 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, yellowriver2010@hotmail.com,
        Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        cheng.shengyu@zte.com.cn, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
In-Reply-To: <201902191014156680299@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902190804150.2570@hadrien>
References: 201902181122502228026@zte.com.cn,ab463e94-287a-6188-6795-06eeb832e861@web.de <201902191014156680299@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-483052161-1550559872=:2570"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-483052161-1550559872=:2570
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 19 Feb 2019, wen.yang99@zte.com.cn wrote:

> > > I would have a hard time saying which one is more reasonable to test,
> > I suggest to reconsider the interpretation of this software situation once more.
> > > since both are extremely unlikely.
> > I disagree to this view because two ellipses were intentionally specified
> > in published SmPL scripts.
> > So some software developers found these “special use cases” important enough.
> > >> In addition, we feel that we should probably accept this patch first,
> > I disagree to this imagination because I would prefer to integrate a source code variant
> > without a bug (which was copied from a version on 2013-05-08 by Petr Strnad).
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/free/pci_free_consistent.cocci?id=f7b167113753e95ae61383e234f8d10142782ace#n12
> > I hope that nicer run time behaviour can become also relevant here.
>
> Both cases are extremely unlikely.
> Although we have tested these two methods in the existing kernel code,
> considering the evolution of the kernel code, these special cases may occur, so we are willing to take them into account.
> We plan to modify the code like this:
>
>  id = of_find_device_by_node@p1(x)
> -... when != e = id
> +... when != e = (T)id
> +    when != id = (T)e

This change is fine with me.

julia

>
> Do you have any other questions?
> Thanks.
>
> Regards,
> Wen
--8323329-483052161-1550559872=:2570--
