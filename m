Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A412082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A412082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeKBPKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:10:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54154 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeKBPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:10:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 59A9314071A8D;
        Thu,  1 Nov 2018 23:04:30 -0700 (PDT)
Date:   Thu, 01 Nov 2018 23:04:27 -0700 (PDT)
Message-Id: <20181101.230427.364286844194487248.davem@davemloft.net>
To:     firoz.khan@linaro.org
Cc:     sparclinux@vger.kernel.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CALxhOnieTqFzs-D9mNB5nL0=iPGFE92Gwm-Coft7D0_7RJgHiQ@mail.gmail.com>
References: <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
        <20181101.133315.47887636039827313.davem@davemloft.net>
        <CALxhOnieTqFzs-D9mNB5nL0=iPGFE92Gwm-Coft7D0_7RJgHiQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 01 Nov 2018 23:04:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 2 Nov 2018 11:09:57 +0530

> On Fri, 2 Nov 2018 at 02:03, David Miller <davem@davemloft.net> wrote:
>>
>> If sys_nis_syscall for the compat syscall shows up in a situation where the
>> native 32-bit syscall does have an entry, that's a BUG and the script should
>> point this out so that the bug can be fixed.
> 
> syscall.tbl is the input to the script, so the developers has the
> responsibility to fill the table
> properly. I don't know, we have to write a script which has to be
> smart enough to catch the
> wrong syscall entries.

It does not need anything "smart", it just needs to see that
sys_nis_syscall in the "compat" column just as my eyes noticed
them in your patch.

It can be completely automated.
