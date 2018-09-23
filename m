Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37418C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EF420989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dn1d0nPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EF420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeIWWU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:20:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33025 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIWWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:20:57 -0400
Received: by mail-io1-f67.google.com with SMTP id l25-v6so2785516ioj.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPbNdcW2sWYvosWPPXUG9XIAS4i6lzwbFnmKC5puE34=;
        b=Dn1d0nPeIIz6sJTA2IttiDzPC3dSxdErFPYl65mGbb4SYbOcE49wfh+W/XcXdRCPTv
         qSyG59eOYBshIoAMNbt70vSgtIdsuA+CurwYisR4UZDfeOurMXVVel9eQU+KP4Ef/DTg
         dSvhCTnsMlhVNutzAQaiMscLJAVkJ8njvXF68DXaxZlXfBY5H/SptYaM5umaHck0URy4
         mwX24e6b6Y9eaNRBWx93S5FUQiGD8hsvroUqfjsh/gQsAE7nkMC0esVYvdnhbTsbbO3x
         MmC71wGDzHMazcSlpldsvtnHn2ipeC1uavpjV1HesxdXf1lU0Ov1cg+DlWetFtnKQ/EC
         +yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPbNdcW2sWYvosWPPXUG9XIAS4i6lzwbFnmKC5puE34=;
        b=lV3WOl89+owR87f5Vh/aekpZsS30CgqTVk1/OJgci7s8eKqiicyQKkabatvoaji8gP
         yJQlNkSf1iTCAF95hV+Ec+4FTcvq/Jj72LUxj5omXWtSOkwe48j/DZzKWpwZ/K+Iwipw
         zsdu4Nq3zEgW3j/UAPYeRkds1PpnDHPKILNKQ3ZVrVjWcFkv4Z9PD7kDJpD9of6yezqr
         w8TaCJkCInXJyL5SOqNME3EkpGzZ8QkztPvlRllPPy7aqKBt6RMLaG4vTDZm7jLHFN/o
         Egj8JZDxrqaVb+JHRfsDfjRs40SMMLGFqbZ4FrCk0TOhtlLDT5yCJ0ObfCCgFeha2c18
         H8ag==
X-Gm-Message-State: ABuFfojM508gGC3kpKTdv/qXAIi82mBz6Zg/5hv0Hm/uQZ+xC79l7+pg
        2yu+kcb5GoxLg1ngclsItbDvh9XNlr4hVVTmSRIhiQ==
X-Google-Smtp-Source: ACcGV6072/fNmbjuErL3KwtDBY5uphhRZ0Pm3oqaMyrmcFe5eE01B/L+3Yjd6WxbMpnuOG8f/tw2kc2UsNjSxA4anEw=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr5278178iog.11.1537719777068;
 Sun, 23 Sep 2018 09:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 09:22:36
 -0700 (PDT)
In-Reply-To: <125732064.15444205.1537718529926.JavaMail.zimbra@redhat.com>
References: <000000000000565ab805768bf006@google.com> <125732064.15444205.1537718529926.JavaMail.zimbra@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Sep 2018 18:22:36 +0200
Message-ID: <CACT4Y+Z1G_QMG_PQu_ZwHsyhwyh_DBOG4mX9n=va08w3Z7j02Q@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in memcmp (2)
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     syzbot <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        sunlianwen <sunlw.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 6:02 PM, Vladis Dronov <vdronov@redhat.com> wrote:
> #syz fix: net: fix uninit-value in __hw_addr_add_ex()

Hi Vladis,

This can be fixed with "net: fix uninit-value in __hw_addr_add_ex()".
That commit landed in April, syzbot waited till the commit reached all
tested trees, and then closed the bug.
But the similar bug continued to happen, so syzbot created second
version of this bug (2). You can see on dashboard that the last crash
for the second version (2) happened just few days ago. So this is a
different bug.
