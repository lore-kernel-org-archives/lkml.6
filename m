Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8923AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD3821763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHtozObl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD3821763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeHMTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:55:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43836 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeHMTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:55:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so18161088qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FyKlPWaqJErS3JIsjdzMmbOqdIKa+Re5E+4OZqAi45g=;
        b=dHtozOblEv6E+xSqjs4SZTyK3xt/+OMvNEgkHctE+hTBUF4SJQBuJrR2Q0bDMIknrp
         F/GLqLcXk2xWTEr2d1VyvnWUgLQFYjubc8JRLdVgJfblTV4Jqvz7WCt5m2HfkMB0SeXP
         ImVp6UGS5+AcXFsySDYzP9iKJGvOAthfvAKS50bNhazvJhFuqtn+ADQvy7RfqtG5BJR8
         345YxwXlFg99MdjYdRvU/Po3BkHJ8B2k9rzIlmF6blEja37vhARxMCHYWwEQi+OxZqs8
         o4vmzxgjUK4hqxwWvJ2yfPmbj9wwddNc3oxJIPMaGSk8TGUVHbv4LM4A0i0kMKqlCxd4
         mOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FyKlPWaqJErS3JIsjdzMmbOqdIKa+Re5E+4OZqAi45g=;
        b=PYSJygK3JzWt8AeuZJynlitb5NAeurB1uFM1XXnj13tOXYx0shezKRcemTJXqgHzqx
         2aYBuqKRPSaLKIrbgBrViXaumPhdQaNrhnUqphUvVsMUwZyY36N9cyp+9AcGULkkj3bK
         qmvvxu3XJXseyBapoRLCOC8NpBlQ+Ccpv59dIilqy0fgSu/UyqXxQ3N/wkwc0HNWiXBt
         9uVVGTLr7t+UyzLROrrfxISLyHKyz1dVFXB1pC+FyCs9cJArYu794tD4iALorkxJEPhA
         ZizeMj43R5/+CCx7Lfkwhws7Am+5/sfEAyn625dNwt9T4CP0t11lLEaX6zNcFMRL1dCK
         TpRQ==
X-Gm-Message-State: AOUpUlH5kpzuRSGqz+L1/10QBtlBNekr/sHIG//z8mL9UglKZkCW3QAb
        wk2Th+HFixVcZ5UM8XAC6UN7E9rteBQrR9IQZ2Q=
X-Google-Smtp-Source: AA+uWPzJjOtHmMCCepYDBpc2pdj1MWph3b5chrBdcP6xjh26c1ZoInYIUf7zHsxK+8oSqsb0NEBVUaQQpSjvNIO3HE0=
X-Received: by 2002:a0c:f883:: with SMTP id u3-v6mr15954417qvn.28.1534180335332;
 Mon, 13 Aug 2018 10:12:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 10:12:14
 -0700 (PDT)
In-Reply-To: <20180813131723.GC28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com> <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com> <20180813131723.GC28360@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 13 Aug 2018 10:12:14 -0700
Message-ID: <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 08/13, Ravi Bangoria wrote:
>>
>> > But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>> > hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>
>> I'm sorry. I didn't get this.
>
> Sorry for confusion...
>
> I meant, if only exec*( could race with _register(), we could add another uprobe
> hook which updates all (delayed) counters before return to user-mode.
>
>> > Afaics, the really problematic case is dlopen() which can race with _register()
>> > too, right?
>>
>> dlopen() should internally use mmap() right? So what is the problem here? Can
>> you please elaborate.
>
> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
> because dlopen() can race with _register() too, just like exec.
>
> Oleg.
>

How about we do delayed_uprobe_install() per file? Say we keep a list
of delayed_uprobe
in load_elf_binary(). Then we can install delayed_uprobe after loading
all sections of the
file.

Song
