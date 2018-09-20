Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE09FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE2C2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE2C2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbeITS5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:57:17 -0400
Received: from ozlabs.org ([203.11.71.1]:33929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387570AbeITS5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:57:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GHHH2DGVz9sBZ;
        Thu, 20 Sep 2018 23:13:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Perches <joe@perches.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add kgdb_arch_set/remove_breakpoint())
In-Reply-To: <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr> <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr> <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
Date:   Thu, 20 Sep 2018 23:13:43 +1000
Message-ID: <87worgia60.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
>> On the below patch, checkpatch reports
>> 
>> WARNING: struct kgdb_arch should normally be const
>> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
>> +struct kgdb_arch arch_kgdb_ops;
>> 
>> But when I add 'const', I get compilation failure
>
> So don't add const.
>
> checkpatch is stupid.  You are not.
>
> _Always_ take checkpatch bleats with very
> large grains of salt.
>
> Perhaps send a patch to remove kgbd_arch
> from scripts/const_structs.checkpatch as
> it seems not ever to be const.

I think it could/should be const though, it just requires updating all
arches.

cheers
