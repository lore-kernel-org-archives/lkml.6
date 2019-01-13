Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C4C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D2C20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547363505;
	bh=kcv80t6lrz56pPHmWGwhIi9r3JxCpNYHUEUiRZvjeig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMzW7A2J62sRRWKp44pLSJz+7HDVGriCW1a7Mzi1n+FIlmmbBo7+6e639THi9jhEe
	 fROzs9gcxnHTPK3Z2Kg0Ce8R9MPeDJrEIQmsyYicIn0zS0Xo+wxcrG7DxowihCp8+k
	 bBuE4KESAjrPdd1pWddntODMIm+Q+w25O+geTNdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfAMHLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 02:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfAMHLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 02:11:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D76520873;
        Sun, 13 Jan 2019 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547363504;
        bh=kcv80t6lrz56pPHmWGwhIi9r3JxCpNYHUEUiRZvjeig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sM+otAn6fpYas3IWn31+uJ3JidsjtwE+ddFSvm+wkR4Lq3jJKisoKsCq2gXjQRq+I
         AeCxz9XN1/FrN3RxpQtWmNhJ+wP79c5q6u8zXH+9a9YsPx4RY81qmNW9XfR8Fxu/jT
         QlRTuJqqVu26UuxGPOD7taE+7OcuB76TeJxnuc7A=
Date:   Sun, 13 Jan 2019 08:11:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4.20 41/65] Revert "powerpc/tm: Unset MSR[TS] if not
 recheckpointing"
Message-ID: <20190113071140.GD5540@kroah.com>
References: <20190111131055.331350141@linuxfoundation.org>
 <20190111131102.136630542@linuxfoundation.org>
 <1547328527@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547328527@msgid.manchmal.in-ulm.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 10:35:59PM +0100, Christoph Biedl wrote:
> Greg Kroah-Hartman wrote...
> 
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > This reverts commit d412deb85a4aada382352a8202beb7af8921cd53 which is
> > commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
> >
> > It breaks the powerpc build, so drop it from the tree until a fix goes
> > upstream.
> 
> Is this necessary on 4.20? The build failures I reported were on 4.19
> only. The 4.20.2-rc1 kernel for my Powermac G5 builds with and without
> that patch, both boot fine, no visible differences. Again however, Breno
> is authoritative here.

If there's no difference on 4.20, then maybe it's not needed there?  :)

And yes, I would like confirmation from Breno as well.

thanks,

greg k-h
