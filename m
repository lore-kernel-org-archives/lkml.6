Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6548521547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nHr0K/u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6548521547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbeIUH3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:29:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40497 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbeIUH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:29:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id h4-v6so306038qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eps11l9GksCmk4RCNmoRr9bwqHSTGWvkVGBJfrcrGCE=;
        b=nHr0K/u1cgzardCo6+488bwby6XI8srQqEOY5IMtoc0iF1xaELpB+83rnX48d39E70
         DClFmf/1Rx4xL0pZh23gIgIw/7I+I/WoMgExcgJIgMd1aSYdamEa4LLEoNuUbmPeTQXx
         TPakijsiMTFcIpcNvyjm7X8y2Ly8glBfRrYpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eps11l9GksCmk4RCNmoRr9bwqHSTGWvkVGBJfrcrGCE=;
        b=S7WVsIQ8dRWXarGVGFnT80xm3HY//xi/7C1v/N/o6Pnes7zD7YCrluhaLmvjHz9B1E
         D8Li83Gvv9sJteOELrKsSWsyc43iwcnGaDIDdNIw4YCyL+32hzR+UCzDogEP3W3z1zSM
         aGXRtY4AGQqHLfQjCV1ya3SnjwRdbAF9CAlgPvNsA1FsDUx0GcxAua5XoQA/ftqATFlN
         IGX+VleKXtArnPUryAb5ipscpYDLWsHr/lLgab5IuJ0NJXJl8aYOWcYsPHGxI0FmheTk
         yWWTo3clB+TgL8TErBJAP/SSuIBFmBWbKIzrxc1ecrnrwjjqMO6PSffrIa0xwfyTFrRS
         RX3w==
X-Gm-Message-State: APzg51DUaynMPM6HlmZ8rIgxLev3SSP3K4NQ3krUvox4YJiV1iKTafnz
        mfge1aNmELNHvpuzp++ptYDFIo9+N1fp6bRIRB4=
X-Google-Smtp-Source: ANB0VdZ5nGfufN5f0to9nMbbq/U6/CYInTy31GRMNadohcO4Fl2Dy744hfPblkkoKM2VN6tgaHyvU5FYS9yEEX4lwVQ=
X-Received: by 2002:ad4:4089:: with SMTP id l9-v6mr30413156qvp.160.1537494156664;
 Thu, 20 Sep 2018 18:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180916215735.31393-1-richard@nod.at> <CACPK8Xd_fNNEYbtY6HEnB6kOnqTWBC5stPVUbc2gMHpne4J6jQ@mail.gmail.com>
 <2090091.R1QOzN4fXt@blindfold>
In-Reply-To: <2090091.R1QOzN4fXt@blindfold>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 Sep 2018 11:12:25 +0930
Message-ID: <CACPK8XfnV=MOLqLL3UK7FP+oRCt1NLLgB-OdNEGWXwyFWVu_+g@mail.gmail.com>
Subject: Re: [PATCH] Revert "ubifs: xattr: Don't operate on deleted inodes"
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        koen.vandeputte@ncentric.com, Eddie James <eajames.ibm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 at 16:40, Richard Weinberger <richard@nod.at> wrote:
>
> Am Donnerstag, 20. September 2018, 04:30:41 CEST schrieb Joel Stanley:
> > On Mon, 17 Sep 2018 at 07:30, Richard Weinberger <richard@nod.at> wrote:
> > >
> > > This reverts commit 11a6fc3dc743e22fb50f2196ec55bee5140d3c52.
> > > UBIFS wants to assert that xattr operations are only issued on files
> > > with positive link count. The said patch made this operations return
> > > -ENOENT for unlinked files such that the asserts will no longer trigger.
> > > This was wrong since xattr operations are perfectly fine on unlinked
> > > files.
> > > Instead the assertions need to be fixed/removed.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 11a6fc3dc743 ("ubifs: xattr: Don't operate on deleted inodes")
> > > Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> >
> > The bad commit 11a6fc3dc743 was included in 4.18.7, and broke our
> > systems which use overlayfs on top of ubifs.
> >
> > This patch didn't apply cleanly for me to 4.18.8 (an encoding issue?),
> > but I did a revert of the offending commit which did the trick.
> >
> > Tested-by: Joel Stanley <joel@jms.id.au>
>
> Thanks a lot for testing and sorry for the breakage. :-(

No worries. How do you plan to get this fix in? It would be good to
get it in master asap, so we can get it backported in the next wave of
stable releases.

Cheers,

Joel
