Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525851097; cv=none;
        d=google.com; s=arc-20160816;
        b=o9vA6IxCFYsHRCSntYOEApq1OTn4Cpa99yOk4enaDFO8R9nsySWiyGiiNo2TigG8vU
         oSVgnmTTmKmMmSmwWB/7234A5SAqyoo2PgbJuS9q+TXJ1Szw9iprp47/ek6kzchBYFDo
         8fXLPxIRtbBgy/9bsRrGMn96pg7ChQ+fbhA4PImvfTookGytheBq40fbB/ViCbrNYt4N
         Fraa8YDnuICzpcbYB1PiCqFy/CvK7hvwdZzQmixsFTyla8vR7R4Uzg7p80fBobil6X/Q
         7I1asjE+CSr44VYy8ir38LrEgOyBj6eM0m4jnxUSbJHWbT5oHa+RULDZVycK2kh3xBHG
         UeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wUdEt2yzfwXah83S1HIUtrvWpRroLoQuJtW1DBHdEMU=;
        b=PjpyKSbAXV5DsVW/Sd/XCUFroUjFfU4X16VdYqymjr711b9oTKatC1u5ynsomTsbUc
         FGfa1B/LjQV/dXDxMNkjEOxNYZviHbOqzCH6PrD9xYLCkuV5VWn7OaY9v6K7sQ7Iwf6W
         k8ftkzYhSlQLnCfuePcaRaCeEgDlPSuo2o9xzxRy567aL69ou7osqMZtPSIVzkTYmZof
         30dh5T0O0LYFO7unPJVvqfU9H3awKZB5r0omyQLyTZgwDVL5gy9TjTnzxRo4XKciPjP6
         jHm64sfdvyWzoDSG2wBst+eC2OAYpEVAhM90Ij8eRpuH7FZRyjmozXuZvkjFjPEv3aqa
         NsFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tkSU2FPd;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tkSU2FPd;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZrsoLCEA2gAul/2SmlCBQBtClSGXkz8535JbLdY5JSXdLQdJgNqJUUBd2O3sXtDymVRUA3GohjTnyoB0pmKgmM=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <5af2492f.1c69fb81.a0c3b.4ef6SMTPIN_ADDED_MISSING@mx.google.com>
References: <5af2492f.1c69fb81.a0c3b.4ef6SMTPIN_ADDED_MISSING@mx.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 May 2018 09:31:36 +0200
X-Google-Sender-Auth: tDVykt1e_V4Nyo3JSAMS2Q5_Z6s
Message-ID: <CAMuHMdUMxbA5+tX6ALnxQQfWc6taE8SJONSmC+cvf400D3bpsg@mail.gmail.com>
Subject: Re: [PATCH v2] nubus: Call bus_register unconditionally
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599946498073404911?=
X-GMAIL-MSGID: =?utf-8?q?1599970840856684816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 3:04 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Loading a NuBus driver module on a non-NuBus machine triggers the
> BUG_ON(!drv->bus->p) in driver_register(), because bus_register() was
> not called, because it is conditional on MACH_IS_MAC.
>
> Fix the crash by calling bus_register() unconditionally. Call it from
> a postcore_initcall(), like other busses do.
>
> Hence, the bus type is available for device_register(), which happens
> in a subsys initcall, and for driver_register(), which happens in a
> device or module initcall.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
