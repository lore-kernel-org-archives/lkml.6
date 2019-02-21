Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5660C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE84207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cEGauRB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfBUWGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:06:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42008 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:06:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so73387pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sNViGJvrXCaoJlnXuiNu2YjSa7SxUCjLL8DEwon24Q8=;
        b=cEGauRB+4YtZAU6hGgs5/nvyC+ld9C327auZPsEhqYsWb3OUPLwPoodFEZWbJ7kMES
         nYKnRpLL4zanjpuV09G5vUdUdCnX2kUxi/72XwRFBJQH8N0E/CypZyAAmWC3Ry7cvGVZ
         f14xvCDLwlHI5IzrU6SCmgL5z7Z/HBhFw4ip1jlAlHylG/h1hxP4htILVAqFZcouCwiF
         +MN/TiMmHhfcVvuPXAt9zRnprl4WhE07f2qS8LY4YxO9EVTlReiaO2jb9MGtJY1xBc+q
         REBP/64Zi354XtXSC3LCVTalcOzBWtW07TU3ZyFQrvWODXWqXzpKse+UY/FI+vbn2iPK
         2zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sNViGJvrXCaoJlnXuiNu2YjSa7SxUCjLL8DEwon24Q8=;
        b=rq69S6uiSo6UN/EI7vwV4mNRjomapDmI2elozmFnJKSJ3CLeRQTvGtLKkaYYFFxyRa
         mNwe/Hjh6EETI3DB79S7TzppFPRaZ0Ed0q8OoyN7tm5CCII+mpALFrGalSLOgUZmZjV4
         9pYNXTfN6f6yVnSo3CVctZIhA8vP2DdrgFvnoDmHyPjk/SPMsWXEosZhUk2/pdjdI6xd
         rvqLrglMIM4uMcmdDCOwUu1zF8kxks3SpRVfkAPd7tVOBQZeMqXgkn04uCunLbQoDFKa
         1G5HaWew0bXxgs7N8/msVd76wCU5R+IaI1fm4iOR+qsi+1liRzMdjTCgs34l+zUKBq8g
         6JSQ==
X-Gm-Message-State: AHQUAua0iHWmNJsx8T3dyX2w5Gi2fMFVoc+UFSvCtCSV/ko9jaoxz2Ek
        o6sWa5WeRb2b0R4rfmtwzYMKxg==
X-Google-Smtp-Source: AHgI3IY9PTilcQLs2Ybwg4yTYtSN5TxL+HhrgS9MGVT6NQHrtNXoMUUy8KMBlVZ64S+F1TM5GaoemA==
X-Received: by 2002:a63:ef50:: with SMTP id c16mr711567pgk.3.1550786789525;
        Thu, 21 Feb 2019 14:06:29 -0800 (PST)
Received: from ?IPv6:2600:1010:b016:9155:d0fd:1b5f:8b43:47e6? ([2600:1010:b016:9155:d0fd:1b5f:8b43:47e6])
        by smtp.gmail.com with ESMTPSA id q28sm28508pgl.35.2019.02.21.14.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:06:28 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190221124629.GA12696@fuggles.cambridge.arm.com>
Date:   Thu, 21 Feb 2019 14:06:26 -0800
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <43ED7513-6A7E-45BC-973A-4EB6DB8E5505@amacapital.net>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net> <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net> <20190214101429.GD32494@hirez.programming.kicks-ass.net> <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com> <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com> <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com> <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <20190221124629.GA12696@fuggles.cambridge.arm.com>
To:     Will Deacon <will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Feb 21, 2019, at 4:46 AM, Will Deacon <will.deacon@arm.com> wrote:
>=20
>> On Wed, Feb 20, 2019 at 02:55:59PM -0800, H. Peter Anvin wrote:
>>> On 2/19/19 4:48 AM, Will Deacon wrote:
>>>=20
>>> I think you'll still hate this, but could we not disable preemption duri=
ng
>>> the uaccess-enabled region, re-enabling it on the fault path after we've=

>>> toggled uaccess off and disable it again when we return back to the
>>> uaccess-enabled region? Doesn't help with tracing, but it should at leas=
t
>>> handle the common case.
>>>=20
>>=20
>> There is a worse problem with this, I still realize: this would mean bloc=
king
>> preemption across what could possibly be a *very* large copy_from_user(),=
 for
>> example.
>=20
> I don't think it's legitimate to call copy_{to,from}_user() inside a
> user_access_{begin,end} region. You'd need to add some unsafe variants,
> which could periodically disable uaccess and call cond_resched() inside
> the loop to avoid the problem you're eluding to.
>=20

Definitely not safe. On x86 they do CLAC and everything breaks.=
