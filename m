Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3437587-1524591365-2-17299703233331250627
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524591365; b=FFbUG0g2o+5ytj93I1Un6LqBeN8KMUUQssXoQqFLK7LB7TtJoA
    13SxrHPJI6pWZAIuyoYomSMLNv7434b9MoQRrwvMgsq8Pob/PHDPBQzn7h63/jBA
    VOpF6ylsjxLpcnVBU3WqGYGxJKD9rV2f544HC6ob6Bkd+KQ2zYlgLwLguYeoiSkK
    39IwdmOOZdtgkv1AO3UFUx7GfwbvWJoC2OVn7Ot8MeIdAsxvjAsttxxQJeQTwRiV
    Fr8W402aMIYj/GqEnqmPmSDumnaY47JygE3uBgW1wTbwwcIvOuSm7gYf4r4AhB5B
    msPkSoIxRRMpQajZO6YcWi7PvloLackBwdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524591365; bh=O7kAEgV/ryVlVNuluL8+6GCL0U41wT
    Ea3eaqxirjYDU=; b=VM5WXiCC9mGWA/s/909bNJkf/bINHs2neIRxxrLLzALY1a
    s4EAziX+pmIa5lZjKtPHytb/tGeXoP3Tt1aoO8wuyvWQskl5K594dXTBctsBv82s
    Vr/HG1hM7l0ml9GluI5SLTezog/+4UHFqZPu2FPoUsHneMhApT+Yv+7NdnL4h3w6
    bJCm0eUjzbnpQGdZf7IiBzPxlUwWpvBphb3vVNkO0ummZ8B/EGn+wwXq3sncIwvy
    CYnFRqkoc56QQXogGTIOCk2LaLx+6mB8tHAIX9T12WzrfX/2Esam11M9eUzH5Te3
    SrauY698fq4vrcfeRsPaO/TCTJEHIjDJR4YFL/wg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=vL8lI2G8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=vL8lI2G8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAA4RaxiPaolG6ddruoVZm7fvzi7t5LtkAg4+JdF9+H48MzkmjQBYofMj4DTlOtmQPWVt6eG+vDiNYhjSeEmfvFYVf8c1SwObNR7kDa5+sRSCLfSPilq
    dqMh7hG3uo4e3ZOcsAMHc7r0qur4E0r2Ju4k/qF3VU+pZauV9PxtWnQBXmIOyzR8LTjode4bPufQ3ylkXUuVXU9Qu1YuNv8Yx6iCkpjs5iSDBX6zol/n1fd8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=RMlRvZAwo0AA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=5G4ssp63t0g2nzYnrH4A:9 a=CjuIK1q_8ugA:10
    a=P2wPx-gUWQ_iITRyI4cA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDXRgD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 13:36:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54308 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeDXRgD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 13:36:03 -0400
Date: Tue, 24 Apr 2018 18:35:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180424173557.GG22073@sirena.org.uk>
References: <20180422135210.432103639@linuxfoundation.org>
 <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
 <20180423165750.GA27986@kroah.com>
 <20180423180137.GA26974@kroah.com>
 <20180423222553.lbxx3cwly2fbvabs@xps>
 <20180424072635.GD18419@kroah.com>
 <20180424172311.meeo6wrsp4rtxxiz@xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <20180424172311.meeo6wrsp4rtxxiz@xps>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 24, 2018 at 12:23:11PM -0500, Dan Rue wrote:
> On Tue, Apr 24, 2018 at 09:26:35AM +0200, Greg Kroah-Hartman wrote:

> > How about only reporting problems?  Having tests "pass" is the norm and
> > should always happen, right?  That would make the reports smaller.

> I agree, though I would like to provide a bit of context so that people
> new to the process have some idea about testing breadth and depth - but
> it should be a few lines, rather than the hundreds that we have now.

If you link to the web site people can in theory look there (obviously
there's some work going on with the website to make it more readily
digestible) for more context.

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfavwACgkQJNaLcl1U
h9DROwf8Cx/1zb8Zyp2L75yGB4Qlokl9aMEIWTLPHoew2uJgcTcAXiHA02y4HtPF
3tMLaGYzKRN0WuPdOn2vJk9YVVQHpLexoSf4MkgiXNL1E6fLBmlaXYkEr95F2WYj
1F/t9I5OxP1Mo7JfwBH3sq5HRSXY7O2IMoraUKyMAHTYHoN2jGsbxBQpttYe7Tg1
6rauGDhhZYGi93DI6dE7e7r3eHCKYZg+NlmdPQ/lcr67MZWPFAJeVDZWyG6Fx+9t
SkKqMijV57I0xraPTihAoM9ZiuKqVspPC2P28jW1Aj5v2qFtaWuLJzJ5YR2hFRUe
A6o5IEgTRYVeYmv7QPpkgtdZvs2BaQ==
=gxLM
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
