Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB897C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697CD24BE1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9/RRnXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697CD24BE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeGCLZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:25:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45877 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbeGCLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:25:21 -0400
Received: by mail-lf0-f67.google.com with SMTP id m13-v6so1295644lfb.12;
        Tue, 03 Jul 2018 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D4LFE8RsTVMobvUDBypDtBsDvlFRgMpKAJ/2uuAdhv0=;
        b=u9/RRnXtQ99nPHMiE3x49vn5d3Tak7KOzsKT09sVdDfGUBbqyecyLyy5YTpjiefSYf
         8Cox7Fu4CJxZ0OpHorOAvpJ6QtYn04CWmuLIYJ7f1TImxJW/smSXzIXC9PdsZSz6cEB8
         ewAF7L2V7bd3WJUeu+sLGwzyKv898KwMshhMi/absi3XM4XfCTOAgEzdwnHpsoK/ULbl
         Jhy0uZtJ1b38TK0GmK31NsrCrIYwdTPdumuAsuQeyN7X8SAWR3S3zUFnHnokmQbN+pu8
         NtGTdaR9ULK35AAyZjHxLs1u/AJsk5znZwGnhQaiO0xmJXgad+YCjApvbNqCjiq5UFVj
         qSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D4LFE8RsTVMobvUDBypDtBsDvlFRgMpKAJ/2uuAdhv0=;
        b=X/4ZYThT2Pfug8hCFBVDNkD8uijyw/pb5acfpD4t0Ao4cBjlPyYyH26BYpjfLbcSoy
         gP5XycaUTHPt07dRd2EITkhAlBlY3jE9YcO5bTJFewLVDXTWPEuimBn9a/+ud4ZRChGD
         YP6vuVhHBpl1L92RgcevBi3s7WRE91bprF7BIIKKWLRTQ24BRBByA02HmpuUNDHRImwS
         ZD/472hJPiguOSbWVHQ7HpPeK6ec+MMNtLsdq3nkp9RG+jRdQlLYN1gZQw/K1p7JTkWU
         1DOccXyYnSU8DW7CGr8Rn/LCHf+tVRGsMUHAQLElHOLkRFuWxOrCCcq1gCLtpSGikvlf
         vgIQ==
X-Gm-Message-State: APt69E0Sq+9LCA0lmBeu/GFHYCASns55FikPLWha7d/GkdPQGt6n/w1i
        bJ5dDttXFYYwVqHT9ZdXdQzl/cK7OYgOczIcIQ==
X-Google-Smtp-Source: AAOMgpfOwlcla9WLub0NGMYD743xMeGbPP/k6g32b/Y9OiPRov7Fi1RvyAImv1NT+umthshyCdXzr42CkVNQIO6jM8o=
X-Received: by 2002:a19:c218:: with SMTP id l24-v6mr2075011lfc.55.1530617119536;
 Tue, 03 Jul 2018 04:25:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ef16:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 04:24:49 -0700 (PDT)
In-Reply-To: <20180701213243.GA20180@trogon.sfo.coreos.systems>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Tue, 3 Jul 2018 13:24:49 +0200
Message-ID: <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     Benjamin Gilbert <bgilbert@redhat.com>
Cc:     linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
>> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
>> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
>> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
>> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
>> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
>> config for reference, and am happy to test patches, provide sample QCOW
>> images, etc.
>

Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,

0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
too with the same symptoms

BR
