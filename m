Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3496597-1523892654-2-2643473408218085306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523892654; b=esYyqeNEtet6NwpjVbjhsDMKP+itRHleuY5X+k2LMwnJnIZilH
    yTrvVRgXVFnb8yMoi4kUD5wHu5hVbg2KxmakyFMEZ1tts0mxlpbLTrLz3UavIbeM
    KUGBmgbSfzF2Z8sVa2MhDceflk68WBJgxIiF7VhxeR4ZZNQxsZl6EPGbZZcfxi1t
    R1hZVw46bWNuvBx7xoWaeSwdP3QAn97bVidABKVP6/sTRz+h53oSQMMEEpA30GdL
    vwSd0pm8eoUJX5ToMIfEgxw7YCkUBDGvJyAcAGXw+7tP7oW2zrgX63EI38jbGhNS
    uOEh3yD8fqmoEqevzpLTQp0UmgRJPjNV9x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523892654; bh=GVWcLJ1V7n0sB+w+gReb68jegEiFA5
    zg7bFs57ykcrw=; b=ckgXQn0T5y2xEZwdrwC/0QiAZ114WuXQ9x4mD9OQ59tqVc
    TN+8OfZPcU4yGb09iCTSSmGcjStMmHaFDKh1hLv98wbrtuVjmx3Iin8UvJPngnrf
    iGIOWPYnrhl6HJvfKr9ClngUU+vbk3syo4mH4iGaLD6edFkqYdsO5Jq9yJKN2x8T
    aeYGeVBiQrQmdNLIi/+xeGLlG987liNwsQVqlAnbkPxhy1K9HJK7MetEUdYLhPGa
    VlRIhO7aYBWG7SeERIk2DsChaDo0Yv0XUnj6ldDKcltJGGwNC1TFdgNx0Hm0kBna
    WHOJFkODbD60MVIPQrdrYxpUGtK6NPUo+29tZAdA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCGzkDDGNBANvmzxViTwWciWQFsOx+yu98xMvQ4FGi5jvDSFi3YkiIrJRthOfQTHLLZSTQQWbrUEPztHznNNEmzngH+h4oAI0KTUOK/ocj756Y8QYQCc
    jOf0yh3bWFiiBq/sPo26dQjXd6ByMmkPBo3JcuGin/KYn1eDWVzEv1RqpwKUN3BbJe3t1Q4bhdipzwTWFeLDMjaDKq9zOb5G3MlWa371fUkftlTNOxlJXumb
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=meVymXHHAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=VzY0cb-wj_IsmQyNyRgA:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=tHAm2DLOYmoqQO0yQlAA:9
    a=ONNS8QRKHyMA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750799AbeDPPah (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:30:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44876 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeDPPae (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 11:30:34 -0400
Date: Mon, 16 Apr 2018 17:30:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416153031.GA5039@amd>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 08:18:09, Linus Torvalds wrote:
> On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> wro=
te:
> >
> > I wonder if the "AUTOSEL" patches should at least have an "ack-by" from
> > someone before they are pulled in. Otherwise there may be some subtle
> > issues that can find their way into stable releases.
>=20
> I don't know about anybody else, but I  get so many of the patch-bot
> patches for stable etc that I will *not* reply to normal cases. Only
> if there's some issue with a patch will I reply.
>=20
> I probably do get more than most, but still - requiring active
> participation for the steady flow of normal stable patches is almost
> pointless.
>=20
> Just look at the subject line of this thread. The numbers are so big
> that you almost need exponential notation for them.

Question is if we need that many stable patches? Autosel seems to be
picking up race conditions in LED state and W+X page fixes... I'd
really like to see less stable patches.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrUwZcACgkQMOfwapXb+vLyugCeOGD9Ww5IgWnSxK5d1h1gXSkk
t8YAnjd3az8WOw1SK0e59lD4Pm85BLVw
=4wFd
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
