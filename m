Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03154C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D543321545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BL4/uSZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D543321545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHOXgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:36:32 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33461 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeHOXgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:36:32 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so18374471itj.0;
        Wed, 15 Aug 2018 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOVfwvb5rUCVSOsH6eB0T9A+JsTzkWgbthfC86KXCYQ=;
        b=BL4/uSZKeoT5DFceUPuGPqi/YECdDa/HZ+CcOQo6Q2G0/A/gQZIENHb4V/eMmilDyg
         WodQBZf/KL0MQx/pjariluYsMG9rRjJbcgD/wz8jXLYHW+i6gHztsce9LMcnOfl7LZfs
         ubmeQzj9/sgIjXyc6WzlWUxP3WBspGP7eE1cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOVfwvb5rUCVSOsH6eB0T9A+JsTzkWgbthfC86KXCYQ=;
        b=Ou1ifCxgmyAxVIYTZEcS1jz3cXkCeh1TdoV4esqJkDbFgxd58yZjV4IEhulZnga7vI
         TZvbEmQ78K2k/1yxUeP2/opqdzFncbxd74ad9dRP894MZqQfbEzjzBKAOz5GcvxPPFQk
         RKjIT8NP+pVshZ8WRgoda+oW9gx4Xmstrx1lybncoSh4G/5LQvr/bv3aKCU3eFIAWCuC
         9d4DIvaUCKqixRrx1paYC9C/UtyFnnd0pTfE7orBJXY/Lv5HFMHaTkNxaJC8crOcxUoi
         ctXjy1lj8t5hmUMobWQYWXd9lWmR8qL65Dc8thVvw1vs+Up7ZzS3Bsnokf4k6zMq10X4
         dZYg==
X-Gm-Message-State: AOUpUlHFsyh3Xi+hhqkEuYZo8mqFmTa0STV85lovQa0irmDjjZTACHjq
        CMLBnFW1hNbwm4GBpKI6JMxXUfSx7n3pL7F/rc8=
X-Google-Smtp-Source: AA+uWPyRayuzSA4POpIF2WMoDd3/pXjP0+vaqrCbnDeCnHI3B7azwTxdZYtMBwgIKLsbQLm8mUDH8phlpRlDEURGfBk=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr24828980jaf.70.1534365766809;
 Wed, 15 Aug 2018 13:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180814171520.883143803@linuxfoundation.org> <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de> <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net> <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
 <20180815192630.GA20575@roeck-us.net> <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
 <c05b614d-0d4d-6e6b-1014-d5d16875e096@dd-wrt.com>
In-Reply-To: <c05b614d-0d4d-6e6b-1014-d5d16875e096@dd-wrt.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 13:42:35 -0700
Message-ID: <CA+55aFzrU=d1y=D32fyyKfqBaxxE78ht=9yhOV4u30ft=x8mWg@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     s.gottschall@dd-wrt.com
Cc:     Guenter Roeck <linux@roeck-us.net>, Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 1:33 PM Sebastian Gottschall
<s.gottschall@dd-wrt.com> wrote:
>
> if it would be helpfull i can do this quick here using the latest
> vanilla tree

It would definitely be helpful, since I'm already quite busy with the
normal merge window work. Having the embargo for L1TF end just as the
merge window opened wasn't all that convenient.

Of course, I have my own "I will delay 4.18 by a week" to blame for the timing.

So if you can find the places that break, and add the right header,
and send me a patch for all the ones you find, that would be lovely.

It's not necessarilky always <linux/io.h> or <linux/irq.h> that makes
sense to add as an include. As mentioned, sometimes it's
<linux/slab.h> or similar.

               Linus
