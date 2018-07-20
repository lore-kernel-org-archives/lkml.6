Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBF020671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ECcqUiho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBF020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeGTWZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:25:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42806 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbeGTWZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:25:43 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so3920844plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TrOMp6tw/qEZYufr/W/wdI7QDq7hMWueQHWQr1XF9Zc=;
        b=ECcqUihov/5TgD6+OU89YumvUuHsVdrjoCa6ZlP/YptOiAZo4j7bhzBaMmi6PHzWe6
         XvHMvpG6ooyhce7/niVxNKx6VNBdL6chq4JOsIvK/iR20X8NXVVK30y3rbGaLQXWS6wB
         h1xDLlVRki3rq+dyn3OL6nYCMcY2s65g1alyqfDrPzYywS2KzNzkUM+Dxhz5L2Hd4Gqi
         mTidV0DeHz+oX1vsO0k4WwMGEEAe6GghqW8XmBYtwPJNkK9pfTirPQ7zb0JaO38DGV2m
         ixSy6mzuDQWNFOK+gK3p4cM6y+hIlrFPAdV9FUfmW+QNDYJK6tunIbXTb7gmfy8TRN/h
         G2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TrOMp6tw/qEZYufr/W/wdI7QDq7hMWueQHWQr1XF9Zc=;
        b=ZROjGXDmltGPGetDprv49ZqJow3g74edw0LfATAxwuqrlRdG9ITyZMUGrZM8KAY3Tb
         TChcP+rSAt6O3GTOZ2I67qKaaTZRktDXi36J52Y1uw7wyjt5Ft3sVB63j0+7wnZGSK2Y
         SFAm716Fzpnq6W/NddaduAF4x8XP3tT5VCoCf8FmK162BRViG8hqlxiCFbIDj97aprKZ
         yTY7OSeGOFgXqFl/JcbQsbSJSgGnt1ZWUBdqXIFLSuIlJCp2B0N63jfhdLfZ+ovkHaHA
         DI0IPTb5djBgjYqiwn8aM9dYJ4IZ/ckW5qKn7KqkUieYy8YJcaIKXGfvj3ap8kQhXiay
         afiA==
X-Gm-Message-State: AOUpUlGhgklTQVRdQwDjwd0izRbW0JaO7nKLSO5L4zKb3+QnqR8XZojg
        6Q7hiF3B583gSqmFu+tWvoPSVQ==
X-Google-Smtp-Source: AAOMgpdOdgRahK3wFTVnmaI/cZY/wY0klG413zJikb8e1LI+6CmXnDD3iwPwxVVMLsoukv4JAfddPg==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr3568145plk.302.1532122537598;
        Fri, 20 Jul 2018 14:35:37 -0700 (PDT)
Received: from ?IPv6:2600:1013:b010:3805:49d9:11b0:692b:4e3d? ([2600:1013:b010:3805:49d9:11b0:692b:4e3d])
        by smtp.gmail.com with ESMTPSA id z8-v6sm3816487pfe.163.2018.07.20.14.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 14:35:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Kernel 4.17.4 lockup
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAMe9rOr_9zsAKMxQaxka8RWCXC8Jc7svdG3tKcp6Q+_EDTC=Zg@mail.gmail.com>
Date:   Fri, 20 Jul 2018 11:35:34 -1000
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88CBCB04-43F6-4353-82F7-20A67AD49B65@amacapital.net>
References: <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com>
 <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
 <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com>
 <067e2d5d-1abf-efd4-cb50-992ba5ca6748@intel.com> <20180711183126.yo7eyqpd4ggb5kcr@codemonkey.org.uk>
 <9A6C6EEB-85D8-4F59-95ED-EB4DA5947BCA@amacapital.net> <f3e2ca08-e22d-f16c-1c2e-9fb1985771ef@intel.com>
 <CAMe9rOpBm71hnzG0wx=2qaWKHYNE30JJOT=Jt4i+Vqs3Xb4qBQ@mail.gmail.com>
 <CAMe9rOoX-x-YezXc_1EE9F0Nv3_SuzN+paXsTO11gcTykMr4Tw@mail.gmail.com>
 <CALCETrUwUdmRAfaKsP0dGXriU=EdoWs69XMwJwxDOLY_9G+1tw@mail.gmail.com> <CAMe9rOr_9zsAKMxQaxka8RWCXC8Jc7svdG3tKcp6Q+_EDTC=Zg@mail.gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 16, 2018, at 6:05 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
>> On Fri, Jul 13, 2018 at 7:08 PM, Andy Lutomirski <luto@amacapital.net> wr=
ote:
>> I'm not at all convinced that this is the problem, but the series here
>> will give a better diagnostic if the issue really is an IRQ stack
>> overflow:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=3Dx=
86/guard_pages
>>=20
>=20
> This kernel won't boot with this configure file.

Bah humbug. You=E2=80=99ll need to turn KASAN off (and maybe even compile it=
 out entirely) if you want to test this. I need to bug the KASAN folks to un=
break their interaction with stacks in vmap space.  It=E2=80=99s been broken=
 literally forever, but I keep incorrectly imagining that it=E2=80=99s been f=
ixed already.

>=20
> --=20
> H.J.
> <config.debug.xz>
