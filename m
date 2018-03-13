Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629652-1520931021-2-18075631062905771825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520931021; b=js0y9pMyE059cMkTl3keqizI4S5PytwxZOVhLlfG6IBq/oq
    +ro8KJFQ6wWL6pSYanOplaz+PWteC7OcA7hTJqTjLFxautrMNIeWOMxui186h6Lt
    h6kFiZvhplxjQVbDS9IleCknQqV0ES3PA0Gk55yKGB07aWw0MsS3Wdq11JFCNCbl
    B4JSNvFApo5bx28Z89Y0tmZn3LQB69E0IhKgJL7hZwbwKCaeqxmVX1Ud/75Bwq8V
    m/S690rzwjCImeIs52zkfTsyNh9X9fXyaEMjOlaC61f81qG+viTp+FfX9JjiZO4K
    x9ZyeWdAxYECqL24CEx3t26POCEUj+dHTKvq4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520931021; bh=3zcohNkOG0+1z6L+YviRHi3AhC
    rWIGklMXIPJnvrkNs=; b=EIX+9jZhloU3OKmUY5CNohS7ZggR3Y9CN1NnuFb+D7
    mua2VC+2z4qBjfmlj9CyvI/855SDeoOC5hhNXqgUccrd0LYf2dH7gQWxB8fbf0Nf
    ZUDMqQy7jwijENZeFrQ8q/CTFErnFjEB8pXrVtLWS4VeGZ0Oaw1amG82FkzyupDi
    A8VjKjpRLb+F/awIq3S7EgEfUE+k+pu9IYZMQMldsvfpe61nWI1VyoGRFcbhqRHY
    WMK0pOWPv/yp/zUEzVSZq6mxOkDQ2TvN5Axl1tQflzGe/WftIBoL6LxhjTxV3xOV
    TvQvARTimqlfRzzcSxaygzMleG0J1NztJ7harSsvfMYg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCMIuS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 04:50:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752471AbeCMIse (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 04:48:34 -0400
Date: Tue, 13 Mar 2018 09:48:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexei Starovoitov <ast@fb.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jessica Yu <jeyu@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180313084835.GB8901@kroah.com>
References: <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
 <20180310140843.GP4449@wotan.suse.de>
 <20180310151652.GV4449@wotan.suse.de>
 <20180310153431.GW4449@wotan.suse.de>
 <1f3e2c92-1e09-cc77-3b90-e33d7da35a2f@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3e2c92-1e09-cc77-3b90-e33d7da35a2f@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:22:00AM -0700, Alexei Starovoitov wrote:
> On 3/10/18 7:34 AM, Luis R. Rodriguez wrote:
> > Also,
> > 
> > Alexei you never answered my questions out aliases with the umh modules.
> > Long term this important to consider.
> 
> aliases always felt like a crutch to me.
> I can see an argument when they're used as 'alias pci:* foo'
> but the way it's used in networking with ip_set_* and nf-* is
> something I prefer not to ever do again.
> Definitely no aliases for bpfilter umh.

I agree, let's not do that if at all possible for these types of
binaries.

greg k-h
