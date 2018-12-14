Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A35C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBDB2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544804029;
	bh=uxQ/GGsP60h8mW67Wmesep32qK4uKhmUVbl/0OtFLRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CXxA/0jSfxLwryu8irxqR6yheG/K/Y0SHkYfNa2x8kpWW9LjYILzGKfFbDmERKl5M
	 AAjzC9sR9xnu6et7otdAyxmYllAVcN9psEV1JMBDYTJLBtxO4TXIUVTA8MHGkm8UaB
	 kgRcs9fiMOn64tfu4zc5WoFCfTzlcaRz47wpfh6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeLNQNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeLNQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:13:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89D5206E0;
        Fri, 14 Dec 2018 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544804027;
        bh=uxQ/GGsP60h8mW67Wmesep32qK4uKhmUVbl/0OtFLRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okr24d4oGkXwnumP9AaTMM8U7dwSLpWwX402yhOdt7/dlkTzYqRobEMVr1MFndCBd
         HB+WEWiE7ZHShLwCA+bcPNnXXb5LwFHsX2Ni8cd/aPWyQkIgGuFsZXwk+PPHEI/CjN
         ZToqK9UbI1c99jz9XlZ5PxOlCxLMIN76i0eAy4fA=
Date:   Fri, 14 Dec 2018 17:13:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
Message-ID: <20181214161344.GA10654@kroah.com>
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:52:15AM -0800, Joe Perches wrote:
> On Fri, 2018-12-14 at 14:01 +0100, Jorge Ramirez-Ortiz wrote:
> > As per Documentation/process/submitting-patches, Co-developed-by is a
> > valid signature.
> > 
> > This commit removes the warning.
> 
> Your commit message doesn't match your subject.
> 
> A couple variants have been documented and only
> one should actually be used.
> 
> $ git grep -i co-developed-by Documentation/process/
> Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
> Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
> Documentation/process/submitting-patches.rst:A Co-Developed-by: states that the patch was also created by another developer
> 
> $ git log --grep="co-developed-by:" -i | \
>   grep -ohiP "co-developed-by:" | sort | uniq -c | sort -rn
>      80 Co-developed-by:
>      40 Co-Developed-by:
> 
> So which should it be?

"Co-developed-by:" please.

Yeah, I wrote the original one wrong here, sorry.

> btw: I prefer neither as I think Signed-off-by: is sufficient.

Nope, sorry, it is not, we need something like this which is why it was
added.

thanks,

greg k-h
