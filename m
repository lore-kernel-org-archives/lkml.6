Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeBFO7x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:59:53 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:14194 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeBFO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:59:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 6FDAE2E5CF8
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Feb 2018 15:59:42 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>, ming.lei@redhat.com,
        ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <77124223e6116350a5184a5199850304@natalenko.name>
 <1517924768.25841.32.camel@gmx.de>
 <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
 <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
Message-ID: <7eff03cac387051a63aa68df99e49f3a@natalenko.name>
User-Agent: Roundcube Webmail/1.3.3
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1517929183;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=Vnq81rpuLDFqnWEmAVpVxjauvZTlvhz6R52Sn5Tz9yw=;
        b=ub282zcRcMiyh78UdkH5xSZIpSaID+VNPcO0tdRQsI/Cgc9D0pEXzbcDtCX05unMnmF5yv
        4G9dYc8BKcEioahjuaHuPsuMmVUAMY/KvY/n6g2B2aJpJQXfy65HXAyq0xrUytUgR4tTHh
        0IQ+aETzOCgznk6D8kJZWNBDsWqZHhw=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1517929183; a=rsa-sha256;
        cv=none;
        b=iNzTzwQ7EBZ63mpLiNxYeN1A1G4vHhz6gwKsmdfaWJTfVPYCwdOvQsUq7l9DPYQ8wwVLsWWoERLDW+X/sUAUPGk2iuGtSH1HyAguJu6IFHYWeaxmWpdiYhhlfwQnEC6OrQHbzVUZbU5Z5dYSlSIIro9AX++HUDMqKHiFVNEM+uY=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2018 15:50, Paolo Valente wrote:
> Could you please do a
> gdb <buildir>/block/bfq-iosched.o # or vmlinux.o if bfq is builtin
> list *(bfq_finish_requeue_request+0x54)
> list *(bfq_put_queue+0x10b)
> for me?

Yes. Just give me some time to recompile the kernel with minimal debug 
info enabled. I'll post then list/disasm and new stacktraces.
