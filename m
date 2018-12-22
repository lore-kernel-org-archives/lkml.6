Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30AEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AD621A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWTycyqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391116AbeLVRS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:18:58 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:40509 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeLVRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:18:58 -0500
Received: by mail-qt1-f176.google.com with SMTP id k12so9339726qtf.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=oKDQg5geAo/RZZ05FD1FyTy1FofP94yAoezBHG5e23Q=;
        b=lWTycyqRb5AZea1arAQmWI2PZSRUmw5KQNhRLlD80RR9kSaBrp+H9ScjVMTFTL5dvo
         Id95qBMC41XyAQmXQr8gbCLfzx3AbD1Pcu2tPhPaMtSo1upoxgMidP7ZL2ukJHclzcN7
         6AIGOf6Rt5Gdrtrc1z5o5sX5A+x37Uzkdpdm1kBKce6jR/7aQlNV90vXfz+lJWWFDA3C
         AK8a8YBlUp0Ffx0SDYu9qvh/6ECifDVKCd51pGAMaaZpSDLVMNiajTA34YC4EnLYyxMP
         uxGtDPzf7rbZpo75cJ4dirxIxh1yGh1R7l/EuZtB4xL3qtXznlHebCeduak9Th4Zb8CS
         jPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=oKDQg5geAo/RZZ05FD1FyTy1FofP94yAoezBHG5e23Q=;
        b=G2Y72/CgeKz35P26iZYLhpnhh8xrUN+IRXPd13WKfSKVQt3DYXJ18iRROKEAzv7DWR
         lGtL0tBY7+tl7oYBPS9g3wulBI3fkYJnbV14XhZZE9mUfmZUBXM5OJpnoceZ1lzqb2Tr
         ir8oo3jFTMOxGjk5FPzM0Bl/2ti1G5RTqfHVKXwWrPwaZd9v6lqNqHv2IVv37unyMoIS
         CUplyWP/utJ8NBdtiJdOKW2bjUn14isSUI77SZYaIlpZvRXlPovHRmlsGGDuN/3jRgf+
         gnC3XMod2o05HdeGA+oUciB/CArYx6UOPeu++C+DBHY5D+yf5sJmDFJxex+j6Us5H8Gm
         skIQ==
X-Gm-Message-State: AJcUukd9FVAoPlT2uHEQwFxSVqBHorB5//pk9nBz1b1HwtELyLXGV385
        pJeN19IJazgKeZR9zYP7xRREVDb/
X-Google-Smtp-Source: AFSGD/VcABp4FrG2ZHY7HWBNbhQCS6JNMavNIhf1IbHpu2HpiX2DzCzCOWsXabdZ78Y4hXrSH+te0A==
X-Received: by 2002:ac8:274a:: with SMTP id h10mr6206976qth.189.1545489431701;
        Sat, 22 Dec 2018 06:37:11 -0800 (PST)
Received: from ?IPv6:2001:470:1d:7b6::245? ([2001:470:1d:7b6::245])
        by smtp.googlemail.com with ESMTPSA id 86sm7981969qky.92.2018.12.22.06.37.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 06:37:10 -0800 (PST)
From:   Ellie Reeves <ellierevves@gmail.com>
Subject: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on userns
 mounts, breaking systemd-nspawn
To:     linux-kernel@vger.kernel.org
Message-ID: <dae0cf2f-d987-4461-d8e7-e2cdf5f7d936@gmail.com>
Date:   Sat, 22 Dec 2018 09:36:55 -0500
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

nginx, dovecot, postgresql, and postfix complained about getting 
permission denied on /dev/null even though it appeared perfectly normal 
to me, the correct permissions, all that
/var was also acting very strangely, getting a lot of permission denied 
or operation not supported messages.
I could not delete a file that my user had the right to create, write to 
and read in /var, I needed root

Here is the pull request that was made to systemd, along with a small 
amount of talk around the issue:

https://github.com/systemd/systemd/pull/9483

It was ultimately decided among the systemd folks to bail out of the 
issue, as shown in the news entry for systemd 240:

KERNEL API BREAKAGE: Linux kernel 4.18 changed behaviour regarding
mknod() handling in user namespaces. Previously mknod() would always
fail with EPERM in user namespaces. Since 4.18 mknod() will succeed
but device nodes generated that way cannot be opened, and attempts to
open them result in EPERM. This breaks the "graceful fallback" logic
in systemd's PrivateDevices= sand-boxing option. This option is
implemented defensively, so that when systemd detects it runs in a
restricted environment (such as a user namespace, or an environment
where mknod() is blocked through seccomp or absence of CAP_SYS_MKNOD)
where device nodes cannot be created the effect of PrivateDevices= is
bypassed (following the logic that 2nd-level sand-boxing is not
essential if the system systemd runs in is itself already sand-boxed
as a whole). This logic breaks with 4.18 in container managers where
user namespacing is used: suddenly PrivateDevices= succeeds setting
up a private /dev/ file system containing devices nodes — but when
these are opened they don't work.
At this point is is recommended that container managers utilizing
user namespaces that intend to run systemd in the payload explicitly
block mknod() with seccomp or similar, so that the graceful fallback
logic works again.
We are very sorry for the breakage and the requirement to change
container configurations for newer kernels. It's purely caused by an
incompatible kernel change. The relevant kernel developers have been
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
