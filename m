Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA38C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC37218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkubCBL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfBHPYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44216 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfBHPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so3037732edd.11;
        Fri, 08 Feb 2019 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1JeMi9goUOWk1cPbNp0BwRo24rWCAy7JYVk6n1DDBU=;
        b=pkubCBL0F4F19BzBF3cApbSFn3K6MOm53mryqqO/5gECJ/0Y+p7X7fRTq/xZGMzWPV
         O1r81YOEA8Dh7b+iJa8pYifjpglgl69QYQS3CdXp125Gk3q1HjLGijygjq0iT7R//Kv8
         53I0+ap/RcmxSIwdKI+tbR2GIUzlUDxa/oIGUakqpXzh4z8igLRqSEqH5CIyFd4LTyNX
         sfUEBEceEWTbYZxzLsSEFGuZqmxWyJ881myHLK1TqjE/xYWFJkjzm+rpTH9AH9ixjdC2
         lwak1kfRtDvBX1zM6V0wXrb75IbYYlMVQpLndl1I5gbXyQVl3dCcrAASZ2slT18K5CBw
         1wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1JeMi9goUOWk1cPbNp0BwRo24rWCAy7JYVk6n1DDBU=;
        b=orcFdSY6WdlwQQr6fTIIPCq0xGWf1LmILMJZgmYhj4J0OktTMGTb2+KrFSGin+oZsf
         lV6Mldaep8PbkEgJ0nkCNfW8aHQJvudMjw434fiazydszM7p3N7x9hfTWadxDIwVfbYh
         mP3ta6YIAb93haECyDw/gvRIQ83lOFcfE7yxFeG/VXCA124k9lXZ1372BbvrEYWgphkF
         lOdTTcNgKUgLH/qaBA6seK2MQ1IGGPEPqpQdZhhf57wAdMEk4XVqmI3luMis+1iy5Owo
         J93QGkXUQcJdQ03b6hT6+blTdLVnAF4AhG3gwqXiROBRx8H8n0CoTYepLzUtsinmVyND
         dvSA==
X-Gm-Message-State: AHQUAuYiJQv0TSNGTEX1O9ks5K8usjLk/Qh4vHcNNXHgbOJsYf46tRBb
        a1eK3CIDu8+jUtB6ajUHPvxjmUvcksN+8inmwX4=
X-Google-Smtp-Source: AHgI3IY7lGN+7g9tJ2P0Kgesj+g6eiXc5rMudUIDOfXI5pfukYc1je+GJHyI+T3ZLQ9xK9DfMptcSNogWqBu77Tp7wQ=
X-Received: by 2002:a17:906:a44:: with SMTP id x4-v6mr16249970ejf.177.1549639449455;
 Fri, 08 Feb 2019 07:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20190208045305.8759-1-coles.david@gmail.com> <20190208135650.GD26594@lunn.ch>
In-Reply-To: <20190208135650.GD26594@lunn.ch>
From:   David Coles <coles.david@gmail.com>
Date:   Fri, 8 Feb 2019 07:23:55 -0800
Message-ID: <CAO82AsgwwmxMPAeU7TimFA-nZosqEgCRZV8A+36rq1hcWM5QzQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: add description of Netgear RN NV+v2 LCD
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 5:56 AM Andrew Lunn <andrew@lunn.ch> wrote:
> Kirkwood! It has been a while since we had a kirkwood patch. Some NAS
> boxes seem to never die. Nice to see somebody still hacking on them.

Netgear firmware only supported SMBv1, Windows 10 does not. Luckily
Arnaud Ebalard had done most of the heavy lifting years ago. Getting
the LCD working with the new HD44780 driver was icing on the cake.

Thanks,
David
