Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A4020833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYxi9tYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A4020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeINV6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:58:03 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39041 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:58:03 -0400
Received: by mail-lf1-f54.google.com with SMTP id v77-v6so8416037lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDW3CItelxwGxiGr0DrkerVJMp6hA7QTQqUn/xuAv70=;
        b=JYxi9tYImVMYOhCvz89SAP7bRw9YXT1/KjPTQpk9gb4u3I2Z8+gZIf8hEwaK3WmzFC
         avvJUBTyhG7TJOjwA7o66r9h6KEOyy9hSf4ofDR34DffQz/Ngv0Vkxu6eunhhF6jOu8C
         IEJPfO7F91PsyNDMWjuhgiX9w32MRadid0fWRyK2PO3ba7pj8wrlb+HgeVygRYu1wunl
         lUskF6guyPP9BeIk1rXUVHjWkFT0WcdAOAS6UNg52SrUXF3dvJ0mO7XVYfly4i66VLGj
         X+emWL4m8vIMK46HlJtnnXMj1ZjnQ2SN1pY9EojncwhQT0eijeHXOu3jDnG9diJN2Jcb
         xRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDW3CItelxwGxiGr0DrkerVJMp6hA7QTQqUn/xuAv70=;
        b=Ylu+9Ya47k+RIH/VcONi4bUohzSZeLJWTrxcz/PtwkSWJqepwgwBCXxgsNpNLemO75
         LlpI56Fk7GThVGOOR5SX0PBmd+4+GEPDI5gOEl3OOyR45mImwOqYhl5fa4B0H03TGK/h
         SgAhCgI/fDFZRFlGDNb2THKrWqE23YNMTXEGS8hdeIuLW220X6f+pVWUmZ5Y2VP3+5EC
         5Lh/vTUP30sJMxBjS18GWVgGqEh33KER4w9kbM6AAPAUi73/5s1QKq32qLmw5BrKYmOs
         ePVtaEDyZq1Tgf2n9CAQZbkUM8uOhRA5Xv3H3B1HCy5DlFW41ajS/m2n+0w5xTGrRQFM
         NCgw==
X-Gm-Message-State: APzg51BNyYq42pbjC7p1uy3FBWuuHz4vlhxgsJy7T2ZDVFnD51TPdA5Z
        eEDy94LIAhA05TIPH+OFqL5tJWYq7NqVjKvLWf5X8eCy
X-Google-Smtp-Source: ANB0VdZaalvCyn1W4vDLIWkAzCyv8kWZisv3JHhypER6FV0XBX/nzcovqVMEj0RKC4Igeha2zAtqmsYadU1ELSj3QLg=
X-Received: by 2002:a19:ead4:: with SMTP id y81-v6mr8930869lfi.110.1536943364332;
 Fri, 14 Sep 2018 09:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com> <20180827182315.126345-7-rkir@google.com>
 <20180914133044.GB16982@kroah.com>
In-Reply-To: <20180914133044.GB16982@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Fri, 14 Sep 2018 09:42:32 -0700
Message-ID: <CAOGAQeoEeKJDDU685cPPXr95hn_tuxmga-+4usa0b2aoKjgO=g@mail.gmail.com>
Subject: Re: [PATCH 07/20] platform: goldfish: pipe: Replace an array of 1
 with a variable
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, in the later change I am going to retire this variable
completely. Could you please accept this patch as it?
On Fri, Sep 14, 2018 at 6:30 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 27, 2018 at 11:23:02AM -0700, rkir@google.com wrote:
> > From: Roman Kiryanov <rkir@google.com>
> >
> > There is no reason to have an array of 1.
> >
> > Signed-off-by: Roman Kiryanov <rkir@google.com>
> > ---
> >  drivers/platform/goldfish/goldfish_pipe.c | 28 +++++++++++------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> > index 24e40deb98cc..e9e3e791c0d4 100644
> > --- a/drivers/platform/goldfish/goldfish_pipe.c
> > +++ b/drivers/platform/goldfish/goldfish_pipe.c
> > @@ -205,7 +205,7 @@ struct goldfish_pipe_dev {
> >       unsigned char __iomem *base;
> >  };
> >
> > -static struct goldfish_pipe_dev pipe_dev[1] = {};
> > +struct goldfish_pipe_dev goldfish_pipe_dev;
>
>
> Why do you need a static structure at all?  Shouldn't this be tied to
> the dynamic device the driver core gives you?  That way you can handle
> any number of these devices without any code changes needed.
>
> thanks,
>
> greg k-h
