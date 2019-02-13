Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7116C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D7A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AwWM04jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394441AbfBMT47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:56:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46335 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbfBMT46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:56:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so3086219ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e28LJ4tt7oVJKO7CgbJcVFBqC5tv55Rtb2nhIFWhcsA=;
        b=AwWM04joRrT5vs+hjoL9MmG7srLew3Te9ugMC75SXqOI/2uV0za5cgm9bc8pb8XXGn
         se+TPfIJUY4NYMOtH8GC9BwVPJFWIuFFqH0OPPPOg2Y/B3SCjVdMR3D9A7rLFl1GaaPs
         yUQL8R/8syuf+rS2mMXEgR8kDwmOiG+bDS59I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e28LJ4tt7oVJKO7CgbJcVFBqC5tv55Rtb2nhIFWhcsA=;
        b=qkCh6lVZpfl+B2Lo2cmIpf0BQRJLv26tjdEOFmj9xnQMJNeFj7No5gjn/IhYtpPWEA
         MU6xh1vkHgqD+coI9NCyDS8SHlJWznY5UBhwvdSVJXoCjbMZb8NBCeEMrUk+6MPxwF7q
         VahfmFM5ziM1af5PTbcPs8RpS+xWlwEAc/VS1sTt7MPYaEu7HO+4HJBqboEHQQ9cnNyL
         jCQ3qBRFZisnzKTvHmfqmO6QNqB9lkDDhImntcs2j+Xy9pVhKnU0ntGpoVQF3aGqnVUg
         jZMAjOqaFYykdLkY4+mvwD2xbN8gcS++cxUTObbQuiOYIotGnI1OAddrRU6pwIlINJzH
         QL0w==
X-Gm-Message-State: AHQUAub8tMeaHJ7Q8amphRkU96X/Pj9rbAW68HM6goDLKWyJD6kfYEzy
        KZQswWNMxHVwsFaYpV5GmikI5Nm8V2o=
X-Google-Smtp-Source: AHgI3IaT7ATOLpefl8pFyLDFEzhOZ20tqCyCV0Ql3KXxrbDshEqEEJcXhKiJTmObLC+B3Hgv8uZ3ng==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr1434662lja.81.1550087816136;
        Wed, 13 Feb 2019 11:56:56 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r80sm42554lff.33.2019.02.13.11.56.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 11:56:55 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id g11-v6so3128110ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:56:54 -0800 (PST)
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr1404666ljk.105.1550087814152;
 Wed, 13 Feb 2019 11:56:54 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com> <20190213091936.GA22829@shao2-debian>
In-Reply-To: <20190213091936.GA22829@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Feb 2019 11:56:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To:     Chen Rong <rong.a.chen@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "IngoMolnar@shao2-debian" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, those test robot reports are hard to read, but trying to distill it dow=
n:

On Wed, Feb 13, 2019 at 1:19 AM Chen Rong <rong.a.chen@intel.com> wrote:
>
>          %stddev     %change         %stddev
>              \          |                \
>     196250 =C2=B1  8%     -64.1%      70494        will-it-scale.per_thre=
ad_ops

That's the original 64% regression..

And then with the patch set:

>          %stddev      change         %stddev
>              \          |                \
>      71190             180%     199232 =C2=B1  4%  will-it-scale.per_thre=
ad_ops

looks like it's back up where it used to be.

So I guess we have numbers for the regression now. Thanks.

And that closes my biggest question for the new model, and with the
new organization that gets ird of the arch-specific asm separately
first and makes it a bit more legible that way, I guess I'll just Ack
the whole series.

             Linus
