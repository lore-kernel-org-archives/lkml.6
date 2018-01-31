Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeAaRjG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:39:06 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:55874
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753158AbeAaRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:39:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,440,1511823600";
   d="scan'208";a="253164858"
Date: Wed, 31 Jan 2018 18:38:55 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: cocci@systeme.lip6.fr, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: =?UTF-8?Q?Re=3A_=5Bv2=5D_Coccinelle=3A_zalloc-simple=3A_Delete_function_=E2=80=9Ckmem=5Fcache=5Falloc=E2=80=9D_from_SmPL_rules?=
In-Reply-To: <243e83a2-ae0c-2dd2-7f8f-83ac0978cc0e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801311836320.3707@hadrien>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com> <243e83a2-ae0c-2dd2-7f8f-83ac0978cc0e@users.sourceforge.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1890958981-1517420340=:3707"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1890958981-1517420340=:3707
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 31 Jan 2018, SF Markus Elfring wrote:

> > I removed the blank line at EOF,
> > then applied to linux-kbuild/misc.
>
> I have taken another look at this script for the semantic patch language.
> I imagined that I could refactor the shown SmPL disjunctions a bit.
> But I noticed then that these SmPL rules contain a development mistake.
>
> The deletion for a call of the function “memset” depends on the specification
> that a size determination is passed by the expression “E1”.
> The function “kmem_cache_alloc” was specified despite of the technical detail
> that this function does not get a parameter passed which would correspond
> to such a size information.
> https://elixir.free-electrons.com/linux/v4.15/source/tools/testing/radix-tree/linux/slab.h#L14
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/testing/radix-tree/linux/slab.h?id=537659c08a7da298aa748854f65f2aa1f31b1378#n14
>
> Thus I suggest to remove it from the first two SmPL rules and omit the rule “r4”.
> Will the rule set be more consistent then?

If E1 is not bound by the kem_cache_alloc rule, then it will match
anything.  The user can check if it is appropriate.

Another option would be to use the type of the variable storing the result
of the call to compute the expected size.  Feel free to send a patch.

julia
--8323329-1890958981-1517420340=:3707--
