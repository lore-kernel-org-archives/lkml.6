Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2771586-1526396586-2-14250222492358806123
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
    1526396585; b=EM498NVQ8ZGVFGa6iyshtR7Drx82u7P57iCDd3//m+jlMdT3gJ
    2CQzzuhsciUwUviKg+/WmwnanOma40jW4PNwgN0Kg1qxZaqZpcKkVP5UWWcE2UxX
    l6sXT+MNw+PcY2OUQxJvmn/FjWfVhy0i48pNlJvifnjUzACHrWB+z4Ckv+NPTGxT
    hS8m0NaidQTnPr7/LnqsMN+f9+LaHXB0LSjQsMGuxq1jqB1NntJaf4bQ7C6MSosn
    ljOLa62o78aWEX+SFOvi3Ov8a34VQx+dCjzTlgJpZYVJZk6M/x9UBTuGpa/5uqxW
    MQx6wSjh+nINDGP6/DTSvIk9gPrrOm69wupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526396585; bh=vKHfr
    SBJxk7smYKokNqk7mRz/Swz199pVWTxcyvlXZM=; b=H4qPZiM/xYC2ayGqxaLUH
    Xe3P6Ne/yqxltR/iUVoaB4pwS/jeMgwn0IhGxUkRn2L39Jxv5qYPO4UdwQl7idzo
    3G0wFH0/K2ZaebplozSRqfBykM/Y3/7A/Znw8I6F9DDixo05KSM/RAGzjCwJf5ML
    3ocxE9PJvnFTNbu6BP6+MBfwpNma/sw9A3OCCqAqVXIbkH4CUz/uQy7iKa0eXLTF
    45LqqErtPA4r7e5w/pphuQ8n+NSf0g41LxwFAxl4vdFcDK1SZL0UIGygROyKOo61
    j8Tt1qL+na8tJYqxS2zQSW/Txi0X7wBLPzOzUXQSSOSB1mYkYT/CNloxd2z6Fj0K
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=uKJ2OL4X
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=uKJ2OL4X
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
X-CM-Envelope: MS4wfK9rTI3adXcFmUXUviTod3JtCR0QcEMtUIp9zdZs+NXXYN/9mn4u1C9DIfs8NE10sAegkLWdJXudQ6ccnH8dV4AxWNbPspx9E+4VmTduZ4BLIN3JWpjU
    6U6A7qzzj/g93TCQySIHamPur6IM+pG+y0GJYacSY0SsYifIqmlWIxxuImfCyKYaAkG5/RhNaTA3d8//U1NYTKVSqNIP2HgJcj7ARXgL6Q8WA8J1TqGCnWYf
    KowrckxSumqLf7Ojo08rkg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=DEsP1X_c2mRDtOHw8bYA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Tue, 15 May 2018 16:02:55 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
In-Reply-To: <20180508114500.qrtnjax4siupgv3n@mwanda>
Message-ID: <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <20180508114500.qrtnjax4siupgv3n@mwanda>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180515_160255_336397_98E7E5CF 
X-CRM114-Status: GOOD (  19.34  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
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


> >  	/*
> >  	 * Allocate new object. This may result in rather complicated
> >  	 * operations, including fld queries, inode loading, etc.
> >  	 */
> >  	o = lu_object_alloc(env, dev, f, conf);
> > -	if (IS_ERR(o))
> > +	if (unlikely(IS_ERR(o)))
> >  		return o;
> >  
> 
> This is an unrelated and totally pointless.  likely/unlikely annotations
> hurt readability, and they should only be added if it's something which
> is going to show up in benchmarking.  lu_object_alloc() is already too
> slow for the unlikely() to make a difference and anyway IS_ERR() has an
> unlikely built in so it's duplicative...

Sounds like a good checkpatch case to test for :-) Some people like to try
and milk ever cycle they can. Personally for me I never use those 
annotations. With modern processors I'm skeptical if their benefits.
I do cleanup up the patches to some extent to make it compliant with 
kernel standards but leave the core code in place for people to comment 
on.

> Anyway, I understand that Intel has been ignoring kernel.org instead of
> sending forwarding their patches properly so you're doing a difficult
> and thankless job...  Thanks for that.  I'm sure it's frustrating to
> look at these patches for you as well.

Thank you for the complement. Also thank you for taking time to review
these patches. Your feedback is most welcomed and benefitical to the
health of the lustre client.

Sadly its not just Intel but other vendors that don't directly contribute
to the linux lustre client. I have spoke to the vendors about contributing 
and they all say the same thing. No working with drivers in the staging 
tree. Sadly all the parties involved are very interested in the success 
of the lustre client. No one has ever told me directly why they don't get
involved but I suspect it has to deal with 2 reasons. One is that staging
drivers are not normally enabled by distributions so their clients 
normally will never deal with the staging lustre client. Secondly vendors
just lack the man power to contribute in a meanful way.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
