Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD50CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F816208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiLifdh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F816208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeGaJdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:33:43 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:45948 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeGaJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:33:43 -0400
Received: by mail-vk0-f42.google.com with SMTP id b78-v6so7042686vka.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+freNz2XJMSzDoJlQjHGFJTnXDYnndIjiMgC669A0+w=;
        b=TiLifdh4LHX1qea2S+R6zZoJ01dM8F4rkjKrzevjcbUlbdUY1VZX7hVu/dySqqGJOM
         Vggq84Cc1NnfQF2rlLr+dYS7lIGaBGuv1VecNgUsfBeE4RRCsTw/5Lduz+hebHRwNFbl
         7a784DQZURy3NqpzYTvtAad0SPV9bjV1+1y0+Ie2GBErRpPsfmZjJ3jnGlU80VqgxuA4
         5N34/LugTPQ2T9H7+XJHpPyFkX/Cns1VkrUEBHciN1t79Y2v7Dwtj9e1WmujUdzOJPMb
         341rDhK4kFMdexPPbOfK/fEiz1Xuu50tEOjCWhi0jpZO73J8c8yJ4T7IeoaGEMpsaE46
         BGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+freNz2XJMSzDoJlQjHGFJTnXDYnndIjiMgC669A0+w=;
        b=dxUrB3U/rutyF3nDvQ3AiAum6vHR8SaltosbMI69xtY8seixPowvC9pfHFgndXxwFP
         cwGfPhWk1wi78FGGO/RmcyPDwhg4YQ0U/Ffi2uYOrWToVinkxgbsbd2tzh4e0PuWIhik
         /gv1nuDOAhwkY1Y7JIUUtfY2sBcqT1N3/HbncQlLX+Krpr4j3NiK8XHb9uQf2F8t3+DH
         VP+Za02u3NDtUw3zJOvRXhBKb+DYoiYlmX2JMIoL4J4ErShldo+PtRxkVA5v+CxFTtNC
         UynmTClp6L1YVbB2kQuo7rHahPzkwcdOSLCUsEYNuwzZgcet49QqOrMEEfqaWe5MQjWF
         jElA==
X-Gm-Message-State: AOUpUlEzxQwz1kCe96WmqDb41cCUjuwU2aNDnn9jgc7F1/PhC4V8Z+Mk
        8LorSVtnqzV1elMfZQOUxRYVheAdyA9kHmO8nodBa8CKKVs=
X-Google-Smtp-Source: AAOMgpdlRuoGWGQ0YBZP+wdQ3hhtl/K2uavC2PP3duY7FCI/o8oiXgCTOJPlfHfKSysRbmuy0Ps4X3Up2E4w9AsJeG4=
X-Received: by 2002:a1f:f01:: with SMTP id 1-v6mr13309145vkp.56.1533023678614;
 Tue, 31 Jul 2018 00:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:50d8:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 00:54:08
 -0700 (PDT)
From:   Feng Li <lifeng1519@gmail.com>
Date:   Tue, 31 Jul 2018 15:54:08 +0800
Message-ID: <CAEK8JBCZ9HOHs9N6mdjg-q5pr4KZe3kWnrYKgW-huo8Yg9FZmQ@mail.gmail.com>
Subject: page faults affects the performance
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi experts,


When I use fio to write our distribution storage, I find a lot of page
faults that affect the performance.

My OS is CentOS7,  anyone could give suggestions on how to root cause
this issue? The CPU is running at 100%.

[root@58 15:50:57 ~]$uname -a
Linux 58 3.10.0-693.11.6.el7.smartx.1.x86_64 #1 SMP Tue Jan 16
22:09:10 CST 2018 x86_64 x86_64 x86_64 GNU/Linux

Thanks in advance.

This is the perf report from "perf record -g -p 9881"

+   64.68%     0.01%  zbs-chunkd       [k] system_call_fastpath

       =E2=96=92
+   42.86%     0.01%  zbs-chunkd       [k] inet_recvmsg

       =E2=96=92
+   42.84%     0.00%  zbs-chunkd       [k] sys_recvfrom

       =E2=96=92
+   42.83%     0.13%  zbs-chunkd       [k] tcp_recvmsg

       =E2=96=92
+   42.83%     0.01%  zbs-chunkd       [k] SYSC_recvfrom

       =E2=96=92
+   42.75%     0.02%  zbs-chunkd       [k] sock_recvmsg

       =E2=96=92
+   39.52%     0.09%  zbs-chunkd       [k] skb_copy_datagram_iovec

       =E2=96=92
-   31.97%     7.18%  zbs-chunkd       [k] page_fault

       =E2=96=92
   - 24.79% page_fault

       =E2=96=92
      + 24.78% do_page_fault

       =E2=96=92
   - 7.17% __libc_recv

       =E2=96=92
      - 7.17% system_call_fastpath

       =E2=96=92
           sys_recvfrom

       =E2=96=92
           SYSC_recvfrom

       =E2=96=92
           sock_recvmsg

       =E2=96=92
           inet_recvmsg

       =E2=96=92
           tcp_recvmsg

       =E2=96=92
           skb_copy_datagram_iovec

       =E2=96=92
           page_fault

       =E2=96=92


+   24.79%     0.04%  zbs-chunkd       [k] do_page_fault


This is the output of "perf record -e page-faults -ag":

Samples: 132K of event 'page-faults', Event count (approx.): 9249205
  Children      Self  Command          Shared Object                 Symbol
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] skb_copy_datagram_iovec
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] tcp_recvmsg
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] inet_recvmsg
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] sock_recvmsg
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] SYSC_recvfrom
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] sys_recvfrom
+   78.92%     0.00%  zbs-chunkd       [kernel.kallsyms]
[k] system_call_fastpath
+   78.92%    78.92%  zbs-chunkd       [kernel.kallsyms]
[k] copy_user_enhanced_fast_string
+   78.92%     0.00%  zbs-chunkd       libpthread-2.17.so
[.] __libc_recv




--=20
Thanks and Best Regards,
Feng Li(Alex)
