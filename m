Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC8CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5923D51
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1NOB0Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F5923D51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeGCHTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:19:07 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45078 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeGCHTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:19:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so721088qti.12;
        Tue, 03 Jul 2018 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCleDRWRT4e+ZblwDnELEDadymCxCFkQN2m1pVc9ENI=;
        b=b1NOB0Lvn+pAQdWNFD/Np3uebU+pL1As8MXpQgsmpEawRdcYXivPmQO2TSzpBSrMHZ
         fbhN7PX2e27j1Bc4qsY5BGrmRQAqIO55IxWagpzZZA7oyLBy1p9WH2RQBBVZELdRx+Yr
         l2kYEZwOcJ2IvMHvO0wKNUvDqEDB7V3DL4c7ttZh8Dc4gQImHqMqhhtShJHMnClHK9aY
         +Z001LAvFDOMypZSkBbCAwngP/WydOwa/kMCuojFwLqCefp+w7Ky1ua5jZYNdG8QSZpF
         XTdkRYJWWyEvVi+lfuKnGqINXFLOhlUgpLvK4/8R3GsBpkcx163w8SMCEouSS9lDuvXD
         XLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCleDRWRT4e+ZblwDnELEDadymCxCFkQN2m1pVc9ENI=;
        b=TYaG7nj0G8eSRhDOx7hELHe3dVjUqQVR3TZFhzv8aF67ll+MdgUeGyTSSbj9SKhYgl
         GSnNGKijOWjABJyRo3QGwWq6M5BuQs8KHCn4GdwwQLcKvKp5gVobGEb6yxV6o8eODx0T
         /0UnYVJMGaVbrTPEP03ykrYqhSQbYqChGNkzRkYNQWBK4ZU6StoeaNWugVvlEzr1hiMx
         OUFK/uw7K9ulus13MFDSecgmN2QwQdCCD5OW88dzPZtpOkK72ZXn4bWwm/qPWfcY+01p
         njcDqy77H+d+n5B+mNDZPCBi9ddF7s1D2vD/XYBbhNP2nCguB+16GYfEYY226uD/1Zbx
         1cZA==
X-Gm-Message-State: APt69E0inciJOGm3pGSL+DUse10/4kbbQCphcueku2gZ8yqTv/4JsFkU
        t20MMAE77V/+jyFltDpEzp4A5RiJ5Nj6+ywE64I=
X-Google-Smtp-Source: AAOMgpcpYR7QhiZI2dHDXnPEg1a42WW15c4YZfz+lyQpiP8SwDjWwD3wUdtRhGZOS9GlLPJLZsyCDtQC/fk5neiStIY=
X-Received: by 2002:ac8:950:: with SMTP id z16-v6mr26326581qth.299.1530602343657;
 Tue, 03 Jul 2018 00:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180628054205.17737-1-luaraneda@gmail.com> <20180628054205.17737-6-luaraneda@gmail.com>
 <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com>
In-Reply-To: <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Tue, 3 Jul 2018 03:18:49 -0400
Message-ID: <CAHbBuxpuAC0PDfFBQ+D_zJu-AmWFNhEWCojr8LAWfO-ootLqEg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from
 compatible property
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Jun 28, 2018 at 2:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
> zynq name here is correct which is saying that hardblock is going to be
> described. Without it it is suggesting that hardblock is not used and it
> is for example on zybo with microblaze.

In my opinion, the zynq name is just adding redundant information to
the "xlnx,zynq-7000" value.
Taking the Zybo board, the current compatible property is:
> compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";

I'm proposing to change it to:
> compatible = "digilent,zybo", "xlnx,zynq-7000";
(I know I must keep the old value too,  I'm simplifying)

In the case of a Zybo board with a microblaze, the property could be:
> compatible = "digilent,zybo", "xlnx,microblaze";

That would allow to differentiate between zynq and microblaze.

I have no problem on dropping the patch if you like. There might be
something that I'm not seeing or a use case that I'm missing.


Thanks,

Luis Araneda.
