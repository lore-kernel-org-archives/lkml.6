Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F1C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63542089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFHeGPMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63542089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeGJBZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:25:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbeGJBZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:25:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id n15-v6so1626162pgv.4;
        Mon, 09 Jul 2018 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NibA++xsIgXeiAy/mtOxYWqoCh/zt3axaqNJtVUMAsg=;
        b=IFHeGPMTlZVLblCL1V/SLPWDZzVo4fpsWFdBKzJxAVDXbGBk3v7Peg0Of0SSqR0AEq
         2NpE3mbcWtXqJE7xw2x6DGPmCtIQaMVfj+EP0qDz+lwS82kX+iu98ECMDVWlykWqVNok
         uYkiRM9rvOSTzCyBpYMM1gsfiiVJb9IFuLDEWoHhut120G6stonV9sIVqOBD4WHYdHqy
         c9Na55e/XEg3mBerpfRm8HC/7OAUi9C5lnTa+jjqoWr6ACJ+LVqSbbMEuRYSCNCS34SC
         xp3QwttTFV2eiNfMntM5+QR7jBFXKbgbWBdSQdS6kpdEtVZ6srdQSRTQF/QIzWJIf3aB
         3E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NibA++xsIgXeiAy/mtOxYWqoCh/zt3axaqNJtVUMAsg=;
        b=chcvpcHAzZSaCSQkFGI9LpggGXdmcojoIERSbvGVLioPkNdSc8sMrBBPx0wUwph358
         qTl04Q/KBvnH+44n8XZWbyYE9KIzzRscv4FMAY9B7MuD+m10MkIQQWhmkRL+RVmrMvud
         jrH+SX4wJlrcAa9INBN8za2yc2enNGVWcPMqzwpXkBfcDYIkfvlA/6eiPuJouftqWZ3h
         gp6wHpci+O4GZPgDfjGAar/Cx3V3EwhUABms2LI82P14N3m4B2Jz6sGx49pZQRh/60nX
         U63R/uOCNDcUkGcQfpvxV42nXs/ypl/i2LtQQkxbg27G4eFljEATBfTuOuOUVIE8mWPI
         2jKg==
X-Gm-Message-State: APt69E11t5hbUn+LA+Wv/hGj2PiQAWQQ8AO9mJm6she3reX0MgrmV+HS
        xOZ4QAF0j2J9JW10Yu4sRt0=
X-Google-Smtp-Source: AAOMgpci7/ukjzUrh+vkg8Q46zcKgmQ41HJgBQq7nmU+wggz8zRiC3KF4QQtV5GjQBn9pUptilQBig==
X-Received: by 2002:a65:5307:: with SMTP id m7-v6mr21420993pgq.431.1531185920155;
        Mon, 09 Jul 2018 18:25:20 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id c5-v6sm41675754pfe.169.2018.07.09.18.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 18:25:19 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:25:18 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 07/18] fs_context: fix double free of legacy_fs_context
 data
Message-ID: <20180710012518.GB1014@sol.localdomain>
References: <20180708210154.10423-8-ebiggers3@gmail.com>
 <20180708210154.10423-1-ebiggers3@gmail.com>
 <3014.1531139469@warthog.procyon.org.uk>
 <20180710011741.GA1014@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710011741.GA1014@sol.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 06:17:41PM -0700, Eric Biggers wrote:
> On Mon, Jul 09, 2018 at 01:31:09PM +0100, David Howells wrote:
> > Eric Biggers <ebiggers3@gmail.com> wrote:
> > 
> > > sys_fsmount() calls fc->ops->free() to free the data, zeroes
> > > ->fs_private, then proceeds to reuse the context.  But legacy_fs_context
> > > doesn't use ->fs_private, so we need to handle zeroing it too; otherwise
> > > there's a double free of legacy_fs_context::{legacy_data,secdata}.
> > 
> > I think the attached is better.  I stopped embedding the fs_context in the
> > xxx_fs_context to make certain things simpler, but I missed the legacy
> > wrapper.
> > 
> > David
> > ---
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index f91facc769f7..ab93a0b73dc6 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -34,7 +34,6 @@ enum legacy_fs_param {
> >  };
> >  
> >  struct legacy_fs_context {
> > -	struct fs_context	fc;
> >  	char			*legacy_data;	/* Data page for legacy filesystems */
> >  	char			*secdata;
> >  	size_t			data_size;
> > @@ -239,12 +238,21 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
> >  				      enum fs_context_purpose purpose)
> >  {
> >  	struct fs_context *fc;
> > -	int ret;
> > +	int ret = -ENOMEM;
> >  
> > -	fc = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
> > +	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
> >  	if (!fc)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > +	if (!fs_type->init_fs_context) {
> > +		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
> > +					 GFP_KERNEL);
> > +		if (!fc->fs_private)
> > +			goto err_fc;
> > +
> > +		fc->ops = &legacy_fs_context_ops;
> > +	}
> > +
> 
> Why isn't this done in the same place that ->init_fs_context() would otherwise
> be called?  It logically does the same thing, right?

Case in point: if allocating ->fs_private fails here, you'll get a NULL pointer
dereference during put_fs_context() not only from the NULL ->fs_private in
legacy_fs_context_free(), but also from put_filesystem() since ->fs_type hasn't
been set yet.

- Eric
