Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D875C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95BD2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApHm5yxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95BD2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeKBPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:42:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51584 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeKBPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:42:32 -0400
Received: by mail-it1-f194.google.com with SMTP id h13so1870348itl.1;
        Thu, 01 Nov 2018 23:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tqoMTTVwnMhiHXdvJBXzh9+8Ed8T4gExN1BaQsoEOlw=;
        b=ApHm5yxsy9Ymaq8mJ41NIJ9D7r5J8wknZLzl6GIbMV7oqQ0WYLsLEq+0zpubN894hM
         Rxa6Z4KeTQ97LXsGqweWQaDIBYjgKYvpMyPhSsv5fqEqw4msQu+MoU/0BN+JwCVeNCV1
         uHpQ4fy+MIiq3Jv/60TOYAUlBTpXhb4O3xarjIRpnnSFGe+wkBRffNRCLZN9ylYYfWz0
         h7pH0zpl1Q61kgjTUnguKTrq2Ubjvrsqmt9g1jqe7jFTkhexAJ0ybaO91IJ60/lgGMLD
         l59SCyQMeG1vdgNk8Z3QOuI5udbeK57iaPbWNzj6AcPwRwow/fr4TbbRHcaXKJtJJQk7
         9lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tqoMTTVwnMhiHXdvJBXzh9+8Ed8T4gExN1BaQsoEOlw=;
        b=ukEgQQsZjCmoxy/DynEv/L5EbxLHDXSKtbYKGOhnjpcCeDbIw2GVaLlSZYxd3M7gQp
         Nj5cafKr1aQwWFp+CEa2kNKwRVVcpcLkbNYzJ3u8spV3mWeY2Bpe9jrFPIItj9GSOAyX
         TwaVbWLLYfi0pundaPIO5ie6ccwKPxx2dLGf29/zG0bFivKGHF3iCBCcj1m8zKIamSPY
         UEzvjgQPp5+4DPVf6AbseqiNfG6n9YweusjJEP0ylNLd+Td93GPFhjyZqzSFOr4nsWwh
         gNO0XXLkURahpt/caEceLgremmCTWMS2SKICMY8JpbMl06VsOTmp7BfF2epYQgOjYZQF
         J32w==
X-Gm-Message-State: AGRZ1gIMttaaTj15a6K4p+8YCEd67TTcPwBl5Dfgl2rP95s9BIPoIv++
        YqgS4Eb/2glh0Ca7UXP6LtCqu7vMtKQ9ktpaa8zUCjEE
X-Google-Smtp-Source: AJdET5cIvHX61oZHGt0hIuUgUPGyVWj+mIeAsT3Sl4MMfz6zbv0+HFMiKCy6UaJERfoEoSKzD4uUIhOiLv7p4L0iPf8=
X-Received: by 2002:a24:6c14:: with SMTP id w20-v6mr89711itb.103.1541140585944;
 Thu, 01 Nov 2018 23:36:25 -0700 (PDT)
MIME-Version: 1.0
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 2 Nov 2018 15:36:13 +0900
Message-ID: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
Subject: perf script doesn't dump a normal call trace
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):

# perf record -e 'skb:consume_skb' -ag
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]

# perf script
swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
skbaddr=0xffff962c591d4900
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
skbaddr=0xffff962c591d4900
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])


On RHEL-7 kernel(3.10.0):

# perf record -e 'skb:consume_skb' -ag
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.170 MB perf.data (214 samples) ]

# perf script
swapper     0 [001] 69006.726193: skb:consume_skb: skbaddr=0xffff917db9647900
            7fffb3425a00 consume_skb ([kernel.kallsyms])
            7fffb34ba3cb arp_process ([kernel.kallsyms])
            7fffb34bad65 arp_rcv ([kernel.kallsyms])
            7fffb343b6d9 __netif_receive_skb_core ([kernel.kallsyms])
            7fffb343b9d8 __netif_receive_skb ([kernel.kallsyms])
            7fffb343ba60 netif_receive_skb_internal ([kernel.kallsyms])
            7fffb343c6e8 napi_gro_receive ([kernel.kallsyms])
            7fffc007d1f5 virtnet_poll ([kernel.kallsyms])
            7fffb343c07f net_rx_action ([kernel.kallsyms])
            7fffb2ea2f05 __do_softirq ([kernel.kallsyms])
            7fffb357a32c call_softirq ([kernel.kallsyms])
            7fffb2e30675 do_softirq ([kernel.kallsyms])
            7fffb2ea3285 irq_exit ([kernel.kallsyms])
            7fffb357b5e6 __irqentry_text_start ([kernel.kallsyms])
            7fffb356d362 ret_from_intr ([kernel.kallsyms])
            7fffb356c12e default_idle ([kernel.kallsyms])
            7fffb2e386f0 arch_cpu_idle ([kernel.kallsyms])
            7fffb2efe3ba cpu_startup_entry ([kernel.kallsyms])
            7fffb2e59db7 start_secondary ([kernel.kallsyms])
            7fffb2e020d5 start_cpu ([kernel.kallsyms])

swapper     0 [001] 69006.754090: skb:consume_skb: skbaddr=0xffff917db9647100
            7fffb3425a00 consume_skb ([kernel.kallsyms])
            7fffb34ba3cb arp_process ([kernel.kallsyms])
            7fffb34bad65 arp_rcv ([kernel.kallsyms])
            7fffb343b6d9 __netif_receive_skb_core ([kernel.kallsyms])
            7fffb343b9d8 __netif_receive_skb ([kernel.kallsyms])
            7fffb343ba60 netif_receive_skb_internal ([kernel.kallsyms])
            7fffb343c6e8 napi_gro_receive ([kernel.kallsyms])
            7fffc007d1f5 virtnet_poll ([kernel.kallsyms])
            7fffb343c07f net_rx_action ([kernel.kallsyms])
            7fffb2ea2f05 __do_softirq ([kernel.kallsyms])
            7fffb357a32c call_softirq ([kernel.kallsyms])
            7fffb2e30675 do_softirq ([kernel.kallsyms])
            7fffb2ea3285 irq_exit ([kernel.kallsyms])
            7fffb357b5e6 __irqentry_text_start ([kernel.kallsyms])
            7fffb356d362 ret_from_intr ([kernel.kallsyms])
            7fffb356c12e default_idle ([kernel.kallsyms])
            7fffb2e386f0 arch_cpu_idle ([kernel.kallsyms])
            7fffb2efe3ba cpu_startup_entry ([kernel.kallsyms])


any idea why I could get a proper call trace on the new kernel?

Thanks.
