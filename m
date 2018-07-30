Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5413F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A6B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j61nTFQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A6B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeG3KJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:09:01 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33285 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3KJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:09:01 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so5319126vkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZZdAyjsqC1xGqJnIyIKJ5LNMjMOZ9JotHzcE7jHvH7s=;
        b=j61nTFQE0+lFBF1uEhqp6CCWJJL/Q8XZN5/Y8hnIiAq4fyD9Ri+dwLJXYy5RDGuGH0
         WX+K9R+EdZ6BHscjLlcOzO9C2R2/rkdFxNeBAe+ueZgSIIK08lX4MICTkhSmJXeqrTFy
         H5Rot7pPij8nZp1jEPYZsax5+Wrh6dtCCu9HtxkMpnV1JjQb2BHxCQ83AVE3ihp8Ja69
         OWXLiEoiCiOrWNEQCidP8r73YOVmrU54b1ICOOuynDqeU9g7T+Iwr/F4DEwyMCkBRGwE
         8dvE4ZulPHr34vNh9UxugVGL78ZRfLnpYi1feIPdMthmDdeWwor0FfLOKMITmqN+rk0l
         +eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZZdAyjsqC1xGqJnIyIKJ5LNMjMOZ9JotHzcE7jHvH7s=;
        b=hR3or890qj0Mx6c9dkiQBQWQwoyEDHytulf4WVd/UDF5AFpQnGWzxu4QjoNB0xHMy6
         tu5ShbvCnwNwkY3p2cjEjgfmQ8A3zZYoS52Xs7b5IZcwmWDSXTvn3QT6rc/x9wbXHBqo
         fRBcRNthk8uZ4JyP3UtzvQ7lt/oinGoxf8pAWN2WTNAGAGidbwdrUd2EftHnk43r9dIN
         FqNo1r7ci38pNPAL8LC+We4wRYfcCv9w5QrlMvogYaGDrW9qHIOgQq3Kl1kAMsfVATLv
         icp455Qpvzhf7zKmaEJGpz6nRqHYcrLHzd2DJyqQ5gEv/LG+8uCyRPMlR5iShsiVjUXu
         ypTg==
X-Gm-Message-State: AOUpUlHTXXonUawgog1u47CpX9iCPbNJ5J3V5SmwyEroQwb0jxl5gss3
        yB8cP0yBU8WEOfJff/FLtAkVrQKAl/bNt4rCfOo=
X-Google-Smtp-Source: AAOMgpeH0RHNZvnSCYz6L9H1IyJljRfPm7BgkzRY1hTAhoWWXRgmMvgnpPKkOTwo2Zaf+kIIhzcqTkGdgYg+BInUMy4=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr9710140vkf.76.1532939707132;
 Mon, 30 Jul 2018 01:35:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 01:35:06
 -0700 (PDT)
In-Reply-To: <CAHp75VdBgGLhWSS9gvt3D3WJhqhq1hqU=ybnJVcACUfjVzimGA@mail.gmail.com>
References: <1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn> <CAHp75VdBgGLhWSS9gvt3D3WJhqhq1hqU=ybnJVcACUfjVzimGA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Jul 2018 11:35:06 +0300
Message-ID: <CAHp75VfRYmB6zVPWMvEz7bMwsfuiWsx9oYZ0AtGKJbz6JyCsYw@mail.gmail.com>
Subject: Fwd: [PATCH] x86/apic: fix two slight indenting
To:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore Cc list (it seems I sent it privately)

---------- Forwarded message ----------
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, Jul 27, 2018 at 1:33 PM
Subject: Re: [PATCH] x86/apic: fix two slight indenting
To: Yi Wang <wang.yi59@zte.com.cn>


On Fri, Jul 27, 2018 at 9:15 AM, Yi Wang <wang.yi59@zte.com.cn> wrote:
> There are two inconsistent indenting in calibrate_APIC_clock()
> and activate_managed(). Remove the surplus TAB.

>         if (levt->features & CLOCK_EVT_FEAT_DUMMY) {
>                 pr_warning("APIC timer disabled due to verification failure\n");
> -                       return -1;
> +               return -1;
>         }

Slightly better fix is to replace with appropriate ERRNO constant at
the same time.

To avoid bigger change for now, just change this one and IIUC one more
above in the same function.

--
With Best Regards,
Andy Shevchenko


-- 
With Best Regards,
Andy Shevchenko
