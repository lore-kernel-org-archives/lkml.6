Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7662084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7662084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeJATZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:25:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56584 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbeJATZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:25:28 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YmkHXu2vw3A9; Mon,  1 Oct 2018 14:47:47 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E21D91EC01FA;
        Mon,  1 Oct 2018 14:47:46 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:47:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Russ Anderson <rja@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20181001124754.GD7269@zn.tnic>
References: <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
 <20180926181035.GA1132@agluck-desk>
 <20180926182317.patqjso7nzw2oxiz@hpe.com>
 <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic>
 <20180927214400.GA2249@agluck-desk>
 <20180927220355.GF19687@zn.tnic>
 <20180927221054.580220e5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927221054.580220e5@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:10:54PM -0300, Mauro Carvalho Chehab wrote:
> I don't remember about any rationale behind /sys/bus/edac. It was
> there already before I start working on EDAC about 10 years ago.
> I guess it was used in the past by edac-utils (or maybe it is just a
> side effect of the need to create a bus on some past).
> 
> Btw, The documented EDAC ABI is /sys/devices/system/edac, as
> described at Documentation/ABI/testing/sysfs-devices-edac.
> 
> So, I suspect it should be safe to get rid of /sys/bus/edac,
> provided that it won't cause side effects at /sys/devices/system/edac.
> 
> Why I think it is safe to get rid of /sys/bus/edac?
> ---------------------------------------------------

...

Thanks for the analysis. So yap, I think we should try to rip out the
whole bus hierarchy then, when we have a quiet minute and whoever does
this, should add your analysis to the commit message so that we know.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
