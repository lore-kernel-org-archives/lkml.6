Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7949C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3C520020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N5wltRlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3C520020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935791AbeFMO37 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:29:59 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:42393 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935664AbeFMO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:29:58 -0400
Received: by mail-io0-f178.google.com with SMTP id r24-v6so3635653ioh.9;
        Wed, 13 Jun 2018 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fERCi616sZ4nTnswzO8dl4bLx3LEimHKsJqCZI6oZtY=;
        b=N5wltRlIihCIbjxBZyrdoSyA6QBIeEfzbKmv+vmPAw7CMdyYdv7ep36XJ2Eci32yQI
         1boJKLqGX334htGED8TU/AetAE1MaJroGBgQZkJLopdjTkIzf4O56huHJSm575YPyHyn
         AqK8rvSEvUUTCBY9QjmOb42ch9HN3EeKYyKCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fERCi616sZ4nTnswzO8dl4bLx3LEimHKsJqCZI6oZtY=;
        b=HTnmPxSJUe+tLF2sy/Kla45fldWIbfDSP5YNBwtk81aJTHbNryL/oWD/astnxdlycX
         bi06CL7EtJB+eoJeuBSkkDr4IOBZzblpQwBPTj0p1twhNA3FOYvo6nWUGaEY4m1vhGnI
         WOsf55jsfMdHtn+09/ALhnVmlO9rsCax3dTX5jtpOWVLCGWlKVOWgF6X9WL01AEHj0X+
         VOEmBNKdk4Ruh7GtM0aI72EgEmyRbq7CCjAZgXLTC00lsX3XluNHi++L99haj708Llfn
         arn5YwyrWTkGxH7XOARvKEDRZnmR1qECSsdKYFqLW30vRAsw57K+/H2fwPPtHVjus/0V
         0GQQ==
X-Gm-Message-State: APt69E3Lnfk/w0HxmNizZc9BLlNB6Ghz9hySfZsmjWHfxa1JiOXsJbt1
        K7/yPUEoGjzeA3uVOtU7DK1Thk0RgRu/u1tLKEfhCw==
X-Google-Smtp-Source: ADUXVKJMMHBEg0lBC75y0mUgr8XLsk1PgKBzOZHWwmflk5Zbj0PijRZIVnLTbzmUXL7o60luH/ccz1yvMQqZT4hP+Bg=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr5128853ion.259.1528900197063;
 Wed, 13 Jun 2018 07:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <6570c00b-bbec-82c3-16e2-1ba96d8e263b@redhat.com> <CA+55aFxyQ0HE6ShB_pF1yXS9VjQv78OyseJpZjLXu=rbBTEPTQ@mail.gmail.com>
 <c982edb3-d2fe-87f9-f1ac-2125901d7013@redhat.com>
In-Reply-To: <c982edb3-d2fe-87f9-f1ac-2125901d7013@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 07:29:45 -0700
Message-ID: <CA+55aFz50grqj4=Eq5HcoH0ZAZgBtHP38wqxtbjo32-P_Wh5Yg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 7:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > Well, being in linux-next should have found it too. I know linux-next
> > had a lot of kvm stuff in it, was this not there?
>
> It was, I suppose that's how Arnd found it.

Ok, apparently the 0day bot doesn't trigger this case, or it's just
that even with randconfig you needed to hit just he right set of
combinations.

Oh well. Water under the bridge, hopefully your added tests will make
sure at least _this_ particular issue doesn't happen again...

           Linus
