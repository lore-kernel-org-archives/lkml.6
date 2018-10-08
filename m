Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5FDC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800DA214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800DA214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeJICAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45269 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730997AbeJICAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so5642984pfn.12;
        Mon, 08 Oct 2018 11:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ho0zHGqLizywLEjpUcGNP8JAH8lbPz2zgki7wV+z6Ts=;
        b=PPXGfhrtlfRsWgprHw9eDmMZgnCStHgMPx0BLlj8JY7dti3rur1m1g3bX3oxUmc6pC
         tqAFVTdplQWYtMXnhhumZ96RqmlO09f99R1aY9hoavM1D127/Nt4rMPM+CQGluzlxqiS
         17ERMMCjWNdQLHsi+97rawnX5klRN1fm5U83CC0dIbcfKGyeJZAz9X0Fymm7ZsTh9QA7
         PsQ4TXAZ5NKlIj3PRY06K7pgYTqGfOH8wpH3pLd1tej/obrwUuDvaBxY+fN59f1fEGR4
         CFOi/kckfP6vEy+gEbyVTQwlACfgxFcA4SD9k6GMUKjNdzKUBa+wtHwvwcPLUdgLgxv4
         IxxQ==
X-Gm-Message-State: ABuFfogSgK1bp7MlX58pYxvoIx5/YMOcu4xVZZ6l1bIM921rCeGtdKpB
        ZUIR7NnZkxhQG3kLhMMiQUCVQWuMLvg=
X-Google-Smtp-Source: ACcGV631GzjHkEdgULbdO1YghsJaUoVTbXnFj9ezodHy75jB7WdGrGgU65xfdo80ByUz4GOe9AirwQ==
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr21980049pgb.411.1539024432002;
        Mon, 08 Oct 2018 11:47:12 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t22-v6sm25863192pfk.141.2018.10.08.11.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 11:47:10 -0700 (PDT)
Message-ID: <1539024429.64374.40.camel@acm.org>
Subject: Re: -Wswitch Clang warnings in drivers/scsi
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Oct 2018 11:47:09 -0700
In-Reply-To: <20181005065754.GA18637@flashbox>
References: <20181004183047.GA1885@flashbox>
         <1538678069.230807.6.camel@acm.org> <20181004184540.GA17513@flashbox>
         <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
         <20181005065754.GA18637@flashbox>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 23:57 -0700, Nathan Chancellor wrote:
+AD4 Regardless of how the overflow is handled within the switch statement,
+AD4 the overflow is also happening when passing in these values to the ioctl,
+AD4 right? I mean these case values are defined in the uapi files so that
+AD4 userspace can easily pass them in to the ioctl, meaning those values are
+AD4 being passed in as a signed integer and I would assume subsequently
+AD4 overflowing unless I'm just missing something here.

From the user space header +ADw-sys/ioctl.h+AD4:

extern int ioctl (int +AF8AXw-fd, unsigned long int +AF8AXw-request, ...) +AF8AXw-THROW+ADs

From the kernel header +ADw-linux/fs.h+AD4:

	long (+ACo-unlocked+AF8-ioctl) (struct file +ACo, unsigned int, unsigned long)+ADs
	long (+ACo-compat+AF8-ioctl) (struct file +ACo, unsigned int, unsigned long)+ADs

Why has the second argument been declared as +ACI-unsigned long+ACI in the glibc
headers and as +ACI-unsigned int+ACI in the kernel headers? That's not clear to me.

Bart.

