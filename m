Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56074C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6AE25701
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmVLssK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6AE25701
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030301AbeF3KFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:05:49 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41695 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934077AbeF3KFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:05:45 -0400
Received: by mail-ot0-f196.google.com with SMTP id d19-v6so12515466oti.8;
        Sat, 30 Jun 2018 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXvWhs1ngb6cZ3QOvIM2MmHMRPT3wyhB7ZVEqxG2dec=;
        b=YmVLssK2uJ9cEzEMGBHq+/CRTNl+IfclTq3MtxVp30GuCMCTRGapYWe7PXNiImgplh
         kd7nh1Udy2uu3hDTQg0C1905B/k59RJxFVR1GP6VA1gYbvuTqbr9q0Fq7WBniqSqEJcN
         Sp8QoFspCb+ePra4WiR42NBwOBASZwo/iFoR0Otl5RWxLu8qCvslwTrd7Wwzs7zl3fHe
         ZbcAfMhpdYBbYrF1NeHr48V/nOrvLFEjB6bMNdXGnVV25qoeaGKUtuAkTGUp+NxDyMjV
         fr1w+4jImr9RO8idsNrmL/4dT+f1ZGAY8iB+xcTAJdUzXSwfSNoVEKB812ApyN1QzL7D
         jOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXvWhs1ngb6cZ3QOvIM2MmHMRPT3wyhB7ZVEqxG2dec=;
        b=D9dxcJswKIjleqdHDuKn2WC3pU0Im6SRWNvntyY5l9xhsmuWRdLsPuSrRuC1C0IrPH
         1R0Qo+BbiZ47HQMVJQus5uPTsLwFufmmbotAZxLBlzFrS8yxzFBUZMcrJYrv63CMz/kM
         k6P1pIqljRNIgiSyVNZUdjWj9DfhDug+guxLdxn0DsAtZYe6xoQoDuYbgur+iuesZpEN
         DXJ9rLUwIXClD6BKtmFCI0pFSLbZJx53iNCbLUOKgDtJM0Ws2L1t+S/gJAZxQTcPT5V5
         Hi4cL5X06sbnTGEwGRh1cgiEgVWtLRxDeODNIlTOFkGrYH/xxHFGkrOfBoRFwcqdL/gM
         56Gw==
X-Gm-Message-State: APt69E1yjL6V8q2lhKbO9CBALIw5Kn03K1tAaahROF4AFCw5cccaTM+9
        0Y2LLcVAzYhnrYMtbuF4lCKsbkKmnGrHxw1jCkE=
X-Google-Smtp-Source: AAOMgpf04k+tPl1c1tkz4x7QEIZvP1UrG5VM94Jmg8AVP4pqrfYInZC9dzHAbh3545F4ytwDUghk9I+ZvM3vsu/Qq84=
X-Received: by 2002:a9d:2d05:: with SMTP id v5-v6mr3583828ota.389.1530353144870;
 Sat, 30 Jun 2018 03:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
 <1530265876-18136-3-git-send-email-wanpengli@tencent.com> <878t6xewei.fsf@vitty.brq.redhat.com>
 <7d2b34ad-2436-0cee-3e71-97ea2eb5fd49@redhat.com>
In-Reply-To: <7d2b34ad-2436-0cee-3e71-97ea2eb5fd49@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Sat, 30 Jun 2018 18:05:33 +0800
Message-ID: <CANRm+CwK2Wza0P236mcMaMDEMbHR+tyFhOZEJtiUs5vtPLGkzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: X86: Implement PV send IPI support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 at 18:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/06/2018 12:09, Vitaly Kuznetsov wrote:
> >> +KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
> >> +                                   ||       || before enabling paravirtualized
> >> +                                   ||       || send IPIs.
> > In case we decide to apply this as-is we'll likely need a new feature
> > for PV IPI with > 64 vCPUs (or how else would the guest know if the host
> > is capable or not?)
> >
>
> Yes, it makes sense.  Perhaps we can do one of the following, or both:
>
> 1) add an argument for a "base vCPU id", so that you can use the
> hypercall to send the IPI to CPUs 64..127, 128..191 etc.
>
> 2) have two bitmask arguments so that one hypercall handles 128 vCPUs.
>
> to remove or limit the need for the more generic hypercall.

Have already done 2) in v2, will send out later.

Regards,
Wanpeng Li
