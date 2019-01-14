Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D1BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C001620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="boo/5wq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfANK0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:26:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52818 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfANK0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:26:36 -0500
Received: from zn.tnic (p200300EC2BC4CA00116FEC2D9C4463FB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:116f:ec2d:9c44:63fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 262851EC0543;
        Mon, 14 Jan 2019 11:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547461595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Pd6Cq+NLWhEYkT/4ZScq6s/oIx2KdPuuWS0HkeoDOwo=;
        b=boo/5wq1HLJsihZGhETrDD1pGA7NYXUni4yrLWYpj6qcVnRy99ypEapdAa6tU97lEQgrav
        iwXuFwdmD728RaTxaZ4ZVtc641P1MYXjUrVCWjsORgl0lS4xswwTsLu/LT+U0H9+WqMe9z
        XdUMXbNv5nJlBGONg3IS25ItaZPbxoI=
Date:   Mon, 14 Jan 2019 11:26:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank
 4" to more models
Message-ID: <20190114102633.GF2773@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-2-git-send-email-shirish.s@amd.com>
 <20190109215454.GJ15665@zn.tnic>
 <808faebf-f708-65d0-fd86-ab2ec2234fdd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <808faebf-f708-65d0-fd86-ab2ec2234fdd@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:02:47AM +0000, S wrote:
> I wanted to send the patch with you in recipient field rather than cc, 
> unfortunately --cc remained in the git-send command

Next time look at the manpage:

git send-email --to <recipient> --cc <other recipient> --suppress-cc=all

and the last switch stops git from adding more CCs.

Make sure you add "--dry-run" to check whether it adds the proper
CCs/Tos first and then send it for real.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
