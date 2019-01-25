Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC45C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91119218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TcPE359E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfAYOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:08:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYOIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:08:31 -0500
Received: from zn.tnic (p200300EC2BCAC50014C06278D1E5EF9B.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:14c0:6278:d1e5:ef9b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A76E1EC035B;
        Fri, 25 Jan 2019 15:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548425309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8t47gKa0bxXB/mNvnju+bpEatbuBCy638ZZbK87SBws=;
        b=TcPE359Es2imxEu42hbAxo9QiKW2JLfNDWTVSdCBQchZl98CbN/HYTTLyETwMUcxWCq0JX
        z0tooeCu18vPZXgmeyidZjYgmeXB1/nHl3Tnaf+EDh/Cb+J0qXMvaGGtEfdEX4/J8byg3Z
        MEnLsWU98GMWQUnKRWlBmUkFy1ROvzM=
Date:   Fri, 25 Jan 2019 15:08:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190125140823.GC27998@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> AFAIK, some people prefer to explictly reserve crash memory at high
> region even if it is possible to reserve at low area.  May because
> <4G memory is limited on large server, they want to leave this for other
> use. 
> 
> Yinghai or Vivek should know more about the history, probably they can
> recall some initial reason.

Yes, just "prefer" is not good enough. There should be a technical
reason why that's there.

Also, if the user doesn't care, then the code should be free to force
"high" and thus probe a different range for allocation.

> Good question, still it may be some historical reason, but it is good to
> make them clear and rethink about it after long time.
> 
> I also want to understand, need dig the log more.

Good idea. That would be a very nice cleanup. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
