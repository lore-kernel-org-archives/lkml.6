Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE59C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFA0207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="h3WdISEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFA0207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJXQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:48:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36255 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeJXQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:48:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so4552726wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TepQzjOizsdY3QBM5ZYPc8nvA+FcJjKoq+Ln/hYNDYM=;
        b=h3WdISEu6ob1GsKmsQJjYQj/+7ck1ARWutHcljl0E3lbbGk7WnTKbioeXoYiW4byem
         QIBFyVg1vLiE+gfajBQZEk+RucCzaE4mFQlIvVPjEGK8nVASsDK69A734QmfOPbdyeWw
         LwsT7RhxU6bhQpcjxsyBwRZ53avCtdbkDd32BLzGZt+Bw1og9B2gK6vKN0w9kTA9pwHC
         yKexqhilrt3N/W3FJXhYYeLWzVTmZn1w1pUhdZhq9poR0hrkkOroqAkpDro4bchBmUYG
         M7/pfcBy2K90XBN2t8zCqzxb580mGZ96b0Q1zTYMtNwiPIfKijZcgMp/rTqKJFA9DI8p
         uSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TepQzjOizsdY3QBM5ZYPc8nvA+FcJjKoq+Ln/hYNDYM=;
        b=po7XbqX5iaoXfOXR3W+lU39ZxnHb+hsBqrG/ZqwRzsrTRJwtwz8/S5FxMz+k09ysuY
         YG2m3966Z7SKP0/6QXrRSKLXV8IaWA+So9lO0bjKjsa0AYylMstUNyM1sP+VyIU8tQnq
         7dfBWrLp+A77UYS0Vc6eqZpK1AWg9eKhhYtxW+WrhIkTZ37s7xFCTJQUyAg+XvKZYEqu
         07cT47SMAnud5rcMzu/YekJYBfhk01Qou6Fk3CpOBbTCMK83GyEKJtQwPLYwWnz6PFZu
         tcxMfUl9Jm1wSponnByYS8MbW5B6CfIX9uUOPl6Vh4o+0iWk3BmNUmSrOKQGYERq51zr
         derA==
X-Gm-Message-State: AGRZ1gIYw06fMH0UjnLC6jXgQu6mQk0hc1/vV4K/+OvZpE7i7CIUqZZb
        +UrQ1zXZGLfP+tCkv3ZMKegowTt3Wh6TNUIs
X-Google-Smtp-Source: AJdET5fvy/n3J/Fqe7OmgjnrnbzB5/m3r0KmkK9PgnWiwPbjoxuwVqZU8nSTvcS9Cf2LwRmlOVy6qQ==
X-Received: by 2002:adf:f384:: with SMTP id m4-v6mr1717533wro.111.1540369297082;
        Wed, 24 Oct 2018 01:21:37 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id g8-v6sm4221542wri.58.2018.10.24.01.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 01:21:36 -0700 (PDT)
Date:   Wed, 24 Oct 2018 09:21:34 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
Message-ID: <20181024082134.GA14565@pathfinder>
References: <20181023201953.GA15687@pathfinder>
 <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:16:20AM +0300, Amir Goldstein wrote:
> On Tue, Oct 23, 2018 at 11:19 PM Phillip Potter <phil@philpotter.co.uk> wrote:
> >
> > Many file systems use a copy&paste implementation
> > of dirent to on-disk file type conversions.
> >
> > Create a common implementation to be used by file systems
> > with some useful conversion helpers to reduce open coded
> > file type conversions in file system code.
> >
> > Original patch written by Amir Goldstein.
> 
> Looks good.
> I guess you used 'git apply' or just 'patch'
> What you usually do when applying someone else mostly unchanged
> patches is use 'git am -s -3' so you preserve the original author and
> original commit message including the Signed-of-by line.
> You can edit your patch by hand to change the From: line to change the
> author and add
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> (you sign below me as you changed the patch last)
> 

Dear Amir,

Yes, I applied each patch manually to my tree, fixed it up where needed,
then after rebuilding and testing each one I committed it and regenerated
each patch. Thank you very much for your advice, I will take it into
account and make the necessary changes. In the meantime, do I add other
tags in the order they are received also (such as Reviewed-by:) and am
I safe to add these in when I re-send the patches with the changes you
and others have suggested (or would that offend people that have
offered the tags)?

Regards,
Phil
