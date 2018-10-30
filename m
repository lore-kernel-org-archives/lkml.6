Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02887C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E5E2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E5E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJ3Q25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:28:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52594 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3Q25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:28:57 -0400
Received: from 79.184.254.164.ipv4.supernova.orange.pl (79.184.254.164) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id c78f4fe32784aa61; Tue, 30 Oct 2018 08:36:35 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: linux-next: manual merge of the pm tree with Linus' tree
Date:   Tue, 30 Oct 2018 08:33:08 +0100
Message-ID: <1746838.ttb7sSuUtV@aspire.rjw.lan>
In-Reply-To: <20181029130124.290346e9@canb.auug.org.au>
References: <20181029130124.290346e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 29, 2018 3:01:24 AM CET Stephen Rothwell wrote:
> 
> --Sig_/X_/swfdki+BZTJ8afk_lQqW
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Rafael,
> 
> Today's linux-next merge of the pm tree got a conflict in:
> 
>   drivers/cpuidle/governors/menu.c
> 
> between commit:
> 
>   8508cf3ffad4 ("sched: loadavg: consolidate LOAD_INT, LOAD_FRAC, CALC_LOAD=
> ")
> 
> from Linus' tree and commit:
> 
>   a7fe5190c03f ("cpuidle: menu: Remove get_loadavg() from the performance m=
> ultiplier")
> 
> from the pm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> --=20
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/cpuidle/governors/menu.c
> index 71979605246e,76df4f947f07..000000000000
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@@ -130,11 -130,10 +130,6 @@@ struct menu_device=20
>   	int		interval_ptr;
>   };
>  =20
> - static inline int get_loadavg(unsigned long load)
> - {
> - 	return LOAD_INT(load) * 10 + LOAD_FRAC(load) / 10;
> - }
>  -
>  -#define LOAD_INT(x) ((x) >> FSHIFT)
>  -#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
> --
>   static inline int which_bucket(unsigned int duration, unsigned long nr_io=
> waiters)
>   {
>   	int bucket =3D 0;
> 
> --Sig_/X_/swfdki+BZTJ8afk_lQqW
> Content-Type: application/pgp-signature
> Content-Description: OpenPGP digital signature
> 
> 
> --Sig_/X_/swfdki+BZTJ8afk_lQqW--
> 

The fix looks good to me, thanks!

Cheers,
Rafael


