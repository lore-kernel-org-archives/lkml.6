Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B83C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C88C2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="uC2WajcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJJTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:18:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43455 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJJTSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:18:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so4640664eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oqa/RfCfY1NbDonkLTTRAs1moBM8fR3V/GENU4PPzpU=;
        b=uC2WajcKhI772RQ20tt4z2VAohV/wm0gE8ZDWu73n6nrp/Ybfye0yU5SCWlW91uS6s
         U18puFBkzTyr7lEOFuXwCXS7Gr9AX739GokniRyvSsFzLOkAGShpfraESei4+kmmzzx1
         KzyZJ9eY7AqZTi6oc2wlRAavag8Gv1mpY2hFQq+7BbLYRYMhLT5PwMXB3I5CTFxYao7V
         Kz9jxHrSyiiX/p1iSON0ZEyb+n7xtfKVv3GncDrDrT7vzLPjurJ9CqjlR7ogljxg57kk
         ok/H772Gp+iuMghKDdbIYbc87kiSAK8skApcUbyq444HnK2aSpbdptqAj0VfUlRCH82q
         X1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oqa/RfCfY1NbDonkLTTRAs1moBM8fR3V/GENU4PPzpU=;
        b=Vh5fP2ycxnBQfE6uBVO/QXZ49sZz7jwsdUNZ9gEfmc+oADJcPkqmsZ249KhWJRn1dt
         jG15pyXUBrKlRSmYIXFgQU3J50wXZXj8HbvOJXhIZIkrakqU7jzn8eyKwTYR8SrSCjLO
         daoSwPDV9K5MShrxS1zKaihZoGk3M2NRZdX2jN/b6fUo1ZmoXGV44a7ywtSSDQ0WgtkV
         DMg/MhWPMy5Q/vBORqiL5UOwYsgSCVWFYqHc9rHA54cpqMjjFqjCWqP/T3FhB84UJzqG
         1MbCVj+EDN2xWij3cBlFYJZXQJMGSW+co/uccMNbZxlx1zC9RX7s+/NISUdu/qq1+M7O
         fcbw==
X-Gm-Message-State: ABuFfog9qVcR+I63GiMKZITZ7MtQWq4dlJwW7TRnl+2L7l470DMTF+C3
        B0DW2f57V5OQ3CUSOf7oJYeENQ==
X-Google-Smtp-Source: ACcGV60nc14K4oX+RddTnAASdMCTV7uWJ+rpCvRgSRVnjyjx5jzYKSlcBC416S8OQwnklYfuPsXGZA==
X-Received: by 2002:a17:906:1851:: with SMTP id w17-v6mr8658744eje.134.1539172603286;
        Wed, 10 Oct 2018 04:56:43 -0700 (PDT)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id e21-v6sm6248495edb.22.2018.10.10.04.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 04:56:42 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:56:39 +0200
From:   Henrik Austad <henrik@austad.us>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010115639.GA25534@sisyphus.home.austad.us>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
> Hi all,

Hi, nice series, I have a lot of details to grok, but I like the idea of PE

> Proxy Execution (also goes under several other names) isn't a new
> concept, it has been mentioned already in the past to this community
> (both in email discussions and at conferences [1, 2]), but no actual
> implementation that applies to a fairly recent kernel exists as of today
> (of which I'm aware of at least - happy to be proven wrong).
>=20
> Very broadly speaking, more info below, proxy execution enables a task
> to run using the context of some other task that is "willing" to
> participate in the mechanism, as this helps both tasks to improve
> performance (w.r.t. the latter task not participating to proxy
> execution).

=46rom what I remember, PEP was originally proposed for a global EDF, and a=
s=20
far as my head has been able to read this series, this implementation is=20
planned for not only deadline, but eventuall also for sched_(rr|fifo|other)=
=20
- is that correct?

I have a bit of concern when it comes to affinities and and where the=20
lock owner will actually execute while in the context of the proxy,=20
especially when you run into the situation where you have disjoint CPU=20
affinities for _rr tasks to ensure the deadlines.

I believe there were some papers circulated last year that looked at=20
something similar to this when you had overlapping or completely disjoint=
=20
CPUsets I think it would be nice to drag into the discussion. Has this been=
=20
considered? (if so, sorry for adding line-noise!)

Let me know if my attempt at translating brainlanguage into semi-coherent=
=20
english failed and I'll do another attempt

> This RFD/proof of concept aims at starting a discussion about how we can
> get proxy execution in mainline. But, first things first, why do we even
> care about it?
>=20
> I'm pretty confident with saying that the line of development that is
> mainly interested in this at the moment is the one that might benefit
> in allowing non privileged processes to use deadline scheduling [3].
> The main missing bit before we can safely relax the root privileges
> constraint is a proper priority inheritance mechanism, which translates
> to bandwidth inheritance [4, 5] for deadline scheduling, or to some sort
> of interpretation of the concept of running a task holding a (rt_)mutex
> within the bandwidth allotment of some other task that is blocked on the
> same (rt_)mutex.
>=20
> The concept itself is pretty general however, and it is not hard to
> foresee possible applications in other scenarios (say for example nice
> values/shares across co-operating CFS tasks or clamping values [6]).
> But I'm already digressing, so let's get back to the code that comes
> with this cover letter.
>=20
> One can define the scheduling context of a task as all the information
> in task_struct that the scheduler needs to implement a policy and the
> execution contex as all the state required to actually "run" the task.
> An example of scheduling context might be the information contained in
> task_struct se, rt and dl fields; affinity pertains instead to execution
> context (and I guess decideing what pertains to what is actually up for
> discussion as well ;-). Patch 04/08 implements such distinction.

I really like the idea of splitting scheduling ctx and execution context!

> As implemented in this set, a link between scheduling contexts of
> different tasks might be established when a task blocks on a mutex held
> by some other task (blocked_on relation). In this case the former task
> starts to be considered a potential proxy for the latter (mutex owner).
> One key change in how mutexes work made in here is that waiters don't
> really sleep: they are not dequeued, so they can be picked up by the
> scheduler when it runs.  If a waiter (potential proxy) task is selected
> by the scheduler, the blocked_on relation is used to find the mutex
> owner and put that to run on the CPU, using the proxy task scheduling
> context.
>=20
>    Follow the blocked-on relation:
>  =20
>                   ,-> task           <- proxy, picked by scheduler
>                   |     | blocked-on
>                   |     v
>      blocked-task |   mutex
>                   |     | owner
>                   |     v
>                   `-- task           <- gets to run using proxy info
>=20
> Now, the situation is (of course) more tricky than depicted so far
> because we have to deal with all sort of possible states the mutex
> owner might be in while a potential proxy is selected by the scheduler,
> e.g. owner might be sleeping, running on a different CPU, blocked on
> another mutex itself... so, I'd kindly refer people to have a look at
> 05/08 proxy() implementation and comments.

My head hurt already.. :)

> Peter kindly shared his WIP patches with us (me, Luca, Tommaso, Claudio,
> Daniel, the Pisa gang) a while ago, but I could seriously have a decent
> look at them only recently (thanks a lot to the other guys for giving a
> first look at this way before me!). This set is thus composed of Peter's
> original patches (which I rebased on tip/sched/core as of today,
> commented and hopefully duly reported in changelogs what have I possibly
> broke) plus a bunch of additional changes that seemed required to make
> all this boot "successfully" on a virtual machine. So be advised! This
> is good only for fun ATM (I actually really hope this is good enough for
> discussion), pretty far from production I'm afraid. Share early, share
> often, right?  :-)

I'll give it a spin and see if it boots, then I probably have a ton of=20
extra questions :)

Thanks for sharing!

-Henrik

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu96PcACgkQ6k5VT6v45llDXgCgqTKGMTk1VZT8+p6zdKDBBCM1
X+8AoNHII7jfIh3vGQgc8PVut1C8zJPK
=DiVT
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
