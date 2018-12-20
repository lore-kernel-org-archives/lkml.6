Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13264217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="m5143/SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeLTPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:47:42 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38949 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbeLTPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:47:41 -0500
Received: by mail-ua1-f67.google.com with SMTP id c12so706836uas.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1iA1jRzfR/5BsDl8bsUXPOoejutwLp6/VkwDfp3MFk=;
        b=m5143/SPAjB1y3AcnHCAM6fa/RY4fAxaanB17U8f9LsmaJEahdHyh1l7OtggaEOvEO
         NkmwHuLSTU3HbJykVVWL5DeUr/6ud/6KZ+jH+6wTBPuM05uHXXH0M96TovIlitKPj78F
         7dL+EN14TXVG/MITBdtcaFCvMPv0Pl6GydqpuGvn7UUwdHUP5HIJEodIk8d0+raGiE1N
         Lz/UXt9+id/msLsulMtHWh9sBSxYCF3mT4/uskiOpkqQuxnIPEchqgh4B4eK8wgF8rC4
         DbZjl/z4ZNAHDo3cEexmsPhBN+WWPyJNfrYzenMYilEjRYk6ev5/5B21GFfXNCP6rIV/
         kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1iA1jRzfR/5BsDl8bsUXPOoejutwLp6/VkwDfp3MFk=;
        b=NdT6RRYbIPMEbcD6ymPvjHvwLMMWz9svRklaNYXTPkxh9G527WZWIZql2WKUyasUAh
         RlWBuHoOMomfSyovWee7fcCRc4daJgE+yhl/+TVFE5oTEnlfYZof8+sXhpl1cTcTEuqA
         9fkh5Yep8weQ3Y78hvCzeh4JWg3VWSxp+x5XtOXsKdDmRKlgxmPGC18XvDIwNCN5I9z+
         Nl5ZeJN1ycATDEBFLgp+qBHp5I0BEZ71o00ozAmhg5oAaCjDXfirVcuzrWEhxXrATwQf
         MazbWBGnfDFN5jDBzcsaLFhKEqspNzzgcZuJnyjC5XK9xIF6n50F8Vj5hECDkyFFvsgh
         sA1Q==
X-Gm-Message-State: AA+aEWabupQA1H9J9JcJto1DSxbOV0wMjHu2EhjY+7BrpStn7Ji2myZe
        78pzErwbYw+PP2ac8Hh523ZOuqYw3zr66O9iDC/pZfQjn+c=
X-Google-Smtp-Source: AFSGD/VEe3F5bdRt3845mDYIIh9gmkShSDOWdUy6onxOvsfsY37SCEDBRz3v6aAu68yeyUa6WApO1CLwsDFUG9OL678=
X-Received: by 2002:ab0:668c:: with SMTP id a12mr2355265uan.121.1545320860068;
 Thu, 20 Dec 2018 07:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20181204182734.20184-1-murphyt7@tcd.ie> <20181205160439.bjbh7stdey32hjgj@8bytes.org>
In-Reply-To: <20181205160439.bjbh7stdey32hjgj@8bytes.org>
From:   Tom Murphy <murphyt7@tcd.ie>
Date:   Thu, 20 Dec 2018 15:47:28 +0000
Message-ID: <CALQxJutDpN6SagB89=cPvNczmD8kRXwaq-yzor7kULU4iLt2uA@mail.gmail.com>
Subject: Re: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and
 tlb_sync to iotlb_sync
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah shoot, it looks like I forgot to change flush_tlb_all -> flush_iotlb_all

Should I submit another patch?

On Wed, 5 Dec 2018 at 16:04, Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Dec 04, 2018 at 06:27:34PM +0000, Tom Murphy wrote:
> > From: tom <murphyt7@tcd.ie>
> >
> > Someone forgot to update this comment.
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> > ---
> >  include/linux/iommu.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Applied, thanks.
