Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23B8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B177321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ7ucoTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfA1Ptt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36296 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfA1Ptr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so8178172pfc.3;
        Mon, 28 Jan 2019 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPOXNmCc9QGZxVPGuBdj+M38qlfRDcwzHxYp1zV1Lus=;
        b=UQ7ucoTFnThPSjvDdyZt6lwceoyLg68tkDcJK1IZiTHV432Otou6D7ou9LSbIqLz2K
         t0HSZ+UFHzDqMVi40Sw6DAIk1B1k9/n7rcuOAA0GQ30AQK2dvdVzevTAOJ1TGlM1jZey
         JFBOau7zoxid3Jg+UKTRn66IqbuRyEG5Cf55Wq+x91PpfGbvi8NX3O+v3aziSrTIUJY+
         7F6ZUmAWT5yWyENgn9Sn1aUrLm8oEnHX7YXR4DO31om1HCktIhNi6usjXa3SR8RQcj6G
         zfcXkvnbnGnjm9TTMDc2B5L4LSZ6vt2dqmxA1bF74lrsD4Bdb76R226UFgYDvPN2VWCo
         bv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPOXNmCc9QGZxVPGuBdj+M38qlfRDcwzHxYp1zV1Lus=;
        b=HdWFk9cGDKRTZWE3za8ofPAIyuen0DKyJESHQpzbf7OxqfSTruaWquq/pRNjCsDcva
         8HrjXVTyNJN1D+CbIvHVNCpztk93oNLTQOC1JHHvu+LVYUIRr56hxXh0XjClX1iQ1Glj
         Jd6JM5yCd9O131g2BOI8IYQmhcJFtfeEjb06p7JoIZvUw2D0WDoE4Rm8PES/QLQeAyzP
         N2GivsLch6y9lcT4OFQg3CGqA/eDI26/Jea4K8G5pIduhpvaEElPU3beb+CjSa1FBavz
         iUom9pXamjy8xbpeQNwwpKsz2nmsYrrIts+G3az7fOaDssi3nqTcMYb4t3hB1i4AiynY
         vnQg==
X-Gm-Message-State: AJcUuke5uJZndSm7w6wX/ON1GCLqC40t0sJqu1LX9bRFizB4VI4Dx3zb
        q6nLmnZ18KkSNSaSb9U+s80CvnJBq45r9H8mla5i+1K+
X-Google-Smtp-Source: ALg8bN7tdWq1w66B7Flm9lZQHyhX5eTOt33kUtitYuedcqS/0NErP/F3afklPsRhHu3MUqM+0Yyro7rYH5F708FgbeY=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr22914890pfa.229.1548690586251;
 Mon, 28 Jan 2019 07:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20190122200302.19861-1-2pi@mok.nu> <CAHp75Vfv1sMyAQn=ue0hroqAnbkhQayCj64xNBHO5PRRv53GSA@mail.gmail.com>
 <20190128143845.2gneic5ip5b56mwv@mok.nu>
In-Reply-To: <20190128143845.2gneic5ip5b56mwv@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 17:49:34 +0200
Message-ID: <CAHp75Vdjq5S3gdk7iPEsbmAvxL1nVxxNSnTQ1O0KLxZ4uTH_tw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: fix potential null pointer dereferences
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 4:39 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> On 2019-01-27, Andy Shevchenko wrote:
> > On Tue, Jan 22, 2019 at 10:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:

> > > -       struct wmi_driver *wmi_driver =
> > > -               container_of(driver, struct wmi_driver, driver);
> >
> > AFAIU this is just a pointer arithmetics, no need to move it.
>
> That is my understanding too, it seamed backwards to do the NULL check
> afterwards, but we still have access to dev and driver. So why not...
>
> >
> > > -       struct wmi_block *wblock = dev_to_wblock(dev);
> >
> > > -       const struct wmi_device_id *id = wmi_driver->id_table;
> > > +       const struct wmi_device_id *id;
> > > +       struct wmi_block *wblock;
> > > +       struct wmi_driver *wmi_driver;
> > > +
> >
> > > +       if (dev == NULL || driver == NULL)
> > > +               return 0;
> >
> > On which circumstances this may ever happen?
>
> Nothing in particular. If there is a bug in the caller of this function,
> then that is when this will come into play. See my earlier mail to
> Darren too.

So, I suggest in these cases do not touch existing till the actual
problem will be discovered and proved.
I.o.w. touch only place which you have real problem, and describe this
issue in commit message.

-- 
With Best Regards,
Andy Shevchenko
