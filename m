Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCLN2d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeCLN2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:28:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70039204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Mon, 12 Mar 2018 14:28:25 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Jia Zhang <zhang.jia@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] modsign enhancement
Message-ID: <20180312132823.dixp7gkjypjlgymt@redbean.localdomain>
References: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jia Zhang [08/03/18 12:26 +0800]:
>This patch series allows to disable module validity enforcement
>in runtime through /sys/kernel/security/modsign/enforce interface.
>
>Assuming CONFIG_MODULE_SIG_FORCE=y, here are the instructions to
>disable the validity enforcement.
>
># cat /sys/kernel/security/modsign/enforce
># echo -n 0 > data
># openssl smime -sign -nocerts -noattr -binary -in data \
>    -inkey <system_trusted_key> -signer <cert> -outform der \
>    -out /sys/kernel/security/modsign/enforce
>
>Now enable enforcement again on demand.
>
># echo 1 > /sys/kernel/security/modsign/enforce
>
>Changelog:
>v2:
>- Support to disable validity enforcement in runtime.

NAK - please use /sys/module/module/parameters/sig_enforce.

And I would rather keep this parameter bool_enable_only, plain and simple.
What use case do you have/why would you want to disable signature
enforcement - after having enabled it - during runtime?  None of this
is explained nor justified in the cover letter.

Thanks,

Jessica
