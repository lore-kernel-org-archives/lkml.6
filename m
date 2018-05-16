Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526500424-2-2923368311832862172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526500424; b=frU+sm6iD8X/lCEKMWMdpqYYY1L4aCGnOPCexeV3pO95HtVDzE
    7D5aGWy/uE/Ef94NT0uhL8EqTESuisg+zwyIVgd20FlhF+73jTM4CvxZiA1Vp+zx
    +0IrgfSRSdV/IR3f8aq9F+zDoF1CxD9SZ5mYXEpt3iBWHJJu50UFyC/5Fy6mlmbI
    0jakdTbKTDy4G+HgQO6Ee2pVFu1KFi6Fj+IjiZrYdWIQ2XDuu9AzH7mAJ0VS8/dq
    KwS4+0IiCq/N0YwSnzHJWuXPKHlBGYlG8sSbF/Copw6Fxk7JUK6yBkcBGMNSaaqL
    Ro/Zr4u+POTkgMCwqLP5sfh4G2JtMAzD9i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526500424; bh=/1Zt13klD+w
    w3o4u40ypZlH2A2I65O7HFCUvyC8fTKw=; b=M3tb9eB6plDyHREpkS2ThtOrSFR
    38cal0E5Y/9F5cX9wUppxrh3SLbtRQ4spDcmBFyXV+j9mdMbJypQOTvhQUuZwn8V
    6EUC9gOyaEkCCQ3ABw4Zan3sIysKXCT45RA9gmuku7I7jm2+Ts09YoDlXbdgevM4
    M6UvdN8+q3bEjSKk2GhHxfMtDg5q88XJof+8W8WjeDWtg8efq5079sbI4zKZXTAj
    9i9VkH0Qqp0QaIV/6WaxiGgZYgyWCAowzNVMYm5TiDwUw65xMgGX+URyzit5GXSK
    03chpOzXKvMIjtO6GfB4nAU+yy0C/Uzgx8aC+H9z2cyUHjagsEPB2kgkLBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGDxSId9evQ8AJJaJ8P/NX/jrUcjIKz7JGcqvH6tWxFqVWBSxOadcwG/ImHHpMlYLrKZc0DDRn7OtXf91MVyVf7vHkjp4V3+NRcPKf/T+5HTmr08b3iQ
    BTHSzYm1NWDgGM1D7CevtcAje1YEHoHLi6WhQenNkb6A1B9PAz4655EoCQpHfJmoq0c8N9GPTni9OF6J4i1LYJk/SH3r0n7vUEr6JWLTm4EJhc8ubRPHkgjl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=xNZQuAOQ-VL72OPsxY0A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeEPTxc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 15:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeEPTxb (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 16 May 2018 15:53:31 -0400
Date: Wed, 16 May 2018 15:53:29 -0400
From: "J. Bruce Fields" <bfields@redhat.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 014/190] lockd: fix lockd shutdown race
Message-ID: <20180516195329.GA24474@parsley.fieldses.org>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183550.916927223@linuxfoundation.org>
 <1526409864.9159.32.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526409864.9159.32.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 07:44:24PM +0100, Ben Hutchings wrote:
> On Wed, 2018-04-11 at 20:34 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > 
> > [ Upstream commit efda760fe95ea15291853c8fa9235c32d319cd98 ]
> [...]
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -129,6 +129,8 @@ lockd(void *vrqstp)
> >  {
> >  	int		err = 0;
> >  	struct svc_rqst *rqstp = vrqstp;
> > +	struct net *net = &init_net;
> > +	struct lockd_net *ln = net_generic(net, lockd_net_id);
> >  
> >  	/* try_to_freeze() is called from svc_recv() */
> >  	set_freezable();
> > @@ -173,6 +175,8 @@ lockd(void *vrqstp)
> >  	if (nlmsvc_ops)
> >  		nlmsvc_invalidate_all();
> > 	nlm_shutdown_hosts();
> > +	cancel_delayed_work_sync(&ln->grace_period_end);
> > +	locks_end_grace(&ln->lockd_manager);
> >  	return 0;
> >  }
> >  
> > @@ -267,8 +271,6 @@ static void lockd_down_net(struct svc_se
> >  	if (ln->nlmsvc_users) {
> >  		if (--ln->nlmsvc_users == 0) {
> >  			nlm_shutdown_hosts_net(net);
> > -			cancel_delayed_work_sync(&ln->grace_period_end);
> > -			locks_end_grace(&ln->lockd_manager);
> 
> Aren't these statements still needed for non-initial namespaces?

Looks like this this should be backported only if 3a2b19d1ee56 "lockd:
lost rollback of set_grace_period() in lockd_down_net()" is also.

--b.
