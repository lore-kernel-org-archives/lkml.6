Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8811ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A9F214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf+kxV8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A9F214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJQTfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:35:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39300 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:35:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id e22-v6so29513573qto.6;
        Wed, 17 Oct 2018 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BXZ5j4Gbfd1jIv77GyWcSrDUOUxh1oKmAT2iC6IeVc=;
        b=Lf+kxV8zSlXu4dxK39Rnn20Vnvo10t192zWm4fyyPm8XtVj3TzzjkQZH6YffwkHDX5
         qLef4Ry9AbrMN3oMW7+RPklunF7bmgRDlJ6nP46B+YT+SOEaQVBYheT4tQDQbPDaiRRC
         0POdqmZkMunUyjb3nJanqKR8YFuw0UXMLyf5CHs6k06Drd9t8Mq1STJU5tPnauSrsLBO
         SLa4kEuunwPqjA2yYLjBZwmWXLBESYIz0eO71I9hSAYj47Bp2RF8stg60mh83Q/yBLCG
         BwgYEnxZKsa+rp8YmODClwXyZeoWmHLBBoG76zpg1UAPSPr50cAx4UG3uPM+iXbjIAv9
         qqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BXZ5j4Gbfd1jIv77GyWcSrDUOUxh1oKmAT2iC6IeVc=;
        b=LCNomoAecEAtw1yruTr8YkA5GJoHAq6IJOWs0b1+yf9dp8ABa/d6NnAkojbM/BgRaq
         vSq4hb9M6LXtjGchusmy21aq6Yn8m0idBNcpsWlTcx8qD/SzGVr1Ay1xvtk7VnywNViR
         iSYG/1pVu7wYbEilu2u1Qbj73HMxpbXeYPcR13JInXele5oIxp5OoJV6svXsNAWStsNi
         l8a3xycjXD88ExCBzDbDPzH30hLB+QAOriXzLuym3b3/XVQYeiRU/OzwqLmQ0/l2Ys/A
         lAPkx5TckNQobshBICd18UdviQoVoW871MPQKEb9S4ErZu/puY+m4/TnfnsA6EbnteaC
         oA/g==
X-Gm-Message-State: ABuFfoh9pMAi/MoV6th1Tiz6y96vZXNpkL77tUhj1DVRg8vy85hV4uSh
        McLiCRocuRTIcGlqCncCo8xCeiiO1zalebWBZyA=
X-Google-Smtp-Source: ACcGV62blSIm01+grOGoJKf49nEhYbh6LEU1I0ZJ+Ei05yAkfs7l9t1lyJdJpu+YHfkwowjotgMbtc+KXsDXr3+KG5s=
X-Received: by 2002:aed:3e4d:: with SMTP id m13-v6mr22501384qtf.99.1539776405984;
 Wed, 17 Oct 2018 04:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181017085928.13406-1-hdegoede@redhat.com>
In-Reply-To: <20181017085928.13406-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 14:39:54 +0300
Message-ID: <CAHp75VcxnGzKbOwEDu_MSKQ1D28=pESTVm+YSHQTjrMXUaKMoA@mail.gmail.com>
Subject: Re: [PATCH 0/1] ACPI / scan: Create platform device for INT33FE ACPI nodes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:59 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael, Andy,
>
> For the why and what of this patch see the (somewhat long) commit message.
>
> The single patch in this set both touches drivers/acpi/scan.c and
> drivers/platform/x86/intel_cht_int33fe.c, this is done this way to avoid
> regressions when bisecting.
>
> The main change here really is to ACPI change and intel_cht_int33fe.c is
> modified to follow suit. Also I do not expect intel_cht_int33fe.c to see
> much changes this cycle. As such I believe it would be best to merge this
> patch through Rafael's tree (after review).
>
> Andy is that ok with you and we have your ack for this?

I love this patch!

Definitely,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

>
> Regards,
>
> Hans
>


-- 
With Best Regards,
Andy Shevchenko
