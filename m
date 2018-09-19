Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B587C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3712146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cantab.net header.i=@cantab.net header.b="qvI5bjMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3712146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cantab.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeISLme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:42:34 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:53275 "EHLO
        mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730604AbeISLme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:42:34 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2018 07:42:32 EDT
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 4DC9720F2C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:00:29 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 4778920F04
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:00:29 +0100 (BST)
Authentication-Results: mta01.prd.rdg.aluminati.org (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=cantab.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cantab.net; h=
        content-transfer-encoding:content-language:mime-version
        :user-agent:date:date:message-id:subject:subject:from:from
        :received:received; s=dkim; t=1537336827; bh=+46RYLRDQHkzTmmowgB
        6haHl9wbzeFK1hhMk7yCkaXg=; b=qvI5bjMMXEM9bKV7XUpf7bcv8LM5FHR+YDB
        z5adbf8Nlkj+xJVuXnT9SXnsr/RxlSQ5Nw+bTvcUbiiiItPyXQChzZx4a7nhAZKg
        xREkVaA/niQ6zMp4nPgGGYXz93AZESxIjFp/hwc9kMoGGkbuSHpI+CxydFzVN63w
        Has40zc6Nkhy50SH8wTpKS/u3flGBzKKBF3ncjYnW5PybIsTRSqsGxATStov5sRt
        JyPI2RaSvWuScyHeke8TXdwCm6rLNzN/XF2IoMhXvDZER6jBWzMl1ZMqgICBn2kG
        MYFctjQeYR0qick6W7gtNt9k8cwguaKjpQQeF/b+8zcan00sPyg==
X-Quarantine-ID: <bB1rDNDgIEl2>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bB1rDNDgIEl2 for <linux-kernel@vger.kernel.org>;
        Wed, 19 Sep 2018 07:00:27 +0100 (BST)
Received: from [192.168.0.2] (cpc92884-cmbg20-2-0-cust324.5-4.cable.virginm.net [80.1.217.69])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 9947762FDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:00:26 +0100 (BST)
To:     linux-kernel@vger.kernel.org
From:   Edward Cree <ec429@cantab.net>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
Date:   Wed, 19 Sep 2018 07:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Code of Conduct makes me feel threatened and uncomfortable.

No, really.=C2=A0 As a person with (diagnosed) Asperger's, I'm a member o=
f,
 =C2=A0objectively, a marginalised minority.=C2=A0 Effectively (i.e. this=
 is a massive
 =C2=A0oversimplification), I was born without the hard-wired circuitry f=
or=20
social
 =C2=A0interactions that is normally a part of the human brain; consequen=
tly=20
I have
 =C2=A0to run a slow and inaccurate software simulation when interacting =
with
 =C2=A0'normal' people.

In nearly all the communities I participate in, this is a constantly=20
limiting
 =C2=A0factor for me.=C2=A0 But there is one world that is blessedly free=
 of such=20
things:
 =C2=A0the world of open-source software.=C2=A0 It is one of the last pla=
ces where my
 =C2=A0particular neurodiversity does _not_ mark me out as Other, does _n=
ot_=20
force
 =C2=A0me to carefully watch what I say and present a falsely constructed=
=20
fa=C3=A7ade in
 =C2=A0place of my real identity.=C2=A0 For here, we care not for 'feelin=
gs';=20
either the
 =C2=A0code is good or it is bad, and in the latter case we say so direct=
ly and
 =C2=A0bluntly.=C2=A0 Not only does this mean that I don't have to guard =
my tongue=20
when
 =C2=A0critiquing someone else's patch, far more importantly it means I c=
an
 =C2=A0understand what's being said when _my_ patches are criticised.=C2=A0=
=20
(Almost all
 =C2=A0of my best ideas and patches have been born out of someone telling=
 me I'm
 =C2=A0wrong.)

The Linux kernel community is a place without office politics, without=20
subtle
 =C2=A0subtexts, without primate dominance dynamics.=C2=A0 A place where =
criticism=20
_can_
 =C2=A0be gracefully accepted _without_ having to worry that admitting to=
 being
 =C2=A0wrong will lower one's status.=C2=A0 A place where I, and people l=
ike me,=20
can feel
 =C2=A0at home, and maybe even create something of value.

And the Contributor Covenant looks very much like the camel's nose of an
 =C2=A0attempt to take that place, that community, away from me.=C2=A0 To=
 replace=20
it with
 =C2=A0an Orwellian nightmare where I must forever second-guess what is s=
afe=20
to say.
 =C2=A0(First they came for "master/slave replication", and I did not spe=
ak up
 =C2=A0because I was not a DBA.)

I cannot speak for my employer (hence why I am posting this from my perso=
nal
 =C2=A0address), but to the extent that my r=C3=B4le as a contributor to =
the=20
networking
 =C2=A0subsystem, and as co-maintainer of the sfc driver, gives me any=20
standing in a
 =C2=A0_personal_ capacity, I absolutely cannot sign up to this 'Pledge' =
nor=20
accept
 =C2=A0the 'Responsibilities' to police the speech of others that it make=
s a=20
duty of
 =C2=A0maintainership, and I urge the project leadership to revert its ad=
option.

Some elements of the Code are unobjectionable; sexual advances, for=20
instance,
 =C2=A0have no place on the lkml (though they may at, say, a conference, =
and not
 =C2=A0everyone can reliably predict whether they are unwelcome), and the=
=20
ability of
 =C2=A0kernel developers to accept constructive criticism is one of the s=
trengths
 =C2=A0that has made Linux what it is.=C2=A0 But far too many of its prov=
isions=20
rely on
 =C2=A0ill-defined terms, and thus give those charged with interpreting t=
hose=20
terms
 =C2=A0the power to destroy livelihoods.=C2=A0 By placing a corporate bod=
y (the LF) in
 =C2=A0the position of arbiter, an avenue is opened for commercial pressu=
re to be
 =C2=A0applied; and the legalistic phrasing of the Code practically invit=
es=20
rules-
 =C2=A0lawyering whereby the most abusive may twist it into a weapon to f=
urther
 =C2=A0their abuse.

If the Code were reduced to something more like the old Code of Conflict,
 =C2=A0reminding people to 'be liberal in what they accept and conservati=
ve=20
in what
 =C2=A0they emit', and clarifying that patch submissions should be judged=
 by the
 =C2=A0_code_ and not by any characteristics or beliefs of the submitter =
(I don't
 =C2=A0think the enumerated list of protected classes is helpful, as a le=
galistic
 =C2=A0abuser can always slip into a crack between them), I think the sti=
ng=20
would be
 =C2=A0drawn.=C2=A0 Probably the CoConflict would make a better base from=
 which to=20
draft
 =C2=A0such a document.

(A note for the irony-challenged: where I use Progressive terms-of-art, s=
uch
 =C2=A0as 'marginalised', 'Other' and 'identity', in the above, I am=20
endeavouring to
 =C2=A0show that this alleged push for 'inclusiveness' fails on its own=20
terms; I am
 =C2=A0_not_ accepting the theory behind those terms nor suggesting that,=
 in
 =C2=A0reality, the kernel community owes me any special treatment on acc=
ount=20
of my
 =C2=A0'diversity'.)

