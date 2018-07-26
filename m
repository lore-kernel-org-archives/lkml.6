Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB56C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agOldFa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B7520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeGZJht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:37:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42205 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeGZJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:37:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so1492141oib.9;
        Thu, 26 Jul 2018 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GndRCQMau3PydFhw8kq1nYnMCcmKMqyUbqUtAZLhF3M=;
        b=agOldFa8qwdRlVZW61U8HgUjoUjYGSsvdbzHtfz423OoRLjaY/1vgpTRoLVpJI9YIL
         eX9/TZtMSf3bbXYmwgGK4VvpzxIznp8NJI8C2vfbF2MlCaCudco2QTSQL7luiAENG8EF
         YYGuYduRgnii6IJiNgLabjnTiPq5j19UGS7fOUKaB9RO++i9P41cHwWqmJoeyf1LivAI
         WrvjQe2/Npbk/BMVUUoHTRSAaE64YhP4TepqiaAQH91Awsaxy++TF5XY8Sgvt/gY27ZS
         zNf5FbdNIqWeSKvpaCijyDANDSN2XSjypD9BZTl7pZG2zxGyQnrGYDwJDfqXTRj0PTIX
         JrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GndRCQMau3PydFhw8kq1nYnMCcmKMqyUbqUtAZLhF3M=;
        b=ps2cKUj0MtJFqdK6Bjc0uvTvXcjk02co3byO7qa32E9xS5ktYvTzSHV4nSr5MxsUer
         jRkYDkDttIVi+D4TgwkBMvugO28TeuqQjFod8E6U/FHD8M8j7W4SaS/o2SGN77ePGhyP
         vjLvIqbXzalWw5vNjQsl0X3P3Wdv4AjqFiwaTymSYdlYz2n/io5MSFMCYprFkSQwNBTW
         idekf/BZ6zU5VVGHGtuftjaNfdOZN86HElGWoPyW5ktHGXTiyWaoO/9LkuFN88p+nWLZ
         EEZzRKmGTu+6Yck2aU7QLFTRKFUo799yQL6mdA2i61SAXugOlgmIN/wL4tntHtpSBhB7
         rpAQ==
X-Gm-Message-State: AOUpUlG0JezaUyHBW/dL7nTHqAvHABLoXJFnKWJ+TgqGq5AX1vaNHNcW
        klNUTPE6pNZj0Ryq1ko/Cq7LAUmB+DuAXZbw03s=
X-Google-Smtp-Source: AAOMgpcM6zgioOsOkADpIu+FsjVe2boaJaIlsx7rQUVdAFygfUCU5ALWBEJLNNtuBZ8eQ09wtG2ciQMJCbuDjk5JN80=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr882495oia.154.1532593325889;
 Thu, 26 Jul 2018 01:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 01:22:05
 -0700 (PDT)
In-Reply-To: <20180725091802.74400a81@gandalf.local.home>
References: <20180724173544.18876-1-joel@joelfernandes.org> <20180725091802.74400a81@gandalf.local.home>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jul 2018 10:22:05 +0200
X-Google-Sender-Auth: 7fphIQA3LKMYHtk3nB4oTD-8dLI
Message-ID: <CAJZ5v0hzdLpFaZuMVPP1oWOExsp5BBStpkg_C1ZekCEnDQjdgA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: trace frequency limits change
To:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Ruchi Kandoi <kandoiruchi@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 3:18 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 24 Jul 2018 10:35:44 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
>> From: Ruchi Kandoi <kandoiruchi@google.com>
>>
>> systrace used for tracing for Android systems has carried a patch for
>> many years in the Android tree that traces when the cpufreq limits
>> change.  With the help of this information, systrace can know when the
>> policy limits change and can visually display the data. Lets add
>> upstream support for the same.
>>
>> Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Better ;-)
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Patch applied, thanks!
