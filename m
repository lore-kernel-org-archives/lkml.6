Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32200C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010BA21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549910408;
	bh=mvL40ZFRmn0Wk72FYLU0UQ1lKy9Er/AasuQ5PYhI8nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SkMUQaSPIX3jttNX4JgzfwIeUxGIwmMbjSKpUgRkgSrsUpvvLHTmnL0+WA53scNPh
	 xt3dIs+WsnYkuM7MRdQPS8CYtSiWxYneKrltx4uVz37y6qTtHpe/PkWT+DSwxAjSiA
	 fjZbHOwfMxfLYLDUhRoydvk1OC+AYUwmjX642k3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfBKSkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:40:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35446 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbfBKSkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:40:06 -0500
Received: by mail-it1-f196.google.com with SMTP id v72so774716itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvL40ZFRmn0Wk72FYLU0UQ1lKy9Er/AasuQ5PYhI8nk=;
        b=cgQLbnRuP7Uw+QDEDuAJHqSyVGsD5onbygMT1QQg39bzEmH1/g5RFyZsfdKnBxho0E
         JCsQjvaWb+1xBRghxvWB+HxM2ODzYK47vz2/PyogqvnlrxA3lbUQ54SMEy6NoS3PNr7S
         5PZ4kQtX7+1kyaoXr8tiGvfIcZeUhlhSJJ5iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mvL40ZFRmn0Wk72FYLU0UQ1lKy9Er/AasuQ5PYhI8nk=;
        b=tFkwYnXfWpupCXhk3nICPR7Uc56gSKWW2Nyre638ltK4hHS/k1W/2E9fvVfxlSE7go
         aFvTLRpBIOEKWrcJocyzTeZ2tpYHj32R12uOajPsiMVFB57tD9cOj7LUwaIQ0rOEzgie
         XL30mEpthVf96xvoZxFWQ+dbtrVodQZqicXVlLMtLBUk2fknInXivhxvPJSAjfHIJhaM
         PsQFRddxMzoBzeaCydF/trJYVntel6Mftjux/qqlr4wfC9NhTF4BHG4VPDkkTYX4lEuc
         ufChDAYDd1+EvxgftUSwE1JoMY7496C/DQ/hc4GTjvw0MgRQRLjSRswhOp2GOqEwDDFe
         hg5A==
X-Gm-Message-State: AHQUAuaBfhQ/oU0DzMmpD+k3l728yKFRICFuW9S8sGg0BtpoT7qKFT3e
        6YvYiY1yXUwRvTZ4XtJEB8wrPw==
X-Google-Smtp-Source: AHgI3IZ2ow5iAr5tnpy7PPNSLvpCLIUshXv1YVvLpaATm96e9gEn8cOJ0jTX4n5AP5v5qaVKEKMq+Q==
X-Received: by 2002:a24:3512:: with SMTP id k18mr485681ita.83.1549910404884;
        Mon, 11 Feb 2019 10:40:04 -0800 (PST)
Received: from chatter.qube.local ([184.75.214.131])
        by smtp.gmail.com with ESMTPSA id x23sm5237709ion.38.2019.02.11.10.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:40:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:40:00 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>, pr-tracker-bot@kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
Message-ID: <20190211184000.GA4907@chatter.qube.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Eduardo Valentin <edubezval@gmail.com>, pr-tracker-bot@kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190210041721.GA2805@localhost.localdomain>
 <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
 <20190211031921.GA1799@localhost.localdomain>
 <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:34:09AM -0800, Linus Torvalds wrote:
>On Sun, Feb 10, 2019 at 7:19 PM Eduardo Valentin <edubezval@gmail.com> wro=
te:
>>
>> On Sun, Feb 10, 2019 at 04:25:16AM +0000, pr-tracker-bot@kernel.org wrot=
e:
>> > The pull request you sent on Sat, 9 Feb 2019 20:17:23 -0800:
>> >
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-the=
rmal fixes
>> >
>> > has been merged into torvalds/linux.git:
>> > https://git.kernel.org/torvalds/c/7ad915f5ebf5b9e7ca98a7048d8f84a631fe=
388b
>>
>> I think the bot is off here because the above commit is about a merge
>> from the linux-omap tree from Tony.
>
>Indeed.
>
>.. and the pr-tracker-bot thing actually made me ignore the pull
>request, thinking I had left it in my inbox despite having pulled it.
>
>So it would be really good to know why pr-tracker-bot ended up
>replying to the wrong email, because it can cause real problems.

Simply put, it's because "it's a pull request sent to Linus." We=20
currently don't disambiguate between Linus showing up in "To" or in "Cc"=20
-- is that an important differentiation that should be enforced?

-K

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXGHBgAAKCRC2xBzjVmSZ
bOikAP4k/WGSPNLjFaIJjs5whbHnVp1dJFbC7jDGvYZr09JfMgEAhkOl2FHLz4wI
I1KPw4Q//nyD2mQ2jfs6lWm5azIFoAQ=
=rG2w
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
