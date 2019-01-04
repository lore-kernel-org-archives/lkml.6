Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B07C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E66F218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhnCy0X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfADVfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:35:17 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40904 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfADVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:35:15 -0500
Received: by mail-yb1-f193.google.com with SMTP id x201so11443042ybg.7;
        Fri, 04 Jan 2019 13:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SFR7md/vz2eTzydlUKTapKHn4O0AuD+6g4E3NDSRiOg=;
        b=bhnCy0X0qp3xQ5OOSkg2LUDpg1zc5TkOco4F8xEVKpip+DJBHCNtlhNK7aOHlxRV3O
         BuOlBEYXXwtEF1MAXkOoK8OyzVj8fAf60gLteJN0dZ6FEo8bNUTAtIVJm1RF9QN7yzYR
         ACsQpRbr06Lam7nVsleDK1rSvYqTJ8nBazqnZFbt9Vxece7rX/X2zRNxg/UQ22XkSB3N
         NTc/JXqhh9boFFhEWoE4kJRDkhnWszD46s6bOugQYkxlXQqKBa3JeFFrhf2Uk+7+aR38
         Gg1bbiJFQjByEGutsi0GGhdaJ02T0oeTiqQqjDHIwv8ZBsyVYNGDaM7epX+QMd60Q5Wq
         Offg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SFR7md/vz2eTzydlUKTapKHn4O0AuD+6g4E3NDSRiOg=;
        b=YhoKTzed9L/xA5lauTWFlrPQmPrSMnix/wKWUI8HzCBgTBW2cR6+Qxldzbx0Uwtvmb
         IIxJrcepNGsYaucQKqSbM3hMFBoANdCdUt3ZJWPNQ9D0ojgk/aouyzbjMeDHmi4MSSto
         ZdFd5YYFMcLMHSBR8vYrXdf2ET/F44QRB9fTQ+l456axbFV8oK3+L5vrHgdHU90+Ben0
         6gl8Cf6pcxjmfbkxNeSgDTnnv402ox6H3l/exuu5NWg82Yi997j0VyjJwkIYmTOE9oAn
         KCwanfziGKd/CPqYGmefZmhyHbYglNR8CV0jX9QxYztH+86KxlqGmbpWr92haHxYxUMd
         BeeQ==
X-Gm-Message-State: AJcUukeGSWP6a8lYGKSRP26YWEFpLmt/G3jF2WZmxSbPbactDQWlOZmt
        vEebn1oqc5Axm/pHy5yipm8U9UKS+94SwIdVZfE=
X-Google-Smtp-Source: ALg8bN7mLei0ltNFK+iLywfs12e/H0IeXbeQ9c6mbgRV34qeJEPv9RPb0MF0RZKyNGT7Math8fiTMiDJC1D4SLqUXpI=
X-Received: by 2002:a5b:44:: with SMTP id e4mr9311448ybp.401.1546637713458;
 Fri, 04 Jan 2019 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
 <CAEc3jaAf2Cd_1vS8Xo-VoJzJKxWJDNm++=eY+5G2dHa5Jo2gXg@mail.gmail.com> <CAE5jQCfPCSe3eCRnjt2WzF0-SVYY7yM=KuAYS5_p7Gz0CmQy4w@mail.gmail.com>
In-Reply-To: <CAE5jQCfPCSe3eCRnjt2WzF0-SVYY7yM=KuAYS5_p7Gz0CmQy4w@mail.gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Fri, 4 Jan 2019 13:35:01 -0800
Message-ID: <CAEc3jaA2Vk+C1iSHL89fTAz9fZBS7rVEdj8WOTW966Pt+MBcyA@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, it seems the tests created a Buzz controller. It is
sony_led_init (called from sony_input_configured), which calls
hid_validate_values. It is hid_validate_values, which is unhappy due
to obviously corrupted reports.

I'm not too familiar with hid_validate_values, but it seems to access
a bunch of data structures on the HID device. The code probably makes
some assumptions. Fixing this issue requires some more sanity
checking, if it is worth it.

Thanks,
Roderick

On Fri, Jan 4, 2019 at 9:04 AM Anatoly Trosinenko
<anatoly.trosinenko@gmail.com> wrote:
>
> > Would you be able to share the sony.bin file?
> Sent it in this message.
>
> > Did you inject a particular device?
> If you are asking me, then no, I blindly send fuzzed data with a
> simple (but quite large and not very meaningful) header. That time it
> just turned out to be Sony-like descriptor :)
>
> Best regards
> Anatoly
>
> =D0=BF=D1=82, 4 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 19:38, Roderick C=
olenbrander <thunderbird2k@gmail.com>:
> >
> > > > For sony.bin:
> > > >
> > > > root@kvm-xfstests:~# cat /vtmp/sony.bin > /dev/uhid
> > > > [   16.891931] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.892432] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.892894] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.893362] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.893844] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.895389] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.898165] sony 0003:054C:1000.0001: ignoring exceeding usage m=
ax
> > > > [   16.901190] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.903797] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.906401] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.908957] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.911449] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.913936] sony 0003:054C:1000.0001: unknown main item tag 0x1
> > > > [   16.916551] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.918454] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.919743] sony 0003:054C:1000.0001: unknown main item tag 0x4
> > > > [   16.920834] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > > > [   16.921904] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > > > [   16.923006] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.924082] sony 0003:054C:1000.0001: unknown main item tag 0x2
> > > > [   16.925195] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.926289] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.927400] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > > [   16.928546] BUG: unable to handle kernel NULL pointer dereferenc=
e
> > > > at 0000000000000028
> > > > [   16.929951] #PF error: [normal kernel read fault]
> > > > [   16.930884] PGD 800000007a52b067 P4D 800000007a52b067 PUD 0
> > > > [   16.931836] Oops: 0000 [#1] SMP PTI
> > > > [   16.932437] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
> > > > 4.20.0-xfstests-10979-g96d4f267e40 #1
> > > > [   16.933752] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
),
> > > > BIOS 1.11.1-1ubuntu1 04/01/2014
> > > > [   16.935372] Workqueue: events uhid_device_add_worker
> > > > [   16.936321] RIP: 0010:hid_validate_values+0x48/0x110
> > >
> > > In a sense, it's good to have a fault there because this was added to
> > > make sure we do not blindly accept any data. The fact that it doesn't
> > > fail gracefully is a sign that there is something else.
> > > Maybe Roderick could have a look?
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
> > Sure I can have a look. Would you be able to share the sony.bin file?
> > Did you inject a particular device? We do a lot of remapping and
> > processing in hid-sony at startup. It is probably related to that.
> >
> > Thanks,
> > Roderick
