Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CD6208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IF0O0ngg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CD6208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFUIhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:37:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35100 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeFUIhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:37:36 -0400
Received: by mail-it0-f65.google.com with SMTP id a3-v6so3656781itd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0f3vte+qHKctjxuzqzw6OOuljpdQG0WxXIaR8pS56M=;
        b=IF0O0nggRVKdZk+Jcu5ifL/102dNu4UqzqwVJBgr58vLjsD4c6AeOQIjfu/PnmTW9E
         n3CxL1o1IvANzElPYiTzcdXJ93N7LVbPjfkcbHngvOb2BG8W9p9+gdonec6xhoPIw/M/
         AFD8DgxcCCkogRcxPrRophDFJIWuY+ylrUobU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0f3vte+qHKctjxuzqzw6OOuljpdQG0WxXIaR8pS56M=;
        b=K58TnpyhIQ0A15HHuwZ5kKMJTCqsnJzpW6PV1zVzGWT30x5fn3eBMHqr1PebtIjbB1
         vPZ6zJefIX6JN4k2SFLdHB712QwwrBVjx5iPgRMI4mlWo4ArdYV0iwd1sjAuZdii49xf
         v0vS+yj81WPumYIpaXflXcUu/RZx171zxHRoR7TLNlzO1ZD3bNAt6i3vBzuMWSpLyAL+
         tKBb6vjoBpCE0sg41+XwWXF8DPGDAK0oWqZRZkLP5YYaLXd9kgjequGFLAx5V+HLttdg
         nK8tzpHz0f0YmxLMRRix9nwRjUujRPV+PbZE92ljQnrOH0/4TyMT1OlBszpkm07uzPlI
         mdaQ==
X-Gm-Message-State: APt69E0tVSTKzI7QkmPVUhzAVN/+K0GTLXmv6J5KHVKDN7pL/SLfdws0
        LWEQdEnr2xXkj5b8RaEgsgF3wl1w9GeBt6rbBXk=
X-Google-Smtp-Source: ADUXVKI1Ogp5spJ26vkUjiYHpD80MUY0ILAzGEdwjYskD94TO9NbVw0pA6HT/7QNTztbXVbZWS19NMnTL0eRRukdIhU=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr4258789ita.113.1529570255157;
 Thu, 21 Jun 2018 01:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180621080624.GO11011@yexl-desktop> <CA+55aFxXCD8qLfHcnshLR2_Feb=RLkOFfCeqPF_sShy7rK2cAw@mail.gmail.com>
 <87muvoh7fy.fsf@yhuang-dev.intel.com>
In-Reply-To: <87muvoh7fy.fsf@yhuang-dev.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jun 2018 17:37:23 +0900
Message-ID: <CA+55aFywQwJDAu6tdouAung+wHxRAWS7Rj8KhtMtHC=NGbF7rw@mail.gmail.com>
Subject: Re: [lkp-robot] [Kbuild] 050e9baa9d: netperf.Throughput_total_tps
 -5.6% regression (FYI)
To:     Huang Ying <ying.huang@intel.com>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>, Aaron Lu <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 5:25 PM Huang, Ying <ying.huang@intel.com> wrote:
> Do you have interest in some other comparison?

No, I think the overhead of the strong stackprotector is a bit sad,
but I assume it's because of the nasty code to load the stack canary
from a cacheline that has absolutely nothing else in it.

Oh well.

          Linus
