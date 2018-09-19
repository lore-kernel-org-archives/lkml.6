Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14352C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FF20657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cantab.net header.i=@cantab.net header.b="No8WORmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80FF20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cantab.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbeITFPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:15:33 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:50795 "EHLO
        mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbeITFPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:15:33 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id EBDDD20E28;
        Thu, 20 Sep 2018 00:35:13 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id DED3520E90;
        Thu, 20 Sep 2018 00:35:13 +0100 (BST)
Authentication-Results: mta01.prd.rdg.aluminati.org (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=cantab.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cantab.net; h=
        content-transfer-encoding:content-language:in-reply-to
        :mime-version:user-agent:date:date:message-id:from:from
        :references:subject:subject:received:received; s=dkim; t=
        1537400113; bh=71yn1dt0vGoWHsl3AP5njRJqCIpSh6kV/DVVJnQzsTE=; b=N
        o8WORmJfkFKumHMaU9ag7ztb/k+RvWLozuMtar9zdtDpaInXtw+NpKMJDxsz1mxf
        Dfn8fL6lvnCpjwWWx0UVgJVw4pSDTEABjIn/9kvsc9GGHFPbT9FuVGBCEFXpVlWa
        eWP6Zqzm+jnXBtJTKlAmxUbhU0Pk4Q9pnazjN19z6JJrci07XxNBQYSBnWDCkD/1
        5361JdowKi/dfLtZxDav+59WuVMjB7d9gcaeWMRjkxrvXT2e/8M1ma+T7VzBSKWg
        B5B3nzNek+7THhriNmo19gf1tXpP45jl4CSQ/3KCqyNAYMQCBSITLM4vY1zgug/Q
        Kggt8hrzRh/UG+A8V54JQ==
X-Quarantine-ID: <lyg3yFFnNqSi>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lyg3yFFnNqSi; Thu, 20 Sep 2018 00:35:13 +0100 (BST)
Received: from [192.168.0.2] (cpc92884-cmbg20-2-0-cust324.5-4.cable.virginm.net [80.1.217.69])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 8D1E66239B;
        Thu, 20 Sep 2018 00:35:11 +0100 (BST)
Subject: Re: Code of Conduct: Let's revamp it.
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
From:   Edward Cree <ec429@cantab.net>
Message-ID: <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
Date:   Thu, 20 Sep 2018 00:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180919081812.020f19e3@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 15:18, Jonathan Corbet wrote:
> I'd like to address just this part, speaking only for myself.
> The LF is not in the position of arbitrating anything here.  The body
> charged with that is the LF Technical Advisory Board, which is a
> different thing.

Thank you for clarifying that.

Jon, you're a good person, and I trust you not to harass developers.
=C2=A0I'm not expecting you, or gregkh, or hpa to launch a dastardly plot
=C2=A0to boot an innocent developer off the project.

But there are too many ways this can go wrong, maybe not now or next
=C2=A0week but in five or ten years, when maybe a different kind of perso=
n
=C2=A0is on the TAB, or maybe external pressure is brought to bear on TAB
=C2=A0members.=C2=A0 (Some people are speculating that pressure has alrea=
dy
=C2=A0been brought to bear on Linus, although I'd like to stress that if
=C2=A0he feels that changing the way he communicates is best for the
=C2=A0project then I for one thoroughly respect that.)

Or maybe some manipulative extrovert will manage to whip up a media
=C2=A0storm about some developer's innocuous remarks, the court of public
=C2=A0opinion will immediately convict, other developers will be caught
=C2=A0in a preference falsification cascade as no-one wants to take the
=C2=A0risk of defending them.=C2=A0 Are you, and the other members of the=
 TAB,
=C2=A0strong enough to hold back the lynch mobs when you know the guy
=C2=A0hasn't done anything wrong?=C2=A0 Do you really want to take on the
=C2=A0responsibility to do that, perhaps time and time again?=C2=A0 And c=
an
=C2=A0you be sure that you won't fall for a misleading framing by some
=C2=A0charismatic sociopath of a fight you missed the start of?

Given that possibility, I think it is important for the kernel
=C2=A0community to continue to send a strong signal that divisive identit=
y
=C2=A0politics are not welcome here; and I think that to adopt a Code of
=C2=A0Conduct that contains in its opening sentence a laundry-list of
=C2=A0protected classes (and was written by a, shall we say, divisive
=C2=A0figure with a history of identity politics advocacy) sends precisel=
y
=C2=A0the opposite signal.

Linux is too important to civilisation to allow it to be turned into
=C2=A0just another battlefield for the American culture war; commit
=C2=A08a104f8b5867 seems like an invitation to both armies to take up
=C2=A0positions on our fertile farmland.=C2=A0 The only rule that gives n=
o
=C2=A0comfort to discriminatory political abusers (on either side) is=E2=80=
=94
=C2=A0ye shall judge by their code alone.
