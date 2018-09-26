Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC862154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSh0XbiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC862154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeI0EnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:43:08 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38356 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeI0EnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:43:08 -0400
Received: by mail-lj1-f176.google.com with SMTP id p6-v6so519461ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tkpLmaKXQVF4COMHWJwaJRl3Py6teNC8t4H8OUTVqw=;
        b=vSh0XbiLNLCpWSaZoPnDICQ/BqTYMvVg82SPxLpseo+rB2ESunXn0gSai7reiKcas+
         PNZ2Ou3qTNGCZZrXJbFGGnmGvMS5bPgibqp8qBMNavEctSItTW9N9QXswuuo/4YtEkYf
         lI3IpKT1QVvyhe0qaIyqJnD/ZaFX4cmAkwUcZ3i0WURoJQ929iItGyqQR5Y0tifwBVR0
         /mcQZF/6y90/jqWOpNCcqoNKC96vxurGic6qyl6l36QuYWEDGMZT1Y1zahcFtQTzzZVv
         Y+zx8mkmWMHchPIhVTsJNKbJ90VCbGJWCWxCctbG7caK0L2iDlVDb9fOGVY17kbtF0Bh
         KLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tkpLmaKXQVF4COMHWJwaJRl3Py6teNC8t4H8OUTVqw=;
        b=oyp5SQfBj3khXPgorkZKQ5KCbEWEGCNKDe3yPkAcXlRjJXg1bRWcAPk+zlk6xDtkgU
         RxD67eJVs+pYhHH55sqz2jvqeWC5EfTsJRghvKhdDB9YZvgMR23S7Lj1Xqy/hR0FQmL7
         8ODNPOkNkYO5GMHyZC+ApDF3OH0MqDX7lKjJI0jRGR4JkxsCkBjgSHjhG0lCuUxL6fnO
         7B3+V7xIe31061EnDYYr3IPCqH3l+WaMYjrNtpiv/ukAM8zME+JLTjCB9FwKYLQfGB9v
         xeiOfP5CAiOZG9Q5pEZQtZXzhQV1QOCIXbRJYbRCcHwx6at78UfRQ+VmAWbyc3+/GoAy
         UFpQ==
X-Gm-Message-State: ABuFfojHeCOV9xT89c8Oof8H5KbOjEXh7BGGD+JSoplYZlQIbsDJqOAn
        uFtwbIOsar040IxGNlN5ovoeTJYDLQwl60WpIxMLrw==
X-Google-Smtp-Source: ACcGV62lOaotfPSaqyMNqUaR8aSFHcB5SEC2v7x3RQKnA5/Rr9rFG89Gd6M/wE/K+9wweoJEqlE/I/eQimDiz0uyqAA=
X-Received: by 2002:a2e:8184:: with SMTP id e4-v6mr5727068ljg.138.1538000878390;
 Wed, 26 Sep 2018 15:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com> <20180914175122.21036-21-rkir@google.com>
 <20180925182821.GA21572@kroah.com>
In-Reply-To: <20180925182821.GA21572@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Wed, 26 Sep 2018 15:27:46 -0700
Message-ID: <CAOGAQeonJ9PBtm+c=QfVHX5VsuE=+WnHhn9nqWLcBCOoHsGySQ@mail.gmail.com>
Subject: Re: [PATCH 21/21] platform: goldfish: pipe: Fix allmodconfig build
To:     gregkh@linuxfoundation.org
Cc:     Todd Kjos <tkjos@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for looking into my patches.

> You can not break the build on one patch, and then fix it up on a later
> one.

Thank you catching this. Please drop this patch.
