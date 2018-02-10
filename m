Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-796730-1518300880-6-4051023335601700278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518300880; b=wi1uDZAhLLzMdPBvBcrUkeCHCubv3PRQZhe6RFb9YGItmou
    eUIr/xsVp/d58YeyhgsoCal5JuqAB6iFwG06nPOx0EcnLRkryjBcji+Ctsi6I7lu
    mJ5bDPVgbhwl9pKW4dI8QyfUKsjW4SHlBN5LzhcgAvfu6oozfPssXUl4N3h1gywO
    rW5YOz4ItiAmxpgLAp56zqpOt4vPUnELMAgYdNU7adqiyrXSlJny6Ig1jME9Imo/
    bMod4CzQwjXMZyeV7Yf1D1ZwmjDqwuxicwl0ObPoARC/FNxzjY0cjOaRhu7ytl4d
    6H2a/Wmzo0mpRQE8k3kgIGtXvWcBI6xNMmwAWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518300880; bh=B
    LkEvFMJJTEPasOuGRR+bEn6VxJyAX72JhOI2TMjc+U=; b=Qz63Grn4snbNogWVu
    ifY1Tx2DbndeDgP89prp8UeAOkj5ElXzHDVIGNqzaKVhjBuERlAiS9yFGKvS0C/A
    85qyi1mEz5UWEUP/6lTfrL+N/0jc5ajE8oIstyyxtwnCM/u8LZcoXAZxMPqbhgg8
    4ASi5SvY4D4aZB9nCltPFt7T//iFkCVEK2VQlAdyKfE9KCDi+LUD5ldCmnXqcsDN
    NoCIQFr1H6a4cdVzch+A3rZs2rTqB+/aQgfAslYTJcPCIQ0CFyDButKpjIP/YYsj
    lDYeJDKLFkPOz4EtXlJd4GfFtisci7o67MOXXJS3eWoc9O/k2ag78PCU+BCbuLbB
    kIiNA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FFtuk3qQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FFtuk3qQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Sat, 10 Feb 2018 22:14:19 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 41/80] staging: lustre: lmv: separate master object with
 master stripe
In-Reply-To: <87r2pvkkl5.fsf@notabene.neil.brown.name>
Message-ID: <alpine.LFD.2.21.1802102108430.5700@casper.infradead.org>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180210_221419_917863_32576BAC 
X-CRM114-Status: GOOD (  44.88  )
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, wang di <di.wang@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> > +static inline bool
> > +lsm_md_eq(const struct lmv_stripe_md *lsm1, const struct lmv_stripe_md *lsm2)
> > +{
> > +	int idx;
> > +
> > +	if (lsm1->lsm_md_magic != lsm2->lsm_md_magic ||
> > +	    lsm1->lsm_md_stripe_count != lsm2->lsm_md_stripe_count ||
> > +	    lsm1->lsm_md_master_mdt_index != lsm2->lsm_md_master_mdt_index ||
> > +	    lsm1->lsm_md_hash_type != lsm2->lsm_md_hash_type ||
> > +	    lsm1->lsm_md_layout_version != lsm2->lsm_md_layout_version ||
> > +	    !strcmp(lsm1->lsm_md_pool_name, lsm2->lsm_md_pool_name))
> > +		return false;
> 
> Hi James and all,
>  This patch (8f18c8a48b736c2f in linux) is different from the
>  corresponding patch in lustre-release (60e07b972114df).
> 
> In that patch, the last clause in the 'if' condition is
> 
> +           strcmp(lsm1->lsm_md_pool_name,
> +                     lsm2->lsm_md_pool_name) != 0)
> 
> Whoever converted it to "!strcmp()" inverted the condition.  This is a
> perfect example of why I absolutely *loathe* the "!strcmp()" construct!!
> 
> This causes many tests in the 'sanity' test suite to return
> -ENOMEM (that had me puzzled for a while!!).
> This seems to suggest that no-one has been testing the mainline linux
> lustre.
> It also seems to suggest that there is a good chance that there
> are other bugs that have crept in while no-one has really been caring.
> Given that the sanity test suite doesn't complete for me, but just
> hangs (in test_27z I think), that seems particularly likely.
> 
> 
> So my real question - to anyone interested in lustre for mainline linux
> - is: can we actually trust this code at all?
> I'm seriously tempted to suggest that we just
>   rm -r drivers/staging/lustre
> 
> drivers/staging is great for letting the community work on code that has
> been "thrown over the wall" and is not openly developed elsewhere, but
> that is not the case for lustre.  lustre has (or seems to have) an open
> development process.  Having on-going development happen both there and
> in drivers/staging seems a waste of resources.
> 
> Might it make sense to instead start cleaning up the code in
> lustre-release so as to make it meet the upstream kernel standards.
> Then when the time is right, the kernel code can be moved *out* of
> lustre-release and *in* to linux.  Then development can continue in
> Linux (just like it does with other Linux filesystems).
> 
> An added bonus of this is that there is an obvious path to getting
> server support in mainline Linux.  The current situation of client-only
> support seems weird given how interdependent the two are.
> 
> What do others think?  Is there any chance that the current lustre in
> Linux will ever be more than a poor second-cousin to the external
> lustre-release.  If there isn't, should we just discard it now and move
> on?

If you think that the OpenSFS/Intel branch (lustre-release) is the land
of milk and honey you are very wrong. Take for example the UAPI header
cleanup I push to the linux client several months ago. That work took
5 years to complete. I had to complete that work in the Intel branch
since it impacted our tools. This isn't the only example. I worked along
side Intel for increasing striping of a file to more then the 160 stripe
limit Lustre use to have. That work took 3 years to complete. If the
patch is more than one line it will normally take 1 to 2 months to land.
It is common to have patches 6 months or more in age.

This is one of the major reasons I'm involved in the upstream client
work. If lustre remains a tiny under manned community it is doomed to
remain a niche file system. For years I have tried to recruit new
developers to help out and even gave talks at lustre conferences on
internals. That effort was meet with little success. This is not the
case with the linux lustre client. We do have people contributing
including you. So the reality is that if we removed the lustre client
it would be at least 3+ years before the code would be ready to merged
back in. It would be another 3+ years before it left staging. Many
cleanups in the linux client which impact many lines of code have not
been ported to the Intel branch. It would take forever to get those in.
Honestly I gave up some time ago for those types of cleanups. The cleanups
done in the upstream client would have to be redone. What we really
need is to expand the community. Recently a lot of work has gone into
supporting Ubuntu for our utilities. I hope this helps to get Canonical
involved with the upstream lustre client.

The upstream client is not as bad as you think. A year ago no one in
their right mind would touch the upstream client but their are actually
sites using it today. Its not perfect but it is usable and it is improving
all the time. Yes we have quite a few bugs to squash that show up in
our test suite but the barrier to leaving staging is much much smaller
than it used to be. Once the number of bugs reported in test suite
becomes reasonable we can start auto testing patches posted here. The
ultimate goal is that as more people join in the linux client effort
and it becomes a full member of the broader linux open source community
that we can leave the Intel lustre-release branch in the dust. I believe
the future is much closer than you think.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
