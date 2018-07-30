Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904E7FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB4B20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Me0jB+RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB4B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeG3H23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:28:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbeG3H23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:28:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7-v6so4025883pff.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sgIt0iOhZJ3IG96mnr7t5lbJHZp4olQue+CDGJswNa0=;
        b=Me0jB+RQD2Kw4eoN+IXTn2nvyQcfsF5CHZFfh+0MjlWD1TxLkvDM/IAkvdjmGFdZd5
         HwNPvryUAIv43AUZ4A4gK1NTdacJ6Br4qHj7/ItP8NLtkUOntJtdzTSNzJfmPbzXyP5U
         QnkQz2Elv2p5WGKgEw2TuTpDwlhT8Ujw/XpSL9IrM8ltJ+bTrWZ8yyrsJs9V8iDTbKZS
         9jDeY/SZlXmehtW3SUfNcgy7GKORpODJdXVya2q/G8kYeTZCjUPx2fEKrcwCfDi4o34m
         UNDNpucJejD7lzzfs/uZneJSQbpQxiuQfYoFbgOA9/NHwOe0ByOOUV+y2udkdk5JJZ7j
         Zr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sgIt0iOhZJ3IG96mnr7t5lbJHZp4olQue+CDGJswNa0=;
        b=KM5LkfeE4Cqhx8xyHoP5iS6MbFE/3n9F4t4j5T/V88wQ9gVDRqyTiCBgCRTXtPAtsv
         H8kHXm8CuHLZxF3Q9dtoJKxTj8GWppV/kFPoAtzOQCewZmAZGeEEdekMLRs2+fXs8q2J
         TSdLLC2nkYpMeMeKUbt78NfhKkd901E0Lsgd5PVJxltBsy0QWOP5UQS1eEdOFmCXHlvJ
         5rDkIo0lhbRy/5cbrl/Bv0k3ZwLRL8jnpjkJEg5h/0U6Dd4gNI5r7U8+M8r4YJVEiImH
         4ohDjH6tueOVUAP++AiW/lFtM4onCBCRa/inU8TZG9pTO9V2myVFBbmo1ZJn6YCGmIYP
         qzew==
X-Gm-Message-State: AOUpUlF2Z62gn/wj9p82lFfJ1FsVRFheTbO8xBfFgGPhRc6i9aqg9j2V
        wYroMtst5NCbsmnxurw3AN9EI9DnvbsrfhK1loc18Q==
X-Google-Smtp-Source: AAOMgpeGT0aJCTGU3tHbVvQOu2vMZCZBiHEhmKLwWRZ5puiz7qypeBZJc/2iKR0kOcHt0KWFIVpZ9WxyCUvQcV94vK8=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr14895778pgu.96.1532930110360;
 Sun, 29 Jul 2018 22:55:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Sun, 29 Jul 2018 22:54:49
 -0700 (PDT)
In-Reply-To: <20180729233336.GB28684@nautica>
References: <20180729130248.29612-1-tomasbortoli@gmail.com> <20180729233336.GB28684@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Jul 2018 07:54:49 +0200
Message-ID: <CACT4Y+bf1NfCV9aTRCR_qwA0jWxhYDkR3CS8jQcJyvkYXCming@mail.gmail.com>
Subject: Re: [PATCH] 9p: fix Use-After-Free in p9_write_work()
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 1:33 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Tomas Bortoli wrote on Sun, Jul 29, 2018:
>> There is a race condition between p9_free_req() and p9_write_work().
>> A request might still need to be processed while p9_free_req() is called.
>>
>> To fix it, flush the read/write work before freeing any request.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
>
> It looks like I have not received this report, I found it through google
> in the lkml archives

But you should have been received it? Or not?
We had some complaints that syzbot emails were not delivered, but in
these cases they were not delivered to lkml,  and only to explicitly
CCed people.

> but Dmitry do you have a convenient-ish way of
> finding the report on the syzkaller website with that reported-by tag?

Well, you can do:
http://syzkaller.appspot.com/bug?extid=467050c1ce275af2a5b8
