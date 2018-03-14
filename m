Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCNQnF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:43:05 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39110 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeCNQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:43:03 -0400
X-Google-Smtp-Source: AG47ELulCTS8wpjzlJgTrkesoo+sUGWWPn8vVMm6HgrYzmFsNx9kYFtv6AkcnLf2thywSw+yNKD03VAM5uGcuZN4LUo=
MIME-Version: 1.0
In-Reply-To: <20180314161317.GA19701@infradead.org>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-2-vkuznets@redhat.com>
 <20180314161317.GA19701@infradead.org>
From: "Joshua R. Poulson" <jrp@pun.org>
Date: Wed, 14 Mar 2018 09:42:42 -0700
Message-ID: <CABHrTiKEEes69gewMjQNwiC4SmEM6BS+LF40bsKQFYGUQY1kRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
To: Christoph Hellwig <hch@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:13 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Mar 09, 2018 at 03:02:43PM +0100, Vitaly Kuznetsov wrote:
>> hyperv.h is not part of uapi, there are no (known) users outside of kernel.
>> We are making changes to this file to match current Hyper-V TLFS and we
>> don't want to maintain backwards compatibility.
>>
>> Move the file renaming to hyperv-tlfs.h to avoid confusing it with
>> mshyperv.h. In future, all definitions from TLFS should go to it and
>> all kernel objects should go to mshyperv.h or include/linux/hyperv.h.
>
> What is TLFS?  And hows does it differe from mshyperv.h?

The TLFS is the "Top-Level Functional Specification" for Hyper-V.

https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
