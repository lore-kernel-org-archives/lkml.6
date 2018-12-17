Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F80C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA9620645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeLQEWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:22:17 -0500
Received: from foss.arm.com ([217.140.101.70]:48676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeLQEWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:22:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FE3FA78;
        Sun, 16 Dec 2018 20:22:16 -0800 (PST)
Received: from mail-it1-f181.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 673653F6A8;
        Sun, 16 Dec 2018 20:22:16 -0800 (PST)
Received: by mail-it1-f181.google.com with SMTP id x19so17006151itl.1;
        Sun, 16 Dec 2018 20:22:16 -0800 (PST)
X-Gm-Message-State: AA+aEWbiFo+ADQbBR97knjiqK4oXJWNehxDyy1kjyA2+sqYILR1WmARM
        ex5DVgoOTqpv3ywDE+AZYyOk8kTwMk/4Pzs2qsQ=
X-Google-Smtp-Source: AFSGD/XKg5uBlKIWqj15XjELxxRPwvqmd+Z296ddkHjfPgdc4KEAicMP6QRESc0rMLwJXayFn+wvVdvzqUw249dV4fM=
X-Received: by 2002:a02:4c55:: with SMTP id a82mr10896248jab.29.1545020535693;
 Sun, 16 Dec 2018 20:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20181130162015.83FE767357@newverein.lst.de> <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
 <20181214094714.GA30043@lst.de> <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
 <20181215134144.6b0cc45b@blackhole.lan>
In-Reply-To: <20181215134144.6b0cc45b@blackhole.lan>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Mon, 17 Dec 2018 09:52:04 +0530
X-Gmail-Original-Message-ID: <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
Message-ID: <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
To:     duwe@lst.de
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        julien.thierry@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        mingo@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, takahiro.akashi@linaro.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sat, Dec 15, 2018 at 6:14 PM Torsten Duwe <duwe@lst.de> wrote:
>
> On Fri, 14 Dec 2018 21:45:03 +0530
> Amit Daniel Kachhap <amit.kachhap@arm.com> wrote:
>
> > Sorry I didn't mention my environment. I am using 4.20-rc3 and it has
> > all the above 8 extra patches
> > mentioned by you.
>
> So that should be fine.
ok thanks.
>
> > I read your change description in v3 patchset. You had mentioned there
> > that graph caller
> > is broken.
>
> No, actually I thought I had fixed that for v4. Would you care to show
> us an actual error message or some symptom?
There is no error message or crash but no useful output like below,

/sys/kernel/tracing # echo wake_up_process > set_graph_function
/sys/kernel/tracing # echo function_graph > current_tracer
/sys/kernel/tracing # cat trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |

//Amit
>
>         Torsten
