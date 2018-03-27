Return-Path: <SRS0=cdMa=GR=redhat.com=jglisse@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4156032-1522167174-2-17625996216557770435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=cdMa=GR=redhat.com=jglisse@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167174; b=fX+GfC+baAJhEdtY++Jg7zUXVEyEK41wrlsJnrdHLrtZlQ0
    WmaZaEXycSAvTpfRB0UNcXWfewQnZlHFF6S2G5utQQ9W3YucTt3Hv0UZID6EwY8z
    /UL0YZkQlo/u3WCLcb4TKELXsum7tyFnam5ZMregHMZQdfj2jFZg5yoSHqrfTbw6
    BNa7cjee09igx9Cx0cFwF4+7/tjzY8CU9YAbPM1yug7Bbi5Lg+1mix4GMycfVyNe
    e1hxvh4h1KprcsP1DJOHk22f9EsnYuitNpspkXec+N9AVI8bI1lpxEf5Aaa0619t
    vzpDQjlmg4kC3eqiSAjM75/iqbdRvZyWyFLtMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to; s=arctest; t=1522167174; bh=ecQz39AvgtpKZje9EHBI3+
    tyVf8tfWbxHMsi8ubGQdo=; b=R8kXqDRZmxM+233YuM4SJmttkf2vOK20aRo8EF
    DOIRc1Em5YXEvrZxEv0TvxxIlLKbPZcTD8/xhtqjumAi/uf4LHbvj+Xw0vS+9kxR
    0kMme4WdjNayicELiNmfiHM4mVGJx7dVUzjm4/f1dtZxZ7DCeteZ2AhaF9B6W8W4
    RSevS8C00LbAifgtMob1TTsdVXrRgkPzAv5boyYJa08hpPKUKhBWpBF3DWdCumUJ
    L7bgF0uFzWBeSQWkBvqxizaWaxNvkLH4yZ7nAUpe8IuEtoq9l/YJaiaSlgkUYz2W
    UZYoDF7KZuCiRxxplYhh31qdUffFEuDvvAS8oaHB1Hx/Mciw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=cdMa=GR=redhat.com=jglisse@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=cdMa=GR=redhat.com=jglisse@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEyrnuBsOaEeBm3EViyzxOoySnmF1bnaP5htkGdIRej3K69TypnbOGY4vT6Lx9oC14C2Y+ERtTmt15JqK9z3wK8AnEpB7nga05lj1VhglvKqFCl4UVLR
    wTmcrkrWVBQqDUmetlzFyiWOAFEuUgy5edf2vo1iVGh/cz8E3nqqLiIlE2o82ekg7QXL4xX4420Czu6WoXIAU82AYdXQBlOuNn0=
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=8nJEP1OIZ-IA:10 a=v2DPQv5-lfwA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=37rDS-QxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=7TDwivaskCKpqI-U4X4A:9 a=wPNLvfGTeEIA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=k1Nq6YrhK2t884LQW06G:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBC3217A8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jglisse@redhat.com
Date: Tue, 27 Mar 2018 12:12:45 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com,
	linux-mm@kvack.org, torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Subject: Re: [PATCH 4/8] HMM: Remove superflous RCU protection around radix
 tree lookup
Message-ID: <20180327161244.GA4251@redhat.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-4-tj@kernel.org>
 <20180326145431.GC1840639@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180326145431.GC1840639@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 07:54:31AM -0700, Tejun Heo wrote:
> Hello, Andrew.
> 
> Do you mind picking up the following patch?  I can't find a good tree
> to route this through.  The raw patch can be found at
> 
>   https://marc.info/?l=linux-mm&m=152105674112496&q=raw
> 
> Thank you very much.

I am fine with which ever route there is low probability of conflict
when merging HMM through different tree.


> 
> On Wed, Mar 14, 2018 at 12:45:11PM -0700, Tejun Heo wrote:
> > hmm_devmem_find() requires rcu_read_lock_held() but there's nothing
> > which actually uses the RCU protection.  The only caller is
> > hmm_devmem_pages_create() which already grabs the mutex and does
> > superflous rcu_read_lock/unlock() around the function.
> > 
> > This doesn't add anything and just adds to confusion.  Remove the RCU
> > protection and open-code the radix tree lookup.  If this needs to
> > become more sophisticated in the future, let's add them back when
> > necessary.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
> > Hello,
> > 
> > Jérôme, how do you want to route this patch?  If you prefer, I can
> > route it together with other patches.
> > 
> > Thanks.
> > 
> >  mm/hmm.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 320545b98..d4627c5 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -845,13 +845,6 @@ static void hmm_devmem_release(struct device *dev, void *data)
> >  	hmm_devmem_radix_release(resource);
> >  }
> >  
> > -static struct hmm_devmem *hmm_devmem_find(resource_size_t phys)
> > -{
> > -	WARN_ON_ONCE(!rcu_read_lock_held());
> > -
> > -	return radix_tree_lookup(&hmm_devmem_radix, phys >> PA_SECTION_SHIFT);
> > -}
> > -
> >  static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
> >  {
> >  	resource_size_t key, align_start, align_size, align_end;
> > @@ -892,9 +885,8 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
> >  	for (key = align_start; key <= align_end; key += PA_SECTION_SIZE) {
> >  		struct hmm_devmem *dup;
> >  
> > -		rcu_read_lock();
> > -		dup = hmm_devmem_find(key);
> > -		rcu_read_unlock();
> > +		dup = radix_tree_lookup(&hmm_devmem_radix,
> > +					key >> PA_SECTION_SHIFT);
> >  		if (dup) {
> >  			dev_err(device, "%s: collides with mapping for %s\n",
> >  				__func__, dev_name(dup->device));
> > -- 
> > 2.9.5
> > 
> 
> -- 
> tejun
