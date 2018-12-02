Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C05C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DB2208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5qmGPpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DB2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLBPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:05:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46768 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeLBPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:05:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so8704278oif.13;
        Sun, 02 Dec 2018 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jy//Qqh5r3gLsFZoCXkRf8ZR7FcSi7TRvRvv7HQfTVQ=;
        b=c5qmGPpoH8VTz4LVVwXpVpygip5FRODjbKRes/BxNv0O+5z7ulE21+5ULKEq/SK+QY
         Zb1DgJDgq1BenIjhE85oYqOc3/vfxxQ0udmWFEmFe6b88eYR1OJw33caodAYgqus42O5
         sgrbBJHVr96yAHvyZ2yPRInfPHSvd2BRSX0JC98i2u7GrfoEoz/PYeMo+tWLPY02B52T
         DkkxGX54qSivSKh1ba5weggUYDawAVbMB8irfBPdGjJmaf/AlH6J9BAgL+YE55dYPL5a
         CIxDGZsxkvrRfWK1457bD6MI1SqpkUBzPVZH96qkisHYVKFl0ME/obxUbVLGhcIV9UXr
         xeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jy//Qqh5r3gLsFZoCXkRf8ZR7FcSi7TRvRvv7HQfTVQ=;
        b=b/3HQ9AzL+AhvuEYhlTd23SWXrjwg6KyMNx6VZ1Q6bPqpoq8mQ3QmnnZWYI6s/7utf
         A5CPh1hOnM8IG1V/Lr6IeNp8DdKQhTrX+HabBJhnEZmNGuifp8SG4uDHZcy59Nxz4RmC
         D9ItrPq/7TOx+V7Z97DXMj8bx1mFQDH2QFsb1aPADiY3YRP5kxSH7uaKB/EeN4UK22xa
         EFkzGbVVOUiHbUihnEDQtnIUWf+EPqbkrpzCrt0NpUxxzIhDdlI6ohuK6LB51oWP5pb4
         mOvsM6UpyenjYmPq3YVPp3PFNE7ezXPeNNpjL4G1LnnlaZNIx3+ZYHJIXyaqVXI03V+7
         ZeNw==
X-Gm-Message-State: AA+aEWZy+uxUWbjuqzyfndLka1psqTggIlxnUZrQAhV/DWUkg1x+3/9c
        FIyBNuoI2r3jkM8rWNbI5BAsFrZXUysJhprLkhI=
X-Google-Smtp-Source: AFSGD/V9jZt9LBlsBwrQo31lariA6QSolUgLfBct3CyHv/ebnbbrgQTCVxiV0A2pvFhNQM3P0rlb9Jk+21rMtrRvuWY=
X-Received: by 2002:aca:7546:: with SMTP id q67mr8137432oic.300.1543763119210;
 Sun, 02 Dec 2018 07:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
 <20181129080923.GE13859@kroah.com> <1676802.TThbbZSlzy@blindfold>
 <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com> <20181202143543.GE221015@sasha-vm>
In-Reply-To: <20181202143543.GE221015@sasha-vm>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 2 Dec 2018 15:04:43 +0000
Message-ID: <CADVatmOFi_S8q=Q3qvnyJ-A--NW=bZ-NgrK_fbbsmb=fJgOhbg@mail.gmail.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
To:     sashal@kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martin.kepplinger@ginzinger.com, Stable <stable@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen <juergen.lachmann@harman.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 2:35 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Sun, Dec 02, 2018 at 11:50:33AM +0000, Sudip Mukherjee wrote:
> >Hi Greg,
> >
> >On Sun, Dec 2, 2018 at 8:51 AM Richard Weinberger <richard@nod.at> wrote:
> >>
> >> Greg,
> >>
> >> Am Donnerstag, 29. November 2018, 09:09:23 CET schrieb Greg KH:
> >> > On Mon, Nov 26, 2018 at 11:38:42AM +0100, Martin Kepplinger wrote:
> >> > > From: Richard Weinberger <richard@nod.at>
> >> > >
> >> > > [ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]
> >> > >
> ><snip>
> >> >
> >> > Now queued up for 4.14.y, thanks.
> >>
> >> can you *please* slow a little down?
> >
> >True. It will really help if you can have some sort of fixed schedule
> >for stable release, like maybe stablerc is ready on Thursday or Friday
> >and release the stable on Monday. Having a weekend in stablerc will be
> >helpful for people like me who only get the time in weekends for
> >upstream or stable kernel.
>
> Any sort of schedule will never work for everyone (for example, if it's
> part of your paid job - you don't necessarily want to review stuff over
> the weekend).

Yes, exactly. But like I said if the stablerc tree is pushed on
Thursday, and the stable release is released on Monday then both types
of people will get time, and hopefully everyone is happy. :)


-- 
Regards
Sudip
