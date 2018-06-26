Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491A526546
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491A526546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeFZG1U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:27:20 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42685 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeFZG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:27:19 -0400
Received: by mail-ot0-f196.google.com with SMTP id 92-v6so17814928otw.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FU3m4WFtWgDkVNK8d/93dQdyw+3LyGH4+StOO7gYhic=;
        b=j9TpR6nuWoyNLj5RJ1Wk07J3rLeP+fIoVZSLxxWfN4SL54uqKz26ji1tD+o7S+EsLo
         uZhWtEAuMAv99s0ZzK8GEFG013XjpSf857bv3RFO41LFPGTh0rPL2A1/DNhfV+4RLntN
         YAspcrBiYv0AwqG1KpvsLa5eFj2RD8TMDVmTmwrNKPO5cGu5Y9UDJ5tTY7G3JAdsrI+W
         qW64ee3uigfL1qOOIpaKkgIBT3FtkeCUprx/z1foo62vPGTlhVUXuvzDflkhpDrS9oWc
         y/HgQcBJ1zZwLBj3IyrFipCITCEKeGiARTlHs4vOuweCXmZNY13HWYbrOUbIzSSUSHZY
         Ri6A==
X-Gm-Message-State: APt69E3nASS7JC8ZrO4BY1z9pvkBFrHWNhdzg+Ez3tgk8vhMwzo4h1rG
        JlCZUPGunzJO3cGTcxydAi1svvjWFNgnRluGt6I=
X-Google-Smtp-Source: AAOMgpeBY0CX7Uo/2Drhk6J8Sh9a9E1jVQgEbbtlIPDrIoXkKwG2AApdt+6WFfEE4C7rjgOg3ReumSiqTMAK3dePtB8=
X-Received: by 2002:a9d:41ea:: with SMTP id v39-v6mr111125oti.125.1529994438511;
 Mon, 25 Jun 2018 23:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180622192718.24242-1-malat@debian.org> <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
 <20180623194716.GY16221@gate.crashing.org>
In-Reply-To: <20180623194716.GY16221@gate.crashing.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 26 Jun 2018 08:27:06 +0200
Message-ID: <CA+7wUsx4wpiP+q7NusNgFYfAM3gbnvOOPgrjq4QV7iA510noCg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_powerpc=2Fxmon=3A_avoid_warnings_about_varia?=
        =?UTF-8?Q?bles_that_might_be_clobbered_by_=E2=80=98longjmp=E2=80=99?=
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 9:47 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Jun 23, 2018 at 06:59:27PM +0200, christophe leroy wrote:
> >
> >
> > Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> > >Move initialization of variables after data definitions. This silence
> > >warnings treated as error with W=1:
> > >
> > >   arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be
> > >   clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
> > >   arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be
> > >   clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
> >
> > Is that an invalid warning ?
>
> No, both are correct warnings.  GCC can not see which functions it only
> has a declaration of can call longjmp.

I assumed those were false positive warnings, given how easy it was to
defeat them. Let give it another try.

> > Otherwise, I'd expect one to fix the warning, not just cheat on GCC.
>
> Yes, the patch seems to change the code in such a way that some versions
> of GCC will no longer warn.  Which does not make to code any more correct.
>
> Either restructure the code, or make the var non-automatic, or make it
> volatile.
>
>
> Segher
