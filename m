Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB287C71134
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C6B2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O36urTsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C6B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeJOXM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:12:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37053 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:12:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so21889772qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/sEKHv4VcnQHFk/MM1gVcgLibNiDzLfHDD/o3V9rBM=;
        b=O36urTskoOYlGdClPcSJLyazt3tBhECsjV9DA+VXyc5xT+Cp4mjHfU9ULVBuxD08nd
         ZzA27ENIQmdo9MwLmSrfHiGVdpsBYp5/ZUjFSmQmPYU13Yx7AyMkfKXLdVKclrNi/ugO
         g5RyAC7R1Pxo4QL+PGXQi6jtGbJLvx/ci6jvrQOyR00MxdwLAE5JbN6ieU/iduYw+k+r
         RiZfAjhpP+jwU8mamfV7I6AOweLB/Agez6X0ESK9euHaJej9KH9CktvPmoIeqrW+nRp7
         yPFTB+syQeY5pebH4nWm//6fS4VpZB/iLtmLJxOqzfXXmKyL4YKrxTh7FxP/8l88l1Pj
         tiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/sEKHv4VcnQHFk/MM1gVcgLibNiDzLfHDD/o3V9rBM=;
        b=Y1nO7MJbiyRT5vG6R2OkDK0X7zFqM5krp4d+npal4/CTbDNg4iBe7nZfutG2MrHCLk
         aWb6t4w5PgLTkrDl9uN3IxFZN15x9p+i7qFEhJbdkEDwaXPVzacafnxODnK+z6JwUdAr
         WNqA0JhtObivgj96orju/lCQLPog4vjNgqH77cB5348hc9LWbfqZUw8qb7ZkyVLAUM+D
         V9BzqYqnEMO6ni3svFQuvH/NdJr42BLp/20Z86+tuv/nRQWb6xWLxtmaC1AvwxspddOa
         7CBml/86kVOBIFGkAG0Ty/DBh+7rpyCVyLr1J7Gf7qXjSRmvreS6BsoowFpdzQX4nUPv
         V8PQ==
X-Gm-Message-State: ABuFfojqsRQCB3Ozdd4lewaYaezMfNdXj82zclVF10x6++LLZhBqbnB0
        rNgCXxB46JqrqaROfIz7gKg=
X-Google-Smtp-Source: ACcGV621LuAjoLgn7ko0Rgj7Wb1tqvl94K/M0tE6hJkImO2LKmbnt2eSaKwI+fwRHUCvV0avijy4SA==
X-Received: by 2002:a0c:81e4:: with SMTP id 33mr17694621qve.135.1539617231887;
        Mon, 15 Oct 2018 08:27:11 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g39-v6sm7643690qtc.89.2018.10.15.08.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:27:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8F43720B71;
        Mon, 15 Oct 2018 11:27:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 15 Oct 2018 11:27:10 -0400
X-ME-Sender: <xms:zbHEW5E55NnbP1RKSlIh8jNqK9sZwcoz_P_smP5EBTjCNunqW5CffQ>
X-ME-Proxy: <xmx:zbHEW6awax3sysf-O3X66iO0nN0VeAFnyi0nIwzilxjHRprqJ0W7Kw>
    <xmx:zbHEW06yjsz_yB3EpMa9ylES40vlzbj9lPtULcEy2pARoh-K6yt39Q>
    <xmx:zbHEW7AVgNpCmrs3oKRMPQf517qsGfR6au5iWfrGZh9k5DjP88yv_Q>
    <xmx:zbHEW6tl9gleTroaDIpwU-AwawKMiU2wlG_V7jz7O4kmDLgOOSPQ6w>
    <xmx:zbHEWwvNkp4xloHaa_dbMVmuQbdJk8vln3cifqHi6ayPF8OAoxh2bg>
    <xmx:zrHEW2t690CSptzvgv-2_JxUjWC0_uenOJtr1MuayEgmjzqGykUOLg>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14BB9E455F;
        Mon, 15 Oct 2018 11:27:09 -0400 (EDT)
Date:   Mon, 15 Oct 2018 23:33:48 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20181015153348.GB8952@tardis>
References: <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
 <20181012184114.w332lnkc34evd4sm@linutronix.de>
 <20181013134813.GD2674@linux.ibm.com>
 <20181015144217.nu5cp5mxlboyjbre@linutronix.de>
 <20181015150715.GA2422@tardis>
 <20181015150902.asifwhikqkz53ai4@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20181015150902.asifwhikqkz53ai4@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 05:09:03PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-10-15 23:07:15 [+0800], Boqun Feng wrote:
> > Hi, Sebastian
> Hi Boqun,
>=20
> > On Mon, Oct 15, 2018 at 04:42:17PM +0200, Sebastian Andrzej Siewior wro=
te:
> > > On 2018-10-13 06:48:13 [-0700], Paul E. McKenney wrote:
> > > >=20
> > > > My concern would be that it would queue it by default for the curre=
nt
> > > > CPU, which would serialize the processing, losing the concurrency of
> > > > grace-period initialization.  But that was a long time ago, and per=
haps
> > > > workqueues have changed.=20
> > >=20
> > > but the code here is always using the first CPU of a NUMA node or did=
 I
> > > miss something?
> > >=20
> >=20
> > The thing is the original way is to pick one CPU for a *RCU* node to
> > run the grace-period work, but with your proposal, if a RCU node is
> > smaller than a NUMA node (having fewer CPUs), we could end up having two
> > grace-period works running on one CPU. I think that's Paul's concern.
>=20
> Ah. Okay. From what I observed, the RCU nodes and NUMA nodes were 1:1
> here. Noted.

Ok, in that case, there should be no significant performance difference.

> Given that I can enqueue a work item on an offlined CPU I don't see why
> commit fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being
> offline") should make a difference. Any objections to just revert it?

Well, that commit is trying to avoid queue a work on an offlined CPU,
because according to workqueue API, it's the users' responsibility to
make sure the CPU is online when a work item enqueued. So there is a
difference ;-)

But I don't have any objection to revert it with your proposal, since
yours is more simple and straight-forward, and doesn't perform worse if
NUMA nodes and RCU nodes have one-to-one corresponding.

Besides, I think even if we observe some performance difference in the
future, the best way to solve that is to make workqueue have a more
fine-grained affine group than a NUMA node.

Regards,
Boqun

>=20
> > Regards,
> > Boqun
>=20
> Sebastian

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlvEs1gACgkQSXnow7UH
+riLhQgAl8b5Ic5ilwWUpkxrUEhRfcUDSSmpzzAdJEbueKFQAaLH1wp5Gi1M6QzL
u7Klz03o4zpYcBnEXzaeZrewywkmbsPOi3/NGoxOV8vRdVl52XwyctqBUvL37UVp
4DGJxmnw2bwxVPa74n94LE72hdS1p6yCU7TKHQ9D57Q1qDHE16x4cQC/zlA62hlT
vzUjyo61tV4gcngVQBao72EuIPNHRkbEktbJ9e8D/lcWIQEu1MXx2eQUeTDFGoKl
sElQRxL5o+lUXztfuNVQ7RXY+e+kBUWZKyaa5hqFvSBj55OJBGN/2sGtvt0pAxW2
+FHaV9yWRKkMZmSNsDh8GVxqnaih7Q==
=MozF
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
