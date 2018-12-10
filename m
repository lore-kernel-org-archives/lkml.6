Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353C20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gEtCVHQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6353C20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeLJUjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:39:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbeLJUja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:39:30 -0500
Received: from zn.tnic (p200300EC2BCAD0002992494E33A10E64.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:2992:494e:33a1:e64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D1271EC0322;
        Mon, 10 Dec 2018 21:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544474369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T9dJK1dJDLxwF0hMYTkQ7FOF1X08CZLPSdQ9bMWgXs8=;
        b=gEtCVHQnDRBph3P6my8Fr8Yxi0PftCDN7PAjP0j1kk2lZ7WQ37pz9n5qj6V5XvDpkfAWX9
        2sEn/f2upLK/waH/TiydYABEGkR75V1ggtGVSixGW7zedjpgYbmYB+PgbOWlODwjgDnlB1
        PHnB+QyrXq52rvAwI8HfyRXZsEpX5Tw=
Date:   Mon, 10 Dec 2018 21:39:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210203925.GG5482@zn.tnic>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210190600.GK4669@habkost.net>
 <20181210194258.GD5482@zn.tnic>
 <20181210200843.GN4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210200843.GN4669@habkost.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 06:08:43PM -0200, Eduardo Habkost wrote:
> | The Opteron_G2, OpteronG3, Opteron_G4, and Opteron_G5 CPU
> | models require KVM support for RDTSCP, which was added on
> | Linux 4.5.

I've added that to the current diff:

"The OpteronG[345] CPU models require KVM support for RDTSCP, which was
added with Linux 4.5."

In the meantime, I tried executing RDTSCP on a K8 laptop and it gave
SIGILL so I'd say the AMD docs have a typo and family 0xf - at least the
A-E revisions of which model 6 is a part of - doesn't have RDTSCP.

But let's see...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
