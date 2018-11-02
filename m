Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12257C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC372082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjHZKarO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC372082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeKCDoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:44:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42990 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKCDoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:44:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id u68so4555774qkg.9;
        Fri, 02 Nov 2018 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgrMZMnMhkTmX8kBi0dluZyfAUqY1+1+zhtrVHFwQc8=;
        b=bjHZKarOkXKo8k54U35RkRBvI9XkU6q4EqKCWwU8lBL890xEV2C7GX4cDy8m9LQ6k2
         j9gKLxQq/gI8iJroUYGi8Ye7cD3LLYchwgB9EP3zJ0OCYBMumu0k4ETZ6g92HVcVr7V1
         IfV3Y94xdvyFgc6jIn/R5gJgWFhVvd17+yEy64rRpFsdKHIgCAjVmIjSHGLvTtLIrU9Q
         ofZnUMbdIqvMfFPmAjA8hb7Z3a8Oozq0gNxwxlu6IAHa8CZOa6DBjYVoD3yJCpZ/0vv+
         x/X6jsqIK7Y0BXBZO+n6VW3UT8z2QrJO2RbvyK633qhYQsZwsN2mkNSlBr9oTugEbMHx
         h+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgrMZMnMhkTmX8kBi0dluZyfAUqY1+1+zhtrVHFwQc8=;
        b=qrOBFoLIFjBKMQ0os1CPlHcmygifpL0Y2gfRnl9N+qzEvtkBfk5+3cyNaLiDCJJc2t
         mIqiwLLUHZ72j1/jHs9R6O7q9xBuiQUUfJird4ZjnwJsLEtInOEbP0O99D03cH9MIJbD
         0xa29oKTzr1arVcB1yEtbOvGoKOb/Rl76/Fl/5CWdtliWZMianGeAUs/0XPfFkqv/v/9
         fdhyXU/VpiemVjGIshCap42I4Nf+RVyCOgaTAUDcOU+nbChbEXDLhlbJxGIGqn+3e11L
         uN4S3TT9D4B2jG2ushyG13upkt99b8vIRKGWAsaXlg0PygEY7TJ6wxm1YYjcLKcaVsdb
         LoQA==
X-Gm-Message-State: AGRZ1gIn6UJrL8v9l1JEAysfzROVTBw+8JkrZT6LydUjTzBwfsfdm/9Q
        87NlyCEb52Ku7HzyZOXLvoGLsP3IA4wpQuApz5tWmcrO
X-Google-Smtp-Source: AJdET5f3RQU3ZE5i/S35kgw1pa3HINJpE8mKhzjiUAPOs9yyPCXbwCGvgEtHUgCxONexvb6GArVS/QSF7wJocmyLUiA=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11256291qkf.33.1541183749209;
 Fri, 02 Nov 2018 11:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <5bdc96b6a91b2_2e7982af9fe8650b0ba@bhelgaas-glaptop.notmuch>
In-Reply-To: <5bdc96b6a91b2_2e7982af9fe8650b0ba@bhelgaas-glaptop.notmuch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:35:38 +0200
Message-ID: <CAHp75VcrMhBZd7LajwbFD=YA3jA=7a1SQKRHmocG600=fr9YOw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] mpt3sas: some bug fixes patches
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Suganath Prabu wrote:
> > V7 Change Set:
> > Split some patches into multiple small patches
> > as suggested by Bjorn Helgaas
> >
> > v6 Change Set:
> > Incorporated changes as suggested by Andy.
> > In Patch 1 converted while loop to do while in
> > function mpt3sas_wait_for_ioc_to_operational().
> > And in patch 3 removed parentheses.
> >
> > V5 Change Set:
> > V5 post has only defect fixes.
> > We are reworking and incorporating the suggestions from Bjorn.
> > And after covering tests, we ll be post Hot-Plug Surprise
> >  removal patches.
> >
> > V4 Change Set:
> > Reframe split strings in print statement, to avoid
> >
> > V3 Change Set:
> > Simplified function "mpt3sas_base_pci_device_is_available" and
> > made inline
> >
> > V2 Change Set:
> > Replaced mpt3sas_base_pci_device_is_unplugged with
> > pci_device_is_present.
> >
> > V1 Chnage Set:
> > In Patch 0001 - unlock mutex, if active reset is in progress.
> >
> > Suganath Prabu (8):
> >   mpt3sas: Added new #define variable IOC_OPERATIONAL_WAIT_COUNT
> >   mpt3sas: Separate out mpt3sas_wait_for_ioc
> >   mpt3sas: Refactor mpt3sas_wait_for_ioc function
> >   mpt3sas: Call sas_remove_host before removing the target devices
> >   mpt3sas: Fix Sync cache command failure during driver unload
> >   mpt3sas: Don't modify EEDPTagMode field setting on SAS3.5 HBA devices
> >   mpt3sas: Fix driver modifying persistent data in Manufacturing page11
> >   mpt3sas: Bump driver version to 27.100.00.00.
> >
> >  drivers/scsi/mpt3sas/mpt3sas_base.c      | 73 +++++++++++++------------
> >  drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 ++-
> >  drivers/scsi/mpt3sas/mpt3sas_config.c    | 27 ++--------
> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++------
> >  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 ++++++++++++-
> >  drivers/scsi/mpt3sas/mpt3sas_transport.c | 91 ++++++--------------------------
> >  6 files changed, 106 insertions(+), 152 deletions(-)
> >
> > --
> > 1.8.3.1
>
> These all look fine to me.  I'm only looking at the code structure; I
> have no idea how the mpt3sas hardware or the SCSI mid-layer work, so
> you're on your own there :)
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Andy also gave his reviewed-by on the v6 series, so I cc'd him here.
> I think it's good practice to specifically cc anybody who has
> commented on previous versions of your patch set.

Right, thanks!

With the same caveat as Bjorn posted I give my

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

to v7.


-- 
With Best Regards,
Andy Shevchenko
