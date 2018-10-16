Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9042FC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F223208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F223208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:21:47 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50964 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbeJPIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:21:47 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9G0Y6Au008822
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 20:34:06 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9G0Y0np013781
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 20:34:06 -0400
Received: by mail-qk1-f200.google.com with SMTP id d200-v6so21731729qkc.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 17:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=T1IRuDbS2RuhG5flVTa5ziE+5IjHXRnSsn0Uqbmzq/A=;
        b=nfSnX0Oh215iuo1WioXhNjxV3XhVAmQ3koMeNXOzxyJItgaIdvZrSbOukGvo9NKHmI
         xgce5M4Xa1TUr6fIG5866O+lpi7rwJ4icbsaLjZSwLpAB7MMBZtcNZiBnoy9ga3yPIsn
         com9kHn3jJC56VR8IAaYpoqp3zPFIyAMDJpIAMGrW0E6qpxxmGjrdMKSK3sh7L0CkaI1
         52Z8DWtYxwe3ISnrVp0YDfy951Q5UM6MMEAhAGu3kb33CrcHROsPzYL5e9g/ppje0FPE
         WHhCgYaJ7phL/LQ8b6qucJ+aec+gdrLb3codxUmWjjeEyFo20IRqkg4UNjtRI6bMqYlQ
         7bdw==
X-Gm-Message-State: ABuFfogZDjtwTah39mRlNGnRh8H2veUgGLWCSd35YoNp2I4urXo6F2GP
        r1zpwTqSN+FFx3buTNCr505d7HDVwNBhmhHzaQyzdG21Xmeo0A2dmC3ScCpOsD8gTZRkm2fy0EH
        IB9pcEMGfmzpQpFKyJHq0SgmQglBooclZudw=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr18035490qtc.230.1539650035280;
        Mon, 15 Oct 2018 17:33:55 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60g0DamtbSFjiqGgISXH9Z4Oo7CsrKCzQxaYdBNFwCzrum7m+AtUCVkoEXooaW5bldxK152fw==
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr18035473qtc.230.1539650034843;
        Mon, 15 Oct 2018 17:33:54 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:3d3c:680f:afbc:c585])
        by smtp.gmail.com with ESMTPSA id n25-v6sm10637764qtf.14.2018.10.15.17.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 17:33:53 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Enke Chen <enkechen@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky \(kamensky\)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
In-Reply-To: <87va62lri4.fsf@xmission.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <87va62lri4.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539650031_2195P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Oct 2018 20:33:51 -0400
Message-ID: <5192.1539650031@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539650031_2195P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 Oct 2018 18:28:03 -0500, Eric W. Biederman said:
> Enke Chen <enkechen@cisco.com> writes:
>
> > For simplicity and consistency, this patch provides an implementation
> > for signal-based fault notification prior to the coredump of a child
> > process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> > be used by an application to express its interest and to specify the
> > signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> > signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> >
> > Background:
> >
> > As the coredump of a process may take time, in certain time-sensitive
> > applications it is necessary for a parent process (e.g., a process
> > manager) to be notified of a child's imminent death before the coredump
> > so that the parent process can act sooner, such as re-spawning an
> > application process, or initiating a control-plane fail-over.
>
> You talk about time senstive and then you talk about bash scripts.
> I don't think your definition of time-sensitive and my definition match.

When the process image is measured in hundreds of gigabytes, the corefile can
take a while even by /bin/bash standards.  You want fun, watch an HPC process
manage to OOM a machine with 3T of RAM in a way that produces a full image
coredump.

To network storage.


--==_Exmh_1539650031_2195P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8Ux740DS38y7CIcAQJpSAf8CFlhML3n1ezv9Www7szL9y4zQSSV/ELG
HvVFpEvQrLIU8cc3TvFIN0zBVIfdyNUwU01fmUT2CasrmdNQiDfZg88e6dUFdNgH
Sm5MRVZJqlfBH8NycbmVs4RclMlbyNgYz9Dk9vAnw2FqBehjoQPvVmAhGr4KiFpP
oF9xSDEMm2URShb/g0PCaB64dOHPObqnRaNtdYYrTeIw6fKSC8ravOiLzRp9u2uA
JrQZE0WwKM0aE5EQNur0DucH7VJ5tpBxdTqDWkTtivHt81Z+SZ/w6/yliScupxt3
4ByNw0CeSreIV4VLyJuZyZkUi3I+s2nXn+JuOjrZxu2AL/eurFwG5A==
=p90O
-----END PGP SIGNATURE-----

--==_Exmh_1539650031_2195P--
