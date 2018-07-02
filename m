Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FBC24087
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HpMqNBqN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/sMzPCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FBC24087
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeGBSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:43:43 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41054 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeGBSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:43:42 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so1851823ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Pieivp9mo6OEr4dXP2ycd0jLkemPNi9+s4uVeRQ/jYA=;
        b=HpMqNBqNYQq/+ZpWfe6f4jQoIIcCUDHONqudIXBGQNwBplHEf5L45LPAXhTSET8dKh
         DEZy7dbhbQqtEwd/my30fXoC9O4j5HVcXo7hIHH92wZf09ypy7orLii2BIRmum2UFYK5
         0NPQBz3Hw6y/mkrP/gyamSTFv1vrbkyAfoBiMvkKTaQQ4dHQXfuVMeDR9pv6lUv5cP8r
         8911EqoOBZZxtZDwHoy7YbEowifGqRmV82irp7daf6N9kZTn2JNFnLjwJmMdG6cSmcvm
         380rWOeUEL6mUTjnWoMOshG1qW9AEdDl5DogxbtH2/YC9DfeTl4GZWPs47vmCxZT88K9
         4pmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Pieivp9mo6OEr4dXP2ycd0jLkemPNi9+s4uVeRQ/jYA=;
        b=G/sMzPCP4Pe9pc6I59MrHebEfGsONOsKHqOSdhE4bJhyPqU2wdAsQzWjH+bcyCVev3
         /f7A15q/QF5MLQ1nVzJHgkUt7orKp5rGizId6JuCuTkV1B/8D9A9TCZBqAAUu4JfhDw3
         7sflIIO4WEwuiuvi5UfVr6fRe5YIEvskVLD+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Pieivp9mo6OEr4dXP2ycd0jLkemPNi9+s4uVeRQ/jYA=;
        b=anOf+ebYtg3efO1vAfZo2KVCGrUB2lnMuKPF+QprtmNfHNbiWRDbxZOSDG2nnPjm/6
         mGbTQYtv4KilNDSrGZkKr9df91z/hNZRayGwgHPcAHGNlr+ox0XPtk4jXlKnGQs3WldP
         JG/h9OeSd53NJvVPvLNdBumCgXG/Nw3ahOEqjiqqOX2MTCyqDRam3xaArL/Vc7yLAzSk
         m/yhlm6AhAufPfk3DtaJhAND6TlKJtA/MW6Mkv9uDW3bd+hdw1ryJwLhcOzbqZ7dE1ur
         yzITFUDVbsWIV/dG4gH/67X2OHb8VUW6toUC3Uc9T4sQvOJwmT0q1wFsArAMbL5xtXEP
         en4A==
X-Gm-Message-State: APt69E2H3O81gfcJYmG/UI5EmPjE2Wc/EMZZs1ieIhyHRXJzDEjRy405
        nXOItjiOIvR4maZJFmlOPAe34xLMdxCcYB8mg92RtA==
X-Google-Smtp-Source: AAOMgpeBYXeI3GuCSo86aENVdVfgIH4AXhwWMgEUZIg+Q0xSkxVhQuCKV02eWAEGhzin8FU8wVagOWg1sPCQiNfoGBY=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr3162690ybe.118.1530557021572;
 Mon, 02 Jul 2018 11:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 11:43:40 -0700 (PDT)
In-Reply-To: <5506a72f-99ac-b47c-4ace-86c43b17b5c5@redhat.com>
References: <1530101255-13988-1-git-send-email-crecklin@redhat.com>
 <CAGXu5jLDULvf-VBhUfBXtSNaSWpq8irgg56LT3nHDft5gZg5Lw@mail.gmail.com> <5506a72f-99ac-b47c-4ace-86c43b17b5c5@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 11:43:40 -0700
X-Google-Sender-Auth: 9qrUUTMD5EXvoHPYH0iwAMb0GnM
Message-ID: <CAGXu5jL8XDYE+B=a_TBM2K8F-c3f4Jz6zcm3ggacbPNN2wCtpg@mail.gmail.com>
Subject: Re: [PATCH v3] add param that allows bootline control of hardened usercopy
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 1:43 PM, Christoph von Recklinghausen
<crecklin@redhat.com> wrote:
> The last issue I'm chasing is build failures on ARCH=m68k. The error is
> atomic_read and friends needed by the jump label code not being found.
> The config has CONFIG_BROKEN_ON_SMP=y, so the jump label calls I added
> will only be made #ifndef CONFIG_BROKEN_ON_SMP. Do you think that's
> worth a mention in the blurb that's added to
> Documentation/admin-guide/kernel-parameters.txt?

Uhm, that's weird -- I think the configs on m68k need fixing then? I
don't want to have to sprinkle that ifdef in generic code.

How are other users of static keys and jump labels dealing with m68k weirdness?

-Kees

-- 
Kees Cook
Pixel Security
