Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C28C20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C28C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJILxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:53:44 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:45784 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbeJILxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:53:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D9563100E86C4;
        Tue,  9 Oct 2018 04:38:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glue43_864aa42fe6b16
X-Filterd-Recvd-Size: 2264
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Oct 2018 04:38:42 +0000 (UTC)
Message-ID: <5f968a498c3d9848389ce5c6e04d98fc59c6438a.camel@perches.com>
Subject: Re: [PATCH] powerpc/xmon/ppc-opc: Use ARRAY_SIZE macro
From:   Joe Perches <joe@perches.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 21:38:41 -0700
In-Reply-To: <874ldv3hty.fsf@concordia.ellerman.id.au>
References: <20181004171036.GA1907@embeddedor.com>
         <8e2f906a85c3cfe0715982370a6d96f08a37987c.camel@perches.com>
         <874ldv3hty.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 14:43 +1100, Michael Ellerman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > On Thu, 2018-10-04 at 19:10 +0200, Gustavo A. R. Silva wrote:
> > > Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> > []
> > > diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> > []
> > > @@ -966,8 +966,7 @@ const struct powerpc_operand powerpc_operands[] =
> > >    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
> > >  };
> > >  
> > > -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
> > > -					   / sizeof (powerpc_operands[0]));
> > > +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
> > 
> > It seems this is unused and could be deleted.
> 
> The code in this file is copied from binutils.
> 
> We don't want to needlessly diverge it.
> 
> I've said this before:
> 
>   https://lore.kernel.org/linuxppc-dev/874lfxjnzl.fsf@concordia.ellerman.id.au/

Don't expect people to remember this.

> Is there some way we can blacklist this file from checkpatch, Coccinelle
> etc?

Modify both to look for some specific tag
in a file and then update the scripts to
read the file when looking at patches too.

Otherwise, no.



