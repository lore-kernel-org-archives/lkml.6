Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59D4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F020843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8Gnhn14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1F020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeICT1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:27:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44484 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICT1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:27:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so317298plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LQ07RiXRVqTS0c2AmIq6Kumte9/kPIrdie9lGUKx7rI=;
        b=u8Gnhn14G/BsTuKzomlibCW/1sNg8Q2wkKH1MD0vxSPb3P2HBfbykr6rEsGsK+cqRK
         1Kt0quWE0LOyyacvTilhHy1be3GU70bcgpbpMN7OQXs+1ajB2ffbzv6Bnw/3iDhibcFS
         DHTxAYC7+01dps9P77h0vIhhvPznVfWldg8xYNzd7Ir5TyU+cNBxwFQANtScROjGzk2R
         0dZWE5RY+THOWMnqd19umS4i/QzlwROq+Ayx1Qd8wHsCVtDBlry8DNf6h/GeE8X4WX2N
         1HJgkqeQnXe5ENWkHWkweOI9Lc4Lb3+jO1yN2ANIQKwXuRynKvzL73PrnRTlSshdjhHO
         5/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LQ07RiXRVqTS0c2AmIq6Kumte9/kPIrdie9lGUKx7rI=;
        b=KoSxn5jG3eP5uH+2MCdjF5km6/8T6GAeoT4LNBJLsOsn2GBrRgsgTPSn0GM4F05R11
         uPlj/11wfGf6BesQjoGzTg3IG/qWsw2LeFW+fG/HaZ/0AR3CDbQ2cAHbt7m+JT/jkZkD
         U6U6l2blUq9yYg0BjOyUgApUO8jqWO7gGKC67+0UvC0TcgcHg8HGv9etgmvzCbhUtKe5
         f3hbdhaXKiadT3niMYl5Pyx0Cgd5cUZUB/bDArwsN3CmFlyWhFBsG1ZHbST22cVcYX2m
         oY3dhgNWOek2EoMr1n3msIUC8CWa1xnJO+Zvr2l+Ib+o84M/uhbwHLRFKGZR/BDdFXdK
         /Rrw==
X-Gm-Message-State: APzg51Aj0CqA0CfhUZDEJ1VBi8wZzSxnivHiWTJp/Xjhi2plFa5Mqojk
        AdA7jN7vJiToA9AcGUtc456NENsZgcBxecZpZ2WtvA==
X-Google-Smtp-Source: ANB0VdZIH1rxx4TlwwmbWSDvSws+aTlNa/gm6wvwrqmkXTs4jEp0skdSBES1EQ9LSXHiZWDzYj41SPO/45R85E0x4uA=
X-Received: by 2002:a17:902:bf46:: with SMTP id u6-v6mr28920450pls.85.1535987186392;
 Mon, 03 Sep 2018 08:06:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 3 Sep 2018 08:06:05
 -0700 (PDT)
In-Reply-To: <s5ho9defwxf.wl-tiwai@suse.de>
References: <s5ha7oyhg0v.wl-tiwai@suse.de> <000000000000a25ae50574f76ff0@google.com>
 <s5h7ek2hfp6.wl-tiwai@suse.de> <CACT4Y+bJM4dfx_2_qwPLOYdU_snGv7Zhhu3g_sHuzUM3sjnZQQ@mail.gmail.com>
 <s5h4lf6hfcq.wl-tiwai@suse.de> <CACT4Y+ZjXmdTb552cEOYdhz4PVOHdS39q7ynW_3uz=STvVmr5w@mail.gmail.com>
 <s5h1saahe2p.wl-tiwai@suse.de> <CACT4Y+Z9Aji1vENUc_8YbMx5dh=uXfm09DewDZZvwXbKn5O_vA@mail.gmail.com>
 <s5hwos2fybs.wl-tiwai@suse.de> <CACT4Y+a1erpZnCVAU44wF+Sve5He4gjK4+7nGHi6RWbogfs3Ag@mail.gmail.com>
 <s5ho9defwxf.wl-tiwai@suse.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Sep 2018 17:06:05 +0200
Message-ID: <CACT4Y+YMetgDkFtqOuPJzfniKBfnq4-RAYE_AJkvMVTLAUx5-Q@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in snd_midi_event_encode_byte
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com>,
        alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 5:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 03 Sep 2018 16:54:23 +0200,
> Dmitry Vyukov wrote:
>>
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
>> is meant to be a complement to the previous generic descriptions of
>> patch testing process, which is:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>>
>> So, you always reply to the syzbot+HASH email address so that syzbot
>> understands which bug we are talking about.
>> Then you do either (omitting # so that syzbot won't consider that as
>> actual test requests):
>>
>> syz test: git://repo/address.git branch
>>
>> or:
>>
>> syz test: git://repo/address.git commit-hash
>>
>> And then you can either attach a patch that needs to be applied on
>> top, or not attach it (if it's already in the tree, or you just want
>> to get another crash report).
>
> OK, so far, so good, it's what I knew and have done a few times.
>
>
>> For KMSAN you need to issue test request against
>> "https//github.com/google/kmsan.git master" (that's the only tree that
>> has KMSAN tool in it) and you need to attach/inline the patch (because
>> your patch is obviously not there yet).
>>
>> Does this make things more clear?
>
> Sorry, the part "issue test request against https..." still isn't
> clear.
>
> Do you mean to open an issue entry on github, and attach the patch
> there?

By "issue test request" I mean sending email with "syz test" command.
So overall you send "syz test https//github.com/google/kmsan.git
master" and attach the patch.
The workflow is all the same, and no github involved. It's just that
you can't ask to test it against
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git because
it does not have KMSAN tool and so no KMSAN bugs will be detected
there.

Since I did all of this, it's hard for me to write clear docs for others. Sorry.
If you can suggest some improved wording, it would be great.
