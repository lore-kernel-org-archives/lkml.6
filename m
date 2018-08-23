Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A85C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A006208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A006208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeHWHgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:36:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:37943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeHWHgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:36:11 -0400
Received: from homer.simpson.net ([185.191.219.166]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LabZr-1gFczc10Zz-00mO4F; Thu, 23
 Aug 2018 06:08:03 +0200
Message-ID: <1534997281.5153.3.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Date:   Thu, 23 Aug 2018 06:08:01 +0200
In-Reply-To: <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
         <1533800010.5087.71.camel@gmx.de>
         <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
         <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
         <20180822102310.GA19827@dhcp-128-65.nay.redhat.com>
         <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jfNkp6MU2y2JRtC0Jt6DdC2YiiryccmPJ7jT5UzWVD4/26w7iA+
 i8trEu39wbMiTXYjsr32Ir++B1qB5/pIc7Hg/HdsyyV3MW+qKslIlAocc/SXa+0YPtgQq+g
 FmZOHhLODP1AFDRvC/Cx6k7w0RSm4iDFYLssbT6snEoUn5EtSmtPyI6OMauzjXGik6g7Tbq
 /hhRd8G9yYL4HhiNrS01A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o4mCvSopZD8=:C6Axcc0QR3XLJjeiUn1W8x
 okMkhobzFQvHpiqxrffSOFTs9ENjJU7NENMR1MkmNBwUjlDa/PJ+H1PhWyOirTGxc2UHNU09n
 HNN4lgBVcOXSGMOwIQzv9VfLH/+E6EiHB+mcOoxDpObmxefZGVo79PS4Su+zNxdkog88oWLax
 HxRXIyozRmOeiGFTYBoISNFul8OREReWBVcyDwvDRSTAw/auQalxGi6Obfl7PREujgyvlaQVL
 Wp7WwRIRcbGI4LfSiJSjwP3jgfSn0PNJ0SClGYWxz52TxDnlQqpZgrfGo7Ok9NDRwU4tU83ta
 7623IQprr+wEH4A6yrqZMCvvfd6GlVhZijL8Z9NKrN1/JhX62AxRdmCuM3gmDcvXmlWE+bnZU
 RZOi9jvikm6nLsy7YXDXc/a3qNum1zCDPhJ6Bs7soUKNwkmsLRKNBWEg3wp3JEoPM2Sv1M325
 OL41bGgdL758wSVWHLT1omxmV8Os7oD7GkEgPs6klgveTRwNZHs7WGJRYgRYR2Dw4Ps+z10IT
 Xr85WP/ZM3uxGJX1V6NqFrxiW9LADnwp2FvMOGGqnLIM9pEPgCBpthTqeZvr3wYJbt3sJkXtw
 +5z5uutBFeH/ba+dHxj139pGzRHUgbgO4ngYYiSAzsys9U+p52c+8Mg4EVLXoUtFkZqD05DfM
 KJstk303ryYiD2XHqox1GQ5SPp4bgdNp2f2XA3Yq+nA314k2GjJKLo+AvbH4t9RsCoA6O5b6h
 zpEWkYCuo5Pb5QsHa312GQd2K7fbqmA17L9kvviLOyFuiNkgVgW5Ylgz2If99V9tzEmS2Ns+O
 PJGKNst
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 11:57 +0800, Dave Young wrote:
> 
> Mike, since we are going this way, I'm working on a kexec code cleanup,
> but it needs careful testing so still need some time.
> 
> Can you help test below efi fix and provide you tested-by if it works?

Sure.  I'm buried to the eyebrows atm (why no patchlet has appeared in
your inbox), but I'll get to it.

	-Mike
