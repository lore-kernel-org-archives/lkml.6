Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9BBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BDB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+kvwTCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BDB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeIJQOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:14:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38196 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeIJQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:14:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id o11-v6so17005745uak.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DS6WhuFuFRh5YcMeKMnwskTnfofT0eufiCkoQN/1Mkk=;
        b=C+kvwTCsMpUTwGsJFrq0RjVTs/qC+1NbePGUC1CCWASJ42bfBZOLlSQd1ksVFVcIXk
         t1EsL5CXnPbm/vTKa0xcX6+FuoyJC5+WxnWxjTzOVIXIMy0F8sMYEGE3qcS118uPhuAT
         o+vbv9Arkelf+vHp1ylXwvTPiECuJsmgGEWlbD8otH51zEISh4l0zdXbhJtkSGs+8YQe
         7P1+M6v6CY+sh/2jlEfDn+SaF03vbqFySUa2al0H/vSzO8M3UOjKqO80NvNbtnrymM1W
         ZarMBaRCTcjt9YjHZpjx/rp8iaddRfE4BJpA0qBNrvz38AIzEEbF9zPS8PD33wsVwTiz
         EuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DS6WhuFuFRh5YcMeKMnwskTnfofT0eufiCkoQN/1Mkk=;
        b=XM5g4sPpIn8y1mnYnnrcwM4lPGe6ZJ6RcVVPxhyHn2XV0edrfp4G3gQzknxFqSKLTv
         P4SzhyaZh1cNH1Zfr514P6f/STsQe7U8xspRlLA3erK1+UMPEjDFsFeUHHa4OBpEqcPM
         5EYtPk9mGcsbwsKCKMj+H/wl614jZxUHfWPnMRF6kVSjI3wD9DIHKtwm4n/Nvs7kjoqf
         EliycImVS16eBO7Lg4oxIWFo0ZdtsDqJOts53iCuUzlInOKKz4k8SuXt6w+iu2fdZ4cV
         x5fQN0r+D2JyBEr1ZRoLJYRMx8W5KxtGBJYXvqpSBSKa9KIJzoZd24zAeBmlnxe6ozlZ
         RW/g==
X-Gm-Message-State: APzg51AnrVzSr3NzEZYAHzJzyu300+fyP/fBMe/z7ygp1O3V4Q5W1N5O
        kZIn++e/+jgF8zl9IuF76mcedLPEANxfh2otpfaClQ==
X-Google-Smtp-Source: ANB0VdZtbr51BmBWdJqh0AynzMfwYgxmc+jf+oJvltvOnjH7xbqeB/1UjtE4aGdX+spZXfbGY2iX40xxIzdTmGglyYA=
X-Received: by 2002:a9f:3a46:: with SMTP id r6-v6mr6778436uag.145.1536578436039;
 Mon, 10 Sep 2018 04:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180524021451.GA23443@jagdpanzerIV> <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV> <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV> <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV> <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
In-Reply-To: <20180620130628.GA1000@tigerII.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 10 Sep 2018 13:20:24 +0200
Message-ID: <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp
Cc:     kbuild test robot <fengguang.wu@intel.com>,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:06 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (06/20/18 13:32), Dmitry Vyukov wrote:
> > > So, if we could get rid of pr_cont() from the most important parts
> > > (instruction dumps, etc) then I would just vote to leave pr_cont()
> > > alone and avoid any handling of it in printk context tracking. Simply
> > > because we wouldn't care about pr_cont(). This also could simplify
> > > Tetsuo's patch significantly.
> >
> > Sounds good to me.
>
> Awesome. If you and Fengguang can combine forces and lead the
> whole thing towards "we couldn't care of pr_cont() less", it
> would be really huuuuuge. Go for it!

Sorry, folks, am I understanding right that pr_cont() and flushing the
buffer on "\n" are two separate problems that can be handled outside
Tetsuo's patchset, just assuming pr_cont() is unsupported?
Or should the pr_cont() cleanup be a prerequisite for that?

>         -ss
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
