Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9882177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9882177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeHCTy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:54:26 -0400
Received: from simcoe208srvr.owm.bell.net ([184.150.200.208]:43918 "EHLO
        torfep02.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728079AbeHCTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:54:26 -0400
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
          with ESMTP
          id <20180803175705.YMQI32387.torfep02.bell.net@torspm02.bell.net>;
          Fri, 3 Aug 2018 13:57:05 -0400
Received: from [192.168.2.49] (really [70.53.62.189]) by torspm02.bell.net
          with ESMTP
          id <20180803175705.QJXG31064.torspm02.bell.net@[192.168.2.49]>;
          Fri, 3 Aug 2018 13:57:05 -0400
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement
 expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     deller@gmx.de, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net>
 <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net>
 <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net>
 <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net>
 <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net>
Date:   Fri, 3 Aug 2018 13:57:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=DZT4krlW c=1 sm=0 tr=0 a=VCUqJnZSONuD0ISaPFNHjQ==:17 a=IkcTkHD0fZMA:10 a=dapMudl6Dx4A:10 a=FBHGMhGWAAAA:8 a=hkL0fQ1ZxZnohGXfZUwA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 4:31 PM, Nick Desaulniers wrote:
> If I understand your point correctly, is it that you're saying that
> _THIS_IP_  should be implemented in terms of inline assembly (as in
> what current_text_addr() is currently)?  If that's what you mean and
> I'm understanding correctly, my point is that we should be preferring
> the generic C implementation as that's what's being used in most
> places currently, so if it was broken you'd likely already know about
> it.  Unless unwinding is truly broken by the additional label, I don't
> think we need an inline assembly implementation of current_text_addr()
> for parisc (or any arch for that matter).  If we do, then it can be
> localized to the parisc unwinding code, that way it can be
> consolidated everywhere else for every other arch.
The label breaks the unwind data, not the unwind code.  So, localizing 
the use of
current_text_addr() to the parisc unwind code doesn't help.

Personally, I prefer the implementation of current_text_addr() because:

1) The generated code is smaller, and
2) it doesn't introduce any unnecessary labels into the text.

As noted, these labels can cause issues with unwinding.

Dave

-- 
John David Anglin  dave.anglin@bell.net

