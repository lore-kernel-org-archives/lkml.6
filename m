Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848FC2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LPTREAWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848FC2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeLJSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:41:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeLJSl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:41:58 -0500
Received: from zn.tnic (p200300EC2BCAD0009567F52EDB121050.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:9567:f52e:db12:1050])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40AD1EC0322;
        Mon, 10 Dec 2018 19:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544467317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lsc5XnsBlWvPoGh9DvSS5jGKkkhEcBBln6b+h+ZfpPs=;
        b=LPTREAWh041mFDJVUR8AkWOI1ZFbTul0tppHJNnLYn5LhrjS3599aONXqjyl3IqhbwlRb8
        fDnuDQclIkiUcnbthOpFYJKBVGN2prIo8GD0YgJbfnOezblg/KT12dI4haEz04JRLwl+LW
        3ykXd2wnyWeW0hAr0IPKvt4NNrX30kg=
Date:   Mon, 10 Dec 2018 19:41:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210184153.GB5482@zn.tnic>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210183730.GJ4669@habkost.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:37:30PM -0200, Eduardo Habkost wrote:
> It isn't as simply as reverting commit 33b5e8c03ae7, but we can
> surely re-add RDTSCP on pc-*-4.0 and newer.

Sure. If you could only point me to an example how to add that to
pc-*-4.0 and newer, I'll gladly cook up a patch and test it.

> I thought we added documentation mentioning the minimum kernel
> version required by QEMU, but I can't find it.  In either case,
> it seems reasonable to require Linux 4.5 or newer on newer
> machine-types.

When you say "require" does that mean, one puts it in a text file
somewhere in the qemu sources or do we enforce it somehow?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
