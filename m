Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD7CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3216521476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3216521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbeGLICq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:02:46 -0400
Received: from www62.your-server.de ([213.133.104.62]:60189 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeGLICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:02:46 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fdWQe-0007YU-L8; Thu, 12 Jul 2018 09:54:20 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fdWQe-000BXY-G6; Thu, 12 Jul 2018 09:54:20 +0200
Subject: Re: WARNING in bpf_check
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+7d427828b2ea6e592804@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000025f8880570c87c51@google.com>
 <CACT4Y+aDK2yFb=8GGMEL8+Tfq6VVJhU-jrhMrQj9KywmMBNHNg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <71a0836d-f4db-d119-0495-dd8732df2cdf@iogearbox.net>
Date:   Thu, 12 Jul 2018 09:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aDK2yFb=8GGMEL8+Tfq6VVJhU-jrhMrQj9KywmMBNHNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24745/Thu Jul 12 06:53:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 09:51 AM, Dmitry Vyukov wrote:
> On Thu, Jul 12, 2018 at 9:41 AM, syzbot
[...]
> Reproducer is below. It seems to be related to the kmalloc failure in
> jit_subprogs():

Thanks a lot Dmitry! Already looking into it.
