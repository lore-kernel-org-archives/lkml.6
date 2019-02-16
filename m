Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61107222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfBPIls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:41:48 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42500
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbfBPIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:41:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,376,1544482800"; 
   d="scan'208";a="296376647"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:41:46 +0100
Date:   Sat, 16 Feb 2019 09:41:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, Gilles Muller <Gilles.Muller@lip6.fr>,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        wang.yi59@zte.com.cn, yamada.masahiro@socionext.com,
        yellowriver2010@hotmail.com, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [v5] coccinelle: semantic code search for missingput_device()
In-Reply-To: <alpine.DEB.2.21.1902160934400.3212@hadrien>
Message-ID: <alpine.DEB.2.21.1902160939540.3212@hadrien>
References: 201902161504357846572@zte.com.cn,10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de <201902161633004137519@zte.com.cn> <alpine.DEB.2.21.1902160934400.3212@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, upon reflection, I don't like the if (...) solution.  if (id !=
NULL) would be better.  This will also check for if (id).  If having such
an explicit test results in false positives, the semantic patch can be
revised.  But it is better than if (...), which allow anything at all, and
could miss cases where the free should happen, but does not.

julia
