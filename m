Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA492C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A698C21502
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A698C21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeIYDlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:41:47 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43807 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeIYDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:41:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3AFD6C17D7;
        Mon, 24 Sep 2018 21:37:32 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PfOzKIASss4v; Mon, 24 Sep 2018 21:37:32 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 3C55BC16CD;
        Mon, 24 Sep 2018 21:36:56 +0000 (UTC)
Subject: Re: [RFC 16/20] selftest: Add Time Namespace test for supported
 clocks
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180919205037.9574-1-dima@arista.com>
 <20180919205037.9574-17-dima@arista.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <741594c9-2247-3cde-5da9-ae8cc41854b6@kernel.org>
Date:   Mon, 24 Sep 2018 15:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919205037.9574-17-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for adding tests with the kernel changes.

On 09/19/2018 02:50 PM, Dmitry Safonov wrote:
> This test checks that all supported clocks can be changed by
> clock_settime.

It would good to elaborate a bit more on the nature of the tests in the
here. Also a few things to consider.

I noticed that this test isn't added to selftests/Makefile as TARGET. If it is
an oversight, please make that change as well. If not, it is fine.

Please make sure if the test can't be run because of unmet dependencies, the test
will exit with KSFT_SKIP as opposed to an error. Dependencies include configuration,
privilege, any other unsupported conditions.

This is a comment applies to all the test patches in this series.

thanks,
-- Shuah
