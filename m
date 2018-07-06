Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92ECC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A11C24015
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dK3EUGyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A11C24015
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGFHjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:39:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:38971 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbeGFHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:39:03 -0400
Received: by mail-pf0-f177.google.com with SMTP id s21-v6so7712763pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5QRWOPCqEruZsjGNwcOkhZPX0bXbNscS61YKCYy6tTc=;
        b=dK3EUGykRgq30U58X4xpJ18UsEDyFUvamN7Q6ELcCWAUUIkh3vJWs4qxhgpcDWgNYr
         IgTiMU3uYDUVnRy0jv+7IlV7WYlY5hXSiSPkEfnukIbA0i0WMClrFvbJT3N19noxZ5LE
         860ZfW7b3/uvX/1ymSIjgRHtWu+aNeLDo0yIbV1sgPIQK/lvoZN5EYFtJh55Vp8wn0xr
         NCMYcswKyo2FDKI6uMxYHXYkHH5ARM6kHv7C0Gk1o8Ps0P+utTuYvWFOHOSbWSytq3yD
         PhOG3WnF/XVwD28RjTwca3nol2oAH9BkTvCTZBFRgK3ChwYjFYISInxX2ew7RMgi1pyZ
         Otcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5QRWOPCqEruZsjGNwcOkhZPX0bXbNscS61YKCYy6tTc=;
        b=tx6F72pSrjbXYMPTS/gZQMz7CBfUHzTuF2PAhrikaFYoRp2oFwK74ZgDBcM4yYWSQy
         UghYHOMg/3mLde45l4UZL/27C10/MPRulzi/o8fO4CYP6y5sKidx6paZGoDVTkBquxBa
         YQn6hSHa6Hfd9pUb+UK6vOHv95JLIh/Hc0SSFqxvZ4R6lgd8y+SQo8DsJbxRnKfixirO
         Aqx6t79riVB5dkwqZqqmJgCY4ZIVodc7vP/npqKviS8UwVivZmkUbwctWTSqvVoOFJ7a
         2P3uSd58HdrR2bWKcfiNNopiSh3Z7xKAMTn6P9Tfvd1DK0IxhDyN0IF7Yj93mc2sr/Wh
         3FFw==
X-Gm-Message-State: APt69E0n76XJaze8lk0n8zUxUP6Mj8HuRiYGAW139OyT5toeSPCcls+m
        VvOr5/uCxYMCUij44SjkK3XKO+qqVf+5Tr9h0NXuJw==
X-Google-Smtp-Source: AAOMgpcuvXPDuB+stgwa0oIL0TNZgdymU1vsnRe5mAS5//YF7vrEeBw1230Iuo/ihBoc+Zndc2iXaoY8i067acEBY9s=
X-Received: by 2002:a62:1894:: with SMTP id 142-v6mr9591848pfy.49.1530862742337;
 Fri, 06 Jul 2018 00:39:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 6 Jul 2018 00:38:41
 -0700 (PDT)
In-Reply-To: <1626520.Rx0128ICKU@positron.chronox.de>
References: <000000000000846e9e0570438176@google.com> <1626520.Rx0128ICKU@positron.chronox.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 Jul 2018 09:38:41 +0200
Message-ID: <CACT4Y+YJUVJnFt2bn7rhV+ET6dVhwWrym8DK+LgV3rJGVUuCFA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 8:45 PM, Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
> Am Donnerstag, 5. Juli 2018, 19:02:01 CEST schrieb syzbot:
>
> Hi Dimitry,
>
> does the syzkaller somehow uses the "---" separator as part of the URL?

It used it as branch. Please see:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patc=
hes

for formats. In all formats a git tree is not enough. And it is not
enough to identify code state in any other context too, it's always
git repo + branch or commit hash.


>> syzbot tried to test the proposed patch but build/boot failed:
>>
>> failed to checkout kernel repo https://github.com/google/kmsan.git/---:
>> failed to run /usr/bin/git [git fetch https://github.com/google/kmsan.gi=
t
>> ---]: exit status 129
>> error: unknown option `-'
>> usage: git fetch [<options>] [<repository> [<refspec>...]]
>>     or: git fetch [<options>] <group>
>>     or: git fetch --multiple [<options>] [(<repository> | <group>)...]
>>     or: git fetch --all [<options>]
>>
>>      -v, --verbose         be more verbose
>>      -q, --quiet           be more quiet
>>      --all                 fetch from all remotes
>>      -a, --append          append to .git/FETCH_HEAD instead of overwrit=
ing
>>      --upload-pack <path>  path to upload pack on remote end
>>      -f, --force           force overwrite of local branch
>>      -m, --multiple        fetch from multiple remotes
>>      -t, --tags            fetch all tags and associated objects
>>      -n                    do not fetch all tags (--no-tags)
>>      -p, --prune           prune remote-tracking branches no longer on
>> remote --recurse-submodules[=3D<on-demand>]
>>                            control recursive fetching of submodules
>>      --dry-run             dry run
>>      -k, --keep            keep downloaded pack
>>      -u, --update-head-ok  allow updating of HEAD ref
>>      --progress            force progress reporting
>>      --depth <depth>       deepen history of shallow clone
>>      --unshallow           convert to a complete repository
>>      --update-shallow      accept refs that update .git/shallow
>>      --refmap <refmap>     specify fetch refmap
>>
>>
>>
>>
>> Tested on:
>>
>> commit:         [unknown]
>> git tree:       https://github.com/google/kmsan.git/---> compiler:      =
 clang version 7.0.0 (trunk 334104)
>> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1207511c4=
00000
>
>
> Ciao
> Stephan
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/1626520.Rx0128ICKU%40positron.chronox.de.
> For more options, visit https://groups.google.com/d/optout.
