Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29934C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC4B20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhSuCNJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC4B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeICRn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:43:59 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:52761 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeICRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:43:59 -0400
Received: by mail-it0-f42.google.com with SMTP id h3-v6so1136525ita.2;
        Mon, 03 Sep 2018 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LBNX8OqXkYhbbN9j7o5KVlg5thwYA5ldDAdt60sUegM=;
        b=AhSuCNJVqt36cgHUWuJX4g7VN8tQth4CPq6h9Zft8kO/PHTxVL58N2Dhybk/6pkrK0
         ljf0P9NfsarZvh/aNBwaJYq5j2Uz/23WXP8ABFKAJ5nO92h0UeodVMJsDYqfSlY1LTht
         7gYQ6Ea6JmgmHDXKO0Rc3CxeJIUXfDfyohW+MAP2u9dzlAspIq7MoxRZ3i6YcTWvxyZ8
         bvdZEtKPu7/Kz9qXKcn9hdEDApHqFMl7PKI7mgkHJDg52oCRXZBpFxewD7/e7bV+C9J4
         drxEUTLWrhCA9UkYJ7Wl7Bn0lVcq80aCc8eRSny3cnkXZ9/CBBI6NOkj69xatf7SoQNB
         PT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LBNX8OqXkYhbbN9j7o5KVlg5thwYA5ldDAdt60sUegM=;
        b=UExGW/v4JRlam/hBjAPuA5SISs2orD2UOfI7FezBKSNf1q68U4xmltZeGacL0Gm+Sz
         h+hrNUbISujS1LximHl8i+pFhYOzObquGzVe+gbDid/2gAUAdhtRKYkDZlvoEthe7f7Y
         rwpNSqIw+lmVTjksjNKPCoQuDvJnpRWt/6dRxZDCfUzcK91CNvvaGSfEfmdeO3+B03+P
         iE34dEYt8FkN8NGFVwLozAxWSv7wfYnl7aIhmujlhjaqxjMQgTSvu2gyxQ8I7KwSrqae
         6eMavkSHCgymMvjY6Xv2HYi2cOy4EtFbfIzgpwZzh7z0W85tsMJheIxvV5I6zQEIn15S
         8PWA==
X-Gm-Message-State: APzg51DBQRh+j77vSYbv3uNdfulhvaKBqSrUoEgwdcn9b3DDOjsWtGHo
        VgsR0BC2gXX0drFaVD+PNshn4tKVFq2u+7cJ52E15Kqr
X-Google-Smtp-Source: ANB0VdayXBDwKzWHhsnsUg1Vg81aQGsE1UWsxO5npO/1kGNfZCK/KFlBR1/kpAzagMc9Ut440BcreJoXKn2GeiudDCM=
X-Received: by 2002:a24:8781:: with SMTP id f123-v6mr4802452ite.146.1535981029214;
 Mon, 03 Sep 2018 06:23:49 -0700 (PDT)
MIME-Version: 1.0
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Mon, 3 Sep 2018 15:23:38 +0200
Message-ID: <CANq1E4QwNg0VuAZZtatOTXspv7Y-z_HSa-9CHzK2Y28CGK8W4Q@mail.gmail.com>
Subject: [REGRESSION] boot-screen override by "34db50e55656 efifb: Copy the
 ACPI BGRT"
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

Since this commit:

    34db50e55656 efifb: Copy the ACPI BGRT

the kernel will override boot-splashs unasked. This breaks the
graphical boot-process on our setups. In particular, we have a setup
where an efi-boot-entry draws the early boot-splash on-screen, then
hands-over to the linux-kernel + initrd. The boot-splash daemon in the
initrd then takes over control of possible animations.

With the mentioned commit compiled in, the kernel will redraw the
firmware logo on screen at a random time without any way to intervene.

What is the intention of this commit? Why is the kernel re-drawing the
firmware logo unasked? If someone during the boot-process draws
content on the screen, I would prefer if the kernel does not clear
that on driver load.

Can we either provide an option to disable this feature, or revert the commit?

Thanks
David
