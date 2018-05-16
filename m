Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-595823-1526489863-2-9260906814054764470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526489862; b=WT6+eQ1zBRzKCVhW3egVw39XmyieYk+q2c1eWKaUXtonIDDPhQ
    inO2YDgNUysuJaQOE0p9H0XPn4ThRcqoo/GAvR+FAhtgoRoLaxXL9K0QffiFTM6V
    QE+Y5oJosW3F7vLLqu0jOu+1sYhGLGVhBSJUGP5WDJJxQ5UeXHS1m+jX/Rr689GY
    NhSId6brhrxsTS2Qlt+AjtuD3Fz40F8cTZN2j7xrDcNN7cNmzK+W/l0KBPfSVRg/
    i76c0j8dpTZbcsQ1GXX3YRmL68jxrT1aukZaIEgsEbImNmEsZpkO8gSITkhwrc+0
    GpVkYvztS8043zya8NLCbj/0Tkq4zp+IqCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526489862; bh=r2PUw
    xusxFBn+befpZKIw6T1qqrqeIOAWpYsevLYPOY=; b=VSfLYkSq8n5iBLF3xq09G
    JyRoze2W8qx3G/M0Zr6oQW7pTWbLrEHN/8wJDEK7/TTv/JZTvD1r74tUstkcJ9EB
    UiSXZws931dDM9qaU2lF/Z3io700/rxPyET7ZSn4pgdrIlxZhLRAVzZsFCWl/LU9
    QncF+iPQLAyOdUGzEb6eq4DKZUry6b1ZXfm81rvIPalxJh0vHMxtGpE2fv32g1++
    dbjadQG/f1W5QLHfQizY4fnz5IPnWpYNt5sFfemjoX/PqS+iP73/XsLXMuBsddyM
    cITVME86IgEDKS2Uk4FmPmcKk0t6XipFtPx6dCamAvOSRRzCiLJPgY/35P4HqbDy
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=uYVi+40a x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=uYVi+40a x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNp3Vnt43Ho2BHUphY2p71hZ5LRu7e3en0Hl2v6A+kRj6AFm+YheLqS0OWZf0Vg0EcWCZOK03s6gqrZ3WUZNbU+xr1mCW36pOhLSdL/nnnsq/iZG9Fxq
    okk/q65ul0Dak9bvrQTXNJQ+2odloY742uYNPXfmE5IemphrOFRuzfGiHoCHsUJ2S05Py7/en9sDlYrwrTbF4OjO4q9lTmrQJZNmRPgOE7WwCzKQ6I1PT5S0
    DHE9A7AVwas6Xly6/XWDCA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=BeBX0tkq6crnKNEYysEA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 16 May 2018 18:57:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
Message-ID: <20180516165719.GA28434@kroah.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <20180508114500.qrtnjax4siupgv3n@mwanda>
 <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
 NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 04:02:55PM +0100, James Simmons wrote:
> > >  	/*
> > >  	 * Allocate new object. This may result in rather complicated
> > >  	 * operations, including fld queries, inode loading, etc.
> > >  	 */
> > >  	o = lu_object_alloc(env, dev, f, conf);
> > > -	if (IS_ERR(o))
> > > +	if (unlikely(IS_ERR(o)))
> > >  		return o;
> > >  
> > 
> > This is an unrelated and totally pointless.  likely/unlikely annotations
> > hurt readability, and they should only be added if it's something which
> > is going to show up in benchmarking.  lu_object_alloc() is already too
> > slow for the unlikely() to make a difference and anyway IS_ERR() has an
> > unlikely built in so it's duplicative...
> 
> Sounds like a good checkpatch case to test for :-) Some people like to try
> and milk ever cycle they can. Personally for me I never use those 
> annotations. With modern processors I'm skeptical if their benefits.
> I do cleanup up the patches to some extent to make it compliant with 
> kernel standards but leave the core code in place for people to comment 
> on.
> 
> > Anyway, I understand that Intel has been ignoring kernel.org instead of
> > sending forwarding their patches properly so you're doing a difficult
> > and thankless job...  Thanks for that.  I'm sure it's frustrating to
> > look at these patches for you as well.
> 
> Thank you for the complement. Also thank you for taking time to review
> these patches. Your feedback is most welcomed and benefitical to the
> health of the lustre client.
> 
> Sadly its not just Intel but other vendors that don't directly contribute
> to the linux lustre client. I have spoke to the vendors about contributing 
> and they all say the same thing. No working with drivers in the staging 
> tree. Sadly all the parties involved are very interested in the success 
> of the lustre client. No one has ever told me directly why they don't get
> involved but I suspect it has to deal with 2 reasons. One is that staging
> drivers are not normally enabled by distributions so their clients 
> normally will never deal with the staging lustre client. Secondly vendors
> just lack the man power to contribute in a meanful way.

If staging is hurting you, why is it in staging at all?  Why not just
drop it, go off and spend a few months to clean up all the issues in
your own tree (with none of those pesky requirements of easy-to-review
patches) and then submit a "clean" filesystem for inclusion in the
"real" part of the kernel tree?

It doesn't sound like anyone is actually using this code in the tree
as-is, so why even keep it here?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
