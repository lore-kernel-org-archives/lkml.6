Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1677195-1526344655-2-10931124658366763576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526344654; b=VBDiWdn61udDe/6iIKWVPhB5GitDRg1GpUIQCenpKjOQoBbCn+
    ujL0QTGrvFtLP+0WIKpdTQghByhRM4vrjdkY8nDR4xOPRkXW5JQNpReGmUerqRzY
    YTHGmyyNZWrmI+aX01HSWsCM9OCfCeXKVN+ad5DSLxlBFCOWjxHLdmRlG2AngXYh
    zS/da3vFS1W4DSy/W9+Gjj2TaSNBg6wznebeh0SfjKPpYzUXmGEeHByqGpsdcma0
    Fgg1HrsmihaLgiYu9Zf3RW6bB5RYAM4WnrYHDBzWwze8z4t8gLR0gZNPmBeeC0LL
    MbbaHRrg4psgUFGbDXXqyp07xPRkCLnvEjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526344654; bh=SKLEo
    ze9rPMqcg5RDSzACXX1d/xwTrOGp30tngPEW8Y=; b=bUKjVoBnu6gDfAyjwkEyI
    Ljni8/unnfq7b4I0TPMo35ylnYxnbIzYRSN7d/cqA73GB110+FZkGvlqmJTlgQXo
    MwoTRdoz96suCUOHJkUmK9YeBAvIFsS7fjACOU5/Unkq0gW/OkbYNFSlSgGZZAVu
    38urmCQ+fef5QjFVTtOorwK3vi5qur5qAwZPzBvyFKXnTdMawiyea9lhdMwAjWcs
    N6phEdRuBHikWqBsoZ+SPrg7LSKV4fFISlqf9EBtbrw5ObXXPW8QSKwrcjD21xZV
    f9pmjFXHqxafiuAfcZTC+Byz+7yd483nclP4Zj0L6+ZzeRBnhnNZF0EX6SMzTUzg
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=PoFxmlXV
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=PoFxmlXV
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLi6iOGFEKn6h70Um9M1Puj+eTgykrjUGy/EGPznFFvGve07VTxm3kvIaTDj2L3UBwpSPoB6xgYJCHjIGz71olwq/2aWDiO1H1Hpg0Oq3NJVGEJC7Vz8
    nNNytEHhB13G2nLee0OGZlB4H+LhgkOkF+JPI5YpQ6TFsZ3Jk2Cq/4+RsNZmZJNCx+3yhgxqmJ2T7GYZlndFrUs/WGOS8cYH2hDwouQz9YEhpI6YE43yJK0a
    rbNPgh25a2I/dPGQU4sG6w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=T7yZBW7l8NnMJ1FWK9oA:9 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Tue, 15 May 2018 01:37:07 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
In-Reply-To: <876044fcgg.fsf@notabene.neil.brown.name>
Message-ID: <alpine.LFD.2.21.1805150133430.576@casper.infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <876044fcgg.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180515_013709_741458_6AB502B1 
X-CRM114-Status: GOOD (  35.39  )
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
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Wed, May 02 2018, James Simmons wrote:
> 
> > From: Lai Siyao <lai.siyao@intel.com>
> >
> > Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
> > to remove object from cache, but this may lead to deadlock, because
> > when other process lookup such object, it needs to wait for this
> > object until release (done at last refcount put), while that process
> > maybe already hold an LDLM lock.
> >
> > Now that current code can handle dying object correctly, we can just
> > return such object in lookup, thus the above deadlock can be avoided.
> 
> I think one of the reasons that I didn't apply this to mainline myself
> is that "Now that" comment.  When is the "now" that it is referring to?
> Are were sure that all code in mainline "can handle dying objects
> correctly"??

So I talked to Lai and he posted the LU-9049 ticket what patches need to
land before this one. Only one patch is of concern and its for LU-9203
which doesn't apply to the staging tree since we don't have the LNet SMP
updates in our tree. I saved notes about making sure LU-9203 lands 
together with the future LNet SMP changes. As it stands it is safe to
land to staging.
 
> > Signed-off-by: Lai Siyao <lai.siyao@intel.com>
> > Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9049
> > Reviewed-on: https://review.whamcloud.com/26965
> > Reviewed-by: Alex Zhuravlev <alexey.zhuravlev@intel.com>
> > Tested-by: Cliff White <cliff.white@intel.com>
> > Reviewed-by: Fan Yong <fan.yong@intel.com>
> > Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> > Signed-off-by: James Simmons <jsimmons@infradead.org>
> > ---
> >  drivers/staging/lustre/lustre/include/lu_object.h  |  2 +-
> >  drivers/staging/lustre/lustre/obdclass/lu_object.c | 82 +++++++++-------------
> >  2 files changed, 36 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/staging/lustre/lustre/include/lu_object.h
> > index f29bbca..232063a 100644
> > --- a/drivers/staging/lustre/lustre/include/lu_object.h
> > +++ b/drivers/staging/lustre/lustre/include/lu_object.h
> > @@ -673,7 +673,7 @@ static inline void lu_object_get(struct lu_object *o)
> >  }
> >  
> >  /**
> > - * Return true of object will not be cached after last reference to it is
> > + * Return true if object will not be cached after last reference to it is
> >   * released.
> >   */
> >  static inline int lu_object_is_dying(const struct lu_object_header *h)
> > diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> > index 8b507f1..9311703 100644
> > --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> > +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> > @@ -589,19 +589,13 @@ static struct lu_object *htable_lookup(struct lu_site *s,
> >  				       const struct lu_fid *f,
> >  				       __u64 *version)
> >  {
> > -	struct cfs_hash		*hs = s->ls_obj_hash;
> >  	struct lu_site_bkt_data *bkt;
> >  	struct lu_object_header *h;
> >  	struct hlist_node	*hnode;
> > -	__u64 ver;
> > -	wait_queue_entry_t waiter;
> > +	u64 ver = cfs_hash_bd_version_get(bd);
> >  
> > -retry:
> > -	ver = cfs_hash_bd_version_get(bd);
> > -
> > -	if (*version == ver) {
> > +	if (*version == ver)
> >  		return ERR_PTR(-ENOENT);
> > -	}
> >  
> >  	*version = ver;
> >  	bkt = cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
> > @@ -615,31 +609,13 @@ static struct lu_object *htable_lookup(struct lu_site *s,
> >  	}
> >  
> >  	h = container_of(hnode, struct lu_object_header, loh_hash);
> > -	if (likely(!lu_object_is_dying(h))) {
> > -		cfs_hash_get(s->ls_obj_hash, hnode);
> > -		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> > -		if (!list_empty(&h->loh_lru)) {
> > -			list_del_init(&h->loh_lru);
> > -			percpu_counter_dec(&s->ls_lru_len_counter);
> > -		}
> > -		return lu_object_top(h);
> > +	cfs_hash_get(s->ls_obj_hash, hnode);
> > +	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> > +	if (!list_empty(&h->loh_lru)) {
> > +		list_del_init(&h->loh_lru);
> > +		percpu_counter_dec(&s->ls_lru_len_counter);
> >  	}
> > -
> > -	/*
> > -	 * Lookup found an object being destroyed this object cannot be
> > -	 * returned (to assure that references to dying objects are eventually
> > -	 * drained), and moreover, lookup has to wait until object is freed.
> > -	 */
> > -
> > -	init_waitqueue_entry(&waiter, current);
> > -	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> > -	set_current_state(TASK_UNINTERRUPTIBLE);
> > -	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
> > -	cfs_hash_bd_unlock(hs, bd, 1);
> > -	schedule();
> > -	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> > -	cfs_hash_bd_lock(hs, bd, 1);
> > -	goto retry;
> > +	return lu_object_top(h);
> >  }
> >  
> >  /**
> > @@ -680,6 +656,8 @@ static void lu_object_limit(const struct lu_env *env, struct lu_device *dev)
> >  }
> >  
> >  /**
> > + * Core logic of lu_object_find*() functions.
> > + *
> >   * Much like lu_object_find(), but top level device of object is specifically
> >   * \a dev rather than top level device of the site. This interface allows
> >   * objects of different "stacking" to be created within the same site.
> > @@ -713,36 +691,46 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
> >  	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
> >  	 * just alloc and insert directly.
> >  	 *
> > +	 * If dying object is found during index search, add @waiter to the
> > +	 * site wait-queue and return ERR_PTR(-EAGAIN).
> 
> It seems odd to add this comment here, when it seems to describe code
> that is being removed.
> I can see that this comment is added by the upstream patch
> Commit: fa14bdf6b648 ("LU-9049 obdclass: change object lookup to no wait mode")
> but I cannot see what it refers to.
> 
> Otherwise that patch looks good.
> 
> Thanks,
> NeilBrown
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
