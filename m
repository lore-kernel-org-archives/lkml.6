Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeEOBdb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:33:31 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34585 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:33:29 -0400
X-Google-Smtp-Source: AB8JxZolVYBvhmiRgA5QkizF1iwKBPzP5PsRpQbfqnKVBHRn3cUV1M5qAH59LbxAmhCMIpZ/Whm9b3gZKTODD5p6tfQ=
MIME-Version: 1.0
In-Reply-To: <1525518152-58340-1-git-send-email-wanpengli@tencent.com>
References: <1525518152-58340-1-git-send-email-wanpengli@tencent.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 15 May 2018 09:33:28 +0800
Message-ID: <CANRm+CxQ=+HwbcN+o2CPRVMDA2qyPyg-f8rJ3MLYfLFUfeW=ZA@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: X86: Lower the default timer frequency limit to 200us
To: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>,
        Darren Kenny <darren.kenny@oracle.com>, Jan Kiszka <jan.kiszka@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4F1XaAL023426

ping,
2018-05-05 19:02 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Anthoine reported:
>  The period used by Windows change over time but it can be 1
>  milliseconds or less. I saw the limit_periodic_timer_frequency
>  print so 500 microseconds is sometimes reached.
>
> As suggested by Paolo, lower the default timer frequency limit to a
> smaller interval of 200 us (5000 Hz) to leave some headroom. This
> is required due to Windows 10 changing the scheduler tick limit
> from 1024 Hz to 2048 Hz.
>
> Reported-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
> Cc: Darren Kenny <darren.kenny@oracle.com>
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v2 -> v3:
>  * update patch subject and description
> v1 -> v2:
>  * update patch subject and description
>
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
