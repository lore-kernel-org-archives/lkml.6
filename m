Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0FC9CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FE208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PlpZ4JqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27FE208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933763AbeFMD07 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:26:59 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:52313 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932839AbeFMD06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:26:58 -0400
Received: by mail-it0-f52.google.com with SMTP id m194-v6so1987530itg.2;
        Tue, 12 Jun 2018 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvODVwp2LsVLOlcKVh1kn3mHyeOhrbQMHGWIBGsq3OY=;
        b=PlpZ4JqTvHzYIHJVpYksON2bkXwtnxWuxk73ytvC4Jqy7Tt22K+WBiNkCIbWc1SFVV
         reERO4WGf5X+XaNj8NCKtqtmWWlISI/7xK8DFpM5DcaYPHHpEfg+3KRdSAw07QjpFGZE
         vpoblwgINMvy9UJRUwKQH0CvPLlZMtI0gE5ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvODVwp2LsVLOlcKVh1kn3mHyeOhrbQMHGWIBGsq3OY=;
        b=EAJGqN1tvs0ayHukyuQ6nLB4jSEyltB2xi1zh6crOVenv+FOB7TE/rRT9FX7zkzf9N
         MH4L34LLzJGP4kp4CaeqXuMpBgR8GeJYYHUTQk1CS19nLi9WeM60fkAsddd0t3COTe8q
         6grHMaSJ6FF92tcAghONiwb7v6q6QybJ9WbeyMj5KEOy40/65ZkBkDuxp/wW6Nd77+U+
         6Wk297c69aQpa4ZoY3cBk/Q6c12d5tOntlrtbaqtNLXqwW8m+LbI15F0O7gzUhWWBqW2
         qWaAAG5fPd04S8nPBOfLRC2tSOTEKLS23EKyRLpK8jvx4rxBROCig4TbrwzfaJ5zlfo3
         jfWg==
X-Gm-Message-State: APt69E061w62Vp1pH5BJiy2kMJzisZjBasBZ/38KYTFxiWPBG1EvZ4lF
        mG3IuuWoPmoI9U0iVqQsmGTKYXJKZG8Ev+SIsIE=
X-Google-Smtp-Source: ADUXVKLcJs3LEsgjfA2o35rxj1HHTvTZtFPiJ3VtEQ6nCvXt0It1uviXZQ8ToKY9X3E3rA2rDtNi9Bk+z0VxkQOBlms=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr2939459ita.113.1528860417450;
 Tue, 12 Jun 2018 20:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
 <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com> <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com>
In-Reply-To: <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 20:26:46 -0700
Message-ID: <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 8:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, the biusection seems to actually be diving into Greg's device pulls.
>
> Odd. I'm not seeing why that would break kvm, but maybe there's
> something in the device core layer that really messed it up.
>
> I'll continue to bisect to see.

Ok, so commit 95cde3c59966 ("debugfs: inode: debugfs_create_dir uses
mode permission from parent") breaks lkvm, and I think qemu-kvm too.

The commit looks like the RightThing(tm) to do, but we do not break
existing work-flows, no matter how much we'd like to.  So it gets
reverted.

Greg, Thomas, perhaps some alternative model? I'm not sure exactly
what kvm needs from debugfs.

                   Linus
