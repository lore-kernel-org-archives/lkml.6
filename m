Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E9DC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE06222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DePMWSY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfBMCPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:15:53 -0500
Received: from mail-yw1-f42.google.com ([209.85.161.42]:42045 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbfBMCPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:15:52 -0500
Received: by mail-yw1-f42.google.com with SMTP id v201so312144ywa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 18:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1jt/s8Bj78A5TMIMiOaGw6Nt1+jxLifdL2JPy3lllg=;
        b=DePMWSY4A7ehg4e8oD2o1ijg66oy8QTxs7bcmOuxTkQ3X9giEok72a5xm0l+C4NOLY
         kV76BE0OOQuh5bHtDGre0rwrU52Vvp/XWHgMmEUd+klPx/u5pdKnyzgDW4eIpuWAKbQ/
         odAIwdo8iBUUu8M3o6H0+Q9F4+e6uyO9rYcMlwwIPBfVKkD9wr4xqIJQyRqDyz9or+yq
         4/4pJSct3sMHJuP0PS1LttIS6FUEJSume6P3hnynustwZQm3EuB5sRTPKWoEj8nco9ee
         W3sFQvWI7egpRLMk7mydV6KlKqJa3Obo4MtRJWsicWsI50VQJ9MdiR3PBH7SeLzl1lIX
         NM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1jt/s8Bj78A5TMIMiOaGw6Nt1+jxLifdL2JPy3lllg=;
        b=ZCxCPZKt3TNgPE+ht0a/TlhW23Jn+kIDnKaYWKPo3BQ3PdqjDZAOQBPMR3zrww/t2d
         RZbQ8SMiIPlle94kobKCL9Bp8MWO8VxuecKl1n6YWDWd0FPhUOItGsnX54uBxqLheb9N
         1PH+ACPoX+sLflNR5c3v8WSL346VLKIOOPqOjubGoD7N/Knq8XE9w+dJ/YuTRhze84O/
         ox1gseNNWv+C/IITbJmbUKJvDOXoTs2peOWs2EA7vShUQ2Pgocmqn6HWCUsvreuRyq1U
         bgLdMKUbt2JT1WDnmOCX0bM85CV1pQoEUDocUleQRFMP27Wi0UgVhU6w339XzZN04UaU
         uFPQ==
X-Gm-Message-State: AHQUAuZ14SW/M3NECPUHwMdvK3cNwo6YqSn56gqRgDnqCdYMWOy5tRAe
        UpDPfCZSdosABTHJ/LsnwmMBrLywWRXMMrzmPV8J1A==
X-Google-Smtp-Source: AHgI3IZoBivKEmPL3Bhk4KyHtE3zAwIct9AzbS4ZTfSUcxcTmyJo9Pv1Egsssi9PbsI1RYfYQbTNM46ZA2dLW73/ENY=
X-Received: by 2002:a81:b189:: with SMTP id p131mr2673215ywh.92.1550024151249;
 Tue, 12 Feb 2019 18:15:51 -0800 (PST)
MIME-Version: 1.0
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-2-git-send-email-laoar.shao@gmail.com> <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
 <CALOAHbAskuYhs3KQTJtT0Y7hjFcOyab-JpG4GCPENUxOk34-eA@mail.gmail.com>
In-Reply-To: <CALOAHbAskuYhs3KQTJtT0Y7hjFcOyab-JpG4GCPENUxOk34-eA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Feb 2019 18:15:39 -0800
Message-ID: <CANn89i+2JB1UfdTmVMPMP-fEeYm9safcO49ygKn6fccEP1rpYA@mail.gmail.com>
Subject: Re: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Lawrence Brakmo <brakmo@fb.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 6:07 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>

> Let me explain the background for you.
> I want to track some TCP abnormal  behavior in TCP/IP stack. But I
> find there's no good way to do it.
> The current MIBs are per net, other than per socket, that makes it not
> very powerful.
> And the ancient SOCK_DEBUG is not good as well.
> So we think why not cleanup this ancient SOCK_DEBUG() and introduce a
> more powerful method.


I am all for it, but this more powerful method does nothing at all in
the current patches.

I can not accept patches just because they seem to be harmless,
knowing that  the next patches
will be pushed later changing more stuff, just because the new
infrastructure is there "and can be used"

Just remove all SOCK_DEBUG() calls, there are leftovers of very ancient times.

Do not add more debugging stuff unless you can demonstrate
they actually allowed you to find a real bug and that you sent a
public fix for it.

Just adding "cool stuff" in TCP stack does not please me, it is only
more complexity for unproven gain.

Otherwise, I am tempted to think that these BPF hooks are there only
so that a company can more
easily build a private variant of TCP, yet letting the community
maintaining the hard part of TCP stack.

Thank you.
