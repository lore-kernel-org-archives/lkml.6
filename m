Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7647C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF420879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="0II1czK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDF420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeLMQBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:01:03 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45972 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbeLMQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:01:03 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so871946uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84yR9u94FchxuM6bLlwEw8+aUqVwObavnlxKODAuoY0=;
        b=0II1czK8gAnU/Iv1ee5SltTk87Ew1CNMUmZ/HWgMIcTwtQQBBIM5N3Mo07oPwbMkoW
         timi8VvYZhmn/rbnPVEErCAiZNTtfwKg8FnEcaELbd8Q19qLwfZkmDDksPCTMeZa0EDV
         YyKvgnHVlUbAMqgOPvIv/9yWb29e931WBAGiqJ5Fj+KyfQMlCnEJ3TcdunwgzjbE2rdd
         h76wCWBE7iY85N0qJMWOWY28dpuRSXXh1HM8Q14VICKCvYrGFTB61nJRJZFXQmZk+3F/
         75HmgGzP+n5riyuGlMU0Y614Va+EG45OB4fvKLJL75YYQtGkFBMWdDqHjzR0o65ZuAgm
         QNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84yR9u94FchxuM6bLlwEw8+aUqVwObavnlxKODAuoY0=;
        b=HLltd1LRMZKwewZAhsOR7FWHfDOMqPPT7Bt09qMLu9Z21w2mz+ZDHOZbdNbMHwu3Ge
         XOF7zVEFG8dbvNrW4ZnICyDhD5khqJf1BzMQH7Km32CuRinB7U2q7WoZwxRxYcxrweht
         hk2keKpSH3v7BFxARR0FUsssNh7MwEpLps7rP5w3uQfSLcaZy0v1VLqDWraJ3PcuiPOV
         uXgqL2rxngFx807epacegnYTBNaXBoZf2N5mgKSLYBwlfib/y3KtGKiR/2j2MmdLGdQP
         XTK6PgQJ8f81n5BOUxl9Oo0DpLK8BQWSEegKwG377q6I00lcstb4/myRjEqTN+xMZhJV
         k3bw==
X-Gm-Message-State: AA+aEWYtY4K9Fi2ocm7zwZRU/kbvtDPH+BnJv5tVp4WfAC0ZaGAW5SjU
        nVJssBZZm0OWGdrgh1HlQ9IWS4EdfNNyqnBHLOmrjg==
X-Google-Smtp-Source: AFSGD/V6vBqQelhDC9ZJ2ZRr+wZJWx/lD8vjWTlLO4o4Nn3x8qXnuzt89O7tHVPns2g7tankIjygE53bj7+x6tEMHXg=
X-Received: by 2002:ab0:1d17:: with SMTP id j23mr11094550uak.133.1544716861667;
 Thu, 13 Dec 2018 08:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu> <1544708187.5826.1.camel@amazon.de>
In-Reply-To: <1544708187.5826.1.camel@amazon.de>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Thu, 13 Dec 2018 18:00:05 +0200
Message-ID: <CANBxJ=FP9GSfMES3e5dSct2qV0Z=uz7uPXufQNqoi5e+sWxvgQ@mail.gmail.com>
Subject: Re: [PATCH V7 0/10] KVM: X86: Introducing ROE Protection Kernel Hardening
To:     jsteckli@amazon.de
Cc:     Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ahmed Soliman <ahmedsoliman0x666@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?6rmA7J246rK4?= <ovich00@gmail.com>, x86@kernel.org,
        Igor Stoppa <igor.stoppa@gmail.com>, hpa@zytor.com,
        Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com, rkrcmar@redhat.com,
        linux-doc@vger.kernel.org,
        Boris Lukashev <blukashev@sempervictus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Given that writes to these areas should be exceptional occurrences,

No not in the case of partially protected page.

> I don't  understand why this path needs to be optimized. To me it seems, a straight-
> forward userspace implementation with no additional code in the kernel achieves
> the same feature. Can you elaborate?

The performance hit I was talking about was when dealing with page with
mixed content, given that page is partially read only and partially writable.
The way this is handled is by emulating the writes from inside kvm, now if this
was done from host's userspace, then every write operating (a size of at most
1 cpu  word I guess ?) will require switching from guest to kvm and then to host
userspace, which is major performance hit. I originally made it for protecting
guest's page table part that shouldn't be remapped ever. Since the page table
gets modified a lot, emulating the writes from host user space instead
of the kernel
would add an unnecessary overhead. Also it doesn't sound right to me
to place the
protection inside the page table when it can be placed inside the
virtualization EPT.

But aside from that, I think I was wrong about hinting that it is
simple when done from
user space, handling cases like THP and huge pages (which I did not support yet)
doesn't seam to be easy when done from user space and when doing Registers
ROE has some arch specific details. That's why I think it is better to
continue doing
it from KVM kernel module.

thanks,
Ahmed
