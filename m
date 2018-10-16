Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC7AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C822098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yNqMNg9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C822098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJQDcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQDcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:32:00 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7E921479;
        Tue, 16 Oct 2018 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539718801;
        bh=zqiRn+Fo0rqu+/frEvnOPp5XH/g2c/3+p9id3MqcdhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yNqMNg9ccRW0apgVLHLPLp/dLg2SGKrXziQTRZxkgpvku5Rr9BH7K891PVYIbi8AG
         GgHJJsLZ/wYTk6HklXhIRhu4qqacgoh6VO21oCfPlFVFcXJOQwjz7gDv2j5vv5hNf0
         0JaLSdwfFvwpM18udvvfm7nVbHVfKiwGwGhVGMRw=
Received: by mail-ed1-f53.google.com with SMTP id z21-v6so22525944edb.11;
        Tue, 16 Oct 2018 12:40:00 -0700 (PDT)
X-Gm-Message-State: ABuFfohQsWxzrwoMbz3OLTtW9PP24wmPHO3BR6LisnbNzNlNACfaD62S
        E3gsw5bE6tRa44VeYuGngK5FlDCkWjQIFQLJbm0=
X-Google-Smtp-Source: ACcGV60emVyHfhWDKraRC4hfrPyhsT7uVvrSPqNod3bmQNOIGBAAuCncLCIT0xdv8P1apqW8L9ui1I7YvS1q5hpdQgk=
X-Received: by 2002:a50:92fd:: with SMTP id l58-v6mr32466773eda.200.1539718799151;
 Tue, 16 Oct 2018 12:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdXad2g5zEZ8=XzzVgfijcatKYj5AjwVQg=W-by_rHfcAQ@mail.gmail.com>
 <e69685d5-e09f-5f7d-2ff0-7ead12500371@gmail.com> <CANk1AXQU=3Ap=wbO5b8c2pMq61hzuRkeWYNv2Esq+c9d+0e_BA@mail.gmail.com>
 <3635be33-7301-ecd5-5966-24b0494771ef@gmail.com>
In-Reply-To: <3635be33-7301-ecd5-5966-24b0494771ef@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 16 Oct 2018 14:39:21 -0500
X-Gmail-Original-Message-ID: <CANk1AXRNKY8eAxXNtOXiWYZ00-mnzvPFMaixS-fXD=zu9C1UNw@mail.gmail.com>
Message-ID: <CANk1AXRNKY8eAxXNtOXiWYZ00-mnzvPFMaixS-fXD=zu9C1UNw@mail.gmail.com>
Subject: Re: [PATCH] of: overlay: user space synchronization
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 7:04 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/15/18 13:38, Alan Tull wrote:
> > On Mon, Oct 15, 2018 at 1:09 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 10/15/18 01:24, Geert Uytterhoeven wrote:
> >>>
> >>> Please say explicitly that tree_version contains a 32-bit unsigned
> >>> decimal number, which is incremented before and after every change.
> >>> I had to deduce that from the code.
> >>
> >> Good point.  I'll add that.
> >
> > Looking at the code, tree_version being odd or even means something.
> > tree_version is incremented every time the of_mutex is locked or
> > unlocked, such that:
> >  * tree_version is odd  == of_mutex is locked and the tree is
> > currently be in the process of being changed
> >  * tree_version is even == of_version is unlocked again and the
> > changes are finished.
> >
> > How about making this explicit in the interface by breaking it up into
> > two attributes:
> >
> > /sys/firmware/devicetree/tree_lock == "locked" or "unlocked".  If the
> > tree is locked, you know that the tree may still be changing and the
> > sysfs can't be trusted to be stable yet.  Or maybe even more
> > specifically tree_overlay_lock?
> >
> > /sys/firmware/devicetree/tree_version = a u32 that is incremented once
> > for every overlay added or removed.
>
> I like the extra clarity of purpose that having two attributes provides,
> but it makes the user space dance more difficult.
>
> With a single attribute, the shell code is (updated from the patch
> to remove the variable "version"):
>
>         done=1
>
>         while [ $done = 1 ] ; do
>
>                 pre_version=$(cat /sys/firmware/devicetree/tree_version)
>                 while [ $(( ${pre_version} & 1 )) != 0 ] ; do
>                         # echo is optional, sleep value can be tuned
>                         echo "${pre_version}  tree locked, sleeping"
>                         sleep 2;
>                         pre_version=$(cat /sys/firmware/devicetree/tree_version)
>                 done
>
>                 # 'critical region'
>                 # access /proc/device-tree/ one or more times
>
>                 post_version=$(cat /sys/firmware/devicetree/tree_version)
>
>                 if [ ${post_version} = ${pre_version} ] ; then
>                         done=0
>                 fi
>
>         done
>
> With two attributes, the shell code is:
>
>
>         done=1
>
>         while [ $done = 1 ] ; do
>
>                 # the order of the next three lines must not change
>                 version=$(cat /sys/firmware/devicetree/tree_version)
>                 pre_version=${version}
>                 tree_lock=$(cat /sys/firmware/devicetree/tree_lock)
>                 while [ tree_lock != "unlocked" ] ||
>                       [ ${version} != ${pre_version} ] ; do
>                         # echo is optional, sleep value can be tuned
>                         echo "locked, sleeping"
>                         sleep 2;
>                         # the order of the next two lines must not change
>                         pre_version=${version}
>                         tree_lock=$(cat /sys/firmware/devicetree/tree_lock)
>                         version=$(cat /sys/firmware/devicetree/tree_version)
>                 done
>
>                 # 'critical region'
>                 # access /proc/device-tree/ one or more times
>
>                 # the order of the next two lines must not change
>                 post_version=$(cat /sys/firmware/devicetree/tree_version)
>                 tree_lock=$(cat /sys/firmware/devicetree/tree_lock)
>
>                 if [ ${tree_lock} = "unlocked" ] &&
>                    [ ${post_version} = ${pre_version} ] ; then
>                         done=0
>                 fi
>
>         done
>
>
> The two attribute example is untested, could have syntax errors, etc.
> I'm also not sure that the logic is correct.
>
> My opinion is that the extra shell complexity makes the two attribute
> solution worse.

Yes, I can see that now and agree with you here.  Thanks for giving
the idea consideration.  I'll review your v2 .

Alan

>
> -Frank
>
>
> >
> > Alan
> >
> >
> >>
> >>
> >>>
> >>> IMHO that is more important than having the sample script here.
> >>>
> >>> Gr{oetje,eeting}s,
> >>>
> >>>                         Geert
> >>>
> >>
> >
