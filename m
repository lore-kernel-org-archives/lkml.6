Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F670C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8240D204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="no7I+5So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeLNShr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:37:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32828 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbeLNShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:37:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so5765194eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PpMyvt7NswqPir1wFCMaChws/OWVN5NL6YxVd3MNcnc=;
        b=no7I+5Socm5n4qQgpxYmeJ6FFnhEedy7hkZKBKbVAFiL213VydocucendTdcLTnH4i
         K5wKiYGVyI+GMkS2mBnGFskJ+yCgg6mN+/kDkJe6VV12e8uzPJYB8MbQI5WwTYH/1nTC
         z8aHDbL6aociSIRKTwa0Zs5zGkLKpYLio6bmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PpMyvt7NswqPir1wFCMaChws/OWVN5NL6YxVd3MNcnc=;
        b=Fx9x0eJwbY0pQMyD6zGwsEaACg7rBXGwTnn8371LG81hrAxXp6sWRUbW5i6T54jfyf
         CTpYqloGnGePAVSyA2roLyx/UVIXZtFu0Hz91G2Zilg816tq0E91KIvJr9mcL5mUJzi8
         pfwqEqNzVfcWWv9v5Wz2PhPyn6f47zLdolWagxv1FHJDabuvlaP7ausXiUhUaqrarPFm
         s/frYBH8ydWcKxmaTMvP5wCa4CoYYnoEHaj4MEZQjb6FQWZRT4kO+qy5m0C6J737pglr
         IrlPDrpF7NM73lLCfnA6IJf7wCAL+bsOIYIuvZe0tZ2/ZGoLAKdYDbzpSM0zZ7j63nXW
         om3Q==
X-Gm-Message-State: AA+aEWZvy83IrHyvaziOjR5qjtz1kqyf/4dXTWpCTHu80vdaJhSJeNAa
        /Y85r9x2gS00ENsCuxQF+hu1Ql14vMg=
X-Google-Smtp-Source: AFSGD/UzviXmiDbu10xNi3PdQGwmcafpIrmSj/C8cVEhuod/YT2JRW21rv9LALf0gZaS1bmMfQrbyw==
X-Received: by 2002:a50:b667:: with SMTP id c36mr4160034ede.190.1544812665847;
        Fri, 14 Dec 2018 10:37:45 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id j23sm1578120edr.89.2018.12.14.10.37.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:37:44 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id y1so6580953wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:37:44 -0800 (PST)
X-Received: by 2002:a1c:1dc6:: with SMTP id d189mr4032686wmd.112.1544812663776;
 Fri, 14 Dec 2018 10:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
In-Reply-To: <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Fri, 14 Dec 2018 10:37:32 -0800
X-Gmail-Original-Message-ID: <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
Message-ID: <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clement,

On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
<clement.vuchener@gmail.com> wrote:
> Hi, The G500s (and the G500 too, I think) does support the "scrolling
> acceleration" bit. If I set it, I get around 8 events for each wheel
> "click", this is what this driver expects, right? If I understood
> correctly, I should try this patch with the
> HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.

Thanks for the info! Yes, that should work.

Harry Cutts
Chrome OS Touch/Input team
