Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882526-1526550662-2-3783898425801314400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526550662; b=IS04g8FZ+mxedugXxCxC8EL6V1eVp9jUcBG/0JFTRAEUkzkkQr
    ZxpXcSuSw/ts4YEjbEotG2tkYbS0YK//DX8bkJDhdjKpKTq/X9ayD2eK8aWL5e+6
    hKDLuamwe7ND3VUhD+iIE3wfg6hdMindLb3w2zYijuM01vKm47JhOPJa8K05BpTV
    SeZcEtAifjR70MJrc/ZX0f565gfKBZFRTYUFBP4TUS8ZV1yvQMohllOqpvrmkSKD
    ED+4qXlC+dOM5tgG0UcNJVvJ2MtF39bC5mXBz/SDGj7tw9Fev4D9STB5d7j6NPez
    j8P3uKOWKJitIsJPTPCYJN5cYDIZjXem40hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526550662; bh=6vA/LjgJXRn
    5jqQzZYYyDptkNSEiAvhwrRyc9wmn2sU=; b=LaChdrOo+R+wBDiVx89cnFrkInz
    Y9ev5Gw23ZvSL2zYLets01azyTIk1XwQr5lOkhSy7PU2+zXsUpAaYnnv55ycHeU2
    nJweew2xcc47vHmldfpjQyWhpv9H7wy7HApWZKP6oo0F9OqPCpYZmwATP1ouZx84
    L8DeNpZ+IecqkRTN546i7CnGJ8qQOPa8EQSgb5GMN/kzGAewi/CAM60WNaA5WgZG
    LldAbtsCXJtPaCzg3cCsMSpu0WObWnYIuq7glygq4ghCRvJdRPHAim361EjiNZ5s
    fIIFPpt6Ibco9jQbGv6azvTntkjuRY8ZQTJmzOtNrugpk51IYEtAkBvKGbg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rnP90ytp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rnP90ytp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNQx/TBF5/VxlDHZYGKozv9H2CtD7cvcZEfK4EjsGWhvrUt1sue3sTk88PAvy3aDmfPL4NES+o0oAcaoGOIQngT2Odohb66BegMxuH4EhkTJ3WKVh2Ir
    tF/Cf5HrKTZBV/4XDJK9IsT1Pp6pVjRoV8ozxJsGRM6bOVoilxQwomIvgxOl4Pds1Ha28vTagoE+j/Z2j7oGMp/KOlAKFEjUGttSUyEgsKEwk2E40poiMCQA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=uql1A4HvJxlFwBdMG0AA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeEQJu7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbeEQJu6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:50:58 -0400
Date: Thu, 17 May 2018 11:50:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "J. Bruce Fields" <bfields@redhat.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 014/190] lockd: fix lockd shutdown race
Message-ID: <20180517095040.GC28396@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183550.916927223@linuxfoundation.org>
 <1526409864.9159.32.camel@codethink.co.uk>
 <20180516195329.GA24474@parsley.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180516195329.GA24474@parsley.fieldses.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 03:53:29PM -0400, J. Bruce Fields wrote:
> On Tue, May 15, 2018 at 07:44:24PM +0100, Ben Hutchings wrote:
> > On Wed, 2018-04-11 at 20:34 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > 
> > > 
> > > [ Upstream commit efda760fe95ea15291853c8fa9235c32d319cd98 ]
> > [...]
> > > --- a/fs/lockd/svc.c
> > > +++ b/fs/lockd/svc.c
> > > @@ -129,6 +129,8 @@ lockd(void *vrqstp)
> > >  {
> > >  	int		err = 0;
> > >  	struct svc_rqst *rqstp = vrqstp;
> > > +	struct net *net = &init_net;
> > > +	struct lockd_net *ln = net_generic(net, lockd_net_id);
> > >  
> > >  	/* try_to_freeze() is called from svc_recv() */
> > >  	set_freezable();
> > > @@ -173,6 +175,8 @@ lockd(void *vrqstp)
> > >  	if (nlmsvc_ops)
> > >  		nlmsvc_invalidate_all();
> > > 	nlm_shutdown_hosts();
> > > +	cancel_delayed_work_sync(&ln->grace_period_end);
> > > +	locks_end_grace(&ln->lockd_manager);
> > >  	return 0;
> > >  }
> > >  
> > > @@ -267,8 +271,6 @@ static void lockd_down_net(struct svc_se
> > >  	if (ln->nlmsvc_users) {
> > >  		if (--ln->nlmsvc_users == 0) {
> > >  			nlm_shutdown_hosts_net(net);
> > > -			cancel_delayed_work_sync(&ln->grace_period_end);
> > > -			locks_end_grace(&ln->lockd_manager);
> > 
> > Aren't these statements still needed for non-initial namespaces?
> 
> Looks like this this should be backported only if 3a2b19d1ee56 "lockd:
> lost rollback of set_grace_period() in lockd_down_net()" is also.

Looks like it, thanks, now queued up.

greg k-h
