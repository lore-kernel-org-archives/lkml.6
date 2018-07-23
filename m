Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A08ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70420883
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1rSIgrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E70420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbeGWPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:53:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34300 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeGWPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:53:12 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so1625768ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q3AjcYW0zP7DBA6DnYLJI16arwQ6xbmIVgLdwfjyJd8=;
        b=u1rSIgrtbCjvxl4s057wjfmG6+tcLaaIr6ZHcCc80rkZhKIWUA7OPRyQ9HBtDOjt4F
         g7gJSRDrI247urqzmboQcgsX1mYZb6ZHjX4tncGFPC+l+JMU0UBAmSvzWfDeO40w07Wh
         8OjL/96jJdvKPWmpYZsE/wtCaZkZRGJ+NE2i9gmEF5EdLKPIHgkdT1RDIMk561TJTfCO
         OMXN/qDdEbQmurJupMyljukjCIqrpNKil4pWNveAeZ0zx6bPmByKn3VrF5Hd3dtfxtn2
         WI+fr0giNCYo6nyM8RpEIKGRYT4WEShu1wydqe/MUb9HZQD6L8PJLo7ALojM+zHBerFN
         U2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q3AjcYW0zP7DBA6DnYLJI16arwQ6xbmIVgLdwfjyJd8=;
        b=a93ezVW68HeoOD7pEvGdQsEO16ZYi9U/f8+STa9b+5CmMYhEXlWLjFwa5Hk3kJ529h
         eQdTdJ3ZMzXqkpcr3arcZObBBNquwPLsfHKPWAMewVKCh4ISqUclnUQmJftyr73X879n
         mjPGI6WWhRjXJNQE5h4Q5WiXdLWXuf6yvWPy5F0ydm2XlQnDISCmWOB+A0y+RsxuTMaE
         0XzZexgCYpOAt0xh/nbLT4P3qk0lxb7tm7PxXOe8DULTOqvNzXJDLy77W2grwYnqxrjl
         01/iKmAqmz5SnuDIP5TL5e2uWjvM6l5RVqyjH7gBr8FD2Ng6zRHI6aa9zQsT+JA5QMZt
         lNtw==
X-Gm-Message-State: AOUpUlG0EbGTr/c6PtJt/aFZ9jtKR9sTASAhMLJw7/of7Bj+NAO5Dm3s
        Mo02SshYHm/pw2ImKQgC12GuEyVDTuUe02H+1cU=
X-Google-Smtp-Source: AAOMgpfzySYtMVQBkdW4RA654En7/8IC7ZB+WRBZ/SIh6B0phrj4hP2zTi+u+BsGO9uC3GB+NLhGPkWT7LSHFKUJnr8=
X-Received: by 2002:aca:ac54:: with SMTP id v81-v6mr8264073oie.1.1532357495918;
 Mon, 23 Jul 2018 07:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 07:51:35
 -0700 (PDT)
In-Reply-To: <88CBCB04-43F6-4353-82F7-20A67AD49B65@amacapital.net>
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
 <CALCETrUwUdmRAfaKsP0dGXriU=EdoWs69XMwJwxDOLY_9G+1tw@mail.gmail.com>
 <CAMe9rOr_9zsAKMxQaxka8RWCXC8Jc7svdG3tKcp6Q+_EDTC=Zg@mail.gmail.com> <88CBCB04-43F6-4353-82F7-20A67AD49B65@amacapital.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 23 Jul 2018 07:51:35 -0700
Message-ID: <CAMe9rOqzvPARD6srX5BZym2ah1Ga4Z_QuJNQV-GG3d3tQ3RKCg@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 2:35 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
>> On Jul 16, 2018, at 6:05 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>>> On Fri, Jul 13, 2018 at 7:08 PM, Andy Lutomirski <luto@amacapital.net> =
wrote:
>>> I'm not at all convinced that this is the problem, but the series here
>>> will give a better diagnostic if the issue really is an IRQ stack
>>> overflow:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=
=3Dx86/guard_pages
>>>
>>
>> This kernel won't boot with this configure file.
>
> Bah humbug. You=E2=80=99ll need to turn KASAN off (and maybe even compile=
 it out entirely) if you want to test this. I need to bug the KASAN folks t=
o unbreak their interaction with stacks in vmap space.  It=E2=80=99s been b=
roken literally forever, but I keep incorrectly imagining that it=E2=80=99s=
 been fixed already.
>

This particular kernel oops has been fixed by kernel 4.17.7.  But now
I am running into
another kernel oops:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1597559

--=20
H.J.
