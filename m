Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3921380-1521235089-2-12463319778273334455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521235088; b=vHc2jMT/c7b0vq7Vj7Nyb5e7eN5ia9/8Jqjfhd6OFMLs6Lh
    SMs8r5eNcyRpug7IX3ostPKTa2sRlOHAbww6irH+d6jRj2Hc57Ct4BNsClAU+QDV
    m+lYRQ4H8kaa9R658+o6WLSjPvKk9UDOgk5yxfmEZX/wIW58Jsmrba4LEv159tG5
    ++/fjvR5Sx9LDPdMq3OtAnRv9UzL29VmPpqUrhu2IY3vuYtSZkCyV/gPBMZ2GMc7
    ckUt/K6h49HXTiTUQ7VyvbCY/BomF6G7QF4j5Ta1avg9Triwc6hE1BN7Iq3V7JK/
    cT4jCIRgBJwACSY31F1CucyXcd5mZc+v1AkYMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521235088; bh=aEcItdd
    cwvHUFBq28xoBIeBkl2/5sSNKCW1QVnl7xD8=; b=VKSyQFdj4n+IHDDSSzeqXdp
    ZsQgj9I0eHd+CdeTTbxU7n71tPuOXHOCn585xeHfyQZl0xI78SCYNKtI/HWngqrj
    D4IXHLJC1mxRwTk6xQdcg97dpuYivuyY4Sa/lQOsmSXu0o+L003BoI50gPxC/Vub
    r5/g7IODVux4uc1IXvedYngiwzvSozYoi52g8YD6tuKkn5VIrg6LaCGNNhi9p+us
    d2KOIJa7WihGLnMLxtEULCXpX2F5ejf2qO5WpIU8SyUBN33kPhv0xe4R9W3uuIhi
    R2gATU+N+gfNNQ++aa9lY/xg6PhiP74G25prGbdmUiyuDC9EQqMzMNcbCsZuMmQ=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeCPVSH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 17:18:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750806AbeCPVSG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 17:18:06 -0400
Date: Fri, 16 Mar 2018 17:18:02 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
Subject: Re: [PATCH 02/14] mm/hmm: fix header file if/else/endif maze
Message-ID: <20180316211801.GB4861@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-3-jglisse@redhat.com>
 <20180316140959.b603888e2a9ba2e42e56ba1f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316140959.b603888e2a9ba2e42e56ba1f@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:09:59PM -0700, Andrew Morton wrote:
> On Fri, 16 Mar 2018 15:14:07 -0400 jglisse@redhat.com wrote:
> 
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong.
> 
> "were wrong" is not a sufficient explanation of the problem, especially
> if we're requesting a -stable backport.  Please fully describe the
> effects of a bug when fixing it?

Build issue (compilation failure) if you have multiple includes of
hmm.h through different headers is the most obvious issue. So it
will be very obvious with any big driver that include the file in
different headers.

I can respin with that. Sorry again for not being more explanatory
it is always hard for me to figure what is not obvious to others.

Cheers,
Jérôme
