Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB8F0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803F52086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MuE+qv1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803F52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934132AbeFMEOs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:14:48 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:40932 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933889AbeFMEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:14:46 -0400
Received: by mail-ot0-f175.google.com with SMTP id w9-v6so1413041otj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2lcJ10BLvwaeJwAmVsMXcpDndGSDwTfXI2yigMMVnBE=;
        b=MuE+qv1hzr3ud6VXtzC9Uac8ZTyQQYPTgoWscm05t805lf/7xLx4o+2klZfLowAk9+
         +u7hZmxUeUla4L3EBMi/2zhU1nlO9R/e2gXaEv7bolgJyHIilXqMYMmEQyZf45PNXIVk
         TTLO7PileUYAuThZfFdHP0TqnlmKKTgadwiq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2lcJ10BLvwaeJwAmVsMXcpDndGSDwTfXI2yigMMVnBE=;
        b=cru9yudXXoImofUC6zEcAAAykgh7Vwbp82NZIIacncvA3L3+O/biARh7L/bgVtL1hC
         MwTD3bKgl5GBG4ZIalSsVJZfaaSiJBGr1dWeRrWtktm1Ln3bH8PkdGM2mkvY0nnG/yjC
         sFQgYE1WfZ6KUCY0VvET8aooE+DC0KjG4WTC/MdK+8vbFqEWaxjso0bB6PHuoqs6jhTQ
         m7Gf2bvofDV1xlFQfmDEZwtIosS0uhbtDA2jIDVWnWKpy7hJpjo2DEeREopMrEt3bshY
         XQ/okoCD9gUAsk/dK9HF7Xl6pGLnchCsOMeYCIoe6lRnAqSwv25rpzxmxwNdWCzFg7l8
         yGHQ==
X-Gm-Message-State: APt69E3cffTl5yv3KGM5h0cnTKvpvpozTF3hqcKXS503amzYoP229Mk8
        alT9agmXAZ1542BAjNEl1CxzDXu77oXcoTknjmhEFKmH
X-Google-Smtp-Source: ADUXVKI1nj3frX+CVawmFcuzFnSSzsokj5In791hWBcX0cnOA3xoU29IIhFTvQFW0DgBlKkYp6LiN9oEFtv4jiM8wAk=
X-Received: by 2002:a9d:1490:: with SMTP id d16-v6mr1924988ote.299.1528863286210;
 Tue, 12 Jun 2018 21:14:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 21:14:45
 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 13 Jun 2018 09:44:45 +0530
Message-ID: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
Subject: ACPI support in common clock framework
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Stephen,

We are adding ACPI support in our Linux based platform.
At present our clock hierarchy using common clock framework through DTS.
Now we required ACPI support in common clock framework to upgrade our platform.

For example, clk_get API called in many drivers to get clock device is
tightly coupled with DT framework.

Please let us know, if anybody in Open Source community have plans to
add ACPI support for common clock framework.
If not please suggest us alternative method to use common clock
framework in ACPI use case.

Thanks in advance.

Regards,
Srinath.
