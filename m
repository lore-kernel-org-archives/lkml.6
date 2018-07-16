Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF59C20852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXmk13/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF59C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeGPQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:49:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34642 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:49:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so75899736ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEvseBhIcJtzOMAk3j/8ABDNdL6rUFRm/FoSCJuxLDE=;
        b=cXmk13/MtSYPZ8OODCaw81kFr1mYLy/Fshcjmzbt215TbcLBhs6dTT++JxHeexKoRN
         nEVzxL3xGSwKnMz68zTcUNHN9908x9rZ8m+iX3M+WiEtunGuF2m/HaNj3yd/zQ0dWDaD
         erhXx7jdIorICRAIVOGbqXIoLo19U/ovEYX3ljXtg+t1DoMYs5N8+X8VUo1nAHHNPkXq
         QCGhXg2fg+bxA+6gLVYmpmVyLMhRq+Uopw1u9GoXonytYX1yGw8c/xItLXYunOn0IqSC
         w72r+WaFYQEpediwGby5oioep8OgJxw+BzPgLg5SHEyUMPoiEw2HIQw/xit9kBxtktcI
         hyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEvseBhIcJtzOMAk3j/8ABDNdL6rUFRm/FoSCJuxLDE=;
        b=e1T5fuURmXUO39pXcPjH652+j6objbY6sSvKeHhsrGAGv6n1gAExQhNxzK5MaX28u0
         DtiKBG7WY//Xwzd5YdwrQgcPm/r6vwD3zClaMB0fCWMFGZHfxWgZw/rYi2ZkO3jq8PxF
         JiGdQjDJ+fH8iEONIE0JwEIioTlOLBVA3JkF+ye36A7CKaUYax+RNaAMv3NMsG7d6NXZ
         28oQAYwS4YgWJ8oQ4us//9cDckIrh22kxXRKU/u+lNeepdVFy6FbqOBv7/psslRRmJtx
         emmBb2uy952jwAqOfud0uUvshdhjFEjCaVZotHzjjkFgOBe6ZQJ1ubDTP/iovCnZdpbq
         g8fQ==
X-Gm-Message-State: AOUpUlExTIpb+Rrv/Gxv8OKP1FJDWjU2x8+YlCzvcq3wzgCqbd5IvAUP
        Rt1EF4B2N8XGQxRdYZyqVYstsfJFQOgykoSuIDblMQ==
X-Google-Smtp-Source: AAOMgpf+qT3SNwIiU0s+TYjvLkZP4JMkdcc/b7wtdetk25qidPUKKj3GMqrOABHCYgZtirYrNgN04qorgwVdW2Yb8pA=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr7101572oiy.219.1531758061284;
 Mon, 16 Jul 2018 09:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com> <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
In-Reply-To: <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Jul 2018 18:20:35 +0200
Message-ID: <CAG48ez0h4c7z+a6Dj-94Wb4-HdWM1YbrBd44oyBEiQyu8NhCKA@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 2:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 6, 2018 at 10:22 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > We did discuss removing the r/w interface, but, as you say, it's been
> > around for ages so it's not clear what regressions would surface if we
> > did.
>
> So since nobody else followed up on this, the attached patch is what I
> was thinking of just committing.
>
> It removes the warnings from the access check, and just puts them
> (unconditionally) at the top of the read/write function instead.

Minor issue:

+ pr_err_once("process %d (%s) does direct read on /dev/sg",
+ task_tgid_vnr(current), current->comm);
[...]
+ pr_err_once("process %d (%s) does direct write on /dev/sg",
+ task_tgid_vnr(current), current->comm);

printk wants a newline at the end of the message, otherwise the
message hangs until the next message is printed.
