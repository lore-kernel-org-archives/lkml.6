Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF822C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E48F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E48F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeIZPlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:41:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:35079 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeIZPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:41:19 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8Q9SAKU027631;
        Wed, 26 Sep 2018 04:28:11 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w8Q9S8e3027625;
        Wed, 26 Sep 2018 04:28:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 26 Sep 2018 04:28:07 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Russell Currey <ruscur@russell.cc>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
Message-ID: <20180926092806.GM23155@gate.crashing.org>
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr> <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr> <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr> <d203ccfce64c8f9fd403162f2fa3807ade7f1d28.camel@russell.cc> <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:58:30AM +0200, Christophe LEROY wrote:
> Segher, any idea about this problem ?

> >>arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_printf':
> >>/var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
> >>sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88:
> >>undefined reference to `__stack_chk_fail_local'

Are you building as PIC?  Are you linking libssp_nonshared.a?  Why not?

:-)


Segher
