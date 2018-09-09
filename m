Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E970AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7358320865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7358320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeIIQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 12:09:24 -0400
Received: from mout.web.de ([212.227.15.3]:46569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbeIIQJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 12:09:23 -0400
Received: from [192.168.1.2] ([92.228.188.104]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeSLv-1gDdZ71Pzz-00QAK3; Sun, 09
 Sep 2018 13:13:46 +0200
To:     Corentin Labbe <clabbe@baylibre.com>,
        kernel-janitors@vger.kernel.org
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Alistair Popple <alistair@popple.id.au>,
        Anatolij Gustschin <agust@denx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Tejun Heo <tj@kernel.org>,
        Vitaly Bordug <vitb@kernel.crashing.org>
References: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Subject: Re: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <463dbbdc-7afc-bee8-8da1-bbe70b4aec26@users.sourceforge.net>
Date:   Sun, 9 Sep 2018 13:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ug9wq6q4CNsey39rItMJwW1cQXH74Vgi68+fc8b5e2dmPYOIfKY
 tMIIX3/8wbW+CMjDhkKfvbkToH7P9pj2omZ7g8VUGYRM5Anby59eXtld/PB/7ZzNsc5DwqT
 /ipi5PD9hGQ7d7pD6yAPw8xaoE4/OAMOHOE9hvteagUZ/+tkaHD9e/xwjDrZsk4x6x+5ujf
 9qi3YfQtobcpBC44mLx+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bv6Bo7b+9h8=:GOKCFAcbWviLRJiVaRVmLs
 VxJ5IrcMatL9GhItFjc0NBQSOrkb8XHTZhAZGHm8MDkGu1Rx2kfSQ0aIqUCgPCZTVhawDb7UN
 sG04ECpHG47J7gPpMPeuub6qE8OtiIDRylerI7M6e2AryunvgTs5VQHtLEIZp0l6BbfEho4qf
 a69SIUCLHiY6PoEyLVc/awPS3WjlyIBQtAsdgNZyUqoHMC0sbGmp65gGBJtnNOhOlR4ZkjIFd
 4z5GxB60sxK1bRAI932MeXcnRoCPAx/TZOGMVRUtCKHysi9u9at8usQcL/RLPAdYh8fdwfeoX
 P8+3f0VAGi4denoE9GwaZ9uSh+vE8AQOiXIIkHTnhbji14h2B47Efrxj2AqWAa3jVMnMS7FXg
 4qgPiH58+DVJzSaomkR7VFsDh4h6a7bj5aEXYFC5TvxGFJaFKp374YIUfFQQJv3QVKZO1GCHG
 XQvdQgjb1yjSRfF5G1vLqd/yfK5+0F7jOhsuLRzainoPUIcTnKAcsV91zIKIZXY0Gge+qi1NB
 bC7JuP7BvroMypEq/4hO8qrEA44siedRNIkGTG3COvj18QX3ogYMbr+lUNfmnugyuvrkhUrEy
 ZksfItYAH0ceVRUrIt9GUeYt9bAIh8mpl9RAYMrv+2L+5vo2IrrgUCt+oBnfhl6wAswn42wYd
 DaJFzbBOkRIaAEzHdmYCRr5HaVWWKPkSK+efhRjnHZ79jyzA1OML/Tj5YMXQJtShgX1chpJaf
 EIAJQMVo4woeKrSN6BkK6QY4xKzUZVw8T5HHqIudb3qMFYOAmH/9ibE7UIkHt9iA6UQxhGWD0
 Rxh4ER+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How do you think about to add any more meta-data for this semantic patch script?

* SPDX identifier
* Copyright information
* Confidence level

https://bottest.wiki.kernel.org/coccicheck


> +virtual context

Further variables will be needed if you would like to use corresponding
operation modes (besides “patch”).


> +expression reg;
> +expression set;
> +expression clear;

I propose once more to avoid the repetition of (unnecessary) SmPL code.
This part could be written like the following instead.

+expression clear, set, reg;


If you would increase the usage of SmPL disjunctions, the specification
of duplicate SmPL code could be reduced considerably.

* Would you like to merge SmPL rules based on the distinction between
  the data types “u32” and “u64”?

* Did you identify any optional code in this transformation approach?


> +@@
> +expression base;
> +expression offset;
> +expression value;
> +@@
> +
> +- mtu3_setbits(base, offset, value);
> ++ setbits32(base + offset, value);
> +
> +@@
> +expression base;
> +expression offset;
> +expression mask;
> +@@
> +
> +- mtu3_clrbits(base, offset, mask);
> ++ clrbits32(base + offset, mask);

Another update suggestion:

+@replacement@
+expression base, offset;
+@@
+(
+-mtu3_clrbits
++clrbits32
+|
+-mtu3_setbits
++setbits32
+)(base
+-     ,
++ +
+  offset, ...);


Would you like to try further software fine-tuning out?

Regards,
Markus
