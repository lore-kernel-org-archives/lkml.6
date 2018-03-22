Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2465629-1521714766-2-14951880282261588645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521714765; b=boIM+xbeUYJhfEgcCMJzcjDH5B3xe/xP+CSj5MdGw00hBEW
    LqbxCmCoGKMawZIzC/Ab9sNJrbvlrNJx0eFY6QCBXMF3IRWLR1yXa+3+pEKKJORo
    evdKzjxX7YroI1A8p+UUW1G6kMWOZiM1unC1heh6lraMzSUeHhMJc/SwEZ9g/lER
    6qQhA1lDhED15eRtM50L4aGChqj+3E/9x4MUf7DEoo0xwRdRhiTZK1t/QsEhvaEE
    YibS5y5BypDJTNtuNV8s74w0OKNOrX3FUDxzvlJO+KH4ic0qLwvnCipK/apJ8m9S
    mWOda50q7X5lWd13ton6HtkowpmhjoeKsWLGVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521714765; bh=0jNDLfocqwTFemnWMja8VtZo6F
    d4E6e8/SLJNhmb2ZE=; b=jplbKHSjpcz88KyOXy2nKHV815QvqJjvrn2Pkc1f2E
    GUTWr2Jae+uBqEmFwrp6p7UFzlfQMcL2dxjV44qQTUFZUD2aIlpe9Iq0fesdIBTS
    4t2Z4gxBFj8U7HXFtW8WjjD/b7VVKezbx8EnKT9YLVXEJar47yvs3zWqvdBOS1eb
    lAZ5pZA81CjivZ1xolirS/vqEBo+FbDRJQgb2VI/dIhAqfn44WXl2t6CoCTyOidY
    PN+8H2gOQMZip2rQxABkiYFdxHihEv+J6oGJZFBE3bN44K9wW1Vg3lp7Mg7eW+XL
    iw64T3dFxYJFsGikFYByIUhMRc49E1BpojXzhODK72jw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeCVKco (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 06:32:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCVKcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 06:32:43 -0400
Date: Thu, 22 Mar 2018 11:32:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Steve French <smfrench@gmail.com>,
        Thomas Backlund <tmb@mageia.org>,
        =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
Message-ID: <20180322103233.GA10695@kroah.com>
References: <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu>
 <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com>
 <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
 <20180316133241.GC11397@kroah.com>
 <CAH2r5mvYxpr_0CPZNiNJTGhFNaM06w-EoTT7WS8oVjVZq8HCCw@mail.gmail.com>
 <6745f869-e249-a891-8d76-79f2830dd57f@csail.mit.edu>
 <46a98623-2125-1f16-c456-db06f015f95a@csail.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a98623-2125-1f16-c456-db06f015f95a@csail.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:15:51PM -0700, Srivatsa S. Bhat wrote:
> On 3/21/18 10:12 PM, Srivatsa S. Bhat wrote:
> > On 3/21/18 7:02 PM, Steve French wrote:
> >> Found a patch which solves the dependency issue.  In my testing (on
> >> 4.9, with Windows 2016, and also to Samba) as Pavel suggested this
> >> appears to fix the problem, but I will let Srivatsa confirm that it
> >> also fixes it for him.  The two attached patches for 4.9 should work.
> >>
> > 
> > Indeed, those two patches fix the problem for me on 4.9. Thanks a lot
> > Steve, Pavel and Aurelien for all your efforts in fixing this!
> > 
> > I was also interested in getting this fixed on 4.4, so I modified the
> > patches to apply on 4.4.88 and verified that they fix the mount
> 
> I meant to say 4.4.122 there (the latest stable 4.4 version at the moment).

Thanks for these, all now queued up.

greg k-h
