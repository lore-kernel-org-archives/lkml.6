Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03D9BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6EF208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZd0scJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6EF208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeFNHyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:54:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33817 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeFNHyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:54:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id i205-v6so4831121oib.1;
        Thu, 14 Jun 2018 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nlRuXHHZqkXniZqE+zv+GcoV2JyN5tBaS+Bo2VVMAa8=;
        b=YZd0scJZwFm8tWFGfXrFrMSm1vDbInsFJ0WbkaUzgS+QVaO6HiU72W6CYAb1WoWhr/
         XM78JL87JticNiXWwM2BVp99DA7tA1SiHuNt3v+XkZx7r3HpHlvRYxgO17QhGU25wbz0
         tjIEJDWa2pIr3EIBXvnfjoIjnEU3Wxe5BcMzr7pHvjAxi3dxOfoXfLNEyRVIQ1OPaBko
         Sz5eMgi76V/PFEG62zMOMby0CD3g9bx9JoGPJODg1QnSc9NYHV2CEK6JXHUK0mtRsT5D
         HlpXmOdQgQhDlYTetnfijkavwgUqlmXyz99YJZ0WN01WdapLYTSj4HImvwu8L+OuzI6W
         zSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nlRuXHHZqkXniZqE+zv+GcoV2JyN5tBaS+Bo2VVMAa8=;
        b=XUKFGTHIGrRdTX3Dh1Rr9+HWkYO01U1cTjCnqjJhzeOjzOzHBBm57T3B1H4MBBzWGW
         XplWfyvMPAIGTxQ4sc/lFol+FXITraTEwz5UntX0UIsG1JcRMZH+THd9/MzIj4DDTNJz
         6Yij88wwp+gAZIR+NTct3HpWq6u/a8QQyVV5Tq89Z7VbtSlAkS0+PBwZtI/0nQP3eHZn
         8hZQKyXhWgaByqPZS2rWrnaMFsRZY5+LWB6jPenFPnlc9Xy7oif2cAcvr5CLIBj89S22
         B0yHYfsMJ6aKpG5GWEN3KQvDoiisvmDHFp8qHOquD5zhJTGRWHOXQko5bMzHJcausTgI
         oOgA==
X-Gm-Message-State: APt69E3vDEY2BCbqmgLQwcI/PG/HytyThpZgw10dIV51AWovJsTS/R9d
        XEPRFNeU3ApDiFmKJCMETF/8VHavp+S2fLSZn4U=
X-Google-Smtp-Source: ADUXVKKf8RNslPS4HY1SzcX0pz1PNhrhE3Ohnm8xFb3hVkZd1Mi4KqjElCwnJMjvCxrZe6fFPbClvqPMKsjUXm0S9ss=
X-Received: by 2002:aca:ac16:: with SMTP id v22-v6mr732235oie.227.1528962880717;
 Thu, 14 Jun 2018 00:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:54:40
 -0700 (PDT)
In-Reply-To: <1528778292-41332-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528778292-41332-1-git-send-email-jiazhouyang09@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jun 2018 09:54:40 +0200
X-Google-Sender-Auth: H8CSuemiUCpyDwWQ-A_OoakqSeI
Message-ID: <CAJZ5v0hjRsVVnvO0rBFxXesTDuE8M+W1YwwAYHp67RMMRikckA@mail.gmail.com>
Subject: Re: [PATCH] ACPI : dock: add error handling for acpi_bus_get_device
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 6:38 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When acpi_bus_get_device fails, the lack of error-handling code may
> cause unexpected results.

It is perfectly predictable in this particular case: adev will be NULL
and acpi_device_enumerated(adev) will return false.

> This patch adds error-handling code after calling acpi_bus_get_device.

Which is not necessary.

Thanks,
Rafael
