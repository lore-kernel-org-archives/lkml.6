Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444CC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510192075D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 18:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G4eMVcA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510192075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeJ1CzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:55:25 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39543 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeJ1CzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:55:25 -0400
Received: by mail-lj1-f182.google.com with SMTP id a28-v6so1042557ljd.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QbohyNorOR8MwbCa/JEbbQHCde/7pFNzFD+0iS5H/Eg=;
        b=G4eMVcA2EQFvLjEsHlZJWF6zV2LspL3YrUhtNB36abxiTzDSwexvIt6CYrTJWSh5O2
         SwnEkZWF2jncRqRvnfajMQavgIccAXC8kfo5hiwuomvoOBCAmWosWzRu59tBTeuYVwZs
         JSpHQeBDnJdh2CoG8DVwNLHqV1WDShqbIeJgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QbohyNorOR8MwbCa/JEbbQHCde/7pFNzFD+0iS5H/Eg=;
        b=o+DuoZVPZ+iytDinSXkgiFgziwPEOiMh+mRZk/B6M4+yv07PJDDzWHXUJvKk5fr5qL
         kOZbd+L/C6DK69x4M74ygdbZDUDE2j6Y0PpVK8q6xyJUfCSTcAp1nnfSTgloKHX2ugIx
         B8Ptego0IgFs4640+zYijmrYOepQZ1crg/pORoa8/qfrVcOp0e0XFYhw2eGKFKRlH3Yn
         nBjtOso6KoSoDlVhqsLVWPVGqyQ4dnLXbLU4tbTNokIVJAX8hca57+9GBqb3GOciZdBZ
         Tb+bLRNR69hOLczhfGu71KilfYZIdL5V7kM22BW/GB7O5EktZ3gPTghu3dd4JybyVoNZ
         8RKw==
X-Gm-Message-State: AGRZ1gKEkW5xcWvL8RhJAaX+g1C9MTt0y3k6AI18Q9OSgtTHSCxPFwsq
        rYSILs/YiFEiSulCgQkRiCdigSDF/4otnw==
X-Google-Smtp-Source: AJdET5crfLTdQIbbP/rxkyixm0n+9RlI9HDCL8fnXcBJvOSNF5NBdyhFei71TmR4A+KEn3h8LkEBJw==
X-Received: by 2002:a2e:50d:: with SMTP id 13-v6mr5261059ljf.85.1540664015357;
        Sat, 27 Oct 2018 11:13:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l13-v6sm1386683lji.7.2018.10.27.11.13.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 11:13:34 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u21-v6so4063738lja.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 11:13:34 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr481987ljc.120.1540664013901;
 Sat, 27 Oct 2018 11:13:33 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 11:13:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
Message-ID: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
Subject: Another HID problem this merge window..
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so this is a much smaller issue than the i2c one that cause boot
problems, but it's annoying.

We do *not* enable new random drivers by default. And we most
*definitely* don't do it when they are odd-ball ones that most people
have never heard of.

Yet the new "BigBen Interactive" driver that was added this merge
window did exactly that.

Just don't do it.

Yes, yes, every developer always thinks that _their_ driver is so
special and so magically important that it should be enabled by
default. But no. When we have thousands of drivers, we don't randomly
pick one new driver to be enabled by default just because some
developer thinks it is special. It's not.

So the

        default !EXPERT

was completely wrong in commit 256a90ed9e46 ("HID: hid-bigbenff:
driver for BigBen Interactive PS3OFMINIPAD gamepad"). Please don't do
things like this.

                         Linus
