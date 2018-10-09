Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B317C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13B42089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwdwXch5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13B42089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJIOKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:10:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38226 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:10:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so487173qtf.5;
        Mon, 08 Oct 2018 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS5tt/THeJBcPFOUVqP4NbqMJDRqihQtiGSeYhs7ywA=;
        b=pwdwXch5mWOcVH36UPH7IUa8pEGgsvwpeD5IKDKJ1C5fBWCFoyNMMz8gzjtOCbZj6V
         JTk4P+KSZ1JJC94AOlzL8HKT2nLVGeCrgACi0NFo7xA5A/2SeGokb8Yk/WT++o03htyY
         Su2qSOZoWyEnDBHbhrCXNpFYr8jb3QfloKDTWB8SXMCmWta0YOfLvHJCrvPvPOoMYXnx
         OHK6bcIvwfNZ1Hh4uIibEx0IBhFl7Zl6O/xYElkq0Qx1TnrW+9VOCc+SeYYkwrHscGLs
         vyvZGB3GiuyxBLF8lm5zlml0uuFjuYxlwRHCvUr68gsCsnPcVxQ6FQuDbwcOVl+bq2Kp
         VsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS5tt/THeJBcPFOUVqP4NbqMJDRqihQtiGSeYhs7ywA=;
        b=D2srCwHG2rO8Ky9jkzxLHeVaD+lmv1PnmQUiTogeQN+cuFgewNSN7nTpzXOA9Anjhf
         d+GYBUuSsuaawfjBQDnBIuqdoKDYxH5C7gUdrCUDVEy0pYaokKGIR+d66Eqs1Su88KYS
         jBEFpGIafIJAOO0gY2vSLQrY9G2hMPWG5al5RnszA2kYagyN0+1a+RXnxG0TXQdwoPYw
         Me7/5fhwHvVxeryL0dpoGCzDr8t94XFHv0fZJ1nEPEIFnX7KTx7J/OH10gVf73sc4Jsl
         Buhh2JstxmlXvidqizVPi6uis9mUv01MXIG182njslHG6lA4wbZ+xqQ/T4hYs98lBVK4
         JbIQ==
X-Gm-Message-State: ABuFfogk24iy8ZnZi2deeaIZpKjZGI3jLi/3fsVsY43Pfc33c3KbETWg
        jH1wpsuBcu4DFZab2y8afuxu3bJpIdvfW8QJsbc=
X-Google-Smtp-Source: ACcGV60VEyQq0OWFHq3MBQYvkqu7vn0OtVq8LMcAUYVvJ3F3Al2NMn8K416026TVguhXDwH5rHcmYs8w/OBrHUe3p7o=
X-Received: by 2002:a0c:8af5:: with SMTP id 50-v6mr7797458qvw.48.1539068127476;
 Mon, 08 Oct 2018 23:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
 <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com>
 <43898.1539033428@turing-police.cc.vt.edu> <CAPhsuW5nPGMOEMKa1UFwgquoUeYiUV8i8nVgWfM6McH2Ri1esg@mail.gmail.com>
 <9337.1539047240@turing-police.cc.vt.edu>
In-Reply-To: <9337.1539047240@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 8 Oct 2018 23:55:15 -0700
Message-ID: <CAPhsuW7-Xa=_2BTATEhthWnyfETPv173p_cG2YrcCZ0BOsS9ow@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Fix a missing check bug
To:     valdis.kletnieks@vt.edu
Cc:     wang6495@umn.edu, kjlu@umn.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:07 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Mon, 08 Oct 2018 17:44:46 -0700, Song Liu said:
>
> > I think I get the security concept here. However, hdr_len here is only used to
> > copy the whole header into kernel space, and it is not used in other
> > logic at all.
> > I cannot image any security flaw with either hdr_len > btf->hdr->hdr_len case or
> > hdr_len < btf->hdr->hdr_len. Could you please provide more insights on what
> > would break by malicious user space?
>
> Say the biggest allowed value for hdr_len is 128.  We check the value, the user has 98.
> They then stuff 16,383 into there.
>
> Now here's the problem - hdr_len is a local variable, and evaporates when the function
> returns.  From here on out, anybody who cares about the header length will use the
> value in btf->hdr_len....
>
> (And yes, somebody *does* care about the length, otherwise we wouldn't need a field
> saying what the length was....)
>
> Now think how many ways that can go pear-shaped.  You copied in 98 bytes, but outside
> the function, they think that header is almost 4 pages long.  Does that ever get used as
> a length for kmemcpy()?  Or a limit for a 'for (i=start; i< (start+hdr->hdr_len); i++)' that
> walks across a variable length header?
>
> Can you cook up a way to have a good chance to oops the kernel when it walks off the
> page you allocated the 98 bytes on?  Can you use it to export chunks of memory out to
> userspace?  Lots and lots of ways for this to kersplat a kernel...;

In current code, I don't thing any malicious hdr_len value could pass
btf_check_sec_info().
On the other hand, I agree this is a good-to-have check.

Acked-by: Song Liu <songliubraving@fb.com>
