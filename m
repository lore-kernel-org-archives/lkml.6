Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBFQ65 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:58:57 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:51306 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeBFQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:58:12 -0500
X-Google-Smtp-Source: AH8x2260MCB1FdH7PlyoyVlUiZx3HmCb8vh2OMR2c/CBdW4nf/Da6JErCkrPKJGnTPvzVti5n3hReOHVWNw0PPBfF+8=
MIME-Version: 1.0
In-Reply-To: <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
References: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
 <CALMp9eQNB+2KLAR2Tv+By2oTthRLvAQMmJiEs61kFNrZDct3_g@mail.gmail.com>
 <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com> <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 6 Feb 2018 08:58:10 -0800
Message-ID: <CALMp9eRHzmU3Kfr0cxhy2Hrr-RybnjrsKHByoV27TdYffuuC3w@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
To: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:57 PM, Wanpeng Li <kernellwp@gmail.com> wrote:

> This is effective one, what I restore in this patch is
> achitectural/guest visible.

This patch doesn't "restore" the guest visible CR4 to its value at the
time of VMLAUNCH/VMRESUME. It loads a new CR4 value from the vmcs12.
That behavior is incorrect.
