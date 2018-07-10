Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AADC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C998208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NbIRnX3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C998208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeGJWZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:25:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38210 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbeGJWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:25:41 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so21858303iog.5;
        Tue, 10 Jul 2018 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJFkWjO4j0BiIqLXIF9pgN1PvfE5eJDghujY0WrDTGI=;
        b=NbIRnX3S0WXwSgPV+MUVHgCkk75LVp6nj+8oCizT+6FVhWyFKVB81oMZHY56rA92rW
         fVXQTNoXskDtKNjVND2odHDDLhZWOkxxXpBxZLWsbcxs2qeliMo6LoRkIBnewuVzsuwk
         gc59T1egqOaloqXO2TSoVnVSPwtqYjNeFb/gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJFkWjO4j0BiIqLXIF9pgN1PvfE5eJDghujY0WrDTGI=;
        b=ZtY6LBZyl0v5/y7BOpcbx2asEnG6NLUD9qmefor8WBLvypdTFV6+XNXvOy98tPi1Vx
         DzOG5O8VuJgYFKrRFxJ3AbzfE0lZAHt0KNXO5FmOmXWULPob+OpXz4T3dFS0IykEVdKb
         vOZ8m+tkMEvUOM8XZJHMddYNs+Cco5oZYX1VIWdksYVPAU+/B5cGf8PNQxDqXUlJuWZv
         Bt7WByqH/XpWBKA1IG4CVARswICTqqFRZ0i2y7in2gIbyx+ChPlkOfZ+uCnXhjN3A7HG
         WbMR2KNLGmbzgVbcmn/yy7Q5lTy3wfUWXKTHuNbyLlr7tLi+Hnxpd4qVFWoAudHWPo5O
         /kfg==
X-Gm-Message-State: APt69E2W1O7YUhRFy4btNakzlpNjwY+52IkWfeL1jFQryfOPMPG4uMDP
        Z5JYSOTmbuNSI9w+maT8b1DC5g7334ZxdmllG/A=
X-Google-Smtp-Source: AAOMgpeL/jLWQ9Polvc0vfQJ7pXnr/hVcM8FfWSGreTOZU2pgfp0IfwnrsEIETud8i/waxB/FlcPcAEE1EsotB/5IOc=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7301352iom.238.1531261471944;
 Tue, 10 Jul 2018 15:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com> <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
 <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com>
In-Reply-To: <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 15:24:20 -0700
Message-ID: <CA+55aFxdkGTQ-djy6Z4D52xzHhwWdqQyfVgKweTiUfRpvYoztw@mail.gmail.com>
Subject: Re: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     tonyb@cybernetics.com
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 2:53 PM Tony Battersby <tonyb@cybernetics.com> wrote:
>
> At my job (https://www.cybernetics.com/), I use the write()/read()
> interface to the SCSI generic driver for access to tape drives and tape
> medium changers.  For example, the write()/read() interface is useful
> for implementing RAID-like functionality for tape drives since a single
> thread can send commands to multiple tape drives at once and poll() for
> command completion.

Ugh.

> We have a lot of code invested in this interface,
> so it would be a huge pain for us if it were removed.  But in our case,
> everything runs as root (as the firmware of an embedded storage
> appliance), so extra permission checks should be OK.

I wonder if we could make the warning literally about not having
CAP_SYS_RAWIO on the file descriptor.

Because the /dev/sg interfaces don't even do the kind of command
filtering that the SG_IO code does.

The SG_IO code (well, at least the block/scsi_ioctl.c code - again
/dev/sg does NOT get it right!) actually has a whitelist of commands
that have known behavior, and that can be done by normal users when
you open a device.

To actually do _arbitrary_ commands, you have to have CAP_SYS_RAWIO.
And there we check the _current_ capabilities (not the file descriptor
one), because an ioctl isn't something you just fool a random suid
program into doing for you.

So /dev/sg really has serious issues. Not just the read/write part,
but even the SG_IO part is broken right now (sg_new_write() actually
does do blk_verify_command(), but only for read-only opens for some
reason).

                 Linus
