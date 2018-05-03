Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2309188-1525340234-2-1346481017992900537
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
    1525340234; b=PIynqO5RIjVYIrl9iCdQGCIvCeps/xp6d8VV9YIKY3FDmbg/Bo
    VEdIUxP9QzF9rMyCoZtYhm5Examws3U/lApxkYVrqwaSE9GjKHP82S8bwfx5oSMG
    y+6jPAyg8q6KSawIaUY9CXQ2TCVq8rt56jCK0AKESdpUxY2LuUlua/0UWj2xwb0d
    24ZQq4DDTddTjBYqGg1LmFK1TrGAVnc3Wzl2pKs9IXcXObswyNuqe55/90Al1E/c
    Bf9ZAfo1Pa+YXuhMQ49t0IMKWj8LzLj+1SyqWwPtwhEbBsMphvb4zphRtzUHBueP
    hlAf7KHpBC+0nqFTYkrq5y+PP1oHDnITW/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525340234; bh=3xgEXqH2LTDh/A4yD5UDJxKYxywJmS
    ykKA/1LrxuwB4=; b=NstQhZacqe+j9S3ZvOhRa71WQVSRHAKvYQ9oXOr63Ba5WH
    N1E8K1gsGYK4kPyh+WzN64BHDpNQ5AhBXy+Swzd+9ukC+cE/mv1pqKN90GlK9HzU
    oPQnwU6clVwSAiYQN/oSPrhF16g7frOqdOdwWCNtbkHqlHlbjR6dDRRh3G4gtRqE
    BUEx2km8j5Uxjbb5wPW9Ig8Cm1i/s+2+3Qnt+tMgxeDqNYTbpjuzWnUXa8ibMyKX
    XM46cc2Vxzl5kcncsFd2j2llELEf+zuxmTH3IC+uh8VrDSsVklYf9biPyq7x8vHx
    0Xz6+7c2OZeYhtU02qVktMXd6eKetK0blpH+57+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEMPGO0bNrqkvbycsnqhNaDdTV0RzTc9ITq0XwnjGYPSy+S4CUNggbKwyU6p0Db/zxGbfpi70P8O+i77IXx/kiHKfYg/iESF5piNB2XsWNO0EK3jeisE
    SDXnQq3bts29f3WSbTX3n808inzFNwjilZFumzw8tLrTgXbAHByU8bQXvinFRYVoMJ5drlz/vBAhXQMxDmeIXgd70DiHygJLndnf0JxaGmXGLFTf5DuNvhvN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=SkLsV9g9yhs7gSsqVzIA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=62F9p3Y6hF_sGa25zQAA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeECJg6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 05:36:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42141 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeECJgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 05:36:53 -0400
Date: Thu, 3 May 2018 11:36:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        jacek.anaszewski@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180503093651.GC32180@amd>
References: <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
 <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd>
 <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
 <20180417133149.GR2341@sasha-vm>
 <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
 <20180417161933.GY2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20180417161933.GY2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-17 16:19:35, Sasha Levin wrote:
> On Tue, Apr 17, 2018 at 05:55:49PM +0200, Jan Kara wrote:
> >On Tue 17-04-18 13:31:51, Sasha Levin wrote:
> >> We may be able to guesstimate the 'regression chance', but there's no
> >> way we can guess the 'annoyance' once. There are so many different use
> >> cases that we just can't even guess how many people would get "annoyed"
> >> by something.
> >
> >As a maintainer, I hope I have reasonable idea what are common use cases
> >for my subsystem. Those I cater to when estimating 'annoyance'. Sure I d=
on't
> >know all of the use cases so people doing unusual stuff hit more bugs and
> >have to report them to get fixes included in -stable. But for me this is=
 a
> >preferable tradeoff over the risk of regression so this is the rule I use
> >when tagging for stable. Now I'm not a -stable maintainer and I fully ag=
ree
> >with "those who do the work decide" principle so pick whatever patches y=
ou
> >think are appropriate, I just wanted explain why I don't think more patc=
hes
> >in stable are necessarily good.
>=20
> The AUTOSEL story is different for subsystems that don't do -stable, and
> subsystems that are actually doing the work (like yourself).
>=20
> I'm not trying to override active maintainers, I'm trying to help them
> make decisions.

Ok, cool. Can you exclude LED subsystem, Hibernation and Nokia N900
stuff from autosel work?

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq2DMACgkQMOfwapXb+vJbHQCfeKHDBJ7/Bf+FhvuYHI5f0JHr
dV8AnRA7YSWoh8YJe0eze3ZDbiDSrv/C
=0tUe
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
