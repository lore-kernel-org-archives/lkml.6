Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0154AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED2208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ED2208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755536AbeFNVwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:52:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:54450 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755348AbeFNVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:52:33 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5ELpd6d002692;
        Thu, 14 Jun 2018 16:51:39 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w5ELpbqw002689;
        Thu, 14 Jun 2018 16:51:37 -0500
Date:   Thu, 14 Jun 2018 16:51:37 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180614215137.GB16221@gate.crashing.org>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr> <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr> <20180612145315.GJ27520@gate.crashing.org> <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 07:01:59PM +0200, Christophe LEROY wrote:
> 
> 
> Le 12/06/2018 à 16:53, Segher Boessenkool a écrit :
> >On Tue, Jun 12, 2018 at 09:14:53AM +0000, Christophe Leroy wrote:
> >>---
> >>Not tested on PPC64.
> >
> >It won't be acceptable until that happens.  It also is likely quite bad
> >performance on all 64-bit CPUs from the last fifteen years or so.  Or you
> >did nothing to prove otherwise, at least.
> 
> Will it be as bad as the generic implementation which does it byte per 
> byte ?

Probably not.  But how is it for short inputs, etc.?

The main point is that it needs actual testing _for correctness_.

Btw, GCC 7 and later can expand many memcmp as builtins on PowerPC (just
like memset and memcpy etc.), creating better code, without function call.


Segher
