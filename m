Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78930C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1B02145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsSZ9r4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1B02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeIXXqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:46:50 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:38832 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeIXXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:46:49 -0400
Received: by mail-yb1-f170.google.com with SMTP id e190-v6so8587942ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HElEbAVIsmdGlDyCgzPwJXm57ftClO1YLJD5etewgR4=;
        b=rsSZ9r4L0m8o1I7uFm5GcYygpjQhjEanyG5r6yQ3xVNpUwwiTKKsfOEmxskLhs/1MX
         VF2st8QU34hL+XAIMB7yf2X3axOZhsM1uM4/68W2dBQQ0wo2V91PC9vkiJxCuypS12d1
         xwoGrTkH5mv/BwlpQvXO6IzhEn8NCPTDwPAhHxv/mCM+KtDlUvjNSpyATsxLVUCad2T7
         X3oaHlHwkdc0b86uuu2x5JO3VfCy2emHNx8KvfmjzpkoYqd1VyPtLOgxSqtqvQ76p4E2
         Pr9ElyU+emr4RCd2/4riWeAbUmkttpwljwrnS7aIEqrA+/NC/ozUNO0VKV65DBrKjXc/
         nXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HElEbAVIsmdGlDyCgzPwJXm57ftClO1YLJD5etewgR4=;
        b=SXHovgpbdD1ENrNBDXY3fnvxFedx9f8iXuOXBZO8pzwnUfPNRUAKcXczO6Of2vdRi4
         H7SAlJI5uMjykrHWmX/z8KmQ0n9p5CGTaYlxr5mI6aXXy0dSJVO5SC1ExfQmIzYRSLPk
         87wkwvUkHtz3UEsou79jue97GQqxPhKHMTul84UwDYq6ENugUm9TJ8LZ1jz4yd2aUKoG
         FGBjRtaVMLUqI1qjyNMY1CIaVQ4Ae8zqnQVPweVgSjEX/h+8i/VeCcGZA9Uicjpwy7Kq
         ixu+N8YN/Rww2GmbFnB77rXa2qmLxpryP9OBIuhCjR4h2SMtnMY6tpu1kc6vimTsTdmS
         G6AA==
X-Gm-Message-State: ABuFfohMBUwOnIPr/V4AsvgRQnD/fEruH5BYj1qa1BrrNxGZG0AFD9oa
        k3qwh3bQL7WpZ/7LDjSOY6RTiASLuJXgNyL79os=
X-Google-Smtp-Source: ACcGV62C3OQo3/mBMzaZaYpbVDme7L790Yoi6weRzRU0nubyUXFuzL1MGKw/K0dmfZuENLAHbFcxX11daet320WHkvI=
X-Received: by 2002:a25:a265:: with SMTP id b92-v6mr3390156ybi.399.1537811012790;
 Mon, 24 Sep 2018 10:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:54f:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 10:43:32 -0700 (PDT)
In-Reply-To: <CAKON4OxCpCMETfg087wV+ZQ3ssA7eDA8gBSxMYFL9ykVfEGwww@mail.gmail.com>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <20180922000521.u373eysq6dogcdfo@gmail.com> <CAKON4OxCpCMETfg087wV+ZQ3ssA7eDA8gBSxMYFL9ykVfEGwww@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 24 Sep 2018 10:43:32 -0700
Message-ID: <CAMo8Bf+ufr_RFtmKMrkCuvObSeGnU2a6L4sDC_LexRcN_a9xaA@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc:     joeypabalinas@gmail.com, Theodore Tso <tytso@mit.edu>,
        dreamingforward@gmail.com, fche@redhat.com, riel@surriel.com,
        ec429@cantab.net, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:24 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wr=
ote:
> On Fri, Sep 21, 2018 at 8:05 PM Joey Pabalinas <joeypabalinas@gmail.com> =
wrote:
>> On Fri, Sep 21, 2018 at 07:31:05PM -0400, jonsmirl@gmail.com wrote:
>>> How do you reconcile working on a public project while keeping email
>>> address secret?
>>
>> This is a little more delicate, and I admit that I can't really
>> think of any real solutions for this part...
>
> But... it this bothers you, simply don't use your private, personal
> email address when working on the kernel. Anyone with the skills to
> work on the kernel should know enough to be able to create email
> aliases. No rule says you have to use your real name either.

There is such rule:
  https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

chapter "Developer=E2=80=99s Certificate of Origin 1.1" says

  then you just add a line saying:
  Signed-off-by: Random J Developer <random@developer.example.org>
  using your real name (sorry, no pseudonyms or anonymous contributions.)

And in general, Developer=E2=80=99s Certificate of Origin
  https://developercertificate.org/

says

  By making a contribution to this project, I certify that:
  ...
(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.

--=20
Thanks.
-- Max
