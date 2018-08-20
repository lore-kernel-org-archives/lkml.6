Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D5621581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D5621581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHTTQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:16:39 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:40321 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeHTTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:16:39 -0400
Received: by mail-qk0-f178.google.com with SMTP id c126-v6so11164597qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0ku84hZ3cs6lLdN/8yr5XoCp3NXz1CewyVR7QbZP8A=;
        b=IT5+031uClHVgqRR/vuSFS0fkSNBMvbk89esq8GdU8r6rVAgH1UQ4oNiCwn4ZTpJi0
         mv0MsMylOg2Jc3iNNR1DSZPGcNFEpD9+rfX7fGxwzmFXNdFjC5ObcrS0PfI1nnh93wuw
         RPTAkkfBUO4sHdBUq5zbcoZbW913x5ytwYFhmltXL054ijweYlP4wcgY65fDvtfdnj0F
         vd6cs1zEItN/RE/qXwx3U6TvgM7HtHeasAlc8tIE/mhEPfoXXLtCt9Jv5bdkj3vaEU78
         7WtVOAjX1uI/4vErxT/1zYfvD1/tHc8gRaS3TPP2JNI0IdEmerdJnsQQNIAXUghS+yw4
         Oxmg==
X-Gm-Message-State: AOUpUlEXSvez1WEB9GacGVGzKnm+sXD2+GTqDbUaNVrS7yeByGTqzKzg
        ZKiwblqVKPZx1Cve0SmOyeKDXCym2WK9i6JDDCo=
X-Google-Smtp-Source: AA+uWPyi5xr28x22s1acXsUAUvXayyooGpMgzyCms3EduniTu7pgYcMkN+EFuln3rCOIhjt7fF/X4NYFYcMcTaMlnX0=
X-Received: by 2002:a37:7946:: with SMTP id u67-v6mr40697115qkc.283.1534780826864;
 Mon, 20 Aug 2018 09:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
 <20180814221559.GA15888@roeck-us.net> <20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org>
 <CA+55aFyU6p-da4j0TWQTEkvYDK_ymFDeTfBa9htYXrdH5gahgQ@mail.gmail.com>
 <87ca655c-e73a-286f-e69d-30fed9d00d77@roeck-us.net> <alpine.DEB.2.21.1808201652420.1551@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808201652420.1551@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 18:00:10 +0200
Message-ID: <CAK8P3a27TU0Y_2j3rR6=mxFh5pBeUjCHVzV2NHaj_WD9E1sKCw@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 4:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 14 Aug 2018, Guenter Roeck wrote:
> >
> > For my part I am all for making gcc 4.6 mandatory.
>
> No objections from my side.

gcc-4.6 is also what I suggested a while ago as a good choice for a new minimum
version, back then I met some objection, but as time passes these probably got
less important:

https://lkml.org/lkml/2016/12/16/174

To recap the distros that I looked at back then using gcc older than
4.6, I found four:

 RHEL6: gcc-4.4
 Debian 6: gcc-4.4
 Ubuntu 10.04: gcc-4.4
 SLES11: gcc-4.3

The first three are all finally EOL as of this month, only SLES11 with gcc-4.3
is still supported in principle:

Service Pack Release                 FCS Date      General Ends    LTSS Ends
SUSE Linux Enterprise Server 11      24 Mar 2009   31 Dec 2010     N/A
SUSE Linux Enterprise Server 11 SP1  02 Jun 2010   31 Aug 2012     30 Aug 2015
SUSE Linux Enterprise Server 11 SP2  29 Feb 2012   31 Jan 2014     30 Jan 2017
SUSE Linux Enterprise Server 11 SP3  01 Jul 2013   31 Jan 2016     30 Jan 2019
SUSE Linux Enterprise Server 11 SP4  15 Jul 2015   31 Mar 2019     31 Mar 2022

However, installing the disro's SDK package on SLES11-SP3 brings it up to
gcc-4.7, or gcc-5.2 for SP4, so this is unlikely to cause much of a problem any
more.

I also have some ideas for cleanups that can be done now, in particular
to deal with compiler warnings.

      Arnd
