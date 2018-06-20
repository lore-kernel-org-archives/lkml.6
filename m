Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA73C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871D5208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drE0uTbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871D5208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFTI2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:28:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36786 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeFTI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id 14-v6so2283597oie.3;
        Wed, 20 Jun 2018 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jX28PvL9TrT72W9DrwnvYnb8EKDt6Lt2v35zFF11A54=;
        b=drE0uTbScU1/dyoHIRp+gf47Jd27x2uALX6MtoXK0Bdqr972eYSBrBrNsT8TinVdgi
         IANWru8sWCDXMn+I8q9xKorxO7Gadzmp27SHOO5/yR+uyjOP89KtQUHqY+EUzza9JPWq
         eYto89ndOVnRuFTzeK051byLwBxbgX27XlULrbxKsktTb3fnvaQ/FqhKcNt6/8Y5oD8+
         5RJtsUEmYDwuslj3KwPVc/FbR5mSSWUG8WKTDbq4qLbNvFXuAlHaPM0RV4zQ55BbtCGx
         F6g6tvRVCLfC25j5i+M77QtCL/RoxiiswUH56epcS1Q/7Qq1guZDGfV5l5jDgsP5EdGu
         s/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jX28PvL9TrT72W9DrwnvYnb8EKDt6Lt2v35zFF11A54=;
        b=MMNNSvbV98ByqhvhTqClKRdLObJUVhqSHfYo6Q+9gVzLznYecn1CSEP0u3xYegXHRL
         y6nzNdBLHh/WmHhCfcsryvPjwXWNZiWirJemwIsG5VaIMdjAwvYXkAmG3MBgD/Atcd4G
         7CF8aXR4yIpJIkuPQTSc02XWarV4c8GAtvYkZG63jrqqwQnMCIxp+aBF2m40clry9VM1
         qJFJZk2bA5O87QsQF+041Vu9Lf92GeLBHzvHwIy7TAy/WVD/PWfp+YqDN8SY60Hy44yK
         WHDX9T2u34+Yb/h+08SR8jhqi+HG2eyRYtpIH0+Cl8rZQjR5C+d4Sug8hvJm8xC6bZ7K
         pj7w==
X-Gm-Message-State: APt69E0B2j0b2Fuiq0Rjtpesf4TQAWlZDTITgRNCLifeIPhOmoEtQO4P
        BpV6SjuPyw7SIdPv1Ixa9xX2eGsIPRe/LxZcRCk=
X-Google-Smtp-Source: ADUXVKK5Fu1tZh20zB7ViCHtVGYPoOPWGliyfZfJ6TDtEzysigLUklQmeqN85DCtNQDCatZBSdOiJn/OoH4alKTAv0w=
X-Received: by 2002:aca:ea42:: with SMTP id i63-v6mr11836802oih.260.1529481972066;
 Wed, 20 Jun 2018 01:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:743:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 01:05:51 -0700 (PDT)
In-Reply-To: <20180619123329.52bf6216@gandalf.local.home>
References: <20180617143625.32133-1-matwey@sai.msu.ru> <20180618145854.2092c6e0@gandalf.local.home>
 <CAJs94EZAAuUS4rznPDmD=1aD8B72P0mLft+YDoNs+74pRXr+KA@mail.gmail.com> <20180619123329.52bf6216@gandalf.local.home>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Wed, 20 Jun 2018 11:05:51 +0300
X-Google-Sender-Auth: TAFkSpAve9ji1eUVFPji_TQBt14
Message-ID: <CAJs94EZTyfh7vuNt3Dsz6wYdhwc93Np6-UbpDKFupHKaHqxgJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add TRACE_EVENTs in pwc_isoc_handler()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-19 19:33 GMT+03:00 Steven Rostedt <rostedt@goodmis.org>:
> On Tue, 19 Jun 2018 19:23:04 +0300
> "Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:
>
>> Hi Steven,
>>
>> Thank you for valuable comments.
>>
>> This is for measuring performance of URB completion callback inside PWC driver.
>> What do you think about moving events to __usb_hcd_giveback_urb() in
>> order to make this more generic? Like the following:
>>
>>         local_irq_save(flags);
>> // trace urb complete enter
>>         urb->complete(urb);
>> // trace urb complete exit
>>         local_irq_restore(flags);
>>
>>
>
> If that can work for you, I'm fine with that. Trace events may be
> cheap, but they do come with some cost. I'd like to have all trace
> events be as valuable as possible, and limit the "special case" ones.

What is the cost for events? I suppose one conditional check when
trace is disabled? There is already similar debugging stuff related to
usbmon in __usb_hcd_giveback_urb(), so I don't think that another
conditional check will hurt performance dramatically there. When
discussing second patch in this series I see that the issue that it is
intended to resolve may be common to other USB media drivers.


>
> -- Steve
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
