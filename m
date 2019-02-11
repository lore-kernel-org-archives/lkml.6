Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC096C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6420863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYTjgZiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBKI3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:29:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39314 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:29:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so4642725pgp.6;
        Mon, 11 Feb 2019 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yltjAFKS9GF5mtiDgNMgOQw/i68kr7Vg6EKoL/JMrV8=;
        b=cYTjgZiJW6rxt/mmCNFw9qybkYWOC8p53SjnIj+NGm8P7TMFKo8a3lyUruJqn46f3i
         Vqg2E0wPvrWVhQ4ZDa4Tzg42Bxqm3U+GQE51hKaQRgWp0coQbo8cHSK4CA0SZVBJoTqr
         Z43Mm9GQvsPMOQWLln/kQ4skXQjWaPuDZj0Mk5zJiKdDRBhhCrMaU2g083E2Bhn9knS5
         Rx1yYeOwLhIqD0Ds/NnFKGaz4s2gsol5lh18FLlDPjLmSyMDsutFOjLCYM1PKWylEtFr
         tR98a09HGI97MstUJgISjs8FT/953K72JDLkK6EOemZPM6d8M9OvXZ2mGCxQt+r8b8d/
         HZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yltjAFKS9GF5mtiDgNMgOQw/i68kr7Vg6EKoL/JMrV8=;
        b=mZjh6V8MonCJ/koIJhdkpuf2nSZT/K49z1PhQOkc+5FfULLvyMvM/sIbqxdt+he5tS
         2Wn0vTSqx8ztEQicFXrlVmYF+xxmguhbzUI0g4j5cdHArebhbhyu94t9Mo8UVelseEVg
         dWEFcrja24zS8WYCAdGIEuKm/nFWVJ/Z08BpC8BeLxehpDF5mtdgUnSbkzjQibAS0bYk
         Mvr0KZ0Q6VkqsiV5WtLFnt2B78Ug8bhiLWtV6AxO+wxpm3Auodv70raDVdVe6ELY0j3n
         mZvYTohnr7k2cIT8NURGPcsp+ODvh53wFwRiRKm5fd5Dx59fmtH+HbUXVcRt9fnmCLvG
         ASjA==
X-Gm-Message-State: AHQUAuaWzavi3RciL8J6LdczsM8Y7hBBYgLIDfIjZ9+M/DyVqExQQv9V
        crMCCZwtMGmStXBjOr3byQE=
X-Google-Smtp-Source: AHgI3IY98ex3WgD4epHUmKzrRyiDfHKbkiS699ZNBYNJkHr6gJyTcxcO++0hTrCjy+HXCC0dzzu2AQ==
X-Received: by 2002:a63:e655:: with SMTP id p21mr17391343pgj.70.1549873745042;
        Mon, 11 Feb 2019 00:29:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f12sm11743822pgo.13.2019.02.11.00.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 00:29:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 00:29:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: matrix_keypad - use flush_delayed_work()
Message-ID: <20190211082902.GA95126@dtor-ws>
References: <20190207224650.GA49861@dtor-ws>
 <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Sun, Feb 10, 2019 at 12:43:21PM -0500, Sven Van Asbroeck wrote:
> Hi Dmitry,
> 
> On Thu, Feb 7, 2019 at 5:46 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > We should be using flush_delayed_work() instead of flush_work() in
> > matrix_keypad_stop() to ensure that we are not missing work that is
> > scheduled but not yet put in the workqueue (i.e. its delay timer has not
> > expired yet).
> >
> 
> Could the following scenario cause a use-after-free?
> (I am adding comments on lines starting with -->)
> 
> a) user closes the device handle:
> 
> static void matrix_keypad_stop(struct input_dev *dev)
> {
>         struct matrix_keypad *keypad = input_get_drvdata(dev);
> 
>         spin_lock_irq(&keypad->lock);
>         keypad->stopped = true;
>         spin_unlock_irq(&keypad->lock);
> 
>         flush_work(&keypad->work.work);
> -->
> --> new interrupt comes in, and schedules new delayed keypad->work (1)

It will not schedule new work because we check keypad->stopped flag
in ISR.

Thanks.

-- 
Dmitry
