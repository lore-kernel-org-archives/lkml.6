Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E185208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="lkoUrEdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E185208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbeKTItc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:49:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbeKTItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:49:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so287236wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjVmBesFxy9LoDjDwVjkC5jCL2KHXfuj0e0USVLR32Q=;
        b=lkoUrEdXqJuRBZuNg8kB4eMPobAA0R7dxzEEswObbnCoOH2cxDrxCwhnk+Q0d34Y0q
         ZzSLivYJgIe/AQwpCDml0M5KIDFRbEvxyU7Ng2cu/O+kAkQR8DzhoYmZrWbYp1nbA4M1
         0L0H04O5RFz91jgFuN8u8vG8q/4NxUhFRIKpO17+K6KlHRGPRhoT+CaytKCPkiQpSKzN
         V7d2QeMnsm2BjgUFzZWwoUmnbpJ3jIDKJadbym6PxD/IYtphbB8N9do+QQe/3VYmjDOK
         zFc5VZ6d87C14G6KmwbxyNil4Zx6NZOmtC7doFNcifHfm9D0HH9MM0b29He0Vr8KSScD
         92og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjVmBesFxy9LoDjDwVjkC5jCL2KHXfuj0e0USVLR32Q=;
        b=QGAqOxRgg/yHhoMGe2IX+lU5koYixqAqdJOW5a+1uRt1C2jM4xZScwhVBNnQcJ6c6U
         0YFgj8rP5j1h/OBZYEGuNDXB0fLiySzmAnxePK4N7d1wv6p01JZjtfz+GQGy4BA/oO4l
         nQRfQSHh96H1rlLDLaZGIqX2JcRDA7zlpa6BAnPKz5mQxJqjB2Bu043mrksjmSOLnesr
         rW+2kj8fkMIEmpHwoWRClKWoFiFZU/x848yfwj3NR4hnUAjHfAJg9JhUe40cwzqSh53U
         Mx7PefOw5pdmbUR3U7ROlKZlokyXvtGGKq32hFudpBhCjiaj/iBZjPS7KL1c4HW7EGb0
         +rPg==
X-Gm-Message-State: AGRZ1gI7vZX78dkWwHq0IkPN2COPdbJDEFmGyc8c892GR4lFZrDe9JZ2
        gathTkj7H9wWEoTp4yyt7vBjxHqudgTY+H/DYPn7OA==
X-Google-Smtp-Source: AJdET5eBygkBBRlIv0dpdk5OTuyErbSB3edwOdQNgboh9HTrU7hkOjWPoBxYu+Q26CnI2SY6Q/5kJ4fNZj1cuu76Z+4=
X-Received: by 2002:a1c:bb42:: with SMTP id l63-v6mr9085525wmf.32.1542666223412;
 Mon, 19 Nov 2018 14:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20181119214934.6174-1-yu-cheng.yu@intel.com> <20181119214934.6174-10-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214934.6174-10-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 19 Nov 2018 14:23:32 -0800
Message-ID: <CALCETrUkXMHcwX8u+mGDD9Vj+iQE7CRMHL7jQnfAT6WXV8SBEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 09/11] x86/vsyscall/32: Add ENDBR32 to vsyscall
 entry point
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 1:55 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Add ENDBR32 to vsyscall entry point.

$SUBJECT should be "x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point".

--Andy
