Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F94ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4D320882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0d1cVsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4D320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeGOW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:28:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51618 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeGOW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:28:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so13299344wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mo4KHA68nCtrOCiZfVJKbV7bYINPMwKyQNvZnbQRvcE=;
        b=q0d1cVsYsM+0Zq9YrSCQNPXx/UG0wwSzkKZvPePFve9HH4aVzt/9Q3G22CQ2zbQj9j
         W6PjnRPQ1RYJI0VhgS2LGzuX/jkAIugSDk6QYZ6WVTQgfxbgEo+ieubr6xtDf8/iLfUP
         OFwscG4IfhJDn/m/knwN8m/dM/imcNjgxtPlnxk1r1LGL6SY/4CPfZWtYIZoknDFQ0QY
         neeAObueAyH+xLW/U5NF6hSvAV+aESqvtoulmfNAACDSBxXC/U2wpjsb9Iw8dDx0GyPX
         TtU2DoxKk4/J3pP9TzhvOFLye4kvlc+sGgjHdje18k3Ku63f4/1ysjrDlnztb9WwBZyL
         GNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mo4KHA68nCtrOCiZfVJKbV7bYINPMwKyQNvZnbQRvcE=;
        b=LoUKEfqZ6Dde2+zzkl8o4N0AjZ87QWwZtkYDhw5KlWrbYtcTXgJGJMupGAqRDvA4Z+
         6b/I4aY9wAgytQKJAqmeht/Jg5R3ZavnWcK2w0raaQBK0rEq4gx8UYL4XlceCv/Dik7G
         jQKvE5xNsCkMhYT1UtzPuHQEmA1Jvt1GIlcmA+nhPbcAlUpo9jtYYbe/3y61xIwMPG36
         6WgPRISB/zd+L2E4VSv1RaJPTfpiCpBqH8uA6ydVftDHYKtXzMKmS4hDkT1ZqviaGziR
         XA7FTv+I7lqBcP4AhZry4zK8I2cpSAKEQoupIz5DAkfCZ1WF5Gy1bI4FvX0evNq4XFaY
         65Ow==
X-Gm-Message-State: AOUpUlGPS1XrkQSaGdJkaV+hdF09aZkgfom6q+ZJubd4HTXi10sHkEOB
        6PIEkIAe6+Yf2dN67NOnLduzkQ==
X-Google-Smtp-Source: AAOMgpdX6R5R92hjF2w5ce9wQdmKDAmenX0K+p0ocLEilY7RN27Ayop8aTvMs7cvRtc2wT6Krzq7xg==
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr7909168wma.84.1531692222304;
        Sun, 15 Jul 2018 15:03:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w21-v6sm13493658wmw.29.2018.07.15.15.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:03:41 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:03:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
Message-ID: <20180715220339.GA15435@gmail.com>
References: <20180706215003.156702-1-jannh@google.com>
 <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
 <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

>  - A malicious user can pass an arbitrary file to a setuid binary as
> stdin/stdout/stderr. When the setuid binary (expecting stdin/stdout to
> be something normal, like a proper file or a pipe) then calls read(0,
> <buf>, <len>), if the kernel disregards the length argument and writes
> beyond the end of the buffer, it can corrupt adjacent userspace data,
> potentially allowing a user to escalate their privileges; a write
> handler is somewhat less interesting because it can probably (as in
> this case) only leak out-of-bounds data from the caller, not corrupt
> it, but it's still a concern in theory.

BTW., a naive question: would it make sense to simply disallow 'special'
fds to be passed to setuid binaries, and fix any user-space that breaks?
(i.e. only allow regular files and pipes/sockets.)

Also, don't allow splice() on special files either, except if the driver 
explicitly opts in to it.

Sounds a lot more robust in the long run than playing whack-a-mole with the 
*inevitable* hole in special read() and write() handlers in our 3,000+ device 
drivers...

Thanks,

	Ingo
