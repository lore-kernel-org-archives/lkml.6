Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A33C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7E219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNhOGu+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE7E219CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHFOHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:07:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39087 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbeHFOHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:07:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id a11-v6so6123627pgw.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M0pPiB+CXXU1AblPzfly4vNNV69SoNgZgh1tMpOFBNI=;
        b=PNhOGu+8J534MszwauV9KKOiOaiIYnsBH3jtIvTNvV8ZGFIPRZRozi4KRzGQu5N6lK
         bhmG/Y01OhpTP8FKabwPPU4CLrnHfucQZa/ovwwtelxHyPJ4CkQObK579Uj8z/BjhyCS
         yMKxGj6mRy0ZZ9PcFHCQIcDzIdKo/ccgrN9VJuMGshyO2TZj2NEkSVavs9EwqebaP8cw
         AuBYsskDq51COgUClAEJWul1Zx1QL1GCI76fELC7KwGaFG5HAMe1LiCfpiI2IsEjO64V
         PbXR4+ZI/u4uhU17QL6PPi+B8wHuiOK+ofTpmaHY59R8chu5DtX3jJiRNsr+0+Okrows
         D5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M0pPiB+CXXU1AblPzfly4vNNV69SoNgZgh1tMpOFBNI=;
        b=bIe9RggOc0dAwb97C8Qw1ecS1BU2YzOan79gmSlYNhpXteT+YpG+ysIm+M0lE7l4UA
         kb157PJjBHCjQQNTaNxwNBNobSeUWxfAnRq7r3XxlplEiU4GOeV3KRo5IiYSu6YypQl9
         wMuEi7kgvONmljBAJMS9FOTdWVAT8+62+SIVjGJeycK1mTU/j19IKidcOA7WdKYNRcn5
         n54/ajFGidJdCN/qv20PGw3sdRIIjpzUIN0gRysaFitpQ32zVwOVdqhPuhU9ezGakN6w
         4iyzUJloz36HqPN0VZ0vrgQz56QRu4EZ97IZgTwOX37f83bDoWECOdiQCNz0An4m284L
         vghw==
X-Gm-Message-State: AOUpUlHpMBO0WlUOQKlvWHnGP5+p1cuqBZ189B7tRbljVPoqlSJndd4y
        scEpaSk6jKI9wTinS527oHUAHDibqsyArhk9RDxfEQ==
X-Google-Smtp-Source: AAOMgpdQ/edhGtUa/NaUW+awwhz3sZIgR3gAghs532Rnq+5KYERFMtVPDgyREUUYkk6CfZIlXO55Ftv4SUv9LAkcx4o=
X-Received: by 2002:a62:6003:: with SMTP id u3-v6mr16869129pfb.114.1533556726196;
 Mon, 06 Aug 2018 04:58:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 04:58:25
 -0700 (PDT)
In-Reply-To: <20180806113212.GK19540@dhcp22.suse.cz>
References: <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
 <00000000000070698b0572c28ebc@google.com> <20180806113212.GK19540@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 13:58:25 +0200
Message-ID: <CACT4Y+ZY6u9qqx6FofECrAZ6TmbcqZ=b4GVwHsxV6hZtNsypgQ@mail.gmail.com>
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 1:32 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 06-08-18 04:27:02, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch and the reproducer did not trigger
>> crash:
>>
>> Reported-and-tested-by:
>> syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com
>>
>> Tested on:
>>
>> commit:         8c8399e0a3fb Add linux-next specific files for 20180806
>> git tree:       linux-next
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fe18e2400000
>>
>> Note: testing is done by a robot and is best-effort only.
>
> OK, so this smells like a problem in the previous group oom changes. Or
> maybe it is not very easy to reproduce?

It's possible to ask syzbot to test on a particular tree/commit too.
