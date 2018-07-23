Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC417ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C420852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="U/CDSBDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6C420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeGWXBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:01:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34289 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeGWXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:01:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so2275263eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bi3SF2M0tR16/g7+nrSn5FOWPYu9UciVUneTKogq3FQ=;
        b=U/CDSBDPmDHaNrqj9tinAWqlCoshn6UGv91KulDt8f8KMDx4sNEemMc8hGxLNTBQYd
         TFe2dzABj2BZ/rYYsQQLboRCQnhL7C6i58JT08zWs0NKG1Esx+l4ZcduaI15DA3tqDGE
         wTAqTIt8wFTl1WSkGuYHWq3CiAmtiQ/6wADrCdyag6FmQcKBMmEN3bek2xxg3ZjhxeSt
         d8zRHZHkScJDV4rjOH500nuxLLanBP8Wz6ewg4w9XeQWfxsRF3Jpd+UCTjHhTxZkTmog
         hg+uh11ny2Q62jXZtiCTaHx2TWwow1N2lR7opiFIAaWzQ7NWJKp9O3cISHP/v5C3AyDM
         ag0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bi3SF2M0tR16/g7+nrSn5FOWPYu9UciVUneTKogq3FQ=;
        b=G2U2KfgqgMeEz4c3nzgIDooG/e/hK5omD/fQJvXT6UmyrhBjwtnKIGLM/K6/QSILNV
         wcYOTRziBB1yVSqrbjX3Y4GvJlZoftqY4RH3iFFuPTQPh6VTSX3DSfq1d0z4UZIrf5j/
         lCl2MkiDQN8KV+vd4NCkwpqFdo6Brz+X6iRjfixUOxO178nJooy1J7pXSL6zkTfAW0DB
         Z7BdbItfQZPl4VZ7JjQKCE0Y67ohhJTzUamMkOMJHcP2Fa1v47agvVYitaICUUThQNSR
         isRg/R+PVmirQd6PSqft/veAv/qJKMjRsi2QC1OqXccd4jx0OqN3FUgKdytb5tLy9eFL
         p2tA==
X-Gm-Message-State: AOUpUlE5OCX4LsdotPhKRJbRJoS94LJEpPoAWJXeSfKYHLLyisMzvNal
        zqMS/RqlQLiBx9veQjC3kg9kJA==
X-Google-Smtp-Source: AAOMgpe2gq16fqcTqi0FwW6/egqCaSv9x/dxmfXpQpJKeTFXtBG873fiYa9WFKuo3CYLWTnQU+OG9A==
X-Received: by 2002:aa7:d717:: with SMTP id t23-v6mr16050557edq.102.1532383097857;
        Mon, 23 Jul 2018 14:58:17 -0700 (PDT)
Received: from ZeroCool ([109.255.141.80])
        by smtp.gmail.com with ESMTPSA id p3-v6sm7400362edp.47.2018.07.23.14.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:58:16 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:58:15 +0100
From:   Mark Railton <mark@markrailton.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
Message-ID: <20180723215815.GA23316@ZeroCool>
References: <20180723213404.20720-1-mark@markrailton.com>
 <e0b30ab8-d418-cbe0-d03c-a0aee1d48367@infradead.org>
 <20180723214011.GA21167@ZeroCool>
 <01b221f3-d923-1abb-0168-bfeba80b9a9a@infradead.org>
 <20180723214804.GA21761@ZeroCool>
 <e8cab255-eb21-fd08-e62b-3afbbe853b84@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8cab255-eb21-fd08-e62b-3afbbe853b84@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:55:12PM -0700, Randy Dunlap wrote:
> On 07/23/2018 02:48 PM, Mark Railton wrote:
> > On Mon, Jul 23, 2018 at 02:44:28PM -0700, Randy Dunlap wrote:
> >> On 07/23/2018 02:40 PM, Mark Railton wrote:
> >>> On Mon, Jul 23, 2018 at 02:38:20PM -0700, Randy Dunlap wrote:
> >>>> On 07/23/2018 02:34 PM, Mark Railton wrote:
> >>>>> Fixed issue with multi line comment
> >>>>
> >>>> Fix [not Fixed]
> >>>>
> >>>>>
> >>>>> Signed-off-by: Mark Railton <mark@markrailton.com>
> >>>>> ---
> >>>>>  drivers/xen/xlate_mmu.c | 5 +++--
> >>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> >>>>> index 23f1387b3ef7..3b03bc1641ed 100644
> >>>>> --- a/drivers/xen/xlate_mmu.c
> >>>>> +++ b/drivers/xen/xlate_mmu.c
> >>>>> @@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
> >>>>>  	struct remap_data data;
> >>>>>  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
> >>>>>  
> >>>>> -	/* Kept here for the purpose of making sure code doesn't break
> >>>>> -	   x86 PVOPS */
> >>>>> +	/* Kept here for the purpose of making sure code doesn't
> >>>>> +	 * break x86 PVOPS
> >>>>> +	 */
> >>>>
> >>>> That is still not the preferred kernel multi-line comment style.
> >>>> Documentation/process/coding-style.rst says:
> >>>>
> >>>> 	/*
> >>>> 	 * This is the preferred style for multi-line
> >>>> 	 * comments in the Linux kernel source code.
> >>>> 	 * Please use it consistently.
> >>>> 	 *
> >>>> 	 * Description:  A column of asterisks on the left side,
> >>>> 	 * with beginning and ending almost-blank lines.
> >>>> 	 */
> >>>>
> >>>> although Networking code has a slightly different preferred style (as in
> >>>> your patch).
> >>>>
> >>>>>  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
> >>>>>  
> >>>>>  	data.fgfn = gfn;
> >>>>>
> >>>>
> >>>>
> >>>> -- 
> >>>> ~Randy
> >>>
> >>> Thank's for the feedback, I'll get that updated now.
> >>>
> >>> I'm still kinda new to this, I assume I need to send the new patch via
> >>> git send-email?
> >>
> >> That is one option.  Use whatever works for you.
> >>
> >> There are several email clients that also work well.
> >> See Documentation/process/email-clients.rst.
> >>
> >>
> >> -- 
> >> ~Randy
> > 
> > From 57c8104d2a30020005be16df2ca69ed66f6c4ae9 Mon Sep 17 00:00:00 2001
> > From: Mark Railton <mark@markrailton.com>
> > Date: Mon, 23 Jul 2018 22:28:53 +0100
> > Subject: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
> > 
> > Fixed issue with multi line comment
> > 
> > Signed-off-by: Mark Railton <mark@markrailton.com>
> > ---
> >  drivers/xen/xlate_mmu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> > index 23f1387b3ef7..2b77c79f8ce7 100644
> > --- a/drivers/xen/xlate_mmu.c
> > +++ b/drivers/xen/xlate_mmu.c
> > @@ -151,8 +151,10 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
> >  	struct remap_data data;
> >  	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
> > 
> > -	/* Kept here for the purpose of making sure code doesn't break
> > -	   x86 PVOPS */
> > +	/*
> > +	 * Kept here for the purpose of making sure code doesn't
> > +	 * break x86 PVOPS
> > +	 */
> >  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
> > 
> >  	data.fgfn = gfn;
> > --
> > 2.17.1
> 
> 
> Hi,
> 
> a.  The subject and the patch description should be in present tense, i.e.,
> Fix instead of Fixed.
> 
> b.  Ideally you start a new email thread for new versions of a patch (but Cc:
> the interested parties).
> 
> For the patch itself:
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
> -- 
> ~Randy

Thank you for the feedback, I will make sure to take that on board.

Mark
