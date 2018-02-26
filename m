Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeBZKGq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:06:46 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34725 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeBZKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:06:43 -0500
X-Google-Smtp-Source: AG47ELvwu5VyRVyth3FZgx6yzSz7RhVoK2Uvf/3+PQpQisiEt3RbKc8FpYxHoRd0/HuMlnJeHf0lXvYsaRn3NmmzCGs=
MIME-Version: 1.0
In-Reply-To: <20180226094148.GA15539@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com> <20180226094148.GA15539@pd.tnic>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 26 Feb 2018 18:06:42 +0800
Message-ID: <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 17:41 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> On Mon, Feb 26, 2018 at 03:23:58PM +0800, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Linux (among the others) has checks to make sure that certain features
>> aren't enabled on a certain family/model/stepping if the microcode version
>> isn't greater than or equal to a known good version.
>>
>> By exposing the real microcode version, we're preventing buggy guests that
>
> Where do we prevent userspace from coming up with some non-sensical
> microcode revision?

I think it is the host admin(e.g. cloud provider)'s responsibility to
set an expected microcode revision. In addition, the non-sensical
value which is written by the guest will not reflect to guest-visible
microcode revision and just be ignored in this implementation.

Regards,
Wanpeng Li
