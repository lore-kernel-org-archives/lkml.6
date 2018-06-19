Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F720652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDaxebz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785F720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966739AbeFSQud (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:50:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43538 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:50:32 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so124279pgw.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sbztqYGekLtSdKf5CtikE1c+jnL4dHETEWXvyoKVS0s=;
        b=TDaxebz9ce5S145z7RNJVCMUVfO1/XoSDQYZHd2HLrwGF/IBVOmlJhvL+8Nw3GfdFh
         0F0En2gAuzQJjQmAYmfIYw2hpc7Vb7oKzobs+sXhi+12cCqUB6xmLWwG0dBtkby3sNUy
         yhazMeh7YBbxwRBIRIZRqOVzbtpwdeZlSOYuuYieNqdGJyNWd0N3viD2v0gyw1LE7ob5
         xGmncRcpZGUfjFC/m4nv1HE5dIrkDx1A/KFl001Pbyhyy09dPCfesXbcXd/VYmB8DnA1
         jMxwRZllzY3Pp3q2AclDmqi2XGfoGF2HVSB9nKXN5KN9gSj3j3Rw0gMzxpfXetCisDvg
         OlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sbztqYGekLtSdKf5CtikE1c+jnL4dHETEWXvyoKVS0s=;
        b=pnKh4kJYrgOnFE9nZjOGziHHwNu1imaOMg278hK6PZx5YrRs89on+B8Uzkjj5tx2Q9
         Hdv9/qF9r49j4KAJ9IKqbyfH10A53vQWEpMSgfS8gv72Sj6OPUeA/HpFzdcW4DGFQMyb
         VOkAPmntLdp9USA4nsdJdcnt45Hwjr2Mnbiavl4PcT6DmIQpyGG30Vi/3scI2DIMRq+v
         rbB43joWpRbxVYZiNCOROjSf4BaOytL1/U28uBW1A3iE0K2zjjfRtBOHlq+0BXvh4sCz
         dCtvFNI3MG9nCYxNa3SHXj3gvIWmaeov9VH7Q8ffRcpMxjAmQS/ZfneHc1d2AydClpa+
         CFDA==
X-Gm-Message-State: APt69E1Y9xa+cVhifIkVCBz11NWg3cL7kmO4GsOEoiWL4dIArucpHjWZ
        6oQ3udiol69HXq9PdyDLXOsMf8eBd9Dr0LrKOesJPg==
X-Google-Smtp-Source: ADUXVKKtL5kWZ8sJhfmCBsFkM+UwdRChqNa/fXjqIqi8KazllAt++OEEgESp7SxvJljDihWnj171OL1LIyeH+CuR6I0=
X-Received: by 2002:a63:b407:: with SMTP id s7-v6mr15906691pgf.334.1529427031443;
 Tue, 19 Jun 2018 09:50:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:50:10
 -0700 (PDT)
In-Reply-To: <20180619163624.4sol67vmh7wrfgyo@lakrids.cambridge.arm.com>
References: <20180618051522.GC28120@thunk.org> <CACT4Y+aq6vXoQpFgg6-_rEttnM4i3j7ng5LkP9gbqX98im=afw@mail.gmail.com>
 <20180619163624.4sol67vmh7wrfgyo@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 18:50:10 +0200
Message-ID: <CACT4Y+bFcAvHhsC4n4bKbW9JcdS4VyvgbMdDEOfMixp7KMRSvw@mail.gmail.com>
Subject: Re: An example of a much more impactful way of doing file
 system-specific fuzzing
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:36 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Dmitry,
>
> I hope the below doesn't sound like a criticism; I am a *huge* fan of
> syzkaller.
>
> On Tue, Jun 19, 2018 at 06:18:07PM +0200, 'Dmitry Vyukov' via syzkaller wrote:
>> On Mon, Jun 18, 2018 at 7:15 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> 3. You say "not actionable reports without reproducers", but you can
>> find hundreds of fixed bugs without reproducers at [1] and [2]. Fix
>> ratio for bugs without reproducers is 66% which is not significantly
>> lower than 76% for bugs with reproducers. A person without expertise
>> in a particular subsystem (me) can't know if a bug is actionable by an
>> expert in the subsystem (you) without first reporting this bug.
>
> I think it might be possible to make this a bit easier, without any
> manual effort per-bug.
>
> For comparison, when the LKP kernel test robot reports a bug, it
> provides a script to reproduce the issue in a VM, such that the
> developer need only provide a kernel. The script launches the VM with
> the right options, providing a filesystem if necessary, etc.
>
> This is a little more actionale, since the developer need not expend any
> effort trying to reproduce the correct envinronment, which can be
> especially tricky for bugs that don't have a C reproducer.
>
> Would it be possible for syzbot to do something similar?

Hi Mark,

Yes, it is possible.
There is even https://github.com/google/syzkaller/issues/563 for this.
Now I've added a note that this script also needs to accept a
custom/local kernel (not sure what was the idea of this script without
such option).

Thanks
