Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeDDJEK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:04:10 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33248 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeDDJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:04:09 -0400
X-Google-Smtp-Source: AIpwx4+a9Hf9oYnX39nLDOqV1bDIxgywMG3/nH4oCGI4uQ8Pl6qY//s+JnhXDjxf+/bDED7ZbUBQZLMv0S3oi/utLiE=
MIME-Version: 1.0
From: Lorenz Bauer <lmb@cloudflare.com>
Date: Wed, 4 Apr 2018 11:04:08 +0200
Message-ID: <CACAyw9-TvamC2HMNv=WDk_aeAM=R7J_BgLiKjevY5+am71W6-A@mail.gmail.com>
Subject: PROBLEM: Using BPF_PROG_TEST_RUN with data_out != NULL is unsafe
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3494IPD002849

Hello,

I’ve encountered an issue when using BPF_PROG_TEST_RUN and capturing the output.
The kernel copies data into user space without checking the length of
the destination buffer.

In bpf_test_finish(), size is the amount of data in the XDP buffer /
skb after the program is run. This can be larger than data_size_in due
to bpf_xdp_adjust_head() and friends.
bpf_test_finish doesn’t clamp size to data_size_out, which is what I
was expecting.

What is the correct way to use this interface?

Best,
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com
