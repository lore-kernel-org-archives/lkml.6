Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0918ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6868120989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNK7O0jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIWWZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:25:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44728 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeIWWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:25:46 -0400
Received: by mail-io1-f68.google.com with SMTP id u12-v6so10852934ioc.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S0b/g1SlJY0bF9RKV/xyfLZryqBzNiXMzU8NrzfxClg=;
        b=mNK7O0jTAX36K/6ySsCH66L2Q3aUHHKm8N5RVNpqhsI2yPn9/vExysUGEFn/LmZW2Y
         2GPVh+p2xKhGopIzj7DL5XWifa3zIqPNQpUPBJTqGUgyNJ4R4vjVL/o4/3qNsNogYfG7
         xCrIrqxnyzffWLGKNaUvbckXjcwCc1p1MoNoRf+7uUISUBdKivZysmVQO1lv8/JFs2wL
         qrAs3yIzHsdWR6MlIS1uGTlpQe4G2SfKh/9z0fUJlM7PSMcrqk7F90Cw39pd+j24xP0r
         Eq6j+jmZdMTj1yyKwr8p2nNHW51hOvVUd9ddFz7F42oHePCkKq8BpEJIE0K57NsBbtvB
         Ud8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S0b/g1SlJY0bF9RKV/xyfLZryqBzNiXMzU8NrzfxClg=;
        b=rJwIAeUyCRv2cxy5rNQrcgKrcubnIakYndhhIvOzw3pJlSKk7y8ONJSzpTbs6xFADI
         lKWjg0B+xIq7w/8TuWItHCydvEC3lSfq8KM1swuWnrxAdQ5gl3daQBp2EuEsYEvV4IA4
         HblldLBik80xKgSa7J2emFIxCL0yQ/5Ug7Y18NYKNx3DqZQUpP9bGnaL2cWc8ODTTMoe
         563myvGx0JKKAle/QL+WO0nQH7y2L0hEf2y623TiaFh47KSm6/z6FZDr7KEw+qPnZrHd
         0DtI5LrKvjWEbU1ceQXQrILBPeQE7sKxe9XwZh6bnN1SfZNH62Mh5xODLHwU9XFzyVYZ
         g1oQ==
X-Gm-Message-State: ABuFfojihMrs5u1bBJI0XMjOycQLqu+JuXcO65lNYxEkyXnz0cJ9lpOp
        y2STsM3zs6lHGPZ/GKHrpHmPcnTDszNJzSeyZ3mi7A==
X-Google-Smtp-Source: ACcGV60JOXnaIrsQkgzRqoxX5P2i2oxmjrH/VPfTJSoBHdUIoqvFlpeEypea7siwi7vEHqPCB81W4pqUruUt4j3byzs=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr4917254ioe.282.1537720064638;
 Sun, 23 Sep 2018 09:27:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 09:27:24
 -0700 (PDT)
In-Reply-To: <1722725855.15417291.1537693865632.JavaMail.zimbra@redhat.com>
References: <956405482.15417289.1537693839327.JavaMail.zimbra@redhat.com> <1722725855.15417291.1537693865632.JavaMail.zimbra@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Sep 2018 18:27:24 +0200
Message-ID: <CACT4Y+anBfjFnKget7zu75uZVOV6ZT3-RPshaVt2a_4R3ararg@mail.gmail.com>
Subject: Re: general protection fault in usb_find_alt_setting
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     syzbot 
        <bot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, kai.heng.feng@canonical.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 11:11 AM, Vladis Dronov <vdronov@redhat.com> wrote:
> #syz fix: USB: handle NULL config in usb_find_alt_setting()
> #syz dup: general protection fault in usb_find_alt_setting (2)

Same here.
syzbot process designed in such way that it will not open second
version of the bug (2) for the same bug. syzbot waits until the fixing
commit reaches all tested tree and only then closes a bug. If the
crash is spotted again _after_ that, then syzbot creates second
version of the bug (2). But at that point it has to be a different bug
requiring a different fix.
So this should not be a dup, and should not fixed with the same commit
as the first version.
