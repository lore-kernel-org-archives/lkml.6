Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C878EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9511521924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SuAP2CLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbeLUOMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:12:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44394 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbeLUOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:12:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so5398234wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aiNZa7Mawb3m+l0Q3Ocsw05qkjdEMWJ9kxmbHt5wTSw=;
        b=SuAP2CLaH/19W7EF8jvK30L30YgXgenrG0t+mhDCbpN5zmbkbYAx5aEkhzkbkGIsju
         Nzfka0dFrkINHV9gR5kEF4K/hA5pVeU/NarnSTGGKlEkahVAxX6XbzNe23U4E/OTSiD4
         jxg74Nl4d+O4qeLL72EBcMgjUd4ixFLJ5Cw53ioJlu7+807TkKlHhxGXBbiz0RG/4jiS
         rQHZ0vyCcVUIPRfCg3WJJvKXiMmW5UJTj0g3sbrC8Lu05lBmoXygNCrtEQFpHsYHJWlo
         AiVZcE5A/5ZFL1Q5h7akmmn/rmYYx8AoxYvHC1TwCgrAF/tG6SNyUyPmqtdn9EJaOSdd
         EcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aiNZa7Mawb3m+l0Q3Ocsw05qkjdEMWJ9kxmbHt5wTSw=;
        b=Nh45UYR+OMPAjrDWdIiKAU7Ri8OtB4Y0+U+/P4mVpzOSK9J2AfAJF1EMyQtxB9mGvS
         HUrWyBrGrwO6MOyEiJ57G+95nnoQ9zxaUvAg8FbjCPgXpzKZGidAaztWNxIumi1cRFbD
         RdUZS5Zair15HlM4lnmVEcRNK9ZpyRdFBo8EGXy6rlgwk0CoT3CrrMOJnp5uSjPmPwdz
         pFjqMF9F+bu+aLLBjmTVotV6hsYawwzTck8FlBj33Ci7096/YaS6BXc/lNM9gHxJAwtQ
         KImTV8xTvrPuFnN9TJqM5EPmQFRcsyofQgh8Y3IXXS/kAMZJUhJfcUu4GCL7BFDRsnks
         bWEg==
X-Gm-Message-State: AJcUukcd2fykhZCcHI4CpfPAPiv+LfV6FrijC0a3LDQyBm/aylPOGIBr
        mVeh3bgm7TY+RFv34xk86q1Cog==
X-Google-Smtp-Source: ALg8bN7epZsD3TpXbYe65hzgK4Q9BKoD9Vsj+5xLOywBw0op3y6/PY3m58h1vsIl7M19uVDsozEngA==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr2709582wri.324.1545401564418;
        Fri, 21 Dec 2018 06:12:44 -0800 (PST)
Received: from brauner.io (x4d0d79a8.dyn.telefonica.de. [77.13.121.168])
        by smtp.gmail.com with ESMTPSA id v133sm10414577wmf.19.2018.12.21.06.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:12:43 -0800 (PST)
Date:   Fri, 21 Dec 2018 15:12:42 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com
Subject: Re: [PATCH] binderfs: implement sysctls
Message-ID: <20181221141241.gnxoiw7t5ajwcd6d@brauner.io>
References: <20181221133909.18794-1-christian@brauner.io>
 <20181221135509.GA30679@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221135509.GA30679@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:55:09PM +0100, Greg KH wrote:
> On Fri, Dec 21, 2018 at 02:39:09PM +0100, Christian Brauner wrote:
> > This implements three sysctls that have very specific goals:
> 
> Ick, why?
> 
> What are these going to be used for?  Who will "control" them?  As you

Only global root in the initial user namespace. See the reasons below. :)

> are putting them in the "global" namespace, that feels like something
> that binderfs was trying to avoid in the first place.

There are a couple of reason imho:
- Global root needs a way to restrict how many binder devices can be
  allocated across all user + ipc namespace pairs.
  One obvious reason is that otherwise userns root in a non-initial user
  namespace can allocate a huge number of binder devices (pick a random
  number say 10.000) and use up a lot of kernel memory.
  In addition they can pound on the binder.c code causing a lot of
  contention for the remaining global lock in there.
  We should let global root explicitly restrict non-initial namespaces
  in this respect. Imho, that's just good security design. :)
- The reason for having a number of reserved devices is when the initial
  binderfs mount needs to bump the number of binder devices after the
  initial allocation done during say boot (e.g. it could've removed
  devices and wants to reallocate new ones but all binder minor numbers
  have been given out or just needs additional devices). By reserving an
  initial pool of binder devices this can be easily accounted for and
  future proofs userspace. This is to say: global root in the initial
  userns + ipcns gets dibs on however many devices it wants. :)
- The fact that we have a single shared pool of binder device minor
  numbers for all namespaces imho makes it necessary for the global root
  user in the initial ipc + user namespace to manage device allocation
  and delegation.

The binderfs sysctl stuff is really small code-wise and adds a lot of
security without any performance impact on the code itself. So we
actually very strictly adhere to the requirement to not blindly
sacrifice performance for security. :)

> 
> > 1. /proc/sys/fs/binder/max:
> >    Allow global root to globally limit the number of allocatable binder
> >    devices.
> 
> Why?  Who cares?  Memory should be your only limit here, and when you
> run into that limit, you will start failing :)
> 
> > 2. /proc/sys/fs/binder/nr:
> >    Allow global root to easily detect how many binder devices are currently
> >    in use across all binderfs mounts.
> 
> Why?  Again, who cares?
> 
> > 3. /proc/sys/fs/binder/reserved:
> >    Ensure that global root can reserve binder devices for the initial
> >    binderfs mount in the initial ipc namespace to prevent DOS attacks.
> 
> Huh?  Can't you just create your "global root" devices first?  Doesn't
> the code do that already anyway?
> 
> And what kind of DoS attack could this ever prevent from anyway?
> 
> > This is equivalent to sysctls of devpts.
> 
> devpts isn't exactly the best thing to emulate :)

It's one of its saner design choices though. :)

> 
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  drivers/android/binderfs.c | 81 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 79 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 7496b10532aa..5ff015f82314 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -64,6 +64,71 @@ struct binderfs_info {
> >  
> >  };
> >  
> > +/* Global default limit on the number of binder devices. */
> > +static int device_limit = 4096;
> > +
> > +/*
> > + * Number of binder devices reserved for the initial binderfs mount in the
> > + * initial ipc namespace.
> > + */
> > +static int device_reserve = 1024;
> > +
> > +/* Dummy sysctl minimum. */
> > +static int device_limit_min;
> > +
> > +/* Cap sysctl at BINDERFS_MAX_MINOR. */
> > +static int device_limit_max = BINDERFS_MAX_MINOR;
> > +
> > +/* Current number of allocated binder devices. */
> > +static atomic_t device_count = ATOMIC_INIT(0);
> 
> You have a lock you are using, just rely on that, don't create
> yet-another-type-of-unneeded-lock with an atomic here.
> 
> Anyway, I really don't see the need for any of this just yet, so I
> didn't read beyond this point in the code :)
> 
> thanks,
> 
> greg k-h
