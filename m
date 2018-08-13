Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E023C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFC62171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFC62171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeHMNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:22:58 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:27807
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbeHMNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:22:58 -0400
X-IronPort-AV: E=Sophos;i="5.53,233,1531778400"; 
   d="scan'208";a="275723598"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 12:41:13 +0200
Date:   Mon, 13 Aug 2018 12:41:05 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Himanshu Jha <himanshujha199640@gmail.com>
cc:     corbet@lwn.net, Gilles Muller <Gilles.Muller@lip6.fr>,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dev-tools: coccinelle: Update documentation
In-Reply-To: <20180813103614.7495-1-himanshujha199640@gmail.com>
Message-ID: <alpine.DEB.2.20.1808131240310.21501@hadrien>
References: <20180813103614.7495-1-himanshujha199640@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2018, Himanshu Jha wrote:

> * Fix install instruction by adding `./autogen` command
>   before `./configure`.
> * Add link to a more detailed installation instruction.
> * Add link to SmPL grammar documentation.
> * Add single space after ',' to slightly improve readability.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  Documentation/dev-tools/coccinelle.rst | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 94f41c290bfc..f8305cd55186 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -30,18 +30,29 @@ of many distributions, e.g. :
>   - NetBSD
>   - FreeBSD
>
> -You can get the latest version released from the Coccinelle homepage at
> +Some distribution packages are obsolete and it is recommended
> +to use the latest version released from the Coccinelle homepage at
>  http://coccinelle.lip6.fr/
>
> -Once you have it, run the following command::
> +Or Github at:

Or from Github at:


>
> -     	./configure
> +https://github.com/coccinelle/coccinelle
> +
> +Once you have it, run the following commands::
> +
> +        ./autogen
> +        ./configure
>          make
>
>  as a regular user, and install it with::
>
>          sudo make install
>
> +More detailed installation instruction to build from source can be

instruction -> instructions

julia

> +found at:
> +
> +https://github.com/coccinelle/coccinelle/blob/master/install.txt
> +
>  Supplemental documentation
>  ---------------------------
>
> @@ -51,6 +62,10 @@ https://bottest.wiki.kernel.org/coccicheck
>
>  The wiki documentation always refers to the linux-next version of the script.
>
> +For Semantic Patch Language(SmPL) grammar documentation refer to:
> +
> +http://coccinelle.lip6.fr/documentation.php
> +
>  Using Coccinelle on the Linux kernel
>  ------------------------------------
>
> @@ -223,7 +238,7 @@ Since coccicheck runs through make, it naturally runs from the kernel
>  proper dir, as such the second rule above would be implied for picking up a
>  .cocciconfig when using ``make coccicheck``.
>
> -``make coccicheck`` also supports using M= targets.If you do not supply
> +``make coccicheck`` also supports using M= targets. If you do not supply
>  any M= target, it is assumed you want to target the entire kernel.
>  The kernel coccicheck script has::
>
> --
> 2.17.1
>
>
