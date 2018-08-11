Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1754C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 06:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76094223F8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 06:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWAY5wcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76094223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHKIrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 04:47:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39166 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeHKIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 04:47:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id q12-v6so12581462qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6VmG1RyVENc8mmnW0eOrrpkUlIOoG8loqawhUUTZdMA=;
        b=vWAY5wcJS1gplO5dSmb3jnOqU5p1fqDcwnhjcbcG5+clI5BQAjufI6qqdz0rPZP4Ls
         JMu8gaak9chBq5nsK4YyrL0aDxDHyXjaMbmdA8x+IAKmGpC3veL3aiZ1PPpvBKjB1MJF
         JpzlNOOCk0sD1GjkIdQ3+n47or8v0/z++0cd4J8lQBSqNZwHB6bWKD1ZwAWPZS2kZP+1
         suSrsrNdv6/aqXJMbXHs7ytmlLRH5lQ1cSd+SeggMsTskM6CnDmG99FsYHCvM8Vm/G4p
         aMOCox6byGlThlUFYjLTQsDH/tFkGvfUIKHdQiVFSjllvTc/36NZ8GktQ3ElwD9t53gP
         s14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6VmG1RyVENc8mmnW0eOrrpkUlIOoG8loqawhUUTZdMA=;
        b=mfeHSsFnlpiDUOMrfSRDd5fZuJwwP+A1VBirCfe5vJlGhHfHsIcPygxfuwFyO5n2st
         PEGvx8awXVl2zyvSVqweUJin/ndKktrAZcRgGndzbpH7ku27Xvuo0MnKZJWWYUtoyaR/
         lHlRi7nsgnneXDd9GSH3R72tv2TF1mthnzlwEM1A81kQ/JPTse3PlqJeTpdQX0kj4DsG
         BZ+TxtaVjT67XNAkrChLipyC1GohbZdRKMSkPs7iinHpngAFHfnCf/xmk2EaYcJcscMt
         RbtPn8LTufDYwbnowMchuu3xFLhVi2s2BpYO+BKCFL1CdmDiGR4hZymx1hXZHTjZ9kgK
         Uzug==
X-Gm-Message-State: AOUpUlFvhQmrwhMvoiYSMgM6zw5iV/xgGulY8TQR8NatgzHCpGHz7xIc
        nOszp1VUhFpSgKi/87Uc3yIC5qTArdJmc0172E4=
X-Google-Smtp-Source: AA+uWPyUpLiZ6AipTTolAPCfrCvUaxTSZVTmtH0orJ9isZI5hHoFN7u0qwPDXS566j9dVteVJYsJ5nAEHNgAtIP5mwE=
X-Received: by 2002:ac8:1abd:: with SMTP id x58-v6mr9448098qtj.180.1533968041795;
 Fri, 10 Aug 2018 23:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 23:14:01
 -0700 (PDT)
In-Reply-To: <20180810155813.49259913@gandalf.local.home>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <20180809143827.GC22636@redhat.com>
 <20180810155813.49259913@gandalf.local.home>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 10 Aug 2018 23:14:01 -0700
Message-ID: <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:58 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 9 Aug 2018 16:38:28 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
>> I need to read this (hopefully final) version carefully. I'll try to do
>> this before next Monday.
>>
>
> Monday may be the opening of the merge window (more likely Sunday). Do
> you think this is good enough for pushing it in this late in the game,
> or do you think we should wait another cycle?
>
> -- Steve

We (Facebook) have use cases in production that would benefit from this work, so
I would rather see this gets in sooner than later. After a brief
review (I will more
careful review before Monday), I think this set is not likely to break
existing uprobes
(those w/o ref_ctr). Therefore, I think it is safe to put it in this cycle.

Thanks,
Song
