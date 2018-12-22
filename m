Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983F12080D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe3Eye/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390695AbeLVSNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:13:52 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:44193 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeLVSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:13:52 -0500
Received: by mail-qt1-f171.google.com with SMTP id n32so9418389qte.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=KimV+wviri6Y02rM4nvg8Iv/6jN5msr9mJi5XbL0wks=;
        b=Pe3Eye/jh8I0IKqi2RfJ3xDxManECWmc20Z9J/kvg8QGT6ncOSyNig+cxK+NxB0crp
         ZvbKAQCfW5iHG7h2gZpGsaAgvX4M8vyltdSQYzjKz/GtzfVqE2lj6RxUskBwrLasPNkM
         UEFQWrgqdeeBstg48mf2zoqxUPdzLpRqj/GlioNmTGkvi/1wVFZg0MA7gBWLezZ2+OKz
         yrj3Y6yMppzuR5Y/tl3fS7io2zE3PvGGGkm6UlAH/JISDtehWtbk+1NhIN7ju0mXC41y
         jf1S9ICwXUrmm0J8QbMQDEX9IIvcngbCmf5Pyjl4EOZPtM3p6LUXB7nbP+/W7KqNfDz7
         29Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=KimV+wviri6Y02rM4nvg8Iv/6jN5msr9mJi5XbL0wks=;
        b=HcfqeR9IL/Oxh/m0rspdugb6B1WlxL25Nz7I0AhAx7AaXPiUEUxH5DmfJS8haHCKVg
         v1onsx9Mvuy+OnRtB98LQmJDh44NpP2SEEZkhCYvHxtEqhaR7McN03ZVv/USR34jzGmV
         8PRDmH/DoBxs8O+r7sp4Ykh28YdBCcxXc09lfrI4CZ5xCCB5oSaKS/sXZoiQ6V5c+mYu
         R+wAoNd3Z0ut5xXjhF+50r4gsbzraVxnQu1JgIuEZXRTn/CMjTuDee7OmuvhH6XgaD7p
         UWV9ciDV84KJXvVlWMLSdQ4tt+ssM/igQ5X6jA2YZAtbseymC4GK8W1ayWbOPEip52Vj
         LlCQ==
X-Gm-Message-State: AJcUukcEAwKtZ/n/A52dz4e+knH79F8jJd3Y+7AoU0/3KuPa2BSftzLh
        A2D6r1oIwCJLjjRlZSYqGADDEeHi
X-Google-Smtp-Source: AFSGD/X744VYg+17QtWcbu8G860xvzN6z9MCtnHCeuFFe8ZiBKFUkRc26CoWbU+sfz673XenrQRvoA==
X-Received: by 2002:aed:2a1a:: with SMTP id c26mr5695332qtd.147.1545478762860;
        Sat, 22 Dec 2018 03:39:22 -0800 (PST)
Received: from ?IPv6:2001:470:1d:7b6::245? ([2001:470:1d:7b6::245])
        by smtp.googlemail.com with ESMTPSA id n92sm5742291qtd.85.2018.12.22.03.39.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 03:39:22 -0800 (PST)
From:   Ellie Reeves <ellierevves@gmail.com>
Subject: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on userns
 mounts, breaking systemd-nspawn
To:     linux-kernel@vger.kernel.org
Message-ID: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
Date:   Sat, 22 Dec 2018 06:39:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
first off, allow me to express that this is my first time ever writing 
on such a mailing list, and that if something is unclear or you would 
need more information, just let me know.
I write to this list in hoping to see this change reverted. The linux 
kernel always said it would avoid breaking user namespace as much as 
possible, and yet this is what happens. I was hence very much surprised 
when my perfectly working containers on systemd-nspawn which makes use 
of userns by default, stopped working from one day to the next, till I 
identified the problem as being kernel >= 4.18. This container is in 
production, hence the annoyance it was. From one day to the next the 
container started failing with stranges problems:

* nginx, dovecot, postgresql, and postfix complained about getting 
permission denied on /dev/null even though it appeared perfectly normal 
to me, the correct permissions, all that
* /var was also acting very strangely, getting a lot of permission 
denied or operation not supported messages.
* I could not delete a file that my user had the right to create, write 
to and read in /var, I needed root

Here is the pull request that was made to systemd, along with a small 
amount of talk around the issue:

https://github.com/systemd/systemd/pull/9483

It was ultimately decided among the systemd folks to bail out of the 
issue, as shown in the news entry for systemd 240:

         * KERNEL API BREAKAGE: Linux kernel 4.18 changed behaviour 
regarding
           mknod() handling in user namespaces. Previously mknod() would 
always
           fail with EPERM in user namespaces. Since 4.18 mknod() will 
succeed
           but device nodes generated that way cannot be opened, and 
attempts to
           open them result in EPERM. This breaks the "graceful 
fallback" logic
           in systemd's PrivateDevices= sand-boxing option. This option is
           implemented defensively, so that when systemd detects it runs 
in a
           restricted environment (such as a user namespace, or an 
environment
           where mknod() is blocked through seccomp or absence of 
CAP_SYS_MKNOD)
           where device nodes cannot be created the effect of 
PrivateDevices= is
           bypassed (following the logic that 2nd-level sand-boxing is not
           essential if the system systemd runs in is itself already 
sand-boxed
           as a whole). This logic breaks with 4.18 in container 
managers where
           user namespacing is used: suddenly PrivateDevices= succeeds 
setting
           up a private /dev/ file system containing devices nodes — but 
when
           these are opened they don't work.

           At this point is is recommended that container managers utilizing
           user namespaces that intend to run systemd in the payload 
explicitly
           block mknod() with seccomp or similar, so that the graceful 
fallback
           logic works again.

           We are very sorry for the breakage and the requirement to change
           container configurations for newer kernels. It's purely 
caused by an
           incompatible kernel change. The relevant kernel developers 
have been
           notified about this userspace breakage quickly, but they chose to
           ignore it.

Here's an email that was sent to lkml about the subject:

https://lkml.org/lkml/2018/7/5/742

I link also this, quoting the last of it:

https://lkml.org/lkml/2018/7/5/701

It has never been the case that mknod on a device node will guarantee 
that you even can open the device node.  The applications that regress 
are broken.  It doesn't mean we shouldn't be bug compatible, but we darn 
well should document very clearly the bugs we are being bug compatible with.

I'm in the opinion that it is a kernel bug, and I quote someone from the 
systemd irc channel:

ewb said applications were broken. But the rule is, if userspace breaks, 
its a bug. The kernel *has* to revert it. And honestly, this change 
doesn't make much sense. You can set nodev yourself but then you know 
mknod will not allow you to open the object. Here, the kernel does it 
without your knowledge

Also, it seems that if this change is reverted, things that were fixed 
to work around the issue this breakage caused will not be broken again, 
they should simply go back to their previous way of working. I 
understand there may be security reason why this change was made in the 
first place, but it is not so big a problem is it ? I can mknode 
arbitrary devices in userns and open them as userns root. But my point 
is, several things broke. My *working* stuff was broken from one day to 
the next.

I am not trying to pick a fight. I want to understand the reasoning 
behind this change in the first place, and I'm simply making an attempt 
at getting it reverted, because it is true that I don't much fancy 
blocking the mknode() syscall in every template unit on every machine we 
administer here, and that staying on kernel < 4.18 is not a good 
sollution either.

I would also like to be personally CC'ed the comments or answers posted 
to this mailing list in response to this message.

Thanks
