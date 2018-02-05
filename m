Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeBEHWm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:22:42 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40325 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBEHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:22:32 -0500
X-Google-Smtp-Source: AH8x227TR4mCaH5NmL63R+O1dl+AUjeuQ9Fo99vA/PIRq96Iuv3T13gw3K1ddsZcIxf/zh8Uh5qFX2RifW88fgb+DAQ=
MIME-Version: 1.0
In-Reply-To: <20180202190242.GE26932@flask>
References: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
 <1517555473-8313-3-git-send-email-wanpengli@tencent.com> <20180202190242.GE26932@flask>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 5 Feb 2018 15:22:31 +0800
Message-ID: <CANRm+Cx7u9_1OkiQBtTP_Tcq8nNdF+Trt4CZR9bX8ZqX8CKWHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: X86: Add per-VM no-HLT-exiting capability
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w157MlrR007744

2018-02-03 3:02 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
> 2018-02-01 23:11-0800, Wanpeng Li:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
>> This patch adds the per-VM non-HLT-exiting capability.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>
> SMM handling needs more work: I think we should vmx_clear_hlt() upon SMI
> and RSM needs to implement auto halt restart (AMD might differ).

Do it in v2.

>
> And also look if we don't need vmx_clear_hlt() around INIT handling,

You are right, the guest stuck after utilizing system_reset command in
qemu monitor w/o vmx_clear_hlt() around INIT handling, fix it in v2.

Regards,
Wanpeng Li
