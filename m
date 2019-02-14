Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1638222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407535AbfBNPTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:19:41 -0500
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:42020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404736AbfBNPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:19:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 61F0D180A7774;
        Thu, 14 Feb 2019 15:19:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: burst64_5426cbf2ebd24
X-Filterd-Recvd-Size: 2433
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Feb 2019 15:19:38 +0000 (UTC)
Message-ID: <d9ad7fb05178dd9afb4906cacdb03f86802c23c3.camel@perches.com>
Subject: Re: report: scripts: checkpatch: Spell Checker Does Not Run with
 '-f'
From:   Joe Perches <joe@perches.com>
To:     federico.vaga@cern.ch
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 07:19:36 -0800
In-Reply-To: <2899994.xJFnvJAAA5@pcbe13614>
References: <3030138.e1gdHPWlgN@pcbe13614>
         <4a6844c41d187d113e0c54dd156ba91c2635c361.camel@perches.com>
         <2899994.xJFnvJAAA5@pcbe13614>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 16:03 +0100, Federico Vaga wrote:
> On Thursday, February 14, 2019 3:44:55 PM CET Joe Perches wrote:
> > On Thu, 2019-02-14 at 13:48 +0100, Federico Vaga wrote:
> > > Hello,
> > > 
> > > Recently I have produce a couple of patches but I get different warnings
> > > if I run checkpatch on the file (-f) or if I run it of a patch file. In
> > > particular, the problem I found is with the spell checker which seems to
> > > run only when the option '-f' is not used. I am wandering if there are
> > > other similar cases.
> > > 
> > > I do not know Perl, so I cannot investigate more, but I have a practical
> > > example. I have this simple patch applied on my tree that introduces a
> > > spell
> > > error:
> > If you want spelling fixes on files you have to use --strict
> 
> Thanks
> 
> Is it a design choice to have different checks enabled with '-f'? 

Yes.

It was for a minimization of churn.

commit 66b47b4a9dad00e45c049d79966de9a3a1f4d337
Author: Kees Cook <keescook@chromium.org>
Date:   Mon Oct 13 15:51:57 2014 -0700

    checkpatch: look for common misspellings
    
    Check for misspellings, based on Debian's lintian list.  Several false
    positives were removed, and several additional words added that were
    common in the kernel:
    
            backword backwords
            invalide valide
            recieves
            singed unsinged
    
    While going back and fixing existing spelling mistakes isn't a high
    priority, it'd be nice to try to catch them before they hit the tree.


