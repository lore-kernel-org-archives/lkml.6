Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA4BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027DD20825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027DD20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeKQVpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:45:38 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44224 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeKQVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:45:37 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gNymn-0004bJ-Am; Sat, 17 Nov 2018 12:29:13 +0100
Message-ID: <e6910a457e75e240e18ed395ccb2f960dda6fc94.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] compiler-gcc: hide
 COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW from sparse
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Date:   Sat, 17 Nov 2018 12:29:12 +0100
In-Reply-To: <20181117004209.v67yalpxuswhs2vr@ltop.local> (sfid-20181117_014213_396373_F28FF538)
References: <20181109093534.15121-1-johannes@sipsolutions.net>
         <20181117004209.v67yalpxuswhs2vr@ltop.local>
         (sfid-20181117_014213_396373_F28FF538)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-17 at 01:42 +0100, Luc Van Oostenryck wrote:
> On Fri, Nov 09, 2018 at 10:35:32AM +0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Sparse doesn't support all the overflow builtins, so just hide
> > them from it to avoid lots of warnings/errors reported by it.
> 
> The development version of sparse support these builtins
> since their introduction in the kernel and sparse's main tree
> have been updated (very recently).

All the better, but I certainly checked sparse git before even
considering this patch, so saying "but it's all there" feels somewhat
dishonest. Also, the sparse repo is 'backdated' to the end of October.
I'm almost certain this wasn't present when I sent the patch.

However, it would be nice to be able to use distro sparse versions, so
not sure I fully agree that we shouldn't apply such patches.

johannes

