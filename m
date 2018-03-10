Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2553435-1520802348-2-2177365306678967640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_24_48 1.34, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520802347; b=PChX3Mz/soic88EUtnC11kdiavJ8XXw+zZ5pltHlcLYwDnK
    PA7Bs81F3qTBUFgxL/xSrZYrjg4L9qK3q89tV1SlZBtk0cHUD0LdB4zEan8KUubh
    knZRCNr9KxsvrgT0fi6DuoYyT0npoIKmOYKHpZALRDI+g0rBdmm4B44VcQ0TVHSK
    0xVjarVS9fOhDhx3kXm2nQ5BN252pbqHlkZSDcVY00Bqm/OORrzXYnSr2T5qePTx
    N07C0lM8rxYH0PSUUj6vS/CDpPTO9JNnsHKLkp8DQaABBfs4NjofCqxKITkhPS1q
    EiAliVWPrjXngt4+PJJB8AY36ltxB+i9ZpPbznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520802347; bh=MNdhackwlJZ/fqbwbeqpVg/ct9
    86BcUaLbR5hwjZ8+g=; b=hg6NswcRm1cxBXiLlhzG+MBOV+xLOj9v+qdufhcG2j
    C1ai/0sn2JAp2lBiVYGvJOcwQQI8JaRrDnakgspQo/A7CpNbeolbOVcL8mdm9fu0
    X2+nTeMPCe5cmvbfaqiETReriir0TKKz9HVylYYukap8ntlg8dW5HoUsk55ubOzv
    rj38HkJmGtjR6h8Gar6VjG55reGdPn34mzYCEl7ROG5/ezW2xqDIC/Ydkv97PsjF
    9EGvi+Lj2Cu/ELEk88uatDOF+1qiqSLGkMEp3BWekmahdB9WNLX8RlKNWo6PSD/s
    eVf3Y2umlNyUCOavJEBsqRagcne8UflTrH+b6m24IwAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbeCKVFp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 17:05:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932232AbeCKVFo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 11 Mar 2018 17:05:44 -0400
Date: Sat, 10 Mar 2018 15:34:31 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Alexei Starovoitov <ast@fb.com>, Jessica Yu <jeyu@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180310153431.GW4449@wotan.suse.de>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
 <20180310140843.GP4449@wotan.suse.de>
 <20180310151652.GV4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310151652.GV4449@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Also,

Alexei you never answered my questions out aliases with the umh modules.
Long term this important to consider.

  Luis
