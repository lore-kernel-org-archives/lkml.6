Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E88C223C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HLL8T4vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E88C223C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeFZVeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:34:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeFZVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ej8jc6giKxYXMysRblkTvftP2k9huG1UoYwTt7xug2c=; b=HLL8T4vOBSxD0U10ecp11LdCe
        KxJK6u9Y+wF1Aiqs0RZjXR8HEyGkKQkcM2eJNDPoDKKNoZ+JijgNW82U/h/eZBpXHcgzBVdlJWKPp
        IGzRtwH4a25binZ7AxRNWAkbNv8mQ/P8vrMx803dgqlBCSsiVL/A8MlX4iyEkq9fJeUjScQYDPBTo
        tAyW68g87HS8j1MVdABZWC5KYcTX+kdLsUmk1KmFsp40WqL2u32MvI9GlJTDvzNTRKZoabDRtqsdh
        BA9lBbCJ+q7enXZ4sbcFLU1dwRV5kR0rX98sM3RuVXo9Zs46ehJIFA+YkzKubcqdWd3i+DdWne4PK
        PsGbBbSEQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXvb7-0004b7-Nc; Tue, 26 Jun 2018 21:34:01 +0000
Date:   Tue, 26 Jun 2018 14:33:58 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-smbios: make a function and a pointer
 static
Message-ID: <20180626213358.GA4945@fury>
References: <20180621181524.30550-1-colin.king@canonical.com>
 <20180623002237.GG27466@fury>
 <CAHp75VfWcosNzM03zsGnQrL6yRh0=uidV+SU-06hyYtwdJo3EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfWcosNzM03zsGnQrL6yRh0=uidV+SU-06hyYtwdJo3EQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:32:17PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 23, 2018 at 3:22 AM, Darren Hart <dvhart@infradead.org> wrote:
> > On Thu, Jun 21, 2018 at 07:15:24PM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The function dell_smbios_smm_call and pointer platform_device are
> >> local to the source and do not need to be in global scope, so make
> >> them static.
> >>
> >> Cleans up sparse warnings:
> >> warning: symbol 'platform_device' was not declared. Should it be static?
> >> warning: symbol 'dell_smbios_smm_call' was not declared. Should it be
> >> static?
> 
> 
> >> -int dell_smbios_smm_call(struct calling_interface_buffer *input)
> >> +static int dell_smbios_smm_call(struct calling_interface_buffer *input)
> >
> > Hrm. So these are passed by pointer to dell_smbios_register_device(), which is in
> > turn called by dell_smbios_call() from dell-smbios-base.c.
> >
> > So while it is valid to make these static, since we're not referencing the
> > symbol, but the pointer value instead - I do worry about the "static" suggesting
> > to someone reading the code that this data is not used outside of this file,
> > when it is.
> >
> > I'm not finding a position on this in coding-style.
> >
> > Andy, do you care to weigh in on this?
> 
> We are using static keyword by almost all callback defined functions,
> so, for my point of view it's pretty much okay.

OK, just wanted to double check.

-- 
Darren Hart
VMware Open Source Technology Center
