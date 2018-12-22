Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24DBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A569C21B8D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUJLBKmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbeLVRUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:20:51 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:41033 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390141AbeLVRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:20:51 -0500
Received: by mail-qk1-f169.google.com with SMTP id 189so5038123qkj.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=KimV+wviri6Y02rM4nvg8Iv/6jN5msr9mJi5XbL0wks=;
        b=SUJLBKmR50Ae9JXK5ODE4qFsaBczhK6a8DTCqctiw9+zL31i58d/aJ1US6XD+LxO7M
         sxTAZ4b/OZKz5osOgycoNY58BO7li006q/6d46yiwSgcKoV+1teqU1akWdZeY8cf8MPu
         eYdPjhz4fmVymFw/PxyqvfC0bT1f+vTdph8K3S5uVADhvxUjiJmCPczgtNuko4eVVCx6
         BFeABi1M95OIZC/fuE1UJ96zT60tKGtLMtnlO+5g6muONcFEgtneEBxS2JtZEyqr1TKJ
         YiG/Qu9gtpPdrhmNDpHZ4Uo2MkDYpFy9HdZXgsOuTfnQm/OJmM+aeRBZjh4BghHG+AKB
         egaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=KimV+wviri6Y02rM4nvg8Iv/6jN5msr9mJi5XbL0wks=;
        b=FsVlPsUpL6f+DL2RAODvVUCe4wJgn2v9sZtqL9lg6cJ6/xKv7ij2HQjP+K0i2g9ww/
         h/g6WkWSBH9eJG52IIFoN+zap7UPA53kM5jf+R8pgaDdWJDM9xXKAkyEcFiMwSDu0Aot
         XiHZexwnbmfHY2Jg6IP3xtMGEQ3yg6iUBWz91kEYO8SKR7Q2tj/3zcrwHnmpbPDENvZb
         gG8dHo4IKiPwSqT/IHw2F7+UUnCRNxSrrjqn8jxkMnKcE31Ikr29bWzN78WIq7jWZFN4
         TfMEkzzg5BPFTy2HCgAdd1PzIBSpujJP2YJEENAaA9kafsksqu/Q+gP0qSfLCQng6i8d
         EPxA==
X-Gm-Message-State: AJcUukfpUWUjLM1e2uejv13OJTtl8GJ00G+BIL4xuYRY9pzAHXJKPDHh
        7wzohBsS1elJB7h6ijD9woTXm6bj
X-Google-Smtp-Source: ALg8bN61KKOVKsfGaRF2Ox29EwnvYhRCuGZPHoxSeIS7mUz5FDr0ygDDqmQnx36Oc5SAOtSDhdkkMw==
X-Received: by 2002:a37:1a20:: with SMTP id a32mr5546537qka.182.1545475460429;
        Sat, 22 Dec 2018 02:44:20 -0800 (PST)
Received: from ?IPv6:2001:470:1d:7b6::245? ([2001:470:1d:7b6::245])
        by smtp.googlemail.com with ESMTPSA id m1sm9487547qkh.15.2018.12.22.02.44.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:44:19 -0800 (PST)
Cc:     linux-kernel@vger.kernel.org
From:   Ellie Revves <ellierevves@gmail.com>
Subject: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on userns
 mounts, breaking systemd-nspawn
Message-ID: <87530985-672b-dc05-c9df-408e6ac12bd6@gmail.com>
Date:   Sat, 22 Dec 2018 05:44:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
