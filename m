Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AE521473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AE521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeIXDO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:14:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIXDO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:14:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DE18308212D;
        Sun, 23 Sep 2018 21:15:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56BF11906B;
        Sun, 23 Sep 2018 21:15:31 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2DBD14BB74;
        Sun, 23 Sep 2018 21:15:31 +0000 (UTC)
Date:   Sun, 23 Sep 2018 17:15:30 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot 
        <bot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Message-ID: <348002473.15454693.1537737330932.JavaMail.zimbra@redhat.com>
In-Reply-To: <CACT4Y+anBfjFnKget7zu75uZVOV6ZT3-RPshaVt2a_4R3ararg@mail.gmail.com>
References: <956405482.15417289.1537693839327.JavaMail.zimbra@redhat.com> <1722725855.15417291.1537693865632.JavaMail.zimbra@redhat.com> <CACT4Y+anBfjFnKget7zu75uZVOV6ZT3-RPshaVt2a_4R3ararg@mail.gmail.com>
Subject: Re: general protection fault in usb_find_alt_setting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.22, 10.4.195.6]
Thread-Topic: general protection fault in usb_find_alt_setting
Thread-Index: u29VG9KDkfFzJ5PgxK6lWk5oVigLYQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 23 Sep 2018 21:15:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dmitry,

Thank you for the reply. I probably do not properly understand how
syzcaller works then. Can you please, have a look at my reasoning.

The bug:

https://syzkaller.appspot.com/bug?id=4b88ff5aa6aa88f9283a45cc62f16e55b0722131
(Reported-by: syzbot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com,
"[upstream] general protection fault in usb_find_alt_setting")

was not fixed. it was closed as invalid, so, afaiu, all the work has stopped for it.

So syzbot did not wait until the fixing commit reached all tested trees, and the
crash was not spotted again _after_ that.

Then I look at the bug:

https://syzkaller.appspot.com/bug?id=a0ec6260a1d37288a4508250fe30a5604ceec666
(Reported-by: syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com,
"[upstream] general protection fault in usb_find_alt_setting (2)")

And I see the crash happens at the same place _and_ at the same code:

(bug id=a0ec6260a1d3)
RIP: 0010:usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231
Code: ... fd 48 8d 7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 86 02 00 00
(bug id=4b88ff5aa6aa)
Code: ... fd 48 8d 7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a1 02 00 
RIP: usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231 RSP: ffff88005893f610

This makes me be sure these are the same bug (dup) which are fixed by the same
commit "USB: handle NULL config in usb_find_alt_setting()".

As I'm kinda a perfectionist, I would like to mark (bug id=4b88ff5aa6aa) as
fixed by this commit and not closed as invalid.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

----- Original Message -----
> From: "Dmitry Vyukov" <dvyukov@google.com>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: "syzbot" <bot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com>, "syzkaller-bugs"
> <syzkaller-bugs@googlegroups.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
> <johan@kernel.org>, "kai heng feng" <kai.heng.feng@canonical.com>, "LKML" <linux-kernel@vger.kernel.org>, "USB list"
> <linux-usb@vger.kernel.org>
> Sent: Sunday, September 23, 2018 6:27:24 PM
> Subject: Re: general protection fault in usb_find_alt_setting
> 
> On Sun, Sep 23, 2018 at 11:11 AM, Vladis Dronov <vdronov@redhat.com> wrote:
> > #syz fix: USB: handle NULL config in usb_find_alt_setting()
> > #syz dup: general protection fault in usb_find_alt_setting (2)
> 
> Same here.
> syzbot process designed in such way that it will not open second
> version of the bug (2) for the same bug. syzbot waits until the fixing
> commit reaches all tested tree and only then closes a bug. If the
> crash is spotted again _after_ that, then syzbot creates second
> version of the bug (2). But at that point it has to be a different bug
> requiring a different fix.
> So this should not be a dup, and should not fixed with the same commit
> as the first version.
