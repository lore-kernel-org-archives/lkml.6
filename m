Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB679C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A5213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakoman-com.20150623.gappssmtp.com header.i=@sakoman-com.20150623.gappssmtp.com header.b="cr0j0hhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4A5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakoman.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeJEBIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:08:16 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39036 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeJEBIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:08:16 -0400
Received: by mail-vk1-f195.google.com with SMTP id x140-v6so2379861vkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4tsz/pdgePORnzoV713QKAEDB9TM8hpER2BjVKddx4=;
        b=cr0j0hhY9g4ZdhSJEHyb5P4UJYCH9CLWKPxLOguyK06ivUKZr65LR2NpMuDm0Upbzy
         Ah8M+pKCmB5Z/RD/bOMPpSzgtAX9Zn97gMPtKJb4nmNNmAy1fUEjA4zwq/vINpEIKnJN
         Cyp3qcSB++D0uZPhuo8Z2jnU54zF+VFXItiU4OimVAjwBQR1fs9p95eP2sosmUKtzA7Z
         qFXx8cT8U1W5vxBH4rALOxO1gr0Gi/fXGIS7iHKXrsTRkCOIUu2wl8vuFyLrMaqE7eF4
         a/gG9Dd9RBOYgCTBvjhM1kXUMayzlBdsw9+wgTs58sUXLwiO6pQ+4U/3PVyhCWkKj1m0
         VLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4tsz/pdgePORnzoV713QKAEDB9TM8hpER2BjVKddx4=;
        b=oer1u02lIxips8t2SqvqbipQVm0CFYHMNp7A3QtZbQ/zuHbPdo8zI0sFPiSiexEHE6
         dpVaFE6knYNBJcrlfdjBuWMcL80dczxRAzVYSxXIZYG3KStNV7+jooUPRVVEvaHTupCG
         WuLqaElCvX8Tuq3gWgUhh6YJDqfQ2BeeMKGIaORZJEKCT9Ms+zMeB3uNIRymviL6UDTS
         DdFsj2ALKQwzrblLZModlSQCFwLIZ7RSY8u+go0w4qEs0wz0ZU/a4uoI3SWuw92mKi5c
         DyjMO+QHJ44CrAwT9sv/1HYr8rZv4A1KLW0+OuKm3e4kd2PHiaMk3YjDzoABNECIw+vI
         dL5Q==
X-Gm-Message-State: ABuFfoh3BB87mS411VfOxzpENEqWRph5C5D1hqTzBnA5qQuhp9MCl7Wr
        8wo89f0aUy9g50xYzZQ8gZ82UvEuHzg7FDXwpFUSLQ==
X-Google-Smtp-Source: ACcGV63cGx1/TBHLcdoumHlgG4E95LYY0CEVBn2LN8RVdscrlveXUs/zmdkiEHSnz2HRk3ssvZBhkkPifcO2SKxAhKg=
X-Received: by 2002:a1f:b3d2:: with SMTP id c201-v6mr3045968vkf.86.1538676830202;
 Thu, 04 Oct 2018 11:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181004151501.280d8282@canb.auug.org.au> <CAOSpxdYzm6fTd88gP_OdrTuqbf-kJr3t+3ObPU9vMCHqYJSgHg@mail.gmail.com>
 <20181004170032.GA7344@kroah.com>
In-Reply-To: <20181004170032.GA7344@kroah.com>
From:   Steve Sakoman <steve@sakoman.com>
Date:   Thu, 4 Oct 2018 08:13:39 -1000
Message-ID: <CAOSpxda1RjgBDN5mKwj8SQ5iVx-SYRMtD32-7_AO5kEwK0-acg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        Eric C Gallimore <egallimore@ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I sent the patch you requested to fix use of the "unused" struct
member in samsung.c. If that looks OK to you I'll redo my
"serial:serial_core: Allow use of CTS for PPS line discipline" patch.

Thanks,

Steve
On Thu, Oct 4, 2018 at 7:00 AM Greg Kroah-Hartman <greg@kroah.com> wrote:
>
> On Thu, Oct 04, 2018 at 06:34:31AM -1000, Steve Sakoman wrote:
> > Interesting indeed. Who would have thought someone would be using the
> > "unused" padding variable!
>
> Ugh :(
>
> > How would folks prefer we fix this, in the referenced patch or by
> > eliminating the use of "unused" in samsung.c?
>
> We should just get rid of the "unused" fields entirely.  They aren't
> needed here as this is not a structure that anyone really cares about.
> We can move things around a bit if the padding is an issue.
>
> I've reverted this patch first for now.  I suggest a patch to the uart
> core to drop the unused fields and fix up the samsung driver and then
> your patch can go on top of that.  Can you work on this?
>
> thanks,
>
> greg k-h
