Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A94C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="LuPgo1xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF9B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeFTTlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:41:22 -0400
Received: from erza.pados.hu ([176.9.136.194]:33020 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754676AbeFTTlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tv3d89gH/fHWXvwkWytcfAuJCY4H5ptTkSLTB4jzMcY=; b=LuPgo1xn76Dhr5fg/awrkiEYwT
        8KEGEMkdqEh6moK+tsGXVOeBHdtq3uOdU0eAL59zeKrALQAVb8Vbu4PxWaKyW4jCLfYa9k4ExfHq1
        gxRumNwwhr2vlWCpLCWcEiM9iBaGL408D5VkhI8N+41AIo9XyuPLWhf0Xk02LYXebjEF0zivrJzIs
        xywT4vnE7bY4XbiIjsIWsTVvb6xJ8nG+LsXIzT9ch4JEwt83MOAzRLjaEGQINRrQHF0r7z1b8T+8r
        9vhZyy6WIAezpjFqrplgAbNvipwP27VJ7c2x4n1ClnqzqRp2QrbrrIKwgYsdGNYzMsxjDZHPGRpuB
        iJBQttdA==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fViyi-00050y-HH; Wed, 20 Jun 2018 21:41:16 +0200
MIME-Version: 1.0
Date:   Wed, 20 Jun 2018 19:41:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <7369694284fcea1a8d7c142f47ab361f@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for 
 CP2102N
To:     "Martyn Welch" <martyn.welch@collabora.co.uk>,
        "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1529513516.2395.23.camel@collabora.co.uk>
References: <1529513516.2395.23.camel@collabora.co.uk>
 <20180620082507.GO32411@localhost> <20180617182503.23080-1-pados@pados.hu>
 <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
 <20180620105231.GQ32411@localhost>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Martyn, > The rationale for the pins being permanently
   configured as output pins > is that these pins (at least on the cp2105) do
    not appear to provide a > true input mode. They offer a "push-pull" mode
   (where the voltage is > pulled directly to ground or supply rail) and an "open-drain"
    mode > (where the pin is weakly pulled high by an internal resistor and can
    be > pulled to ground). Unless I missed something, there is no tristate/high
    > impedance mode typically associated with a pin being used as input. [...]
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

Hi Martyn,=0A=0A> The rationale for the pins being permanently configured=
 as output pins=0A> is that these pins (at least on the cp2105) do not ap=
pear to provide a=0A> true input mode. They offer a "push-pull" mode (whe=
re the voltage is=0A> pulled directly to ground or supply rail) and an "o=
pen-drain" mode=0A> (where the pin is weakly pulled high by an internal r=
esistor and can be=0A> pulled to ground). Unless I missed something, ther=
e is no tristate/high=0A> impedance mode typically associated with a pin =
being used as input.=0A=0AYou didn't miss anything. It is the same for ma=
ny (maybe all) SiLabs=0Adevices, in particular also for the cp2102n, whic=
h spawned this conversation.=0AI sent in patches for its GPIO support, bu=
t in contrast to the cp2105,=0AI try to emulate input mode by making sure=
 that a pin is never pulled low=0Awhen it is set as an input, and that yo=
u cannot set push-pull pins as inputs.=0AThe reason why you were invited =
is because we are trying to figure out which=0Aapproach should be taken.=
=0A=0A> Sure, you can use the open-drain mode as input as long as you=0A>=
 understand that the permanent pull up in the cp2015 might have an=0A> im=
pact on what you are reading. For example, if you have a signal that=0A> =
is externally weakly pulled down, it's going to depend on the relative=0A=
> resistances of the internal and external resistors as to what voltage=
=0A> the line rests at and therefore what state the line is considered to=
 be=0A> in. This could stop things working if you naively think the cp210=
5 is=0A> acting as a typical high-impedance input.=0A=0AHere I argue the =
following multiple ways. First, I say that claiming that=0Aa pin which is=
 used as an input is actually an output is not only confusing,=0Abut also=
 much less correct than thinking of it as an input pin with a weak=0Apull=
up to prevent floating signals. Second, the pullups - while not =0Aexplic=
itly listed in the datasheet - can be calculated from what is there, =0Aa=
nd for the cp2105 are typically 132k, for the cp2102n even higher around =
=0A165k. These are pretty weak pullups, so weak that they won't matter fo=
r=0Athe vast majority of applications as people rarely use pull-ups or pu=
ll-=0Adowns higher than 100k (not never, but rarely). So claiming that it=
 can=0Aresult in false expectation, while not completely wrong, is favori=
ng the =0Aneeds of a few instead of the much more common practice.=0A=0AL=
astly, and maybe most importantly, I argue that calling everything an =0A=
"output" pin only in name does not actually avoid any design errors, as=
=0Athe same circuit that would case a false reading in one case would als=
o=0Acause the same false reading in the other, and the circuits are usual=
ly=0Adeveloped before the software. So it'll be too late anyway by the ti=
me =0Asomebody realizes such a mistake. But on the contrary, it opens up =
more =0Aopportunities for errors, because now you are open to software bu=
gs that=0Aignore a pin's direction because everything's an output either =
way even =0Awhen it really isn't, and think that they can treat it as=0Aa=
s open-drain while for some reason it is in push-pull mode. Worse,=0Aeven=
 if it is in open-drain mode, it will only work with a specific output=0A=
values - it must be high, which is not the default. With my proposal, =0A=
setting a pin's direction to "input" will make sure it cannot be actively=
 =0Adriven by the chip, avoiding such "misunderstandings" and errors, and=
 =0Asimilar measures are also in place for the push-pull pins.=0A=0AThe o=
nly problem I can see is if there isn't a way for the cp2105 to =0Aquery =
the reset values of the pins (maybe there is, I just haven't =0Alooked in=
to it). Then I don't know how the direction could be =0Adetermined for an=
 open-drain pin during initialization. But this is =0Asolved for the cp21=
02n, and then it is a device-specific issue for =0Athe cp2105, which shou=
ldn't be forced onto other devices if we otherwise =0Adecide the approach=
 to be inferior.=0A=0AKaroly
