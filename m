Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD97C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420A92083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ofKPxBbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfBURN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:13:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBURNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:13:25 -0500
Received: from zn.tnic (p200300EC2BCBF8004DE098E2D9810947.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:f800:4de0:98e2:d981:947])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AE101EC027A;
        Thu, 21 Feb 2019 18:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550769204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PBYrejRM9gX7hu5ficWMUqeNOUHX7U9TXP8lxSaWkWk=;
        b=ofKPxBbKLx/XsQYMzPDWCDqb1pS1BEsQjWMl7Rf8KzEdcmDfBk/xzrCwjzTGfj6tcuiQnD
        3/rl0Rbcv+20gLTWXU3CusFZLFc/lfI/Ht4fbGyXGZp1DzDPnZLZZry7Fs7cSGShqAB3WK
        3sbWSnteJQw7TEvd05wF3uU9P9VYewM=
Date:   Thu, 21 Feb 2019 18:13:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190221171321.GD12997@zn.tnic>
References: <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:41:46PM +0800, Dave Young wrote:
> Previously Joerg posted below patch, maybe he has some idea. Joerg?

Isn't it clear from the commit message?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
