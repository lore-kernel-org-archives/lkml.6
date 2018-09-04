Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41968C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BC820869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLG1R+8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BC820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIDK4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:56:19 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:45136 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeIDK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:56:18 -0400
Received: by mail-oi0-f44.google.com with SMTP id t68-v6so4628170oie.12;
        Mon, 03 Sep 2018 23:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CXLQcA1iSpuAyGmdyCZtcimQX46Ng7zpcg4/PQO9oOw=;
        b=CLG1R+8Xwp8RbpVWtQEV0jjCEme/JbuD6/BJdcTkL5PMntqBzfqJB01BD9Y3yJ0gS7
         rqe7bkF4Xn9c5t25tuh0gca1uFIR5oEoaO1pIiHkurxX2R/mtdpYsa75YES+4p0jXrlG
         1D89j4AjJ05ynwB94Mj7d7HW7/LVFmdTePeVuGZjaY5fRu3+G540Lbn8nhN4IN5lbBGh
         XZAMwppPkMdydQHyM4h4c4jhs+u2GHnteaiGCohDMV9lmuHX6zpkWpg8MsZ64tCMZLL6
         Oozin07gkooYj5VmnhYfInUev3fLfqCZzuh04g/mULLOJXq3gG9sJyMERnRKumO3vKF4
         64qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CXLQcA1iSpuAyGmdyCZtcimQX46Ng7zpcg4/PQO9oOw=;
        b=NA5cHZvJh3Zoy+5SUGEFac/uxzqh8DmB7HeJQpGb5TtvitH+mQ/lGCL9dKizjgky/T
         ZcXeiGZ0LzAjs7m+vJKowgafXBHLN4ukjsrHk3OdPlO3FW01MINBiGlnDYeNTz+dwGXl
         IfagvLgq3ApsXZ2ylppXP4tNb3Ajnw8pD6fTQH6dZASZAktkIUb6F+IUVvl2bKRJlSW7
         CRlAab32tZMrxU8946QkIh8HR+0WaMdpkj0/Cx1eJ6oi0xrSJPSkDl7/SvWM94eEEPrq
         VfK0VKrEDryBfQnp9nVpp8ZwX+OoA1F73sfwGMORTjZXaE7YtoTQD0Je7soRcg3H75/l
         eQRg==
X-Gm-Message-State: APzg51DvZdJTwLycr0k3DF5KaBlGjV+RXf9Ei5fvvFaWb4IQ4VNMES/b
        iRAInjKrtjfmhfioqRkNnFaRZpNYgnv6jsAb2xxWSsUWNhw=
X-Google-Smtp-Source: ANB0VdZ27Kg45usUCsdJUcUMNOMCIitEojWyWgLh2/GweVSJBF8yyIKwIul5hNvQzXSf4vi2thdF0+/6BRu/xJfRM+U=
X-Received: by 2002:aca:d0d7:: with SMTP id j84-v6mr24223664oiy.37.1536042758405;
 Mon, 03 Sep 2018 23:32:38 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Tue, 4 Sep 2018 14:32:28 +0800
Message-ID: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
Subject: POSIX violation by writeback error
To:     jlayton@redhat.com, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After reading several writeback error handling articles from LWN, I
begin to be upset about writeback error handling.

Jlayton's patch is simple but wonderful idea towards correct error
reporting. It seems one crucial thing is still here to be fixed. Does
anyone have some idea?

The crucial thing may be that a read() after a successful
open()-write()-close() may return old data.

That may happen where an async writeback error occurs after close()
and the inode/mapping get evicted before read().

That violate POSIX as POSIX requires that a read() that can be proved
to occur after a write() has returned will return the new data.

Regards,

Trol
