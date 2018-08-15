Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27062C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8036E2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="evV0YakP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8036E2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHOVUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:20:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50252 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:20:01 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so2948779ite.0;
        Wed, 15 Aug 2018 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ADFdMardIrNtmOrzL5uBgpJXy7g9GGHRyBjfvtnWZk=;
        b=evV0YakPN5OAeNw+qF5ztRpOTZCR88/NNQxtOpxQrBCNbrMUThztYrcdmSSqjEgIvU
         nnXvkDs2w8/kBbw6BzSNaZTxQ3ujvprT+TdmDhfXXhNwOH9PiAKo1vzue6LeFjTS8YQA
         AvMLBlqKYkngq7DbaVDG/KB4WQN2a2rOJMn6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ADFdMardIrNtmOrzL5uBgpJXy7g9GGHRyBjfvtnWZk=;
        b=QGIoTTE+ptPjA3Rwrb1aJKSo1nAv471yjtwL01u32DqD8EC2WxuCCmFZIBVe8vCT1W
         pSmgazZ4G+uvumD7IkjpSkJPE6A+3/aTO+VZT9ATmULcJjcX5oIbExBV17AV5oKer7wa
         6ffkYbD5o4Bv0UfCs8DKlMnztD8vpe/ZdOtNa2SiimpRoobn5Z3V+ZHio+ujn31vhkXl
         bSmnc1Jg6Etz070C+tJ4nHVEP+BGo9jvThbJZRCc8x8ruAjcC6ugxWdRvcbKh+9n/KsA
         O2Oizt9VqjbDs8KZ5n1/K+AtSIkl3a/nZtjWvhUKOflT+c5fg9H9tj7QGbCRS4qW3D84
         SSbQ==
X-Gm-Message-State: AOUpUlEqS83AgGiN6yXk2iwuZtRU6as1xtJlchzjk4269rowJ47Ozivf
        or61bPAlepXil/CPJ3s2FsERgQ5rDOLriAAkvZrNirqm
X-Google-Smtp-Source: AA+uWPw8JrXVIzoWlKgo7pa81AICOZ6mgYlUw69xpxcR/5vnvPVGhs/mNhEDN+M+kuvuNiI9w6JGsWE2MSZy+KZcFHE=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr18451289ite.1.1534357606392;
 Wed, 15 Aug 2018 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180814171520.883143803@linuxfoundation.org> <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de> <e675976b-c23d-5bee-0583-cf241033d02f@dd-wrt.com>
In-Reply-To: <e675976b-c23d-5bee-0583-cf241033d02f@dd-wrt.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 11:26:35 -0700
Message-ID: <CA+55aFyZz5jahQvHPjZebyfRNsZTP0+_0rm3tUR_2k6D26bzYA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     s.gottschall@dd-wrt.com
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:22 AM Sebastian Gottschall
<s.gottschall@dd-wrt.com> wrote:
>
> btw. i found another compile error with x86 :-)

This should already be fixed by commit d0055f351e64 ("x86/smp: fix
non-SMP broken build due to redefinition of
apic_id_is_primary_thread").

          Linus
