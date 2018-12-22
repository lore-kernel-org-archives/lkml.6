Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD567C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D9E21983
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392274AbeLVQt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:49:58 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:59159 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLVQt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:49:58 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id C59C15C0864; Sat, 22 Dec 2018 08:59:44 +0100 (CET)
Date:   Sat, 22 Dec 2018 08:59:44 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Scott Wood <oss@buserror.net>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Message-ID: <20181222075944.GA26155@osadl.at>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > devm_kstrdup() may return NULL if internal allocation failed, but
> > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > can be used here, which will only copy the reference.
> 
> Is it really going to only copy the reference?  That would require that
> is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> of the kernel image.
>
I had tried to figure out what is RO and what not but was not 
able to determine that - from the discussion it seemed that the
assumption of RO is correct though I did not ask if it would
satisfy is_kernel_rodata() so that explains the incorrect assertion.
see https://lkml.org/lkml/2018/12/6/42
So then the only option is to check the return and cleanup
on allocation failure as the orriginal patch proposed.

thanks for clearifying this !
hofrat
