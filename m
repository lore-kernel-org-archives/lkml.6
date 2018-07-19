Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3584BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E332E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UlNUF0KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E332E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeGSA7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:59:51 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46794 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGSA7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:59:51 -0400
Received: by mail-vk0-f68.google.com with SMTP id b14-v6so3483010vke.13;
        Wed, 18 Jul 2018 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AePPAynY3ujVl4sfgtjGAzbDeABn58A2Sz2hVU1S3EI=;
        b=UlNUF0KFb0tQoj7TVKSJWFFVRGaNTfnkdN5I77CD1X5aaV/26pnLiPX467UJa9KB2z
         7OPBvwrCOn1OkgfI4I4EPvndamyhPiAnXF9PtAOcuOkrzLYgzT6hzHazu/xyUo+rdCZT
         yn1DFSHa2PyqYVTnIv7m9a7RjQyeS6u9AyyIXdcImdbIZpS1fYPmgDDtK46eQuWtz1sl
         9Kgz038nBoaMtDlJyXQ65I+uK2Ks3BpaOzgxlZRczk2tehx9mbgZReP08G73EizewlRi
         X560H/6G6T0U5HGUAG4lnbV5K1BcD2voOe6ogJ+MnNSBCiTiPbOVBHXB7HYCNC49t0tJ
         4IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=AePPAynY3ujVl4sfgtjGAzbDeABn58A2Sz2hVU1S3EI=;
        b=tpUFULqh4nONrYN+4PIy65K33kcD2WgGu0eEt9vuIJ1B/SqDdCKzzcRcQa2qTqeExZ
         d3GPHMxmF5dXv525gr6CxtewYK0LVhiwJRJC1M/XxE/q4ZVoSdf0qHuzzjDyowVbQXcL
         jWqvFfDGswdbiM3mpcJxbSKr3UaN1k1HqbqS+4EzPohTez3QtE6yAyhjzy9YAY+yOYdH
         fj9xY/znzhojzRB/o10/bt5Szv6l7a5gA7n/rwXa6853b0MAt1mKTH6TqNdIdkFp3yPu
         bhpC95fu68zGYn1c0Uhcfc1ZJX35JImw3X/7l610ES1KhDaMAIsfEQRx31vePoFfQycP
         h9+Q==
X-Gm-Message-State: AOUpUlEB/dhvzod5O29VhWGdufJls33BpJ63f7QJAWL77/TEjQDPA0gn
        BiC2ofJxqx2U1+q1cJhw0BdXyPunsdB55Bi3FPE=
X-Google-Smtp-Source: AAOMgpfd4ttgIUyph8G+nUCzgjClcz7g9jFLauvNBOuVxtVtweP3/59NgP6XBdcoetLUb+xyoMQevJUHoQR6J8owzvE=
X-Received: by 2002:a1f:bf0d:: with SMTP id p13-v6mr4638482vkf.169.1531959567895;
 Wed, 18 Jul 2018 17:19:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:d012:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 17:19:27
 -0700 (PDT)
In-Reply-To: <CANVEwpY2H+OBnYNAf15bRRbmepFCerWrisLiLQ=h3+_692MY7A@mail.gmail.com>
References: <20180718014344.1309-1-tytso@mit.edu> <20180718015154.GE3489@thunk.org>
 <CANVEwpY2H+OBnYNAf15bRRbmepFCerWrisLiLQ=h3+_692MY7A@mail.gmail.com>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Thu, 19 Jul 2018 01:19:27 +0100
Message-ID: <CANVEwpbcaTq=gFHVi0FUjq=7vLbQNYRX7aBRxWvH68oY_LFm-A@mail.gmail.com>
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 18:21, Ken Moffat <zarniwhoop73@googlemail.com> wrote:
> On 18 July 2018 at 02:43, Theodore Ts'o <tytso@mit.edu> wrote:
>>
>> This will prevent getrandom(2) from blocking, if there is a
>> willingness to trust the CPU manufacturer.

> For me, it seems a price worth paying. I've got bigger problems than
> _worriying_ about my government, or yours, spying on me, so I'd like to t=
ake
> the risk.
>
Sadly, my enthusiasm was premature: the Kaveri doesn't have a hwrng. So
although I've enabled the device under the HW_RANDOM options, nothing
comes out and this "fix" will only work for some machines.

For me, I'll have to go to plan B (revise the bootscript and/or patch unbou=
nd).
I see that Nixos seems to bind /dev/urandom to /var/lib/unbound/dev/random
so I guess that ought to work. Sorry for the noise.

=C4=B8en
