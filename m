Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56836C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B392054F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPzBjI1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B392054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeJ3KGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:06:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44693 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJ3KGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:06:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so1195749lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 18:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=L8RAauLSKqBotBP1ZU0EkUCtppDgn3QWdWd3w3w7iLE=;
        b=dPzBjI1umkEDNpJvXBpJXzZVF4mzuH5gfOQtQQi9SGpzZ6b+t5d1UsJNATwrXYWHfZ
         XY9mOPvDsxPbdW84VOfIt6aRP3K0NrwEH9e8zn1J8TgF9BW8M51N3v+c5VT6UEaOE/nX
         viph17Ac0z3NRRnh/TUUcq1JsRY0xSMX+4IxrBlK3OAuuRoUHRbPzvCNruZMGE17cukS
         g9plqbTsFHdi9Ag1EwOQFps5/acKGnVqj9RWWZ6HXP8eO8VQM9b7mjZfqdSgW/bBn+I4
         uzwAsc1wL98ZQmE9NHHWTgh/2IHHeONu725ibqRO+qMQ4LDQv07sbngwecHw6njJBLAZ
         PzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=L8RAauLSKqBotBP1ZU0EkUCtppDgn3QWdWd3w3w7iLE=;
        b=PoR3m8n0OqFmOXUwtk+/FAQHs23/Ez+DY1Rrevi5D6AggaA7XJqt0bhCgZLhzfqKTm
         JPZoP69cL/qb4Qql2oZ8A4uMdS9aqzzPzD+6Qlx5XL1dkdjwdcbebjcb3d4ZM4M1a+88
         EcHh0rTvGQYR4uG4jm9mzrYLdwS6u6MCiEHtib8s3kNBwGHsImbTXKaJZuGog/o9xoNd
         fSv8X+JeZXKRYeJ6KyH9nDpm1cQOgPCYkhb+5bizUyH/i4j7HQPVWXXZPqkpzeyO90iz
         GqDXYBUa3IQvkJ5clLGOwfesDtXw4eIL9XPQeoeHexkt/uDpiIosn8tTi3EMVc6cffop
         vhwg==
X-Gm-Message-State: AGRZ1gL8TMba3xJUnMRcxsS2KRqi9BqpIYtMo5MU8eSKFw0wEuzUj9ki
        0IJdTn3sUdnd4qtzIM6STb506YNRfqlduc8AdOXqAQ==
X-Google-Smtp-Source: AJdET5cLh1MIhJGStf0SJb8G3nR4wCytPyLFTwIN5wAtodNvDQ9MfKmoSRHYmkK5BdSgJXvG/KupPvxavwq6rbUg7wU=
X-Received: by 2002:a2e:80c7:: with SMTP id r7-v6mr10388335ljg.174.1540862125572;
 Mon, 29 Oct 2018 18:15:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:1487:0:0:0:0 with HTTP; Mon, 29 Oct 2018 18:15:25
 -0700 (PDT)
From:   Nathaniel Russell <naterussell83@gmail.com>
Date:   Mon, 29 Oct 2018 20:15:25 -0500
Message-ID: <CAONH+JkdjAN+5cWsHPxbRN2knM8ifyjOgkk2UfegrVid=qMWqA@mail.gmail.com>
Subject: RTL8812au driver source code A little help please?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory '/usr/src/linux-4.19'
  CC [M]  /tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.o
/tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.c:816:22: error:
initialization of =C3=A2=E2=82=AC=CB=9Cu16 (*)(struct net_device *, struct =
sk_buff *,
struct net_device *, u16 (*)(struct net_device *, struct sk_buff *,
struct net_device *))=C3=A2=E2=82=AC=E2=84=A2 {aka =C3=A2=E2=82=AC=CB=9Csho=
rt unsigned int (*)(struct net_device
*, struct sk_buff *, struct net_device *, short unsigned int
(*)(struct net_device *, struct sk_buff *, struct net_device *))=C3=A2=E2=
=82=AC=E2=84=A2}
from incompatible pointer type =C3=A2=E2=82=AC=CB=9Cu16 (*)(struct net_devi=
ce *, struct
sk_buff *, void *, u16 (*)(struct net_device *, struct sk_buff *,
struct net_device *))=C3=A2=E2=82=AC=E2=84=A2 {aka =C3=A2=E2=82=AC=CB=9Csho=
rt unsigned int (*)(struct net_device
*, struct sk_buff *, void *, short unsigned int (*)(struct net_device
*, struct sk_buff *, struct net_device *))=C3=A2=E2=82=AC=E2=84=A2}
[-Werror=3Dincompatible-pointer-types]
  .ndo_select_queue =3D rtw_select_queue,
                      ^~~~~~~~~~~~~~~~
/tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.c:816:22: note:
(near initialization for =C3=A2=E2=82=AC=CB=9Crtw_netdev_ops.ndo_select_que=
ue=C3=A2=E2=82=AC=E2=84=A2)
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:306:
/tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.o] Error 1
make[1]: *** [Makefile:1517: _module_/tmp/rtl8812AU_8821AU_linux] Error 2
make[1]: Leaving directory '/usr/src/linux-4.19'
make: *** [Makefile:1584: modules] Error 2

If anyone could help me with this issue it would be greatly appreciated.
