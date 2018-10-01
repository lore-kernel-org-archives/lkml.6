Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CECC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC382082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUJhS4PK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC382082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeJBBDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:03:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54999 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBBDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:03:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so5763034wma.4;
        Mon, 01 Oct 2018 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3d8uoZ9jCqDqemUU8IioBY+cRe4IOM/hpQz0bGB7OI=;
        b=IUJhS4PKHOHkdV9C94AdJ+4Wr4ywPf+0VXSUOrQuduFYpVg22g00D3c6G1nPR9efBo
         Vfy9lwsBKTtsRG2Yq+YNrPG0zQ9AQhT9gaIyxVCfITx2zd28I6fawOiI3yTwhmUKaNnZ
         KDtvMS7ZsIjDReRn6O+Zgy8vUuaZS1LdX6S1LqTqPMuHpKExLVV+nEQ8vAtZUJb0Qzv3
         YgIIQd5nujSFLw230VQ9HanuowP51xWqIaCgNWH3OrdSVnXejS2BanYLZ2oH4ft1HJ3u
         iWSn818QphRr7oFAZm3gZJ2EZjuUD6QMXgBFa3/USVe2KhH+lRJKZ/BXO3704t5w+T/P
         yF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3d8uoZ9jCqDqemUU8IioBY+cRe4IOM/hpQz0bGB7OI=;
        b=gPIddOki9/aw4ScZBJNfFJ4UpYtRp/eiR1hf/3cQmYNuOnXZh4tqD2h3pkMEzzhriQ
         wV7nks5CIp/vuf64mzjezQ1r3+XRcLDhKkTtkHfW2Zs93qOlsGMKT2Ct7zyAp5crczZC
         teggVA4ZSlXfd2gsxx+rU1GK0qjin+ndX2naHE8SiwknVpR1JFHKQgNYXcp3Aoy59bY1
         ook4GPuhnns47J/NoYZgdj9ZwPeK6zRS2qTUBeDx8YX+GxjKAtlRlgJslnwTwAH9X4Lw
         BKxR8trvUtmeS4gxsU+zbGvCFe+ldjQgcPkrByt8QOkbWquYmd2/nI0EaxaYT5tCaih8
         xARw==
X-Gm-Message-State: ABuFfogTXEV1V5mwPkEm7m5KASDViCP5aYgHbUX/z1+EYIbHdVivzMsV
        NwoVuq2FN9zogCJH2nUZgBA9yjOW0zWbOmb2Dr0=
X-Google-Smtp-Source: ACcGV60d7+ABKTfaBIjZOmoct8T5zdze/FK0t6hF4wixGI6eQT+WJX1MpmJ//htUiqfBYzWvLoU+cXeqioWKC8wofV0=
X-Received: by 2002:a1c:a696:: with SMTP id p144-v6mr6265141wme.14.1538418235854;
 Mon, 01 Oct 2018 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000357da505772ec5ad@google.com>
In-Reply-To: <000000000000357da505772ec5ad@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Oct 2018 18:23:43 +0000
Message-ID: <CAADnVQ+DyZ5ze4gjfgQz+OATRE_Jd1b5D1osq8+8O3BL9vHzhg@mail.gmail.com>
Subject: Re: WARNING in pcpu_alloc
To:     syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com,
        Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:14 PM syzbot
<syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c5a9f9817ba5 Merge branch 'bpf-per-cpu-cgroup-local-storage'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=175f98e6400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
> dashboard link: https://syzkaller.appspot.com/bug?extid=18628320d3b14a5c459c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129cbd1a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16685ac9400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> illegal size (0) or align (8) for percpu allocation

Roman,

looks like
        if (attr->value_size > PAGE_SIZE)
                return ERR_PTR(-E2BIG);
is not enough, since value_size==0 needs to be rejected as well.
Could you prepare a patch?
