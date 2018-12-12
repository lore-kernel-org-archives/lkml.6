Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C9CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C5F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2g6Cmqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C5F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeLLOFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:05:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46212 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLLOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:05:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so10746713qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VKj9JdAWi5KGtHg2WRJdDYlZfjB2B+dHt6ZI53OuOEk=;
        b=E2g6CmqhY3pAP6CHUz03BtcU7EowTHrMzhaGMXxqKFRNNM3pgCXxZRWYx6bbVEhj9q
         fhxgE83Swa3DWimTzoQUrmb1amWcBhrTp5AgPisWgDvzxuKmGqIbCxwQHBXzsjPdYM70
         ZysrVyQxQUFZi7X7hlNGLH7Y6DPGNodjj8XrbBajyJlOZbdQ/igqGYO9gNzUBZRMcRoM
         zY83SPNirfFkjzDAEvAMjjZyp3ZotFlrCFGg+sryvgCFkAGz5rXXkLFs/2ES6h9i7ztJ
         mXH2JeYjA8mtvDQMGoo8QG0PQCQ17ABY1z9wCxEF55YI836/y2hb87Wl6RNbAOulgwOg
         lbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VKj9JdAWi5KGtHg2WRJdDYlZfjB2B+dHt6ZI53OuOEk=;
        b=H3CAbSOaClgRiodyMJKtxYfRThRC3q+Ei0XxyZvtPbt0XES/k5+B1J96jBJgA41Ehp
         DLuUGYT9Ui1bBZI43628LCdNJiyk8pwPj9dXWL/9tt7+ytLigKT8P2P5BVyjh0xnnDcZ
         lrE0+s8uOGGFQOzZLtW+hp7EHXHBeION7aj8x/Xf/fR5zVMqkOALtlKtPF+QFsrK1EtR
         uamV85qrQlkG5XFKNZzwtPaem1QRrJbHaEKaY+Do22zpZ5JPzbsBRmexNCq3Cpmbii6j
         Jq3/SuNHh3f2faWPs8RmGxGgO9FKcCEIfnZtO7Bdfnu6RlhIr8a7goGIVUUCmck2BVaX
         TVSg==
X-Gm-Message-State: AA+aEWZCEG4dLOwGqnT3fY75V0MUuLsjNJauA2meqYKblGoj0Lhp76yW
        kLuFunBSYlD5ICA2iKU31Ho=
X-Google-Smtp-Source: AFSGD/W47FCRGlEQTLAXNQXWoECMzkwSbJRtPxotWWn8sgvh3ClNqU0hbSFS6HzHoUImnAyLGbmyiQ==
X-Received: by 2002:a37:1f6a:: with SMTP id f103mr17682498qkf.138.1544623531583;
        Wed, 12 Dec 2018 06:05:31 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t43sm11264470qtc.53.2018.12.12.06.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 06:05:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id EA05721E07;
        Wed, 12 Dec 2018 09:05:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Dec 2018 09:05:29 -0500
X-ME-Sender: <xms:pxURXPZZmM6_wRoi0EX4LKdSPXdSntxts1xC6eLrQHTxFZ8PQY_IKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudegledgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigphhluh
    hmsggvrhhstghonhhfrdhorhhgnecukfhppeeghedrfedvrdduvdekrddutdelnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:pxURXPcb5W6vkRckpg8xzYNK3Bo0vCGtRH6L7XvPbMTLpIteMJpY5w>
    <xmx:pxURXHOY_cu-fUGEuUrJG6-08p_fDdhchetaRTha2s9CvhlcI2qNpw>
    <xmx:pxURXBWSKbeZWsaagqnOiwNOMtdGxEfPgUxsouHrhNvpXu1cifYpOg>
    <xmx:pxURXI19J_lxpTKUkPijRz0-12wny9P2SIvm1iFnt9vFtjOLTqodxA>
    <xmx:pxURXM7n-MDNR06-BFWHlwDDHqLw6baAeHmdiJkUSxaKxsQnkBdzhQ>
    <xmx:qRURXCEvPFwC7Cj3rxhrifM6eSriIe388dMY5plyvIIed-sdw5qwcA>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFD4F103FA;
        Wed, 12 Dec 2018 09:05:26 -0500 (EST)
Date:   Wed, 12 Dec 2018 22:05:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH] srcu: Remove srcu_queue_delayed_work_on()
Message-ID: <20181212140519.GA10937@tardis>
References: <20181211111238.13474-1-bigeasy@linutronix.de>
 <20181212014016.GA97542@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20181212014016.GA97542@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Tue, Dec 11, 2018 at 05:40:16PM -0800, Joel Fernandes wrote:
> On Tue, Dec 11, 2018 at 12:12:38PM +0100, Sebastian Andrzej Siewior wrote:
> > srcu_queue_delayed_work_on() disables preemption (and therefore CPU
> > hotplug in RCU's case) and then checks based on its own accounting if a
> > CPU is online. If the CPU is online it uses queue_delayed_work_on()
> > otherwise it fallbacks to queue_delayed_work().
> > The problem here is that queue_work() on -RT does not work with disabled
> > preemption.
> >=20
> > queue_work_on() works also on an offlined CPU. queue_delayed_work_on()
> > has the problem that it is possible to program a timer on an offlined
> > CPU. This timer will fire once the CPU is online again. But until then,
> > the timer remains programmed and nothing will happen.
> > Add a local timer which will fire (as requested per delay) on the local
> > CPU and then enqueue the work on the specific CPU.
> >=20
> > RCUtorture testing with SRCU-P for 24h showed no problems.
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/srcutree.h |  3 ++-
> >  kernel/rcu/srcutree.c    | 57 ++++++++++++++++++----------------------
> >  kernel/rcu/tree.c        |  4 ---
> >  kernel/rcu/tree.h        |  8 ------
> >  4 files changed, 27 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 6f292bd3e7db7..0faa978c98807 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -45,7 +45,8 @@ struct srcu_data {
> >  	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
> >  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
> >  	bool srcu_cblist_invoking;		/* Invoking these CBs? */
> > -	struct delayed_work work;		/* Context for CB invoking. */
> > +	struct timer_list delay_work;		/* Delay for CB invoking */
> > +	struct work_struct work;		/* Context for CB invoking. */
> >  	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
> >  	struct srcu_node *mynode;		/* Leaf srcu_node. */
> >  	unsigned long grpmask;			/* Mask for leaf srcu_node */
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 3600d88d8956b..7f041f2435df9 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -58,6 +58,7 @@ static bool __read_mostly srcu_init_done;
> >  static void srcu_invoke_callbacks(struct work_struct *work);
> >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long del=
ay);
> >  static void process_srcu(struct work_struct *work);
> > +static void srcu_delay_timer(struct timer_list *t);
> > =20
> >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_no=
de(). */
> >  #define spin_lock_rcu_node(p)					\
> > @@ -156,7 +157,8 @@ static void init_srcu_struct_nodes(struct srcu_stru=
ct *ssp, bool is_static)
> >  			snp->grphi =3D cpu;
> >  		}
> >  		sdp->cpu =3D cpu;
> > -		INIT_DELAYED_WORK(&sdp->work, srcu_invoke_callbacks);
> > +		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> > +		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> >  		sdp->ssp =3D ssp;
> >  		sdp->grpmask =3D 1 << (cpu - sdp->mynode->grplo);
> >  		if (is_static)
> > @@ -386,13 +388,19 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp=
, bool quiesced)
> >  	} else {
> >  		flush_delayed_work(&ssp->work);
> >  	}
> > -	for_each_possible_cpu(cpu)
> > +	for_each_possible_cpu(cpu) {
> > +		struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> > +
> >  		if (quiesced) {
> > -			if (WARN_ON(delayed_work_pending(&per_cpu_ptr(ssp->sda, cpu)->work)=
))
> > +			if (WARN_ON(timer_pending(&sdp->delay_work)))
> > +				return; /* Just leak it! */
> > +			if (WARN_ON(work_pending(&sdp->work)))
> >  				return; /* Just leak it! */
> >  		} else {
> > -			flush_delayed_work(&per_cpu_ptr(ssp->sda, cpu)->work);
> > +			del_timer_sync(&sdp->delay_work);
> > +			flush_work(&sdp->work);
> >  		}
> > +	}
> >  	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) !=3D SRCU_STAT=
E_IDLE) ||
> >  	    WARN_ON(srcu_readers_active(ssp))) {
> >  		pr_info("%s: Active srcu_struct %p state: %d\n",
> > @@ -463,39 +471,23 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> >  	WARN_ON_ONCE(state !=3D SRCU_STATE_SCAN1);
> >  }
> > =20
> > -/*
> > - * Track online CPUs to guide callback workqueue placement.
> > - */
> > -DEFINE_PER_CPU(bool, srcu_online);
> > =20
> > -void srcu_online_cpu(unsigned int cpu)
> > +static void srcu_delay_timer(struct timer_list *t)
> >  {
> > -	WRITE_ONCE(per_cpu(srcu_online, cpu), true);
> > +	struct srcu_data *sdp =3D container_of(t, struct srcu_data, delay_wor=
k);
> > +
> > +	queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> >  }
> > =20
> > -void srcu_offline_cpu(unsigned int cpu)
> > -{
> > -	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
> > -}
> > -
> > -/*
> > - * Place the workqueue handler on the specified CPU if online, otherwi=
se
> > - * just run it whereever.  This is useful for placing workqueue handle=
rs
> > - * that are to invoke the specified CPU's callbacks.
> > - */
> > -static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struc=
t *wq,
> > -				       struct delayed_work *dwork,
> > +static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
> >  				       unsigned long delay)
> >  {
> > -	bool ret;
> > +	if (!delay) {
> > +		queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> > +		return;
> > +	}
> > =20
> > -	preempt_disable();
> > -	if (READ_ONCE(per_cpu(srcu_online, cpu)))
> > -		ret =3D queue_delayed_work_on(cpu, wq, dwork, delay);
> > -	else
> > -		ret =3D queue_delayed_work(wq, dwork, delay);
> > -	preempt_enable();
>=20
> The deleted code looks like 'cpu' could be offlined.
>=20
> Question for my clarification: According to sync_rcu_exp_select_cpus, we =
have
> to disable preemption before calling queue_work_on to ensure the CPU is o=
nline.
>=20
> Also same is said in Boqun's presentation on the topic:
> https://linuxplumbersconf.org/event/2/contributions/158/attachments/68/79=
/workqueue_and_cpu_hotplug.pdf
>=20
> Calling queue_work_on on an offline CPU sounds like could be problematic.=
 So
> in your patch, don't you still need to disable preemption around
> queue_work_on, or the very least check if said CPU is online before calli=
ng
> queue_work_on?
>=20

I should be the one who answers this ;-)

So I found something after my LPC topic, that is queue_work_on() may
work well even if racing with a cpu offline. The reason is that in the
cpu offline hook for workqueue only switches the percpu pool into an
unbound one, so as long as the related cpu has been online once, we are
fine here.=20

Please note this is only my own analysis, and I'm the one who told
Sebastian and Paul about this.

I should send an email to check with workqueue maintainers about this,
but I didn't find the time. Sorry about this.. But let's do this right
now, while we at it.

(Cc TJ)

So Jiangshan and TJ, what's your opion on this one? If we call a
queue_work_on() at a place where that target cpu may be offlined, I
think we have the guarantee that the work will be eventually executed
even if the cpu is never online again, right? In other words, if a cpu
has been online once, queue_work_on() on it will be free from racing
with cpu hotplug.

Am I right about this, or did I miss something subtle?

Regards,
Boqun

> thanks,
>=20
>  - Joel
>=20

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlwRFZsACgkQSXnow7UH
+rh9uwgAqeWqH4zTtAA2l88U24oOOhuSgvxMD7CXKdDQUHkT+NPJa3z1u7r7xNBt
uOwz8t5JOhMBFTAB0HavRLSUogotFHzTkau0OmDrVGNFbIKj1fTkssvhASxb6vJu
8yIleDexwFzmed1ZJQHEq2JpC2cs0CkH1peGtg6HqGC59nJ2PihO9WblaJbces2e
KbTD59BnBlE7+6qKJJLf0Ws8Lhziyd1r7DQj7pPHCdHDzGkSDD8Ekd+44TqA8dMa
ZeCAbjmetLkvXIyu+yU5RZVhcCyIKnHn0zzUoRyQoy+m3Q4wNSXSX51JKB++8agF
h71iq/TuqEewzTqiWNX7zVmbjcF4gg==
=5UVe
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
