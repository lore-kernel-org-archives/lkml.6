Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeAaR2c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:28:32 -0500
Received: from mout.web.de ([212.227.15.4]:63700 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeAaR2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:28:30 -0500
To: cocci@systeme.lip6.fr, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
Subject: =?UTF-8?Q?Re:_[v2]_Coccinelle:_zalloc-simple:_Delete_function_?=
 =?UTF-8?B?4oCca21lbV9jYWNoZV9hbGxvY+KAnSBmcm9tIFNtUEwgcnVsZXM=?=
From: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <243e83a2-ae0c-2dd2-7f8f-83ac0978cc0e@users.sourceforge.net>
Date: Wed, 31 Jan 2018 18:28:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:mMrinxa8SGh9+1dLgbct/LVK6j4lf15/bSWzTYVKQDxEB9f3FmU
 tSe70GyJr8nUtFuGx8OIvzaX7o9Jx8Xtnt6X4a2zH4E/SNtWi9sk8tx0yTCKn32Abos3pu4
 eGeZajVztxDqHkqTNDXS8Vh2tumaYdwsQ2Ei4wH/X5SBxF3R+JcPVshdvI73sB2aIX2tspl
 zL9sMLMlbn2hwTckmdf1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iGw2Gr9jnq4=:C4jvjMUKM/Rl9VOkIMz8sm
 ZMHG9uxNRSCtp9agpDdbdcVTaN3xQhP3qNQyHRzFBXCmUow05T314NZ7ANqANZd/l/yNDjWpj
 hP8UKTjESP4S/3FMlGgoVU4cPFrc8RZp3MV6NvavGMF2c0F804vfR3RA1hvHk9O48c/rJ81S5
 YawGFNQfGNNLCJHfXTBwekv8L4mBsgE7qlIYSE0IhQ9F7UzckoHZpo1WZ9I4VJUjYn6s4W0oR
 nLoczS2/k923AIzXi2EgUSCaFIXIqWTq+cDy5YRRs8l16ENyiLZ/ALvfw19AKyJdwVRGheJfA
 KbQNyMsskIT7LVQDIT8ztZHONyHLDtBJa97u0x/JyMZfmGDGrXJ1bajntAGObUPPM45XSqL+e
 pvSne+ijsc62zlFBnsPhKL3yj/3m8UBDGLGx0qHtgTUvH3WPDZHo2aUVCsr7jhRC3MdskLDdh
 zD5tJ5ENJ4yprEE5RehBj09zpZJCXOybV6pLBwgAFgAl342oVf1vMNftCqq2c6l9MLPKHSgR/
 3rMt/4LZJT4m5iwCccW5u8khLkETJ5zx4lawY76Pn24VsHbq1wZWqXG2MOi7Xk4PkDHkR/puF
 5vZMC29Xcn6cLVUvivh8bp8NssexzwsDkSP6cEYRvk6eeQl/KGx6SuKTQKKHkUYSoDT2xAtTW
 HKIwQgJsBU1VJizFUiN4+Tqbl7NleLNAnk0tNaxiJPOQnLUR2Gxt6vA/NrqIQA41pXgxN1/NP
 FRmPsHWOfgHVxmbMWMB1DT7fquDca9ThvrbzCQrL9Zox8/imaWlnpSNKY7uPS9HPT0ed5EO0F
 1B2SADlNpnOMterAg75xqmFe/OYX7c9v3S/XjNG+zGb4mpCyPw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I removed the blank line at EOF,
> then applied to linux-kbuild/misc.

I have taken another look at this script for the semantic patch language.
I imagined that I could refactor the shown SmPL disjunctions a bit.
But I noticed then that these SmPL rules contain a development mistake.

The deletion for a call of the function “memset” depends on the specification
that a size determination is passed by the expression “E1”.
The function “kmem_cache_alloc” was specified despite of the technical detail
that this function does not get a parameter passed which would correspond
to such a size information.
https://elixir.free-electrons.com/linux/v4.15/source/tools/testing/radix-tree/linux/slab.h#L14
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/testing/radix-tree/linux/slab.h?id=537659c08a7da298aa748854f65f2aa1f31b1378#n14

Thus I suggest to remove it from the first two SmPL rules and omit the rule “r4”.
Will the rule set be more consistent then?

Regards,
Markus
