Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C8C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C4820840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY+HgvNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C4820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeJAJeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:34:16 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34706 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeJAJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:34:15 -0400
Received: by mail-yw1-f66.google.com with SMTP id m129-v6so4937837ywc.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 19:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tl2qk2xHB4yuCr2k2BS6fw5a8mt5rh+izmVX4Ht0M7Q=;
        b=gY+HgvNqF9brm8E3t0eZU9hS8OLxVRMwvV18mm32zIHpgezHA7CXY3Gvd30Crv8/yN
         Nqdk6DqlWVmd0b25+HAddjt14fhNg3KbueKKhu2hJiJu6W0Pe7B4fPlk38HGt7znJ/vm
         0CK6L7AMHWfOjiYIl2fyDuoEiFRI8QV/CGAORrN/25CwgITBPu1DbBp+iMOIqw3lzyK4
         cHZvlv1josUlyxqM/DZlT8EJt7WQq0AEharVWB/4T4vHaP+3bCPt2nNSeWB8TIDFg8RY
         mjHXG/oVNqfSr1WxDMBB3NJeTr3EhZBzm3S3rbTCNBOAIKkSVP2UQUg8DpSOLivTD8KL
         stqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl2qk2xHB4yuCr2k2BS6fw5a8mt5rh+izmVX4Ht0M7Q=;
        b=tBofrN7cr7y3nyHE8PE7wGSts1TRt0V0EQY9rrTlBvJcLUKHEm4h+WCmQK56q5uHux
         GsrE8rGxTkKNsisKz20X8Mi1Ud6jsW8EwwFm5vZc+O9G7ugjBNE8zBhvRU9LrRcENvOJ
         dcbdxODDX+GJLQsJZvA2tiBI6foELaH1T6LTFmoInBxYHEJwDTjt7JCAi7bpxKJT+s5c
         Kl0m3hCg+ZCHQ07G/itA0x/FlwvYW5YqoVQXRrhbF129MaUpcLzIUIyjieJyOwcVR9SQ
         EFUitxKgM6o0j1rgCayxyQUT75md6Vt3hYbGriXVQHIBTCI/I8WJFoZx31pBJHSNnn57
         RJ4A==
X-Gm-Message-State: ABuFfoh7hTNHuBuNtN2PAbDOyiYPzn0hsGAX1HYeCIqy1A9/V2ky5tdO
        Hzs8X9qPMrpnY7FFypgTDZYz90GC
X-Google-Smtp-Source: ACcGV61S3yU0x8Eg+6yFcLnCB9LEex9x0Ay7SwlVoY2/VyzihzF66E7M8NaD3NiJxmuLzoRWqC15qA==
X-Received: by 2002:a81:6587:: with SMTP id z129-v6mr4702822ywb.8.1538362721441;
        Sun, 30 Sep 2018 19:58:41 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id k184-v6sm4692529ywc.62.2018.09.30.19.58.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 19:58:40 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id v1-v6so4915389ywv.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 19:58:40 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr4842769ywf.237.1538362720057;
 Sun, 30 Sep 2018 19:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180930032055.GJ15893@shao2-debian>
In-Reply-To: <20180930032055.GJ15893@shao2-debian>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 30 Sep 2018 22:58:02 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdBMVtWG3u9KmM2qmNMyukd+J_E-Op9SE4q0PUficPbRw@mail.gmail.com>
Message-ID: <CA+FuTSdBMVtWG3u9KmM2qmNMyukd+J_E-Op9SE4q0PUficPbRw@mail.gmail.com>
Subject: Re: [LKP] [flow_dissector] d58e468b11: BUG:unable_to_handle_kernel
To:     rong.a.chen@intel.com
Cc:     Petar Penkov <ppenkov@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 11:20 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: d58e468b1112dcd1d5193c0a89ff9f98b5a3e8b9 ("flow_dissector: implements flow dissector BPF hook")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: test_bpf
> with following parameters:
>
>         test: jit
>
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 2G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +------------------------------------------+------------+------------+
> |                                          | 1edb6e035e | d58e468b11 |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 16         | 0          |
> | boot_failures                            | 0          | 4          |
> | BUG:unable_to_handle_kernel              | 0          | 4          |
> | Oops:#[##]                               | 0          | 4          |
> | RIP:__skb_flow_dissect                   | 0          | 4          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 4          |
> +------------------------------------------+------------+------------+
>
>
>
> [   11.372447] BUG: unable to handle kernel paging request at 0000000000001288
> [   11.375142] PGD 0 P4D 0
> [   11.375884] Oops: 0000 [#1] SMP PTI
> [   11.376822] CPU: 1 PID: 446 Comm: modprobe Not tainted 4.19.0-rc2-00341-gd58e468 #1
> [   11.378646] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   11.380605] RIP: 0010:__skb_flow_dissect+0x8e/0x1690
> [   11.381777] Code: 05 f7 d3 79 7e 4d 8d 14 07 41 0f b7 44 24 06 66 89 85 3e ff ff ff 48 85 db 0f 84 12 02 00 00 48 8b 43 10 48 8b 80 e8 04 00 00 <48> 8b 90 88 12 00 00 48 85 d2 0f 84 f7 01 00 00 48 8d 4d 92 31 c0
> [   11.385799] RSP: 0018:ffffc900008c7a80 EFLAGS: 00010286
> [   11.387040] RAX: 0000000000000000 RBX: ffff88007e80d600 RCX: 0000000000000000
> [   11.388612] RDX: ffffc900008c7bb4 RSI: ffffffff828b3cc0 RDI: ffff88007e80d600
> [   11.390178] RBP: ffffc900008c7b80 R08: 0000000000000000 R09: 000000000000000e
> [   11.391747] R10: ffffc900008c7bb4 R11: ffff88007ea34c00 R12: ffffffff828b3cc0
> [   11.393315] R13: 0000000000000008 R14: 000000000000001e R15: ffffc900008c7bb4
> [   11.394870] FS:  00007f64be17e700(0000) GS:ffff880072900000(0000) knlGS:0000000000000000
> [   11.396785] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.398112] CR2: 0000000000001288 CR3: 000000007ee8e002 CR4: 00000000000606e0
> [   11.399693] Call Trace:
> [   11.400425]  ? vsnprintf+0xf2/0x4b0
> [   11.401335]  ? up+0x12/0x60
> [   11.402116]  ? _cond_resched+0x19/0x30
> [   11.403069]  ? skb_get_poff+0x4b/0xa0
> [   11.404010]  ? __kmalloc_reserve+0x2e/0x80
> [   11.405145]  skb_get_poff+0x4b/0xa0
> [   11.406050]  bpf_skb_get_pay_offset+0xa/0x10

Thanks for the report. This has most likely been fixed, by commit
100811936f89f ("bpf: test_bpf: add init_net to dev for
flow_dissector")
