Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16C9CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA1E20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2f/0jNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA1E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935081AbeFLWyE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:54:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39792 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935033AbeFLWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:54:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so685966wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VlYvQP3073KxZfp6eQnnDLuq0RxOpbhqQpOKhO5xfW8=;
        b=J2f/0jNSrYiQu0mh+4FRbxXyuQf6VT2VD240ngR/c2V75MpQG+6Bnv+/CCxc7SHqMf
         zDRxg/qCzobzHsxLpR4qkQvSxmTyDtH33rV3X5CzswEwyAg9uDXS7c1KEkH2a4Bn/ETx
         MVeajMjFi70Kom2ukC3gVYfVXSLCufyHLk+tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VlYvQP3073KxZfp6eQnnDLuq0RxOpbhqQpOKhO5xfW8=;
        b=a12f47ECUpE2k/5Cm3NsM1KXdDekVNqXB4UdNbIOHlEBLOBFpiMWeW6zUDkNdopctO
         C2eBHKUYyWZq23r6Unnf89Ii8F+CvoWxRxnEC+TM67CCRe3YM6dGyT2xI6cWsebc+SNX
         eSKxz+lWnEl83d8ESjSjZF1A38irjoYMMhZwJzyxTtHEamRwD4Ud0F05RmrkyvSBMOvL
         g2cUKnbwmI06u4NAPodnziKD5g8+uf/MuLq86nHLByZzsDVIrqBcw02lK2x1x14lvLkQ
         GsVlykY+1eH4yzhULYZqLqfcp2r9luX1ehRYU/dPG8uYIkQTcwsO9WrSPCJ74qMhfX2j
         vEpg==
X-Gm-Message-State: APt69E2T125Uc40H0yV2mYqi+BKcViay8fHN+b/2grcuTlhHEdeqNSCJ
        z3vJhcdhSl4hNlSoA8Q6fimRog6O6YfUFns1yvcpvA==
X-Google-Smtp-Source: ADUXVKK+ARPWYY2g9pSAyqp9akO1Wwag+al+Auvmu4h8EdDo77/e31m+D7ubFoGKdSWUT7MSXB0wh40nOPvqnc/p6z4=
X-Received: by 2002:adf:ab96:: with SMTP id s22-v6mr2250946wrc.90.1528844038890;
 Tue, 12 Jun 2018 15:53:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:53:58
 -0700 (PDT)
In-Reply-To: <CAGXu5jJe5dy65OqmSUr6vdfsZJfoPHLH7z+Uuk3MRy+VQoSydA@mail.gmail.com>
References: <CALAqxLVCpyKzGJPVtBuipnZbGbDC_Z0rPBrn-J2mkMsQsSvdtA@mail.gmail.com>
 <CAGXu5jJe5dy65OqmSUr6vdfsZJfoPHLH7z+Uuk3MRy+VQoSydA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 12 Jun 2018 15:53:58 -0700
Message-ID: <CALAqxLWNhAR3T6UfobdPfiVX9HQ_h9aehrkV8n+4H9s2Q6fy9g@mail.gmail.com>
Subject: Re: REGRESSION?: debugfs: inode: debugfs_create_dir uses mode
 permission from parent
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:52 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jun 12, 2018 at 3:40 PM, John Stultz <john.stultz@linaro.org> wrote:
>> Hey all,
>>   I noticed recently that linus/master (plus patches) stopped booting
>> to UI on HiKey960, and I bisected the issue down to:
>> 92170b62f1c1 ("debugfs: inode: debugfs_create_dir uses mode permission
>> from parent")
>>
>> On the HiKey960 board, we mount debugfs via:
>>    mount debugfs /sys/kernel/debug /sys/kernel/debug mode=755
>>
>> But since the change, it seems most of the nodes in /sys/kernel/debug
>> are: drwx------
>>
>> Which ends up breaking the egl library, keeping it from loading.
>>
>> This seems to be the expected behavior of the patch, but I'm surprised
>> the mode override is now ignored. It seems like the potential fix here
>> would be to set the /sys/kernel/debug dir to 755 prior to mounting? Or
>> is there some other advised solution?
>
> This change has already be reverted from other people reporting the
> problem. Perhaps the root cause is the lack of propagation of the
> mode= value?

Ah! Thanks, sorry for not searching for the earlier discussion.

thanks
-john
