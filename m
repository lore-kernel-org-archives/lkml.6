Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8haRBYItHlvhVwAAmS7hNA
	; Mon, 11 Jun 2018 08:09:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F25D8605A5; Mon, 11 Jun 2018 08:09:45 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR4GHGma"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68A97605A5;
	Mon, 11 Jun 2018 08:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68A97605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbeFKIJm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:09:42 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:40206 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeFKIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:09:40 -0400
Received: by mail-oi0-f43.google.com with SMTP id f79-v6so17090122oib.7;
        Mon, 11 Jun 2018 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gfSoTk4192Kp0FD5d5XyfgIrZCIKivpvt2fILOhxfVE=;
        b=RR4GHGmaqjPJuTkGYS/ljuAtjJuEWRnphOhQ34xBgfiGxVDzlyc/0v14PnHPIVyvVX
         X/9HLSLCZZ+HTvC3PdkVVJHFZK603tKAj6LeahtzeNF8cLGMcGjUuXonTN98GZJjRfVX
         g52m4lW8aDjUS4S3tt24LF0GIBYuC2UMsBJm6FiEa9bkMejANmTpbeIR9rb4J4FljT2V
         6VRTtbRVFWHByRq739AdhPdThulOYSU3gHv4x792qQIXsOLbNjHFwUXro6nhvcP9vn3P
         /+nJ8Fcy7v+8lsZFD5kn86ZCe/6a0YPrEPnWxLLO4EF37IDhRdDvq4SJPDt6UzrCzGni
         ao9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gfSoTk4192Kp0FD5d5XyfgIrZCIKivpvt2fILOhxfVE=;
        b=MT24dBmfr5mVUSwMXdyJYF0h8Zsiw6uLWDJbn2lm4Nb/q18WlPR+acNbkhEkUN/Eba
         65V3B27RMrnd+EFzxC0tnA8gTw4RZ9b4ihahOOMS2WniqY1EkKbk2rI693kbNQKGSLwk
         oNkOYek7DAxMWXlG4WB/GGL0NpbnRlPOB557VWIG1yN0Z2DRBVpBjjcN8/Y7yQtCdFGu
         740mfj+IAhqHGz0DHlrpbYDhxI5A8+rIqhRqG+rdFOXiEDg1wlA0lte3MNr4cbk5uznm
         yChg8vG2H3YEhgyQ8M8pPG+tn36ePaVrUScapCZ+1kCUyPPqz+ZiKtYEkPPK5tU6kLIy
         YHmw==
X-Gm-Message-State: APt69E2UvFmCfN0T8zJrGz+IVaz35GsNiUxVAuO2TKPx3OlIwjeMJ/MJ
        LDYiGPHLU1LQOyXk2Uhbhg0z4+4gJdb5bWrRqbs=
X-Google-Smtp-Source: ADUXVKJueXhJy38ghpsXakwomzh2K/gGwwpAc5iXeVzQrk5mJrz/wTANtVdIl2LcvZZ9pgGLKuTQg+DRqA9z4psmAvU=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr7487221oig.282.1528704579790;
 Mon, 11 Jun 2018 01:09:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:09:39
 -0700 (PDT)
In-Reply-To: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Jun 2018 10:09:39 +0200
X-Google-Sender-Auth: LCeeqB6JxueYBvAVuHqTTlJSUNE
Message-ID: <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
Subject: Re: Possible regression caused by commit a192aa923b66a
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        perryhelionsemail@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Rafael,
>
> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
> LPSS: Consolidate runtime PM and system sleep handling") is the first bad
> commit.
>
> From the looks of it, it didn't introduce any behavioral change. So your
> help is appreciated.
>
> [1] https://bugs.launchpad.net/bugs/1774950

Well, the only difference is the iosf quirk AFAICS, but that should be
easy enough to check.  I'll try to cut a patch for that later today.
