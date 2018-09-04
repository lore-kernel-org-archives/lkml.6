Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F0420843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVzGsrgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F0420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIDMm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:42:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42586 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:42:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so1308472pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sj6O03EtfdBfFDCC1nLS1cLhz+Et8ttgZBGKryIDm78=;
        b=MVzGsrgoH8t4QV2wC0/dYj+zS7/gJRt8uAoUw/kN3K5Ph0PXI0RvY/SJSKHSAnMQhv
         qUhLstHzSSuVCD3PuY2VuHDG+jvVmixst9ygl3DKnTWMzQWw6mKDvT39NBEPEHMbpD2Z
         LMJOUR+1xVSiwvm3QnKHzKzUILQtb6ZdhL1HE2pW/+YWH9iMyQYZ86/liXaBWPxrcUKB
         JfWND/Nl54YYNBo9vw/emk//T0NM0mlXfAb79P1bCoxVU5s39DgvoTRkHkL8IHMk196B
         Xn3kcVONKrfq60ds2w6Q+DgPscxLapFlAxDYzwXKh1+qADDk+yfaLcqWVYHFOxHuIyTN
         jLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sj6O03EtfdBfFDCC1nLS1cLhz+Et8ttgZBGKryIDm78=;
        b=LONt1FHPrKJKESqYTQ1Lipix0+rk21CeFeFWRnkoMjNQtFPzVehCSdheNWqZT9oFz4
         sdm76MdrULi2uUgWw+i8KuomHM+8WDbDQcR6DNBwFXvLlqH7ZJOj3PubmlGvoiilWfQH
         Cun35Sxzuw3ILtiipOegk9qxdu2VGwBVTkdVQpIkcav6Qg5vDh0Dt8McnWF3qMkDlnrJ
         spQ7xGYLuOAAghmApefjkdkZMb7reDnOTBMTbBg0+fGGIvJAmx+k025Mhxf5DJga7FHT
         3O6NCDf2HSI3dImkphboOMsDYGO8ijoZG05oybKqAn6Dv5yomUGaqmsMbQQFeLdehMFy
         bTdw==
X-Gm-Message-State: APzg51DgJFvnjq1GCPNZroRynxuNJ4xQlCR5nj+wXnkCTauLvL/Pzl8Y
        D21WWSLX5GN//c6z+BJOwhjCYv6tw/3fvmw4mYUBPw==
X-Google-Smtp-Source: ANB0VdY+chIASsnJsD9hgWzS/GisLIGHkYfZ74nPUJG46FjNjOMEkVfbXom6U3ATEVFag+or2wGt8Q9XJDVbPYDTv28=
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr29346313pgm.227.1536049134419;
 Tue, 04 Sep 2018 01:18:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 4 Sep 2018 01:18:33
 -0700 (PDT)
In-Reply-To: <CACT4Y+YFQfrnvV7XfeCsiQBQ7UicrHE=fadiYdJdPA8=jumW3g@mail.gmail.com>
References: <000000000000237cc60569ad11c7@google.com> <46b9489e-6986-d512-1276-9da14c96999e@I-love.SAKURA.ne.jp>
 <CACT4Y+YFQfrnvV7XfeCsiQBQ7UicrHE=fadiYdJdPA8=jumW3g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 4 Sep 2018 10:18:33 +0200
Message-ID: <CACT4Y+Zkf-zR30E4DCxzwsn+WhfjG8uzKXmQGvqvu+7SQqWi0Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in d_walk
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+ae80b790eb412884ca77@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 8:41 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Apr 25, 2018 at 1:05 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> OK. Patch is in vfs.git#for-next as 4fb48871409e2fcd.
>>
>> #syz fix: restore cond_resched() in shrink_dcache_parent()
>
> I see there is another patch titled "fs/dcache.c: re-add
> cond_resched() in shrink_dcache_parent()" points to this bug:
> http://lkml.iu.edu/hypermail/linux/kernel/1804.1/06252.html

It seems that that commit was pulled into linux-next and overridden
Tetsuo's fix command.
Now it's hopefully has gone from everywhere, so let's remark this with
the right commit:

#syz fix: restore cond_resched() in shrink_dcache_parent()
