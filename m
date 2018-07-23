Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C92C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880B32075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5BxOsky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880B32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbeGWBu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:50:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44186 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeGWBu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:50:58 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so30352376oih.11;
        Sun, 22 Jul 2018 17:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IEp2zZGb+mWhpJPcuHg8TKoSs6lcgIlzZDyxL3c618=;
        b=L5BxOskyCJrb0YRF8QiPHGd/IWIJ8ZBbGcUF8Ua3fWIidd33/tC2wQYsKC3/Q0gQKf
         pQYXAw6psa3F3GGXiOFLGXwsRHFLPMNSH3G18mgOYw8s+CIjiDcLAW23ybG+q4InUV+S
         mh4eWmc6dgguev+gNGXEy2IKOULyvnn/q1gk3M+mgFk6A3c6ZbxD9FtAKdYvQT8/T5e0
         dHU6RKwFF9Ak4Wsca5gHasrGloK+IN0IKBODy6LSuCNNcBH69BM246K2Q0D612GuNw7s
         2Vo36ryat6TtFJoVNZsIdEOJ63JXjTCsszkVY0Rl4xik5REwgkl6QwFNLUNhOlCpZt3d
         DJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IEp2zZGb+mWhpJPcuHg8TKoSs6lcgIlzZDyxL3c618=;
        b=V0aomO/P2T7GosIgvBNNC+S7x49XtQvez3AdsI3+lvBX/mJHyJF2p7ZT+GSEzEjwt9
         yDe0+KeoQl5azLI6mj0euq6EJLRKb0gPyk4NxXhQuGZd88uKQIKdzJImys6iTt9OW5pn
         zFYLhS/8wksL5zBssh62s36PTQGwr58FlUx4AfgVznOfLDZRBhWs/Y+ol6e6ZnltoBHt
         DBipMS0sxFOCxPHbZI17GJSSTtZuiCXX/JP1R/tuNe+TGG7s9gv3V6Jg/UyuzFs9yzqZ
         gUyTA6Ykk7WxaZrdHfAH5Ir3ebMkZdYqjf458Su3GOagzOQCdFzrpzVL19FW06MJAxQt
         qx9w==
X-Gm-Message-State: AOUpUlHUVB7EGIbvP4pSwhbfyMtKWrkdRVMp9wjeG9IAnXbQb7yQWXiU
        N3N41NdVL5+Yj03vCjdImWhcImMCpZTW7Axtc0o=
X-Google-Smtp-Source: AAOMgpeOry5ZtaNaMt7yROKsjjmpfjSAysuu7lp7PDfdp89HnyzqlgkXVovl0DL6IS37W3IDTXMfY3a37/wIXw46rFs=
X-Received: by 2002:aca:cc46:: with SMTP id c67-v6mr7278201oig.197.1532307140827;
 Sun, 22 Jul 2018 17:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-6-git-send-email-wanpengli@tencent.com> <20180719163138.GC11749@flask>
 <CANRm+CwzG8jcsVhhGa2w55KcCTpwm-yokFR2Oi6LYaoS0ameqQ@mail.gmail.com>
 <825c953c-ec48-84cf-f1ca-bdee5d327427@redhat.com> <20180720132656.GB8330@flask>
In-Reply-To: <20180720132656.GB8330@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 23 Jul 2018 08:52:12 +0800
Message-ID: <CANRm+CwzB9CiiS6GWG109cREjRDd-0RJAut-QvmWxwwV4eF8Ow@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] KVM: X86: Add NMI support to PV IPIs
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 21:27, Radim Krcmar <rkrcmar@redhat.com> wrote:
>
> 2018-07-20 10:04+0200, Paolo Bonzini:
> > On 20/07/2018 05:53, Wanpeng Li wrote:
> > >>> -     ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
> > >>> +     switch (vector) {
> > >>> +     default:
> > >>> +             icr = APIC_DM_FIXED | vector;
> > >>> +             break;
> > >>> +     case NMI_VECTOR:
> > >>> +             icr = APIC_DM_NMI;
> > >> I think it would be better to say that KVM interprets NMI_VECTOR and
> > >> sends the interrupt as APIC_DM_NMI.
> >
> > It's not KVM, this is arch/x86/kernel/kvm.c so the guest side.
>
> Yes, I was preparing to drop the delivery mode bits as they are not
> needed for NMI_VECTOR: real APIC can't send nor receive vectors 0-15, so
> we could just say that NMI_VECTOR is sendable through this interface and
> is delivered as APIC_DM_NMI.
>
> I didn't realize that this allows the other delivery modes.  They are
> not useful [1], but we don't really have a better use for the three
> bits.  The only other option so far is extending the cluster index to
> increase addressability ... I'm starting to reconsider as addressing
> another few millions VCPUs would probably be even more useless.
>
> Wanpeng, sorry for the confusion, feel free to use any version.
> Document the hypercall layout, though,

No problem, you and Paolo always help me a lot, thanks for that! :)

Regards,
Wanpeng Li

>
> thanks.
>
> ---
> 1: I think that OSes will use unicast INIT+SIPI as it's easier to call
>    it after preparing structures for the new CPU;  SMI is pointless;
>    LowestPriority shouldn't be supported; and Reserved (APIC_DM_REMRD)
>    is reused for KVM unhalt, where unicast is most likely.
