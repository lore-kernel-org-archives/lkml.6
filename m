Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-171367-1518405685-2-14974429346761045005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518405684; b=VuGJ6mWrTdGiPH1TsjmXVsP+3jVd3WcOkfYvgivULZ8grAm
    wnH5IUY8JhIeNInwk9yOEzAyAwixFLLeUO55Imvlfq5vLSGfr4KvQ22d5ciVMDJH
    BUaBfeb13ssqJh3KfFXMx9dIjZd+cT2RzwlSgEhw/2h1bzMB+ufUCqRMg/cuCc68
    bDbqbxvpP9pjwLNfsjziim3qQaDDdaxFAbfNWOzRU2yKjBK3y/IiT8bBCZPx2gzY
    wc4jFXaOeK/R2ytikpzuWN/7ku4CA/MroCUdHqjciWFENX4B+0RgPEZ+z0Gvsd0x
    +5jpDWCbMUv2//UhAG1a2YjxjOFlHzYWh/ARsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518405684; bh=q
    oVqHKE6fIoEnuQ1hIgqLF65+Ha0kyWZKsB18y8udB4=; b=T03y5fP3rdJvAKGNJ
    Cvu8PDNIOfzAtc1qOmOj9d9WTwPCjDvheSnxOOH+lZIh/Nkt7lkRs8ILquh5SX9j
    j3clfKjJaMxkH//vgd845pOQhHGIGE+zVIk6nqXlBJpgTVV9B5KD2wNbID4Tp2P2
    hONQzU3YiHUM8e9DH8qm8WkMHH/fYa2d/+X5OxFmL6sSyQ+m8zNuhcdYNOu9soUU
    3I8D7l874G0G2JH0+oAFXHA5NdFKo1LOgL14hI6zaJ1sV99v7mV3WuHtHfn9z6XU
    0AnOKiCuWtFbPENdz6HazwI6yqKx2CmbcQnlSV8z8xESSxOsgoNN8x3ccu6vnvew
    upk7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:7903:9010:9012:10004:10400:10848:11232:11658:11914:12664:12740:12760:12895:13069:13160:13229:13311:13357:13439:14096:14097:14659:21080:21611:21627:30012:30051:30054:30060:30070:30091,
 0, RBL:none, CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none,
 DomainCache:0, MSF:not bulk, SPF:, MSBL:0, DNSBL:none, Custom_rules:0:0:0,
 LFtime:1, LUA_SUMMARY:none
X-HE-Tag: basin68_61394578afd1f
X-Filterd-Recvd-Size: 2437
Message-ID: <1518405666.4139.8.camel@perches.com>
Subject: Re: [PATCH] staging: lustre: update the TODO list
From: Joe Perches <joe@perches.com>
To: James Simmons <jsimmons@infradead.org>
Date: Sun, 11 Feb 2018 19:21:06 -0800
In-Reply-To: <alpine.LFD.2.21.1802120158500.3291@casper.infradead.org>
References: <1518390008-17876-1-git-send-email-jsimmons@infradead.org>
 <1518390961.4139.1.camel@perches.com>
 <alpine.LFD.2.21.1802120158500.3291@casper.infradead.org>
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
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
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-12 at 02:06 +0000, James Simmons wrote:
> > On Sun, 2018-02-11 at 18:00 -0500, James Simmons wrote:
> > > As more people become involved with the progression of the lustre
> > > client it needs to more clear what needs to be done to leave
> > > staging. Update the TODO list with the various bugs and changes
> > > to accomplish this. Some are simple bugs and others are far more
> > > complex task that will change many lines of code. Some even cover
> > > updating the user land utilities to meet the kernel requirements.
> > > Several bugs have already been addressed and just need to be
> > > pushed to the staging tree.
> > 
> > Nice list.
> 
> Thanks. Its nice to have a direction :-)
> 
> > Are or should those entries that have been addressed
> > also in this new list?
> 
> Do you mean by those entries what originally was in the
> TODO list or what has been fixed over the last 2 years?

My reading of

> Several bugs have already been addressed and just need to be
> pushed to the staging tree.

is that the new list contains entries for things
that have already been fixed but have not yet
been pushed to the staging tree.

So, if there are entries in the new TODO list
that really are fixed, but not yet posted, then
marking those entries as TODO seems inappropriate.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
