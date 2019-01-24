Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79E6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A3E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7HzvY8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfAXPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:48:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33815 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:48:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id q8so3521829qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zuDB9aQP50Nzs83T+/xEPO8GsYbx96PZ87iyfN9P8Hw=;
        b=L7HzvY8qUL6w9l9T3M0oOShIxhqF9QABTaat8QUseNi1x6rYu9Ea+C/632y/+YtQr0
         otlGQNGqlih4rySwaxBT6+ItqZnYQiHQ9xrB3R8BpyVB5NqHT1ZYy5xjymy1h7oBI9//
         D7XR0qeT9xTTmNMpngr99IIB7dukAW+AccqwniFq5w+wYqrwdbo8SkGn0MhgVePIQGOF
         kTiwCJ+HY9Vn6XyZVlhGvzhM2CQSm159oOnHj1J+xPeAM2piq3Ds/76HHjru9o5C1yKz
         jw6ndbOqIolKf49/lgSDOK2FQGoFqx60S7xmyUBcEgOGTki0V0CdOhRGf5OKy2Ssq+Ah
         io5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zuDB9aQP50Nzs83T+/xEPO8GsYbx96PZ87iyfN9P8Hw=;
        b=g0+iLfPUA7jzKoeWNXho6ug4fT5wrIHsMk5Td5B2khuZp+fqmhv8MqXJmEJl+SK4k0
         c6TqfrXx4kU+umEJ5eC1lrCPndsKwW692U9M9SlqCxdSs8XJMalF0uI727X5ijuVlr4V
         3E+vqNZolB773XWnZDsT8NmCj85gvIYqdtvg2OPf2/s7M1XFinTpe1T1yPcQ53HINERf
         o+1R6zGBKhSkBzUwvV9tcisoPFOYBNZQlO/AvdQn9m1Rg2DvQZ92PPB6qhHxmJOZ0G9a
         54xrOpFf6AcirXK/e2++GdWQqqpLeiYtFsVv8lYGRRgcN7AOBqDO2RjIXUCTAiG7dvD7
         QurQ==
X-Gm-Message-State: AJcUukcCkqG9JimogZ98DYhBWm8yCu41+Bk+jbEuoUrSC9fKgdXMdd7o
        rS3BC17dCfs36Lk9wo0s1c/Xg1MJ83c63V2nYVmDig==
X-Google-Smtp-Source: ALg8bN7J7Sbn2/W8SzOEVnz49IFaZwORGUnt89GF2RhNGrg98PkwsKShxA3PqbrQEiIotY9OlA8NebsU0S/FA27K8mU=
X-Received: by 2002:a37:a315:: with SMTP id m21mr6139827qke.152.1548344912516;
 Thu, 24 Jan 2019 07:48:32 -0800 (PST)
MIME-Version: 1.0
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
In-Reply-To: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
From:   robert shteynfeld <robert.shteynfeld@gmail.com>
Date:   Thu, 24 Jan 2019 10:48:21 -0500
Message-ID: <CADfvbxoFH50nhOamBQhpXskHo0fJP1cuRfcFFY+pR9SbHC1dpg@mail.gmail.com>
Subject: Fwd: kernel panic due to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: robert shteynfeld <robert.shteynfeld@gmail.com>
Date: Thu, Jan 24, 2019 at 9:21 AM
Subject: kernel panic due to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
To: <zaslonko@linux.ibm.com>, <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>


Hi,

It looks like the above commit is causing an early kernel panic during
boot on my system starting with kernel 4.19.13.  Here's the redhat bug
regarding this: https://bugzilla.redhat.com/show_bug.cgi?id=1666948.

Cheers,

Robert
