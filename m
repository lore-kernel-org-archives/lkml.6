Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeEDM2d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:28:33 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42707 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:28:31 -0400
X-Google-Smtp-Source: AB8JxZqyJ4qITD7RKwya74ZgW2cwzApyuqhPvOXZQr8HjSTaJa1Q83yO4FoSKqZeZM2uwMdJgF2IRl3SqJnWEZTHiEY=
MIME-Version: 1.0
In-Reply-To: <1525055900-20729-1-git-send-email-wanpengli@tencent.com>
References: <1525055900-20729-1-git-send-email-wanpengli@tencent.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 4 May 2018 20:28:30 +0800
Message-ID: <CANRm+CxuzHjfFPapQbPGBLN78nt=e4T4z5D0NJYrQ_EzrQdOMQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Limit timer frequency with more smaller interval
To: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44CSb6U026902

ping,
2018-04-30 10:38 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Anthoine reported:
>  The period used by Windows change over time but it can be 1 milliseconds
>  or less. I saw the limit_periodic_timer_frequency print so 500
>  microseconds is sometimes reached.
>
> This patchs limits timer frequency with more smaller interval 200ms(5000Hz)
> to leave some headroom as Paolo suggested since Windows 10 changed the
> scheduler tick limit from 1024 Hz to 2048 Hz.
>
> Reported-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 51ecd38..dc47073 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -114,7 +114,7 @@ module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
>  static bool __read_mostly report_ignored_msrs = true;
>  module_param(report_ignored_msrs, bool, S_IRUGO | S_IWUSR);
>
> -unsigned int min_timer_period_us = 500;
> +unsigned int min_timer_period_us = 200;
>  module_param(min_timer_period_us, uint, S_IRUGO | S_IWUSR);
>
>  static bool __read_mostly kvmclock_periodic_sync = true;
> --
> 2.7.4
>
