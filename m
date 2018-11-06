Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B62C2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvLdEEDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B62C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeKGFvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:51:21 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40972 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeKGFvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:51:21 -0500
Received: by mail-yw1-f66.google.com with SMTP id c126-v6so5688715ywd.8;
        Tue, 06 Nov 2018 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rStzlRBnFgkrJLY71gS1Gi4o7h7W451Yq8I6+PGxOoU=;
        b=NvLdEEDBSR6H5+/8s2uc6lRpHCQW58gt9jcZkfPo6Q49s3yt4JX1bx+Z3JUTDGSv29
         CD45EybUMKCtG4AOU+sSCSeXRG5ZilsVMYMdV8TLeMjz3jo9P1KTt+/0rHHh8cN8CgBa
         giv5bWzxrMxTNfSu3SBnjx17GsAZE90403STbOARWXhDuUjEf8Mg7x7/ekXhe77B4P2c
         IA10HCbCNNEtBwq4Vl+8s1Z7rOvC5mEiqDJFK77+Ll7PBChNKDu40piTSW8M06k9MiZh
         Vv+fOC0m3yYp3pAsRHv4mTJxQbILUd0kkA9xKNPeThALVjoYXTPaEY+NPew+RGo4IfJ4
         YG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rStzlRBnFgkrJLY71gS1Gi4o7h7W451Yq8I6+PGxOoU=;
        b=P43MYsiGJlbS05hgHmN2NOgDAPOtHLPp1eDa92p1//Gtof4Ee//iHQ2Yycsw8hF93s
         htvcyOBWc0ZM9cKhMiMGLJrPzk+GHKFaw3v3EjV4FbYrbHOKK3YbA4QBddgWgTnLhyBj
         s7Nely5qSWIsrBCZo3IVYVxynAPmvgPCu0ZZxkDtmOVSt9Vh4UBE1g3rDx9RgG9qvi2e
         14Qh7qSg8S5wls0OuLspYT4YNQRDfdyvOEfyS6KM9WEg2vHRsWSZdUyHU/fpacCBfvRp
         l2UN5UJ8nH0mPXihvc0pV15fqeJYzzO4JumV6h6/031cyfM28V33DXvvt7eKdn9oBmxy
         4eFA==
X-Gm-Message-State: AGRZ1gKUz/sNyYUT/NBinjJ3Z5ViIevO/pKIJgmuqkABP1aRJV3P0qeC
        ARU/pesSuynWrlA906T116DWYq5T8mdNFKmvDmk=
X-Google-Smtp-Source: AJdET5dHamnICYRPA/nlp/t8XoP/h3KCf2IPKxQF6+UXIM8pkqGEjApfJb88QDCzHdBmTFy+wVpQPTazeify49m9dyA=
X-Received: by 2002:a81:6f57:: with SMTP id k84-v6mr27575910ywc.348.1541535862742;
 Tue, 06 Nov 2018 12:24:22 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
 <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com> <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com>
In-Reply-To: <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 6 Nov 2018 12:24:10 -0800
Message-ID: <CAMo8BfJcUuC1tcrZNf+6_iRA0esj5QrGFViMMeR3NPw6G5GbFA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
To:     firoz.khan@linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Tue, Nov 6, 2018 at 7:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> My initial patches does have generated-y += unistd_32.h instead of
> generic-y += unistd_32.h.
> If I remember someone pointed out that this implementation doesn't
> look good. So I
> replaced to generic-y += unistd_32.h.

I've only found the following case, where you did the replacement:
  https://lkml.org/lkml/2018/8/9/177
and I'm pretty sure that Michal meant that only the missing newline
didn't look good.

> Sure, I'll change to generated-y += unistd_32.h instead of generic-y
> += unistd_32.h.
>
> Max, this looks ok. right?

Yes, generated-y looks goodto me.
Could you also please move the line
  generated-y += syscall_table.h
up, so that alphabetical order of the header names is preserved?

--
Thanks.
-- Max
