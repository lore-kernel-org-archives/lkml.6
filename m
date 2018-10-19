Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B19ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BCF21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BCF21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJSPNx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:13:53 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34997 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeJSPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:13:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id m18so7099228uaq.2;
        Fri, 19 Oct 2018 00:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mi1QA2+ltMlWRYrMcdsWV9jjxac3h71oRUzPwqpqmv8=;
        b=jhd9aOTJ84sUNcUq+tS8C4GylNiWDc6Oh8XQUTQLW5uSuJbsghhp/AKBi7XzyzQ1H6
         I3fNVyEGUyVmwN2MMY6cBlpDDWsnXYrx8MsT+/8PvmIInEn7ZbM4t6MXm9vpG1iU0ymU
         kH9iBwiaDbcj3/CMgrE+fWwNzZO3tiL+gFh8fIEXeKQzYPMDqbzfS+WuEGqTaokmoD+S
         MCZdgfgz23HuPmTdBjXm0gpmmgf2cUFGRX9zRX2jN4rhcJYRFtI7kHlxjH+hSsyGvaDI
         ePNcg/nkUlRevniPnLURwjSLvIbS9Yy6bskJSzrfbra88+8Vbh00iRbXw2o5NStHJFx1
         2Tcw==
X-Gm-Message-State: ABuFfohf9PupgpjJEVSp2TKwbqFuyQAttwGi4/9niFYjOB+fDUsLhkb0
        NKQMcSac7xKW+NUbofgdiRa6i4FOWqzKI0OuCj8=
X-Google-Smtp-Source: ACcGV62mOkNLiReIUuU7DqgC5V7LTu1oAx5QiRBZWSI+EnpHt4PIYNvKuX8hpspAn7ktihrGiLPvDGjsNwuxaT6gMyM=
X-Received: by 2002:a9f:308a:: with SMTP id j10mr4378980uab.28.1539932945580;
 Fri, 19 Oct 2018 00:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <1539736466-28638-1-git-send-email-frowand.list@gmail.com>
 <20181018193216.GA9971@bogus> <2f99d700-6276-cfa4-8878-4eb161126330@gmail.com>
In-Reply-To: <2f99d700-6276-cfa4-8878-4eb161126330@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Oct 2018 09:08:53 +0200
Message-ID: <CAMuHMdVYkWkpBn4+LF3VGvHEbTGgBWSXTRzZfvy8o1aWzuiCOg@mail.gmail.com>
Subject: Re: [PATCH v3] of: overlay: user space synchronization
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Fri, Oct 19, 2018 at 2:06 AM Frank Rowand <frowand.list@gmail.com> wrote:
> On 10/18/18 12:32, Rob Herring wrote:
> > On Tue, Oct 16, 2018 at 05:34:26PM -0700, frowand.list@gmail.com wrote:
> >> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
> >> user space to determine if the live devicetree has remained unchanged
> >> while a series of one or more accesses of /proc/device-tree/ occur.
> >>
> >> The use of both (1) dynamic devicetree modifications and (2) overlay
> >> apply and removal are not supported during the same boot cycle.  Thus
> >> non-overlay dynamic modifications are not reflected in the value of
> >> tree_version.
> >
> > I'd prefer to see some sort of information on overlays exported and user
> > space can check if that changed. IIRC, Pantelis had a series to do that
> > along with a kill switch to prevent further modifications. At least some
> > of that series only had minor issues to fix.
>
> The kill switch addresses a different concern, which was from the security
> community.  The kill switch is on my todo list.
>
> I don't remember exactly what info the overlay information export patch
> provided.  I'll have to go find it and re-read it.

I'm still forward porting the overlay configfs interface, cfr.
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/renesas-overlays

E.g. after loading r8a7791-koelsch-exio-b-scifa3.dtbo, it changes like:

--- tree /sys/firmware/devicetree old 2018-10-19 08:49:24.073441000 +0200
+++ tree /sys/firmware/devicetree new 2018-10-19 08:49:33.173397000 +0200
@@ -1237,6 +1237,11 @@
 │   │   │   │   ├── groups
 │   │   │   │   ├── name
 │   │   │   │   └── phandle
+│   │   │   ├── scifa3
+│   │   │   │   ├── function
+│   │   │   │   ├── groups
+│   │   │   │   ├── name
+│   │   │   │   └── phandle
 │   │   │   ├── scif_clk
 │   │   │   │   ├── function
 │   │   │   │   ├── groups
@@ -1510,6 +1515,8 @@
 │   │   │   ├── interrupts
 │   │   │   ├── name
 │   │   │   ├── phandle
+│   │   │   ├── pinctrl-0
+│   │   │   ├── pinctrl-names
 │   │   │   ├── power-domains
 │   │   │   ├── reg
 │   │   │   ├── resets
@@ -2277,6 +2284,7 @@
 │   │   ├── scifa1
 │   │   ├── scifa2
 │   │   ├── scifa3
+│   │   ├── scifa3_pins
 │   │   ├── scifa4
 │   │   ├── scifa5
 │   │   ├── scifb0

The above hunks are for /sys/firmware/devicetree/base/.

@@ -2778,6 +2786,14 @@
     │   │   └── target
     │   └── __symbols__
     │       └── target
+    ├── 2
+    │   ├── can_remove
+    │   ├── fragment@0
+    │   │   └── target
+    │   ├── fragment@1
+    │   │   └── target
+    │   └── __symbols__
+    │       └── target
     └── enable

The above hunk is for /sys/firmware/devicetree/overlays/

# ls -l /sys/firmware/devicetree/overlays/
total 0
drwxr-xr-x 6 root root    0 okt 19 08:49 1
drwxr-xr-x 5 root root    0 okt 19 08:49 2
-rw-r--r-- 1 root root 4096 okt 19 08:49 enable

1 is from the DT unit tests,
2 is from r8a7791-koelsch-exio-b-scifa3.dtbo,
enable is the kill switch.

Note that after removing overlay 2, and loading a new overlay, the new one is
again called number 2.  But the subdir date is newer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
