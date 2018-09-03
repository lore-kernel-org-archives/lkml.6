Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D62C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IostoKYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4256820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbeICVrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:47:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35225 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeICVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:47:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so451501pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S8qFm5PoPU2o+ncVCYpVUYvvjXPodweeTVVy0dlY9YY=;
        b=IostoKYTWo3j85GfHSshPIG8JMkTgBOzJDaQPEIPj2y9LszxO8Gd7W0sJwk+BoAeGl
         AWoAs822EZN8dNCwCG6TIw7verZS5WIzXK1GEdDgqjsYUVn0bK9cz90ERMjZirCKG8sE
         0QcbOv/kH4xOxF/7tIH80TiZW1HpuGygkl21Xjy6b9/e15awLIEYahAs7PeLlOKhwri5
         l9gJGQ5JxjSNpLZe8p2hUTCE0QY2RTKn3Vgm5+fenslOYtuJQaNQcOfcMRs3F5VTDD7F
         Jn5ibObSr4DLtX619c+vY1V1MtVp3ySR/VyWcjOyppNaSkKTOOHztDHw7AepJew2ekvX
         gZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S8qFm5PoPU2o+ncVCYpVUYvvjXPodweeTVVy0dlY9YY=;
        b=YE8iU9D6zK/HkCMTjzrlIIXL/7Kx2jijaLkBNRXZV+fntFjrQmQBTUQzanCX/F/+ke
         5lfW7khMYgKpzX5XMHaVyKFuWXVDrsr5mwSqOudK+rusJOncMr3HT8byLJsJhBDJRfZx
         ZwQ7wzgHt1fGtXYBdb2WfqD/4SG6FTS5L+KqIpcUQRLFdvAtvaSGtbke0+YSFfxlR6+h
         qnUodksvT0y6nEtAoZZEhv2Keojd7vszohlqWRIfUEVH+gMGyH33Cdy1znLHlQvkqeok
         s7s2QivuaAWs6S7lCA/Z5+FfHC+Ui4nNxdsTiTOpf9dzeyz2sZ+u5SRRQwJgMj8qTTAG
         BMlA==
X-Gm-Message-State: APzg51BX5GM67dtN1jTTBAOVze7dMD00d8tD9oCoLNUb0/P5rCYqN9xL
        qCYyPOjNXEO9MyyVksaGyUFlO23jZyv/qJDWHj33UQ==
X-Google-Smtp-Source: ANB0VdbnebIhn5EPD5MqaoGuxYJ6lnqUKT/hKgrL6kjbHwksI08cyyrfsPynZAFF+prEPDxAIChJTVi36mTR5+wXwX0=
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr30541546pfb.29.1535995560697;
 Mon, 03 Sep 2018 10:26:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 3 Sep 2018 10:25:39
 -0700 (PDT)
In-Reply-To: <s5hlg8ifw3v.wl-tiwai@suse.de>
References: <s5ha7oyhg0v.wl-tiwai@suse.de> <000000000000a25ae50574f76ff0@google.com>
 <s5h7ek2hfp6.wl-tiwai@suse.de> <CACT4Y+bJM4dfx_2_qwPLOYdU_snGv7Zhhu3g_sHuzUM3sjnZQQ@mail.gmail.com>
 <s5h4lf6hfcq.wl-tiwai@suse.de> <CACT4Y+ZjXmdTb552cEOYdhz4PVOHdS39q7ynW_3uz=STvVmr5w@mail.gmail.com>
 <s5h1saahe2p.wl-tiwai@suse.de> <CACT4Y+Z9Aji1vENUc_8YbMx5dh=uXfm09DewDZZvwXbKn5O_vA@mail.gmail.com>
 <s5hwos2fybs.wl-tiwai@suse.de> <CACT4Y+a1erpZnCVAU44wF+Sve5He4gjK4+7nGHi6RWbogfs3Ag@mail.gmail.com>
 <s5ho9defwxf.wl-tiwai@suse.de> <CACT4Y+YMetgDkFtqOuPJzfniKBfnq4-RAYE_AJkvMVTLAUx5-Q@mail.gmail.com>
 <s5hlg8ifw3v.wl-tiwai@suse.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Sep 2018 19:25:39 +0200
Message-ID: <CACT4Y+aZo9oJbmESUBgRe43WuW6uTiAJ21PPWrybFWbS4hg=3A@mail.gmail.com>
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

On Mon, Sep 3, 2018 at 5:18 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 03 Sep 2018 17:06:05 +0200,
> Dmitry Vyukov wrote:
>>
>> On Mon, Sep 3, 2018 at 5:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Mon, 03 Sep 2018 16:54:23 +0200,
>> > Dmitry Vyukov wrote:
>> >>
>> >> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
>> >> is meant to be a complement to the previous generic descriptions of
>> >> patch testing process, which is:
>> >> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>> >>
>> >> So, you always reply to the syzbot+HASH email address so that syzbot
>> >> understands which bug we are talking about.
>> >> Then you do either (omitting # so that syzbot won't consider that as
>> >> actual test requests):
>> >>
>> >> syz test: git://repo/address.git branch
>> >>
>> >> or:
>> >>
>> >> syz test: git://repo/address.git commit-hash
>> >>
>> >> And then you can either attach a patch that needs to be applied on
>> >> top, or not attach it (if it's already in the tree, or you just want
>> >> to get another crash report).
>> >
>> > OK, so far, so good, it's what I knew and have done a few times.
>> >
>> >
>> >> For KMSAN you need to issue test request against
>> >> "https//github.com/google/kmsan.git master" (that's the only tree that
>> >> has KMSAN tool in it) and you need to attach/inline the patch (because
>> >> your patch is obviously not there yet).
>> >>
>> >> Does this make things more clear?
>> >
>> > Sorry, the part "issue test request against https..." still isn't
>> > clear.
>> >
>> > Do you mean to open an issue entry on github, and attach the patch
>> > there?
>>
>> By "issue test request" I mean sending email with "syz test" command.
>> So overall you send "syz test https//github.com/google/kmsan.git
>> master" and attach the patch.
>> The workflow is all the same, and no github involved. It's just that
>> you can't ask to test it against
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git because
>> it does not have KMSAN tool and so no KMSAN bugs will be detected
>> there.
>
> Thanks, this finally made me understanding the whole picture!
>
>> Since I did all of this, it's hard for me to write clear docs for others. Sorry.
>> If you can suggest some improved wording, it would be great.
>
> Well, how about like below?
>
>
> KMSAN is not upstream yet, though, we want to upstream it later. For
> now, it lives in github.com/google/kmsan and is based on a reasonably
> fresh upstream tree. As the result, any patch testing requests for
> KMSAN bugs need to go to KMSAN tree
> (https://github.com/google/kmsan.git repo, master branch).
> A standard way for triggering the test with KMSAN tree is to send an
> email to syzbot+HASH address containing the following line:
>
>   #syz test: https://github.com/google/kmsan.git master
>
> and attach/inline your test patch in the same mail.


Done:
https://github.com/google/syzkaller/commit/3ea6c028b154d2faea45142bfb15b02f3243800c#diff-5b3b5ff5f03b01e1d31ec93aafd2f3d5

Thanks
