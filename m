Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1549218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufIBLCOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfADQim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:38:42 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40518 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfADQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:38:42 -0500
Received: by mail-yb1-f195.google.com with SMTP id x201so11120710ybg.7;
        Fri, 04 Jan 2019 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIPrvXgyo6VOqMsvWHzkUQ0Pf1d/cVy9Lvm/usq8UdI=;
        b=ufIBLCOTqDUcRXJH+qXKbdUpVEHJEr3x9YQ8slSZ9yqgdwWNYhFpKs3oG0uykVWd1N
         mcrtNBml7TQYJ8bObGXKd2tibth7jYijKmEUYGihRLZ8X8zAF9k14Yi0ggHsXLo1c04j
         2AJJmCR/f1cYFBz9WDXEf1kzcJQUoF3vtnFIunoncu4k4C2FXx1nkrVbVCYONODjImQ0
         OrIN/fbrEN4k4ZtJTVqOOfnBvbLUmR4t1tt0DgfFr3Dkkfsdu6jN8kS/pctop9fb7owx
         iTehtgu4264GiSeFCJ4M4uiHSmnv3NB7Zbsq+x7AWILBNDE9qPpgFkB6NW4ROM5tjPFH
         iK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIPrvXgyo6VOqMsvWHzkUQ0Pf1d/cVy9Lvm/usq8UdI=;
        b=k4NRCYoV8aAnia9mtKe6ZOyBT77ueSjKhvQduqT/PilIskabALvh4qBzAdExIA+iCt
         Fj1rWk2SlmB4Ipr4Wg0Tx1xj9EC/UMT0VvKFpEjqDt/cyT0NyWPB6EkUnzPaJCGfbemP
         6h6dQGnq+yz7+oW9WKdULOvAyitxXAsx/P5z/L0qMfmzrzV2rUAGa/CESqe7KlcuN0o5
         eEhcB6oTwrbKTC9xaLexFUTwjkPKr1mkWOofzzVRpk47azMNfgedlq0M408thr5mEr1v
         R/3E7JoqCdWLzBXfxYtY8ONvnX+9BVCBe+NcdTe5DRYC9ZZzTjuaxHpYA9wwkf6xWRud
         6mTg==
X-Gm-Message-State: AJcUukdSJiKbHCn6kfw+w/ZM4hlPt9tI1RMtVB4XRFqSX86MVxRjwD9C
        dbHn5Esd+Ms0Wj0L4/9jM6qqQ+/LJKIgmS8jkRpCww==
X-Google-Smtp-Source: ALg8bN620hYkcgRmwQ3zs9ZX7v3eV0vUo9hcMq0OkqxGYA0K/RgEpTnlNsD8TU7NbTPBSDk3t0Q9Eh35N5/CF8KxMw4=
X-Received: by 2002:a25:db85:: with SMTP id g127mr39490093ybf.394.1546619920266;
 Fri, 04 Jan 2019 08:38:40 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
In-Reply-To: <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Fri, 4 Jan 2019 08:38:28 -0800
Message-ID: <CAEc3jaAf2Cd_1vS8Xo-VoJzJKxWJDNm++=eY+5G2dHa5Jo2gXg@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > For sony.bin:
> >
> > root@kvm-xfstests:~# cat /vtmp/sony.bin > /dev/uhid
> > [   16.891931] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.892432] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.892894] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.893362] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.893844] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.895389] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.898165] sony 0003:054C:1000.0001: ignoring exceeding usage max
> > [   16.901190] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.903797] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.906401] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.908957] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.911449] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.913936] sony 0003:054C:1000.0001: unknown main item tag 0x1
> > [   16.916551] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.918454] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.919743] sony 0003:054C:1000.0001: unknown main item tag 0x4
> > [   16.920834] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > [   16.921904] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > [   16.923006] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.924082] sony 0003:054C:1000.0001: unknown main item tag 0x2
> > [   16.925195] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.926289] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.927400] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.928546] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000028
> > [   16.929951] #PF error: [normal kernel read fault]
> > [   16.930884] PGD 800000007a52b067 P4D 800000007a52b067 PUD 0
> > [   16.931836] Oops: 0000 [#1] SMP PTI
> > [   16.932437] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
> > 4.20.0-xfstests-10979-g96d4f267e40 #1
> > [   16.933752] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.11.1-1ubuntu1 04/01/2014
> > [   16.935372] Workqueue: events uhid_device_add_worker
> > [   16.936321] RIP: 0010:hid_validate_values+0x48/0x110
>
> In a sense, it's good to have a fault there because this was added to
> make sure we do not blindly accept any data. The fact that it doesn't
> fail gracefully is a sign that there is something else.
> Maybe Roderick could have a look?
>
> Cheers,
> Benjamin
>

Sure I can have a look. Would you be able to share the sony.bin file?
Did you inject a particular device? We do a lot of remapping and
processing in hid-sony at startup. It is probably related to that.

Thanks,
Roderick
