Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1FD5DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB509208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2bGAWz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB509208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935063AbeFMKDd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:03:33 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38695 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934279AbeFMKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:03:31 -0400
Received: by mail-ot0-f193.google.com with SMTP id p95-v6so2289755ota.5;
        Wed, 13 Jun 2018 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBWYwfvit6w2rrTis/V/4VcR8mShGoeLQ7tizyU+9s8=;
        b=L2bGAWz7FMubUJ//VndNbKxL5sBn1dZ+O4bBKOLFQQSyS5kA5XCO/pqqfJmXG3SpUx
         dtCzuOqu9p/2kuvdYvkyGCkgBN2nfSV4L+HeclueN7q67VtgUhSOTP/qtzXBKcOv3Ayb
         nIZwCtiitn6ColwtWxdFR8J9KgUU4yI87Uqzln5HcKZzkD/OVxo884OYZq+SlXYjau8D
         mx8xPQfZMXm1ntO/PitN1MzeTo+fXOfo7pmWMVeiYLBtHsMJk8q0GmF+LAl1fPE/rA0e
         RidqQepMGR4PjIU66sFBPSEYgFLO8SCKrszKac8y+t9jbB/UIZWWSQtHHVA0atSQUk4H
         GAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBWYwfvit6w2rrTis/V/4VcR8mShGoeLQ7tizyU+9s8=;
        b=NsESo1ATwUAF+vUtmbWlsLM0F5oJulpAuG0f2v0nriGFei0CNv8o+xwMJf3DWJff+H
         WGd6P41y9xqCGp4V0XLmWp233n4Q8bePnl9sZ7u3ZnqmFJAEmB8Gd6UIrc8u5Hn4wJnX
         Je8Nsq6JpUTWSzWUSQkIyuQCcuXl1q+sCCu2vEDLx2KO1B/eBR9Zsxz/z6MoJ625uMRI
         2+1zfekRb7NLnSG3xfod3uwKiLDFtmqqqOXkxJ5mzAq8mgUBXBGKnn/V46niSgNTQ2T9
         ynuLB3Kr43hkANMK/4vzsYAuj0OyXoy9OCR9sQBlzSKvtaoiaLR7ES/uOhUtwYrXAeLt
         U58g==
X-Gm-Message-State: APt69E1nVzTU5DJ7ZHBfrilj9a/KOCfkM1yxYnxhYTzH7x2GhaL+oenN
        D6bUc/fKRE43ITwzKJhk7HG2GfkXPoggETfP8FU=
X-Google-Smtp-Source: ADUXVKLjexrSyQxtvYVDHNOZU9a9NjPqIkbrXfOyltUT73ZxqdQMdAB+6P3RYSVKExsoxmpiUxBrpir1Xu8laeD8zU4=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12-v6mr2433533otf.203.1528884211116;
 Wed, 13 Jun 2018 03:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
 <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
 <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com>
 <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
 <CA+55aFw3a1j1GCTtf2C2bDML13G9aZ=bT2ysmXY7=fnHJups2w@mail.gmail.com>
 <20180613044840.GA669@kroah.com> <CA+55aFxogs_+6E-1HWr8L6Go4j0rQPK2Sk7qkSCMnq_18g-+2A@mail.gmail.com>
In-Reply-To: <CA+55aFxogs_+6E-1HWr8L6Go4j0rQPK2Sk7qkSCMnq_18g-+2A@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 13 Jun 2018 18:03:27 +0800
Message-ID: <CANRm+CwvuGWo0c-jvPOaPCpxAHPZb1s6HS-nReh5aRyt6LOzJA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     torvalds@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, tmricht@linux.ibm.com,
        keescook@chromium.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 at 12:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 12, 2018 at 9:49 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> I'm going to be start traveling towards Japan and China tomorrow
> morning, so I wanted to just get the problems I noticed out of my

Great!, welcome to our country(China),  and looking forward to see you
at Linux Conf. :)

Regards,
Wanpeng Li
