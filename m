Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A1924D07
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/eXCkWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A1924D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeGBILt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:11:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42446 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeGBILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:11:43 -0400
Received: by mail-pl0-f66.google.com with SMTP id y15-v6so5695695pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rbdvndPe1GNy9xK+A/XGIQaZt/JEXGqJmOIWEtlJbsk=;
        b=N/eXCkWQ8sSMKvsKWDiI1ZBZzsKRCH8dPJgl4j+cs3WjNguxx2Xv8hFjKP3OqoEywI
         XgnGZUDUhGAMFgyVw3siGjgXo2c9hGJg+p0KV3zXinAo1oQwIV9JXq+rX2IVvlEd70zc
         YMocV72SBzUfBxAuzuRYTxk/aa43Hyz9KqhvqODJU7K8X1/fkl/6oVH3Xw8YkKXme06D
         TWK1yK6huZMxdnvZ9fUbgvYuhZ77HZdMs/K5F1MfeJngbzvYfrWf3z7Lyu0uP/chnBEE
         2+7mqZL4Ud2k4ER2+Op+Pb3drBzpQevfLyH/0t0qSAmeDOKbrzRXbFQc1JIXONCGNRs2
         8WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rbdvndPe1GNy9xK+A/XGIQaZt/JEXGqJmOIWEtlJbsk=;
        b=mTgyWU+OQfJN9D0uBSIWHvWIdHilowRAO5Bo2k+NH2fPXDhGaWV/28+H24m4u4hhFp
         di1BapuBm1y5bqONLnAJmn3LS3AGn2DfeGo6oAah0Vqts7gTq3PxEUKbM2fWq3fB2RWI
         mI8SS6umPhdFyX9K0uVkl1nJHn+PW0TgYR9UheVnd/ruLicN2ZRI3uS4X9ofOgONhvzH
         aRISdx2NJTLmityj2QtNfcsytfYUCL03xcqXxQhTiZs/eSv3SMLpsFg1T90wXUBLeuMs
         3jx4j28HUm5Q2Rne30ZuKOK97T561kTBJ3kRQ57xmbE6CnyqvU+sMj4lE680XY44adLI
         BT0Q==
X-Gm-Message-State: APt69E0LpaWIBhwo2LmxCmxn+YCcXrKlW94JpKMp9ik8pcx6LY9nCi3D
        ZNZhwy4w/qYUooR9TArR2qz+AoIrHLNhA1dmu3bXPw==
X-Google-Smtp-Source: AAOMgpds0ot6Uatc9tOisz8rMh7GSPjRlfWMTKAM4K7OWRu8xfn64by/xKELCFAEZOWl6ojCZ9NGGSZBcy2sNCSwdk4=
X-Received: by 2002:a17:902:b115:: with SMTP id q21-v6mr2327295plr.97.1530519102391;
 Mon, 02 Jul 2018 01:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 2 Jul 2018 01:11:21
 -0700 (PDT)
In-Reply-To: <20180630110720.c80f060abe6d163eef78e9a6@linux-foundation.org>
References: <201806301538.bewm1wka%fengguang.wu@intel.com> <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
 <20180630110720.c80f060abe6d163eef78e9a6@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Jul 2018 10:11:21 +0200
Message-ID: <CACT4Y+awX=X2-Oc+3jVBO24cYxYJ1mpkE+8KznPM+9qReyxDQA@mail.gmail.com>
Subject: Re: /tmp/cctnQ1CM.s:35: Error: .err encountered
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 8:07 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 30 Jun 2018 12:27:09 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > head:   1904148a361a07fb2d7cba1261d1d2c2f33c8d2e
>> > commit: 758517202bd2e427664857c9f2aa59da36848aca arm: port KCOV to arm
>> > date:   2 weeks ago
>> > config: arm-allmodconfig (attached as .config)
>> > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>> > reproduce:
>> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         git checkout 758517202bd2e427664857c9f2aa59da36848aca
>> >         # save the attached .config to linux build tree
>> >         GCC_VERSION=7.2.0 make.cross ARCH=arm
>> >
>> > All errors (new ones prefixed by >>):
>> >
>> >    /tmp/cctnQ1CM.s: Assembler messages:
>> >>> /tmp/cctnQ1CM.s:35: Error: .err encountered
>> >    /tmp/cctnQ1CM.s:36: Error: .err encountered
>> >    /tmp/cctnQ1CM.s:37: Error: .err encountered
>>
>> Hi kbuild test robot,
>>
>> The fix was mailed more than a month ago, but still not merged into
>> the tree. That's linux...
>
> That was a rather unhelpful email.
>
> I've just scanned all your lkml emails since the start of May and
> cannot find anything which looks like a fix for this issue.
>
> Please resend.   About three weks ago :(


Sorry. I am just frustrated by kernel development process.

Bugs are untracked and get lost. Patches are untracked and get lost.
State of patches is nontransparent for most people, including author
(sic!). I've just got a reply on another patch along the lines of "oh,
I've already merged some unspecified version of this patch, so please
resent all changes since that unspecified version in a separate patch"
(what?). It's unclear what is the designated tree and who is the
designated responsible merger. Merging a build fixing patch takes
months (!) whereas most other modern project processes today are
capable of merging such changes into (the single head) tree within an
hour provided only a single maintainer from a group is around, and
they simply need to click a button because all tests, style and
mergability checks have already run by that time. Resending patches
thing should not exist unless the patch needs to be updated, condition
which is detectable automatically.

Andrew, none of this is related to you personally. That's the process
we have today, and I understand you are doing your best.
