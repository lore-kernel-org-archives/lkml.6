Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AF320A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4i9kFHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AF320A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeHYCsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:48:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHYCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:48:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so4916075pgp.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xLUhCcEcMo9CnyHRLdPOVxKzXNQUTjOYbtk1spCSAr4=;
        b=n4i9kFHAKHGqhNe5Er6GQuPj0Uv5CwFNIaU6IdbPIzAjrnbhQmuyN/TUZVTTJqZ4pz
         0xkiieAfUhr0lKRc8yYr2yomiuHOcNLEPx92zhXZzGgzbWB2Uxuv1QtSOmNPobsshVmP
         ZbvwPuxLF9I8LeJKEitrV6kQ+T6NuWy5PZqFsxL4i/rIsvPQZuAf7gH+0ufBlRI+tGs7
         WxRReAHcU2AcoESEwuC49dTHvASmMn+9n2lQh6dfzs3FqcCn/4r+S5FuumDE9K1oOz8L
         T/cDDyB1V0wdSasLDOIkG+eR475B3gfvmIPmBzp/WmUyMeVT9UDEKWFNTxuXoN67qUHB
         mC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xLUhCcEcMo9CnyHRLdPOVxKzXNQUTjOYbtk1spCSAr4=;
        b=URNXckzG6UymOUkdHWZEs9cMbpvY7J4Fm+MT87eD9nr8YiYXHDk7xYlzRqxkDRH6T4
         XBmT569qnEPTZM8oxbAW/G9xgR0vBrJ+XhrR+R/aVtKw0+dQ43RUu75bCecU+XKEBRHU
         7vEajk2qfVI0Dt70fKWVvf73P1bRtjkR8eY+6Mw3GyCUME4l9oeRLt7/ZmsB5JuG3CJQ
         +fWlzmT9Sy9g72NmHO+5O3ReRUHi0mMWxOaYaVpchYoI6+8t5zQzJt+iDU0x8AZybPhT
         5+tuPcNgYixkbMqkIhhghzvhttB1RlmntQO8Y07d7/SZ/ThsXIm8eHbAZpVG+SJEmUbq
         lH0w==
X-Gm-Message-State: APzg51Bi3C0XqWPHnlnM9OQ55bI17JXKxe1c5d3dFrBwjzFy5WLTS1su
        Loyi41umoNDOoV654dpovxXLbWn7UxOip4ttjiUPtg==
X-Google-Smtp-Source: ANB0Vdb1yUMqC62CaYqghsUxPRNGQC2zIx8A30OBE6J2neCg/0hcE1Tsbvxavg8g+cUPVRYIh9abH1FjPLnLBt4n3js=
X-Received: by 2002:a63:5418:: with SMTP id i24-v6mr3369882pgb.95.1535152279028;
 Fri, 24 Aug 2018 16:11:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 24 Aug 2018 16:10:58
 -0700 (PDT)
In-Reply-To: <000000000000d8879a05743667a2@google.com>
References: <20180824230446.GA16891@oracle.com> <000000000000d8879a05743667a2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Aug 2018 16:10:58 -0700
Message-ID: <CACT4Y+a6P+q8jtRrd=cAf5hWbqQO4CQdWUaCCX-ygRbGsWHnGQ@mail.gmail.com>
Subject: Re: Re: KASAN: use-after-free Read in __rhashtable_lookup (2)
To:     syzbot <syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com>
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:05 PM, syzbot
<syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com> wrote:
>
>
>> #syz dup KASAN: use-after-free Read in rds_find_bound
>
>
> unknown command "dup"


You need a colon after dup.

But this can't possibly be a dup of that bug. That bug was fixed in February:
https://syzkaller.appspot.com/bug?extid=93a5839deb355537440f

And this crash happened a day ago. This is a different bug. If you dup
it to a closed one, this one will also be considered closed, and then
a new crash will immediately create a new bug.



>> The problem is a missing synchronize_net() in rds_release.
>> References:
>>    https://www.spinics.net/lists/netdev/msg475074.html
>>    https://www.spinics.net/lists/netdev/msg507908.html
>
>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/20180824230446.GA16891%40oracle.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d8879a05743667a2%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
