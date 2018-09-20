Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636E3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190572150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cantab.net header.i=@cantab.net header.b="j2c5Dgny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190572150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cantab.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbeITHzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:55:18 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:42203 "EHLO
        mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbeITHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:55:17 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id D792B20EB1;
        Thu, 20 Sep 2018 03:14:26 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id C83DE20E90;
        Thu, 20 Sep 2018 03:14:26 +0100 (BST)
Authentication-Results: mta01.prd.rdg.aluminati.org (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=cantab.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cantab.net; h=
        content-transfer-encoding:content-language:in-reply-to
        :mime-version:user-agent:date:date:message-id:from:from
        :references:subject:subject:received:received; s=dkim; t=
        1537409666; bh=17a3AXeMDyphqzJHotcSkcb+gBbltGJReSb3du6tBIk=; b=j
        2c5Dgnym3DTqsxiQGOESUwhK9anA/bf+2vy7RPV42ldCh8OAKvT3qIG7A/Qm6prB
        eAlFi6P71nLpMPSOxLAvZfIaiWEuFBvlvQXZ9aID4wJTdB25YP88Jl42rFdBGBNn
        JVzUo4ffSVY4BuyQgO58v667q+UdujcJi+XAFKC0kpkR0Ud/SBBIYDRnyE8QTEv4
        sQ+gftNoDRWeqoa87OI2WqiDEYndUkVp5HyJZg8pk0KL44jpSswGYFoVYVCHoDEm
        4Xnz4EcqbZFOGoo9PD3epRir93S2Q7/grks9eIMvlzdLKi5j0zSkSERk/3oPSMEn
        AiC6bw+9jcBW/jxGP2Uiw==
X-Quarantine-ID: <i6i8TXV0txjx>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i6i8TXV0txjx; Thu, 20 Sep 2018 03:14:26 +0100 (BST)
Received: from [192.168.0.2] (cpc92884-cmbg20-2-0-cust324.5-4.cable.virginm.net [80.1.217.69])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 1997E6219C;
        Thu, 20 Sep 2018 03:14:22 +0100 (BST)
Subject: Re: Code of Conduct: Let's revamp it.
To:     Olof Johansson <olof@lixom.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
From:   Edward Cree <ec429@cantab.net>
Message-ID: <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
Date:   Thu, 20 Sep 2018 03:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/18 02:16, Olof Johansson wrote:
> I would be very surprised if any of my peers on the TAB ever had those
> intentions, and I know I would not have them myself.
In case my references to individualsmade it unclear: I have no reason to
=C2=A0suspect _any_ of the present TAB members would; everything I know a=
bout
=C2=A0them points to them being good, honest and principled people.

> I can
> see how that kind of environment _could_ be implemented with the same
> code of conduct as a base, but [...] I know I
> would fight strongly against that.
It is definitely reassuring to hear you say that.

> There is a list in the first paragraph, but the preceding words say
> that it should be a *harassment-free experience for everyone*. That
> part of the paragraph is to me the most important part.
It certainly _should_ be the most important; IMHO the sentence should end
=C2=A0after 'everyone'.

> Your above argument that the Code of Conduct is problematic because of
> who wrote it seems to contradict your statement that we shall judge by
> code (or text) alone.
I think there are important differences between code to be run by CPUs
=C2=A0and a Code to be run by humans.=C2=A0 And when the author goes on a=
 victory
=C2=A0lap on Twitter and declares the Code to be "a political document", =
is
=C2=A0it any surprise I'm worried?

Applying extra scrutiny to a political document written by someone with a
=C2=A0history ofstirring up political antagonism is like checking the loc=
king
=C2=A0extra-carefully in a patch from a developer who has a history of le=
tting
=C2=A0locking bugs slip through.
