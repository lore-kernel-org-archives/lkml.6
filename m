Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F56CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12BE20867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12BE20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbeITInN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:43:13 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:33031 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbeITInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:43:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8248E180A8135;
        Thu, 20 Sep 2018 03:02:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bird61_4c9ff76703f49
X-Filterd-Recvd-Size: 1644
Received: from XPS-9350 (modemcable064.186-131-66.mc.videotron.ca [66.131.186.64])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Sep 2018 03:02:06 +0000 (UTC)
Message-ID: <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 20:02:05 -0700
In-Reply-To: <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
         <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
> On the below patch, checkpatch reports
> 
> WARNING: struct kgdb_arch should normally be const
> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
> +struct kgdb_arch arch_kgdb_ops;
> 
> But when I add 'const', I get compilation failure

So don't add const.

checkpatch is stupid.  You are not.

_Always_ take checkpatch bleats with very
large grains of salt.

Perhaps send a patch to remove kgbd_arch
from scripts/const_structs.checkpatch as
it seems not ever to be const.

