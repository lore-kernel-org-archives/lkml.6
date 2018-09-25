Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBD7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BC720880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BC720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeIZFrT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:47:19 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37830 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbeIZFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:47:19 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PNbL7K028707
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:37:21 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PNbGmV024868
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:37:21 -0400
Received: by mail-qk1-f198.google.com with SMTP id c22-v6so27633916qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SBJLq7GB9bKcitGhBt9cVfz4e7R5rmfHPfqunRtthLI=;
        b=C6dY7kYWxF6XUtGFTHI8AYIOnF7BLUna1GSetRDA1cChLtx481hWQasHyr+MLneJxQ
         2ul90fsNVOqCvMFGP52lE2YaVwlMMIskEpJFjqRvOvbEISKjbBneR4BUI6lrMzzrMhuV
         Xxg9m1YIFXxQh7YdX5JOUjhyJn32VGy5BbDJJLjS/IHTG+Gkr4Tgh7fKsmbhjdggg4SS
         3jVCa5/SmYZ2a6UkkYHAZ/lfxYBaXmenO7pxJkepn5SjZQY0//v5pEGbjoUGLD98sWr4
         J2OcO4N304vfx96KTYx8EEdD79kQZpIYDLcvJ7xi1ZwlwFm07zcFquya1jYLpZ3bKlQR
         0NCg==
X-Gm-Message-State: ABuFfojf8GFirpJHC+frOa9720QdSFS+l/sa6GWU3BV1JBHKV8Eu9GrF
        2dTO/ENCxtlLjvRXQAJArJUqlQx0BOo28vjzJZd4PYTNZpJC7Kv3Y+LGjJZ9XNhKhVsc3u1quCg
        snu+VYVPzYIcJY6ce4hEKDT85da0hAElgPPA=
X-Received: by 2002:a37:b982:: with SMTP id j124-v6mr2417314qkf.134.1537918636270;
        Tue, 25 Sep 2018 16:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62ReH1WsiIFmXAspRUQAuDot1O/KgRXKW77D5kdH3o7az8E94znVQCuiX6Ru3YS7fDHX8ideA==
X-Received: by 2002:a37:b982:: with SMTP id j124-v6mr2417301qkf.134.1537918636100;
        Tue, 25 Sep 2018 16:37:16 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:49da:1857:54ff:f889:7a68? ([2601:5c0:c100:49da:1857:54ff:f889:7a68])
        by smtp.gmail.com with ESMTPSA id r20-v6sm1907806qtm.80.2018.09.25.16.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 16:37:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: different capability from different namespace required for
 prctl_set_mm_exe_file
From:   TongZhang <ztong@vt.edu>
In-Reply-To: <20180925183427.GH15710@uranus>
Date:   Tue, 25 Sep 2018 19:37:14 -0400
Cc:     Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        akpm@linux-foundation.org, linux@dominikbrodowski.net,
        ebiederm@xmission.com, keescook@chromium.org, Dave.Martin@arm.com,
        wolffhardt.schwabe@fau.de, yang.shi@linux.alibaba.com,
        LKML <linux-kernel@vger.kernel.org>, wenbo.s@samsung.com
Content-Transfer-Encoding: 8BIT
Message-Id: <7D0EDE0E-ADFB-4B43-90BB-1845FD0FEAE8@vt.edu>
References: <990D0DB4-35C7-4B7B-A938-2B984CD97E78@vt.edu>
 <20180925173745.GA20508@kroah.com> <20180925183427.GH15710@uranus>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can see there are two problems,

First: In kernel/sys.c:2117  capable(CAP_SYS_RESOURCE), seems that ns_capable should be used to check capability against user namespace, instead of init_user_ns. Because a  process in a user namespace may call prctl system call and this should be checked against their user namespace capability instead of init_user_ns capability.

Second: They should both require CAP_SYS_RESOURCE or CAP_SYS_ADMIN, is there any particular reasons for requiring different privilege?

> On Sep 25, 2018, at 2:34 PM, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> 
> On Tue, Sep 25, 2018 at 07:37:45PM +0200, Greg KH wrote:
>> On Tue, Sep 25, 2018 at 01:26:55PM -0400, Tong Zhang wrote:
>>> Kernel Version: 4.18.5
>>> 
>>> Problem Description:
>>> 
>>> We discovered inconsistent check when using prctl_set_mm_exe_file(), which is used to setup exe file link.
>>> 
>>> It is required to have capable(CAP_SYS_RESOURCE) in prctl_set_mm().
>>> while ns_capable(CAP_SYS_ADMIN) in prctl_set_mm_map().
>>> 
>>> There are two differences:
>>> 1)requiring capability from: user namespace, init namespace.
>>> 2)capability bit required is different
>> 
>> Can you submit a patch showing what you think is the correct fix here?
> 
> It is done this way on purpose. The prctl_set_mm_map is a complex call
> which carries a bunch of parameters and allowed if you're inside user-ns admin,
> in turn prctl_set_mm allows to modify settings one by one. So no, it is not
> an error but rather call specifics.

