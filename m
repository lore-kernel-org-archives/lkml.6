Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4114809-1526656948-2-12304455669340492279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526656947; b=Bkrjq4peGHfgX0PhXSZbFkOcGTLPDymNXTy/DeqlDm4ySAxCFc
    EDU7cUuG2WfRWst0bhflfaljoLsm2FQcEni4eLM5yJyIB1WfVCdb3V0T03Ls3RcS
    KgjNktQPMd6MYkXMD8Zf6IA9LbUVa4DWypk0Mf9834Ua7HFyQF4qROhlmJnCqEsj
    MwX2xxXL1pm7c3Oay29YT3HfK5Cto4j8qlOAxO5PI19Qw4gvTKZ0npmyjVDczB4f
    C63uQQCLlOgOmrqHJOW1Eifjy88QYkJmC+sflnK4GWH1wrIDnSHnourw7/YfIKzH
    gRFz/zW3GxaZqyn80Y7DHHwZMnFOHQ3CJMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526656947; bh=ZRtKGFChDxG8C0UqOZpMj9gyF2Z/gh
    3Kau+xw7IEWME=; b=Jbz7gxGwI91Urg//rKQ1KPBJhTBoVdeNprK5O6U4452mGS
    SUPtasLSed4gc6GCYtAV8RTeEeD5ARQxKRwuLVvO41CWDBMhjOFdJTOuiKDUsH8E
    pQiHAU9P5wlDHIy6y8sQeITrVBlj+fSzUJcx6BWVvobnmXMDYo9Oakd2RsDAzBjQ
    Rqj3O7YbYhCGwrYpjeNIhstRxqxzs7FVpoj8Khsu3H0bjzMUariCfoky6f/Aa3Kl
    F1ok6Zb2l38mHxvdOWNB5CCeqIs37eytzAu6zMDzMqDOFsGV3TGnY2RF/XWhDYlB
    5lcwLchAreYIt740xC+pLp+grw3lLZ7sUpxbMKyQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
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
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB4IwPjScPaHMoS3c9v7HLPT0Ixc9T9NjXiWAedWnWTRm/IleDUwCzVpdqEjsqKoGFSIstKIlm7cTuvsO52GqlRDRv9mvE/A5By+pvld3ONa1n+n/peq
    l0uZTfw6/79CwBfZiWts/hvzZNYdddOj+4ewvXi3ITVbPoasAUq8X69sKUSuKPBILhzPoilzIZA1Wu9C8lhbtp6Oy0R5LSMKBnxhqHMdTj/4N5KKgVf5hFzn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=XPr_PtNKpo9reDbqrIIA:9 a=CjuIK1q_8ugA:10
    a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeERPWE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 11:22:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752334AbeERPVy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 18 May 2018 11:21:54 -0400
Date: Fri, 18 May 2018 11:21:06 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180518152106.do5b3mu6e6eyvo7q@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <20180517170053.7d4afa87@ivy-bridge>
 <20180517215600.dyswlkvqdtgjwr5y@madcap2.tricolour.ca>
 <20180518095636.56ff322d@ivy-bridge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518095636.56ff322d@ivy-bridge>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-18 09:56, Steve Grubb wrote:
> On Thu, 17 May 2018 17:56:00 -0400
> Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> > > During syscall events, the path info is returned in a a record
> > > simply called AUDIT_PATH, cwd info is returned in AUDIT_CWD. So,
> > > rather than calling the record that gets attached to everything
> > > AUDIT_CONTAINER_INFO, how about simply AUDIT_CONTAINER.  
> > 
> > Considering the container initiation record is different than the
> > record to document the container involved in an otherwise normal
> > syscall, we need two names.  I don't have a strong opinion what they
> > are.
> > 
> > I'd prefer AUDIT_CONTAIN and AUDIT_CONTAINER_INFO so that the two
> > are different enough to be visually distinct while leaving
> > AUDIT_CONTAINERID for the field type in patch 4 ("audit: add
> > containerid filtering")

(Sorry, I had intended AUDIT_CONTAINER for the first in that paragraph
above.)

> How about AUDIT_CONTAINER for the auxiliary record? The one that starts
> the container, I don't have a strong opinion on. Could be
> AUDIT_CONTAINER_INIT, AUDIT_CONTAINER_START, AUDIT_CONTAINERID,
> AUDIT_CONTAINER_ID, or something else. The API call that sets the ID
> for filtering could be AUDIT_CID or AUDIT_CONTID if that helps decide
> what the initial event might be. Normally, it should match the field
> being filtered.

Ok, I had shortened the record field name to "contid=" to be unique
enough while not using too much netlink bandwidth.  I could have used
"cid=" but that could be unobvious or ambiguous.  I didn't want to use
the full "containerid=" due to that.  I suppose I could change the
field name macro to AUDIT_CONTID.

For the one that starts the container, I'd prefer to leave the name a
bit more general than "_INIT", "_START", so maybe I'll swap them around
and use AUDIT_CONTAINER_INFO for the startup record, and use
AUDIT_CONTAINER for the syscall auxiliary record.

Does that work?

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
