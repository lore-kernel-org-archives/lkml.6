Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940AEC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584C320833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584C320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIJLxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:53:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36654 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeIJLxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:53:47 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tfmSIClJ3RZA; Mon, 10 Sep 2018 09:01:14 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 174D11EC02C1;
        Mon, 10 Sep 2018 09:01:14 +0200 (CEST)
Date:   Mon, 10 Sep 2018 09:01:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] x86/paravirt: Cleanup native_patch()
Message-ID: <20180910070108.GA21406@zn.tnic>
References: <20180907104917.12502-1-bp@alien8.de>
 <20180907105112.GD12849@zn.tnic>
 <20180907201050.GF12849@zn.tnic>
 <65bb69fa-855f-9efc-19ba-c0fab69f468c@suse.com>
 <20180908152800.GA8286@zn.tnic>
 <229941d4-c152-89fb-eb75-fcfa5f265ad4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <229941d4-c152-89fb-eb75-fcfa5f265ad4@suse.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 08:54:12AM +0200, Juergen Gross wrote:
> > +	case PARAVIRT_PATCH(lock.queued_spin_unlock):
> > +		if (pv_is_native_spin_unlock())
> > +			return paravirt_patch_insns(ibuf, len,
> > +						    start_lock_queued_spin_unlock,
> > +						    end_lock_queued_spin_unlock);
> > +		else
> > +			return paravirt_patch_default(type, ibuf, addr, len);
> 
> Why not replace the else clause by a "break;" and ...

Because I think that exiting right then and there is much easier to
follow than adding all those breaks and wading through ifdeffery
to realize that this is the default path and we'll end up calling
paravirt_patch_default() in the end.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
