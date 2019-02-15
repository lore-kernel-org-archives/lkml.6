Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226A721924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="vAX80ath"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfBOQSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:18:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46851 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfBOQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:18:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so7575511lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OuviDuBJEJxQ5jftlZ0q5y30AnbgWiDB4aWAzogNy5Y=;
        b=vAX80ath2vb4178rAVNvaYCeB1XWmqD338XX8UCO5s6dOo21U6/uqDXQLqnRGWA/8v
         7qRizfJ6Z/6HmKV6JCRLw5BhIPPEpcqOIDEQ6dg+h0xOFLqfvc3DqbJVABc/EZZzfIMW
         mu45TNdOy3fY25gdb2jXbC38gmq1MbNPxolCsNQ/7zLoAzkRUIcNCIUt8wW2ZswEGVvc
         VLZkuZmEQXPJtxBI9FigI5BenAEItw5MQmjY45ME4Te5X16b52LeiUlR41EGRPg+ZEbI
         ZLgMIPRhBi7dH0Lv1Sh3h7LcmQcMLjBnz3mSmtYkcDGBPkq+jpTBc3Rdhk94EzW6/vde
         xAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OuviDuBJEJxQ5jftlZ0q5y30AnbgWiDB4aWAzogNy5Y=;
        b=I7VNP+qj1AOHDDMHzWbdxtk5GWhneXCKY+okYIkrRIJ39UH0hJH1q6PK9qfhwp0UTN
         sQFQxrdv/KSIrV6s5xmECfrk9Hya5VXYnpJVOJc5WNBo1oTJXtyEXv5q4H4J5pprAeug
         QGqyyE8ju1VSjLc2QQyDP+W4oiFpsTvlrQUqBNaMJhpcFSRNNYS0IbVJNhgNHVrqxhAu
         r6u9dS+C1z2L8Q5/WS+YN1NHadLeOM5RFAy2GZhkVN3KPKB8DhWdFwiWA/CnvnXtG62a
         19CQi206zYFO7Qe6kdH2QZyVidIjiQEsMt9fDeqTADJVEeNdseXs6gWM/WBCyzHlKdQc
         TVlw==
X-Gm-Message-State: AHQUAubJEsGb4L1yxtVQI2o53a8UTgd1S2ZMtDk8KOI2MDqfxmLDeB7c
        doJWOhTtQUsV7FyCeTk+qX9BcmKLOtbqV45rZEl0RwcUCC8=
X-Google-Smtp-Source: AHgI3IbKc3yz3rup22X8gfKdkxSCGTTcahgfs/llcMBHoMzT5Y8UoYNI/0U8yv/xElQqIic02jBK+S9k7S3juH1MDJc=
X-Received: by 2002:ac2:562b:: with SMTP id b11mr6079818lff.85.1550247511697;
 Fri, 15 Feb 2019 08:18:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:5612:0:0:0:0:0 with HTTP; Fri, 15 Feb 2019 08:18:30
 -0800 (PST)
In-Reply-To: <20190215155200.GB4525@dhcp22.suse.cz>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com> <20190215091000.GT4525@dhcp22.suse.cz>
 <20190215092013.GA32575@kroah.com> <20190215094205.GW4525@dhcp22.suse.cz>
 <20190215151912.GA10616@sasha-vm> <20190215155200.GB4525@dhcp22.suse.cz>
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Fri, 15 Feb 2019 11:18:30 -0500
Message-ID: <CAN1fySWnazf3Z7tCnK1p10+XYV1zGfBO-YqoE3LNoOfKpPO3zQ@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 15-02-19 10:19:12, Sasha Levin wrote:
>> On Fri, Feb 15, 2019 at 10:42:05AM +0100, Michal Hocko wrote:
>> > On Fri 15-02-19 10:20:13, Greg KH wrote:
>> > > On Fri, Feb 15, 2019 at 10:10:00AM +0100, Michal Hocko wrote:
>> > > > On Fri 15-02-19 08:00:22, Greg KH wrote:
>> > > > > On Thu, Feb 14, 2019 at 12:20:27PM -0800, Andrew Morton wrote:
>> > > > > > On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds
>> > > > > > <torvalds@linux-foundation.org> wrote:
>> > > > > >
>> > > > > > > On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
>> > > > > > > <richard.weinberger@gmail.com> wrote:
>> > > > > > > >
>> > > > > > > > Your shebang line exceeds BINPRM_BUF_SIZE.
>> > > > > > > > Before the said commit the kernel silently truncated the
>> > > > > > > > shebang line
>> > > > > > > > (and corrupted it),
>> > > > > > > > now it tells the user that the line is too long.
>> > > > > > >
>> > > > > > > It doesn't matter if it "corrupted" things by truncating it.
>> > > > > > > All that
>> > > > > > > matters is "it used to work, now it doesn't"
>> > > > > > >
>> > > > > > > Yes, maybe it never *should* have worked. And yes, it's sad
>> > > > > > > that
>> > > > > > > people apparently had cases that depended on this odd
>> > > > > > > behavior, but
>> > > > > > > there we are.
>> > > > > > >
>> > > > > > > I see that Kees has a patch to fix it up.
>> > > > > > >
>> > > > > >
>> > > > > > Greg, I think we have a problem here.
>> > > > > >
>> > > > > > 8099b047ecc431518 ("exec: load_script: don't blindly truncate
>> > > > > > shebang
>> > > > > > string") wasn't marked for backporting.  And, presumably as a
>> > > > > > consequence, Kees's fix "exec: load_script: allow interpreter
>> > > > > > argument
>> > > > > > truncation" was not marked for backporting.
>> > > > > >
>> > > > > > 8099b047ecc431518 hasn't even appeared in a Linus released
>> > > > > > kernel, yet
>> > > > > > it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.
>> > > > >
>> > > > > It came in 5.0-rc1, so it fits the "in a Linus released kernel"
>> > > > > requirement.  If we are to wait until it shows up in a -final,
>> > > > > that
>> > > > > would be months too late for almost all of these types of patche=
s
>> > > > > that
>> > > > > are picked up.
>> > > >
>> > > > rc1 is just a too early. Waiting few more rcs or even a final
>> > > > release
>> > > > for something that people do not see as an issue should be just
>> > > > fine.
>> > > > Consider this particular patch and tell me why it had to be rushed
>> > > > in
>> > > > the first place. The original code was broken for _years_ but I do
>> > > > not
>> > > > remember anybody would be complaining.
>> > >
>> > > This patch was in 4.20.10, which was released on Feb 12 while 5.0-rc=
1
>> > > came out on Jan 6.  Over a month delay.
>> >
>> > Obviously not long enough.
>>
>> You're assuming that if we wouldn't have taken this patch to stable
>> somehow someone else would notice this bug and fix it.
>>
>> What test do we have that would catch this? Which testsuite tests for
>> long shebang lines? Where is the test added together with this patch
>> that covers this and similar cases?
>
> The test is the "users out there". Right now we do not have any
> specialized test case because we haven't even realized it might break
> something. The main difference between breaking on the bleeding edge vs.
> stable tree is that people running on bleeding edge are more likely to
> expect a breakage while stable users would most likely prefer to not be
> guinea pigs and have, well stable trees.
> [...]
>
>> > > We have a list of blacklisted files/subsystems for people that do no=
t
>> > > want this to happen to their area of the kernel.  The patch seemed t=
o
>> > > make sense, and it passed all known tests that we currently have.
>> >
>> > Yes, the patch makes sense (I wouldn't give my acked-by otherwise). Bu=
t
>> > this is one of the area where things that make sense might still break
>> > because it is hard to assume what userspace depends on.
>>
>> Great, so the solution is to just not take these things into stable at
>> all?
>
> No, but if the patch author and the maintainer have considered the
> stable tree and haven't found convincing arguments to mark for stable
> then it is likely that the patch doesn't need an urgent backporting.
>
>> The solution should be to add tests to the patches that go in there
>> to verify their correctness and that they don't regress in the future.
>>
>> If you're really concerned about subsystems being brittle the solution
>> is to improve their testing rather push stuff in and hope nothing
>> explodes.
>>
>> On one hand you Ack it saying it looks great to you and should be
>> merged, but on the other hand you're saying that you don't really trust
>> the patch?
>
> No. But I didn't consider it a stable material. You just do not really
> need all the patches in the stable, right? I have already said that this
> code is there for ages and fixing it is good to have for future but
> considering that nobody was really complaining then a backporting just
> adds a risk and as it turned out that risk was really not zero.
>

I'm sorry to interject here, but the issue was reported on the
Kernel.org Bugzilla on February 2nd

 - https://bugzilla.kernel.org/show_bug.cgi?id=3D202497

In the interest of better communication, if the need arises again, how
should bugs in the RC kernels be reported so they (1) are spotted by
the right maintainers and (2) not backported even though they were
reported as causing breaking changes?

>> Really, if I wouldn't pick this patch now what do you think would have
>> happened? It would just pop up in a few months as we roll our stable
>> kernel forward.
>
> and that would be a different kernel version and people kinda expect
> bugs with newer versions. This is not the case with the stable update.
>
> But I guess we are just repeating the same discussion over and over. Our
> expectations about what the stable kernel should be differs a lot. I
> would like to see fewer but only important fixes while you would like to
> take as many fixes as possible.
> --
> Michal Hocko
> SUSE Labs
>

--=20
=E2=80=94 Samuel Dionne-Riel
