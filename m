Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B285C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C2E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MhT211Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C2E20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933915AbeFMDwV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:52:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33474 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933483AbeFMDwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:52:20 -0400
Received: by mail-it0-f67.google.com with SMTP id k17-v6so15903321ita.0;
        Tue, 12 Jun 2018 20:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPmsHsCK9DoY1D7rXTVitkdAuD9oWSjrfKTKFb5blXc=;
        b=MhT211RxpfTd/151dPXPkCBrhjkbEASQr/s4ZiJVyN5D5oeZc3cibPP1uSLdRAlZEK
         9N3TgJMQ3X1iyDQL1o173d2LdFgd3zEmSHs6gJ3JP+hPUs9dtCm2oUCYmhvNFi+tsf1G
         bWgXhqSok0UPrAj1WfcN1tXO3A9iJazbZH35I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPmsHsCK9DoY1D7rXTVitkdAuD9oWSjrfKTKFb5blXc=;
        b=jAVUpyS5LcfIklr4AH0ftdKcRpzChzZD+WpV2iZWbvu+BK+rH2lSsJpxiv0if4FrX/
         83ktb8u51zcZtty0v5BMvmigEJ3WYLnsOOForppdwM6+oqGMXAeB1F+Hz6FFQLVDjWgz
         v4kICxjFBlEWoWFzg2SckZZqjnv/GF+yxypgwfP2U9Oi1133CjfvC+jsYzxC/XIoGsYI
         UJpOTchZdMGW8MrMCH4Wf79FEuouTbGIXcWOsl98d5wWvImRHTu9hhOhKNxNiorzsW0f
         oIjejU1cRPSOzD0hyMwxY4FErAT4PkEM5S2N3k8kpSd1AGykeW4YbjRRevTfD3H9RC1u
         LXgA==
X-Gm-Message-State: APt69E3v5s8xSL5aYdM4DQPy3NShC+nA1roGxcZX70zPFDEipBpH9Aez
        sypD4bF+h9rMdTTNHVFTlYA1emn2jAiIIcK2RyM=
X-Google-Smtp-Source: ADUXVKJSsrhShXHNaOJK5oGm4WhAXyNRBGXLMD1CCbYjaZuyfBbARTYEo9VcLAbsSb9syG1GJoBcoBl30dlbq0WmJEA=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr3014193itb.1.1528861939350;
 Tue, 12 Jun 2018 20:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
 <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
 <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com> <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
In-Reply-To: <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 20:52:08 -0700
Message-ID: <CA+55aFw3a1j1GCTtf2C2bDML13G9aZ=bT2ysmXY7=fnHJups2w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>,
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

On Tue, Jun 12, 2018 at 8:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, so commit 95cde3c59966 ("debugfs: inode: debugfs_create_dir uses
> mode permission from parent") breaks lkvm, and I think qemu-kvm too.
>
> The commit looks like the RightThing(tm) to do, but we do not break
> existing work-flows, no matter how much we'd like to.  So it gets
> reverted.

I suspect it's the special kvm debugfs entries - see kvm_create_vm_debugfs()

Anyway, I've verified that both qemu-kvm and kvm-tool work fine with
the revert in place.

                     Linus
