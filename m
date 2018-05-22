Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2845700-1527010623-2-10733628254601756085
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
    1527010623; b=XBFp/nuOJyPcs/uhvzYkfLL/5IiF8Mx/bC1/cwF0lVNcF5vTPw
    0xWeLIrVosof4MAb+kqN/XMBg0f4Lh+cgRY6w9u1/TwqBsKYIF5Qz8Y32HLVWn3J
    Ojo7DX3q4eiFrkUQ55pnoXQbd11w7Awbpo/QLUIKo1z8Lqa4kSaWNdcN/uA/CGCT
    lz3yECTbVDcT8FDWS9xcNXOR4sT4BheTbmiGMlPst1Mo/C8xdmnqrfILmqXl6+h6
    H0upOJ7DUvKtHioYxWkpmGG0X7NXhMmEUO8+tcqsvtDsmhpvhnjf/UMdxibs78Wv
    Wn6hjLgpeg6iqfCYpeaTFVNbWf+JcvtnxM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527010623; bh=ksCbZrQOPWgfmDYG5Xh+wKgV7bpLpB
    utodlOaLMQ3cE=; b=XZRO5Girwe2qF2ViDU4vs1tI9trc1PXdodJ34NHa1wSoC4
    GN+b0LD+kPbC74+eG2XAEeFrMnSDyFU8oYkE/S2YEQYQeku1bM6qQvBfnx6IhkEW
    RzeAN8MK9irVxs5DhIWI1/4maZAu/SSJm1TZZdqcnF/kmpZW4oJUhatf3SnwLSgz
    8fpLdRaMWIO/tw0+4GBRLBttPpKoKM0sKQTVfQKOLvcH/gJLtpeafzGZtnXW80YV
    w607c8mvsuuNW9vH0fP3D7izYOX5PLuE/v9fSIGnERAyRiHLzhM2YpyfthzyrByR
    PxOSqPSBwe4vzumlryXFyYwLEib0w3W007o/oSGQ==
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
X-CM-Envelope: MS4wfJGGU+6Wbhn5gAGJu90YjsKFsuwxEkP0vHH/SOKK3l7DzbY9oOv9qa+lWV0odLvQazSS40GZu5EjhV+5tOe3nhnRnZrjYGXa6MUof0XjeSpnMnv0Jsgh
    XQRaEUiEeCm0VaJSoIHQccULPru/ugakH+ocXfhX+FMLG0Smv2C+04RL4d4K6F3Tji5cxOaGyGrp6kUHdjQvb6gnMuIT5Slyy+iIcKMQT3bsrd227tthvk1Y
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Qhz2HMvRcKgEtM29gnMA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeEVRgj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:36:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751355AbeEVRga (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 22 May 2018 13:36:30 -0400
Date: Tue, 22 May 2018 13:35:41 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Steve Grubb <sgrubb@redhat.com>, simo@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        carlos@redhat.com, linux-audit@redhat.com, viro@zeniv.linux.org.uk,
        luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 13/13] debug audit: read container ID of a
 process
Message-ID: <20180522173541.slcdszumi7q6c4id@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
 <3001737.MkQ41rgtZF@x2>
 <87muwshl4z.fsf@xmission.com>
 <CAHC9VhQruN88t-R9Qo3e4hwCZ58RAyrmEmH1nY4RR6NZaiBzGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQruN88t-R9Qo3e4hwCZ58RAyrmEmH1nY4RR6NZaiBzGQ@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-21 16:06, Paul Moore wrote:
> On Mon, May 21, 2018 at 3:19 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Steve Grubb <sgrubb@redhat.com> writes:
> >> On Friday, March 16, 2018 5:00:40 AM EDT Richard Guy Briggs wrote:
> >>> Add support for reading the container ID from the proc filesystem.
> >>
> >> I think this could be useful in general. Please consider this to be part of
> >> the full patch set and not something merely used to debug the patches.
> >
> > Only with an audit specific name.
> >
> > As it is:
> >
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > The truth is the containerid name really stinks and is quite confusing
> > and does not imply that the label applies only to audit.  And little
> > things like this make me extremely uncofortable with it.
> 
> It also makes the audit container ID (notice how I *always* call it
> the *audit* container ID? that is not an accident) available for
> userspace applications to abuse.  Perhaps in the future we can look at
> ways to make this more available to applications, but this patch is
> not the answer.

Do you have a productive suggestion?

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
