Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D429C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjvR6SkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBYTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:47:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41185 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfBYTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:47:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so11294488wrw.8;
        Mon, 25 Feb 2019 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqvd7lW6S0ulQdJhtJFnIlzmKEqsb42Eu4kRGe6Js4w=;
        b=SjvR6SkGXssoG+gt8dJehg/2BKeKxp7wRaRdI4QmqixfjrfRnegGvNYZjHSTOnDgT3
         G2/0szpwvV5P82f+OZtc3Tq6D5/Y0rkGLEORXkUQv5mv1OCHX77PnWuWMgOslHA0UTki
         qaIfgoRLvkysc1S83kIhIPf1lwmCAHGaV0HhggmkpaMyHQLV6TvqUC1tSMGFgtIOZLwn
         SJuLR2lN7fVdkfChHWlSEkssn2paFVEetSmEjM1Ph9BhYF5XWoPiLIAZtMW3WAayHdMd
         naTT8/wpqdCwFr24p88LghpLAfkw1sADZjoLfVe3RrpA8VJWXfzOKNYOayL3hCKyJoVc
         vvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqvd7lW6S0ulQdJhtJFnIlzmKEqsb42Eu4kRGe6Js4w=;
        b=LDaFin+MCBOCJI6SM00do0PshGGklS8rLkPu4r4aGnv50TrPfH+dB0hMw+xyTQgoJb
         RmomXS6s6VHQhgxXy7KwbpZy/UOWYmP/Aa7HaICWzA4WdMGftfH5wUkf6czGpJxkciFZ
         yIOTcJmOH6oq6mFBfl1gKh6pUlkjoqEAUw3Xs/E3S7Xl6ydqochcmrWLr2s+5VG5f7nq
         7ElatljVO1OsCSGML/6byHJbYmnBILPHbf6C0AEez3KwM9cceqRArILL0FQn3tAfqVcQ
         3dC16Ri+xBm+4PrwhtkNIifLfguAvrnZiD76PRIqPW7GN/70GFk/wx0aeexOMznOXyYM
         AvgQ==
X-Gm-Message-State: AHQUAua/orX3UyFlo1tj7W58epKWzja18ZB8gkj/tAbxgguNmDA4vcvc
        nYEJ70r6N35ysnC5iIUfig==
X-Google-Smtp-Source: AHgI3IYVsTch1HViq7FfddvE+gP4f5tdadXga4KNVLhw7UsE2bKsHkguSn2t1OwqYCSJF22NOl1D8Q==
X-Received: by 2002:adf:bc11:: with SMTP id s17mr14367808wrg.129.1551124056449;
        Mon, 25 Feb 2019 11:47:36 -0800 (PST)
Received: from avx2 ([46.53.243.195])
        by smtp.gmail.com with ESMTPSA id z129sm17814884wmc.33.2019.02.25.11.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:47:35 -0800 (PST)
Date:   Mon, 25 Feb 2019 22:47:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     David Both <dboth@millennium-technology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: update i_atime when reading files
Message-ID: <20190225194627.GA14348@avx2>
References: <20190221163714.22330-1-jcline@redhat.com>
 <20190222053742.GA4270@avx2>
 <20190222150020.GA14465@laptop.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222150020.GA14465@laptop.jcline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:00:20AM -0500, Jeremy Cline wrote:
> On Fri, Feb 22, 2019 at 08:37:42AM +0300, Alexey Dobriyan wrote:
> > On Thu, Feb 21, 2019 at 11:37:14AM -0500, Jeremy Cline wrote:
> > > Prior to commit 1da4d377f943 ("proc: revalidate misc dentries"), the
> > > access, modify, and change times of files in /proc were just the current
> > > time.
> > 
> > Ehh, actually no. Doing
> > 
> > 	$(which sleep) infinity </proc/foo &
> > 
> > will sabotage atime updates because dentry and inode will be pinned in
> > caches.
> > 
> > "revalidate misc denries" commit simply makes the effect (much) more
> > visible by making objects stay in caches for longer.
> 
> Indeed. It wasn't my intention to imply there's anything wrong with that
> commit, just that that's what caused this apparent change in behavior
> for users. In the "common" case when something hasn't pinned the dentry
> and inode what users saw was the current time.
> 
> > 
> > > Now the mtime and ctime values change mostly as a user would
> > > expect, but the atime isn't updated when the file read. This patch
> > > updates the access time of /proc files when they are read.
> > 
> > >  			rv = read(file, buf, count, ppos);
> > > +			if (rv >= 0)
> > > +				inode->i_atime = current_time(inode);
> > > +		}
> > 
> > Maybe it should be done given /proc is virtual so there are no concerns
> > about scheduling writes noone cares about to the filesystem.
> 
> Sorry, maybe I've not had enough coffee yet, but I don't understand this
> sentence.

I meant it should be harmless to enable atime unconditionally for /proc
because it is virtual filesystem.
