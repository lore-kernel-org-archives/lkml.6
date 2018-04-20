Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1351710-1524219714-2-15865206175503137859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524219713; b=pRsX6yqiDUFeeXhCzf1QwfvP4doOhNc/XFSKBhrylokdO09MTI
    Hyq4b9jnu8HoIxpcwJwPvOE9M7M5qGXS6xNxsXmDkXYz6ul/dY9ubnuO3vCjq4V+
    5acZpmYqH3SpRN8d3q8n8P4REJeQ9W19cWyYRbZ7xjLkeGw/fznJ5BE/ifE6GG/V
    ltLtdQrTrSJsL3w+n88bWz1xlOL1l1X1V70Net/5IvKswBdsOEuXOG+9AFbA/QEy
    jBZioWOFQ+DSQV7vuLiPknwmg/W3Pttw1lC3gtVCbUFfJtdawZCGwmjJEEb0iRPk
    dN9qk8xLtc+s4O6ZcKdzD47eYSXFNRvrnbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524219713; bh=rfrZQclYAbV55VARnueG67QFWSJ74+
    zzkQMf9HFKL88=; b=Msh4dx5uh2By0d6qDE46kTZcso/VyWG4TrVZMZVT/NgqsE
    QYaZ1SmU90YqsV2XfosknSPJuf+FuvDCRo7eQINOSqiFPf6w/e98U5nyc01MKyeM
    mAb9EXjO4Zo4pQtz+9dslNkpDqEqySDtadpJdlEL60FM4DyVTCv/uC0S/iiNf4G/
    b6fytWKfqNqyPp+fD2NkyZTK7o+YbgHmArdNq9LFsV/398puGMpKSwRedG8iqNzJ
    9zTsPjeTlqflv5qgNxALT63K+t27zOhIZ1zh2nin0/Zbvuif/itZQgW/KTs/3nXy
    Q3kRd+1IxQ4jqh1WBx93RLOQgv56zurfe1q15NXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK44/UkpK72S845geWHS4E083opTpKkvwyCbmMUxepYtl5gaSME9klK7ac925VxT1UYqeZ9ogiJKCSH9l5soYvzTAOPtWLQo4wuhYD41iGqEzCwuNJTW
    T+JDk9kDuyd90nm17rBay0ICrk9T9psVCiP3IzOb/oycQjc2JiTig9oCPm2I+O6IiE9xpSSouBwPSwV2HKyadcQHjhy/1StfdYQBcVWlCsAFqoeyJMDVF4ah
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=PEGQdXUccWqmAXXFBIAA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbeDTKVk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 06:21:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34617 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754398AbeDTKVj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 06:21:39 -0400
Date: Fri, 20 Apr 2018 12:21:36 +0200
From: Jan Kara <jack@suse.cz>
To: Dexuan Cui <decui@microsoft.com>
Cc: Jan Kara <jack@suse.cz>,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        Guillaume Morin <guillaume@morinfr.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180420102136.a637r6eoghxjqhaf@quack2.suse.cz>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
 <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
 <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
 <KL1P15301MB000619E372AA3A2FD505ADA5BFB50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1P15301MB000619E372AA3A2FD505ADA5BFB50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 19-04-18 21:37:25, Dexuan Cui wrote:
> > From: Jan Kara
> > Sent: Thursday, April 19, 2018 13:23
> > Good news guys, Robert has just spotted a bug which looks like what I'd
> > expect can cause your lockups / crashes. I've merged his patch to my tree
> > and will push it to Linus for -rc3 so eventually it should land in
> > appropriate stable trees as well. If you are too eager to test it out, it
> > is attached for you to try.
> > 
> > Jan Kara
> 
> The patch's changelog says "... this behavior results in a kernel panic." 
> This sounds like a reference to corrupt memory causes a page fault or
> general protection fault.
> 
> But what I saw is only a lockup rather than a kernel panic:
> watchdog: BUG: soft lockup - CPU#10 stuck for 22s! [java:87260]"
> 
> So I guess what I saw can be a different unresolved issue?

Actually I don't think so. The list iteration simply went through stray
pointer. That can crash but it can also end in an infinite loop, or it can
just randomly corrupt memory. I've seen all these situations with similar
problems. So the fix is definitely worth trying.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
