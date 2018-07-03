Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1ECC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1BA21468
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHpCM5WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1BA21468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeGCGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:48:14 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53550 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCGsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:48:12 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so1633414itd.3;
        Mon, 02 Jul 2018 23:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3LH9VkHuhUwidbK89hjIg6mtEerfhd3tGlXSQ5z5jw=;
        b=IHpCM5WWuIdDL2MV6CHThuT3fZ3xIWg0nFT/T46USMLuVwRwg6T+dF3h2HyTZH5g0j
         ilABfZKd/JSA+vAHeHJeSIg63yolfot5vkUp+6DEquS0R6zvBPuHIy7fk4twkhly4Rt6
         v/ghD8sAaXvduIZNzlr6enjKOcRZ5thldSxczcJ9ywmE21X7U4MOyFPkqMhfTmfxDXlW
         WK83ugzK/ju5T+OTSfBD1uWngabJM9EEyepLh8eqNNsSBbqI/caNa+wGZfYRKkKoYdH4
         dgUYfJCrnxwx6oTeX5k17L1ydLOCFJxPGY9gTUCvBj0dnVWdPsHufiEQKotCr62JsIUV
         hDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3LH9VkHuhUwidbK89hjIg6mtEerfhd3tGlXSQ5z5jw=;
        b=AREZDvTU3sKOLzFfYD/UT5Q1UioBkreppcc2ey6EKPKsQLdR42y6x/f11K4Dkiaeqr
         +Q6kOPP70A3eKkJYg95EibjRz5OLWIp5XYn1wiZ7rSQo0vchMTk72XDT6Xk41q203lpo
         TrcKYFtJMcoZrQi+jI6JQbjOo03LCD0PjpStU4um4VjJ/KhH68pm6QqzZDwKh5/jOwlg
         shEFTfChJli/MttgSc1pionHgbg/bwIcpi0wWa301EyETB21iojNn1V00t4QMyYhNiD/
         OlGrAoHTWOIP76xFhbG33V8/AB4DhRif+Yorto3zKMAwNO+7K3vWeFu1v67puDCJvfo8
         epzg==
X-Gm-Message-State: APt69E1sgk3lYHzd0pGJiWAAUzJOifnZFCQXp+OnKMABTFr6BOrjJTbU
        Bjvyl0/ofBtTdrhn/0NQmjNhx5BGHCgj+OJbeP8/
X-Google-Smtp-Source: AAOMgpfohkSjc5lD9I1kJjdqnOCHhCXXo05ZWWffZbd2ZhhUYDRX2aaTadyXA4eKWWykH9TpriA1XKdjxm6yODfPSgQ=
X-Received: by 2002:a02:b687:: with SMTP id i7-v6mr6021747jam.55.1530600492175;
 Mon, 02 Jul 2018 23:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
 <1529912859-10475-3-git-send-email-kernelfans@gmail.com> <20180625104505.GA3058@kroah.com>
 <CAFgQCTt6MTwXbbcQCcJroM3wGdx+5c7A+eVy+dXJscu1JtfA-w@mail.gmail.com> <20180626115402.GB30256@kroah.com>
In-Reply-To: <20180626115402.GB30256@kroah.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 3 Jul 2018 14:48:00 +0800
Message-ID: <CAFgQCTuztrZbFJF3_NgZrq2r0ngSmcnkXMB=CgvMNgzQkwe+4w@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] drivers/base: reorder consumer and its children
 behind suppliers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 26, 2018 at 11:29:48AM +0800, Pingfan Liu wrote:
> > On Mon, Jun 25, 2018 at 6:45 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jun 25, 2018 at 03:47:39PM +0800, Pingfan Liu wrote:
> > > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > > introduces supplier<-consumer order in devices_kset. The commit tries
> > > > to cleverly maintain both parent<-child and supplier<-consumer order by
> > > > reordering a device when probing. This method makes things simple and
> > > > clean, but unfortunately, breaks parent<-child order in some case,
> > > > which is described in next patch in this series.
> > >
> > > There is no "next patch in this series" :(
> > >
> > Oh, re-arrange the patches, and forget the comment in log
> >
> > > > Here this patch tries to resolve supplier<-consumer by only reordering a
> > > > device when it has suppliers, and takes care of the following scenario:
> > > >     [consumer, children] [ ... potential ... ] supplier
> > > >                          ^                   ^
> > > > After moving the consumer and its children after the supplier, the
> > > > potentail section may contain consumers whose supplier is inside
> > > > children, and this poses the requirement to dry out all consumpers in
> > > > the section recursively.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > ---
> > > > note: there is lock issue in this patch, should be fixed in next version
> > >
> > > Please send patches that you know are correct, why would I want to
> > > review this if you know it is not correct?
> > >
> > > And if the original commit is causing problems for you, why not just
> > > revert that instead of adding this much-increased complexity?
> > >
> > Revert the original commit, then it will expose the error  order
> > "consumer <- supplier" again.
> > This patch tries to resolve the error and fix the following scenario:
> > step0:  before the consumer device's probing,  (note child_a is a
> > supplier of consumer_a, etc)
> > [ consumer-X,  child_a, ...., child_z]     [.... consumer_a, ...,
> > consumer_z, ....]    supplier-X
> >                                                              ^^^
> > affected range during moving^^^
> > step1: When probing, moving consumer-X after supplier-X
> > [ child_a, ...., child_z]     [.... consumer_a, ...,     consumer_z,
> > ....]   supplier-X, consumer-X
> > But it breaks "parent <-child" seq now, and should be fixed like:
> > step2:
> > [.... consumer_a, ...,     consumer_z, ....]  supplier-X  [
> > consumer-X,  child_a, ...., child_z]    <---
> > descendants_reorder_after_pos() does it.
> > Again, the seq "consumer_a <- child_a" breaks the "supplier<-consumer"
> >  order, should be fixed like:
> > step3:
> > [....  consumer_z, .....]  supplier-X  [ consumer-X,  child_a,
> > consumer_a ...., child_z]   <--- __device_reorder_consumer() does it.
> > ^^ affected range^^
> > The moving of consumer_a brings us to face the same scenario of step1,
> > hence we need an external recursion.
>
> Something really got messed up here, and this all does not make any
> sense :(
>
> Can you try again?
>
> Also, please cc: Rafael on all of this, as he wrote all of this
> consumer/supplier logic and I am not that familiar with it at all.
>
Cc Rafael J. Wysocki for the context.  I will send out V3 soon.

Regards,
Pingfan
