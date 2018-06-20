Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92380C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CA620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="t7B6s1Ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CA620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeFTJvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:51:48 -0400
Received: from erza.pados.hu ([176.9.136.194]:46514 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeFTJvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G/eooBuIxPIc1PDMWhsVgetISF7ZB8EuCTESxAw0DMw=; b=t7B6s1Ga1p41Mks4hv+G5DHXKE
        PqQz0okjNh0+Q+m+vTVKVnbJN0VDM84L0LbKJnhBvLdMkIV20aLz4F3zoHJ4sKeEsFu6twJV5C9oF
        iMHogDlfKhnBaA2c8AJASOGp2fCVpsAGCmaKNsZSstriZuBTgoDC3SFjBlNop3pQ+6dt3K0rlrDwW
        Xru5BwllHzHCAQsfmnsOI5zLQYSYU4jGUT0Or6Ij4Z6J9qqE06KrRIly85FHxHG4H4MHTDnEtjXQG
        vLj+6rol/7925A5pBhEfgVfBm+4w7C7jLttg7pEWqqH2nEY7okmk9sr+EWti+16OwDbkKlmYZUOZe
        VngdGrwQ==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fVZmB-0006uN-OD; Wed, 20 Jun 2018 11:51:43 +0200
MIME-Version: 1.0
Date:   Wed, 20 Jun 2018 09:51:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <b82f656ba4c2c05d86ae7149be4109c6@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Improve baudrate support for
 CP2102N
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180620093905.GP32411@localhost>
References: <20180620093905.GP32411@localhost>
 <20180619091528.GN32411@localhost> <20180615212957.26539-1-pados@pados.hu>
 <0b27c3da292fa1f4b360614685fe8aa4@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  > By the way, have you tried setting other baudrates except
    the ones you > explicitly allow for here? According to the data sheet more
    rates should > be available, so perhaps just handling cp2102n as cp2108 (e.g.
    by not > trying to report back the exact rate used) or by actually calculating
    > the resulting rate could be another option? > > Can be done later of course,
    just curious if you tried it. > [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> By the way, have you tried setting other baudrates except the ones you=
=0A> explicitly allow for here? According to the data sheet more rates sh=
ould=0A> be available, so perhaps just handling cp2102n as cp2108 (e.g. b=
y not=0A> trying to report back the exact rate used) or by actually calcu=
lating=0A> the resulting rate could be another option?=0A> =0A> Can be do=
ne later of course, just curious if you tried it.=0A> =0A=0AYeah I know, =
I was thinking about this too while developing the patch. =0AOfficially t=
he cp2102 and the cp2102n are fully software compatible (aside=0Afrom bau=
drate aliasing), but if the cp2102n chooses different baudrates for =0Ath=
e same inputs than the older devices would then they couldn't/wouldn't be=
=0Acompatible. So I concluded it must also be doing the quantisation.=0A=
=0AMaybe I am too naive and trust the datasheet to much. I'll do some mea=
surements=0Awith my scope and let you know the results.=0A=0ABest,=0AKaro=
ly=0A=0AJune 20, 2018 11:39 AM, "Johan Hovold" <johan@kernel.org> wrote:=
=0A=0A> On Tue, Jun 19, 2018 at 09:50:54AM +0000, Karoly Pados wrote:=0A>=
 =0A>> Hello,=0A>> =0A>> Pass in a struct usb_serial (or port) as a first=
 argument instead which=0A>> allows for more readable code as well as for=
 this to be reused to handle=0A>> other device type differences (e.g. onl=
y 2108 besides 2102n handles=0A>> baudrates over 921.6k).=0A>> =0A>> Sure=
, will do.=0A>> =0A>> Add a static helper (looks like you add a define in=
 the gpio patch)=0A>> cp210x_is_cp2102n(serial) here.=0A>> =0A>> Yes I ha=
ve macro for that in the GPIO patch, and I will turn that into a=0A>> sta=
tic function too.=0A>> =0A>> To keep the baudrate and gpio patches indepe=
ndent,=0A>> do you think it is a good idea if I make a new patch which on=
ly adds the=0A>> partnum defines and the helper function first, then baud=
rate v2 and gpio v2=0A>> can build onto it?=0A> =0A> No, that's fine. And=
 you can submit it as a series, where the first=0A> patch using the helpe=
r includes it (e.g. the baud rate one).=0A> =0A>> You can even test for b=
it 0x20 in the=0A>> helper if you prefer (we can always change that later=
 if needed).=0A>> =0A>> If you wish, but personally I think that is askin=
g for future bugs=0A>> in the long run. Even though the helper can be eas=
ily adjusted if needed,=0A>> when/if a new partnum shows up which has not=
hing to do with the cp2102n,=0A>> no one will think of having to adjust c=
p2102n-spacific code until bug reports=0A>> start coming in. So I'd prefe=
r to explicitly check for the packages, but in=0A>> the end I'll use what=
ever you prefer.=0A>> =0A>> What do you prefer?=0A> =0A> Sure, I have no =
strong preference. You can keep the explicit package type=0A> enumeration=
 if you want, but move it to a static helper. We'll see how=0A> this ends=
 up being used in the series.=0A> =0A>> And even if the current code uses=
 this odd formatting, your amendments=0A>> should not.=0A>> =0A>> Of cour=
se. I also saw this is odd, but (apparently wrongly) decided to=0A>> stay=
 consistent inside the function with existing code. I will change=0A>> th=
at too.=0A> =0A> Yeah, that's admittedly a bit arbitrary. I should probab=
ly just clean=0A> this up somehow once and for all.=0A> =0A> By the way, =
have you tried setting other baudrates except the ones you=0A> explicitly=
 allow for here? According to the data sheet more rates should=0A> be ava=
ilable, so perhaps just handling cp2102n as cp2108 (e.g. by not=0A> tryin=
g to report back the exact rate used) or by actually calculating=0A> the =
resulting rate could be another option?=0A> =0A> Can be done later of cou=
rse, just curious if you tried it.=0A> =0A> Thanks,=0A> Johan
