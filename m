Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jSSxLedVHluRbwAAmS7hNA
	; Mon, 11 Jun 2018 10:58:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AB78260792; Mon, 11 Jun 2018 10:58:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 320CC60541;
	Mon, 11 Jun 2018 10:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 320CC60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeFKK6p (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:58:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:58002 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932765AbeFKK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:58:44 -0400
Received: from [188.63.75.139] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fSKX3-0007Vo-RE; Mon, 11 Jun 2018 12:58:41 +0200
Subject: Re: [PATCH v2] selftests: bpf: fix urandom_read build issue
To: Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org,
        ys114321@gmail.com, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <CADYN=9JEi2=YcC0KD555atZFiJNbP8Y9O0UME+63iTpSSd=ttg@mail.gmail.com>
 <20180608065127.28115-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e974c47f-50eb-c8fc-43d6-4dcb22dea6e4@iogearbox.net>
Date: Mon, 11 Jun 2018 12:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180608065127.28115-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24652/Mon Jun 11 06:34:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 08:51 AM, Anders Roxell wrote:
> gcc complains that urandom_read gets built twice.
> 
> gcc -o tools/testing/selftests/bpf/urandom_read
> -static urandom_read.c -Wl,--build-id
> gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bpf
> -I../../../../include/generated  -I../../../include    urandom_read.c
> urandom_read -lcap -lelf -lrt -lpthread -o
> tools/testing/selftests/bpf/urandom_read
> gcc: fatal error: input file
> ‘tools/testing/selftests/bpf/urandom_read’ is the
> same as output file
> compilation terminated.
> ../lib.mk:110: recipe for target
> 'tools/testing/selftests/bpf/urandom_read' failed
> To fix this issue remove the urandom_read target and so target
> TEST_CUSTOM_PROGS gets used.
> 
> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied to bpf, thanks Anders!
