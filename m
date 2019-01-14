Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B50C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B450820656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dL5prS63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfANWa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:30:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45311 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfANWaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:30:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so639611ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaiJGYIs1DiWgIq6qxEriZFnzxBXyzoJsIEPkYvzLaE=;
        b=dL5prS63eibNFwsyiDdlnyMFRbIiyxvzySuIBf3Bd06PpGJJFcyrByp7gn30i0aWy0
         DUDgkWmTcLIYcSTCD7o+aCcOCaLgWbEY4pmFdLNcy97v7x50+PXEFTPJmPGihvOjxcTk
         PgIhmCXNZ35OgUfZmJwauaL3MKMXlDZsBJ4Fy66ad6mzgvoidFE4XWtBiePkb4ew8/4b
         QDZqeYexK6AQW9Ij9I40dQO6zPqlBp3VxBCErDTmBb/fomdnbM+hZjN6K9Rm7fcd7czw
         N0g3WjvJ8dO356bVxdZsvsYd7HZsjvPKW8lTg0ZSN0C2+NTiD8RL7tHf+wePATp5qwtH
         uu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaiJGYIs1DiWgIq6qxEriZFnzxBXyzoJsIEPkYvzLaE=;
        b=sUV8N70QoucJT5BAOEj0RJp+hK3W+7droQ2gAdifdg0Sv6egPZcDFGdSx/K0R9BSvp
         G4LfPkRowLwlKwyNH+0XhTX9F/W6eypcSa0ntmmE+bdXCAh3Ov3h2YEx7HPdf7rcOLa4
         S3aBLPzbJe9L8CeK4ELVFHtuEhpMlwfZeQmx0mzW8nS+XzkYJf28LTjJMtLPxKNyRdPb
         EC6GcOPb7J1WVW/0C1x7ozQAMxPoFhMouNM2psEZJjRxruc/zc4KNEkFLHRCdEERH4aw
         8vR3cvTWHBt0xi5iNSvv77XrtfGoaXQBTFW4bBnIf0XXMvKF5jDOktmg63ForZcO2154
         iOmw==
X-Gm-Message-State: AJcUukc0l4AvNEBvgeqxdb3ksJnU455DOhNUcLRvwTKAFZ9KpilTMUeT
        +vLjS+AQkmgKAlDOnKMOvvsxTCVwdME7B/CEU0qh8Q==
X-Google-Smtp-Source: ALg8bN5hqC6Uk//IyoqWmivhgVrRs+ndFnsyWSEXt1/RVMekScQZ98OuJboZaN4/44hYYJvQ4jcBHImOolk/YtjYhgE=
X-Received: by 2002:a9d:394:: with SMTP id f20mr457021otf.98.1547505055318;
 Mon, 14 Jan 2019 14:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20190104192410.GA11084@jordon-HP-15-Notebook-PC> <20190114085839.GA13316@quack2.suse.cz>
In-Reply-To: <20190114085839.GA13316@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Jan 2019 14:30:44 -0800
Message-ID: <CAPcyv4hV0VQv9bMz9FWW_n734KiHY-HfLMHW_atG8Wqbnrf34A@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Convert to use vmf_error()
To:     Jan Kara <jack@suse.cz>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 12:59 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 05-01-19 00:54:11, Souptick Joarder wrote:
> > This code is converted to use vmf_error().
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Dan, you are merging DAX patches these days. So probably you should add
> yourself to 'FILESYSTEM DIRECT ACCESS (DAX)' in MAINTAINERs.

Sounds good, I'll merge this and get MAINTAINERs fixed up.

> Or I can start
> picking patches for fsdax to my tree if you are too busy but I think your
> tree is easier as there are less chances for conflicts etc.
>
> In either case this patch looks OK to me so feel free to add
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  fs/dax.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 48132ec..ed39161 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1220,9 +1220,7 @@ static vm_fault_t dax_fault_return(int error)
> >  {
> >       if (error == 0)
> >               return VM_FAULT_NOPAGE;
> > -     if (error == -ENOMEM)
> > -             return VM_FAULT_OOM;
> > -     return VM_FAULT_SIGBUS;
> > +     return vmf_error(error);
> >  }
> >
> >  /*
> > --
> > 1.9.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
