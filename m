Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeCMRvE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:51:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34097 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeCMRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:51:03 -0400
X-Google-Smtp-Source: AG47ELtT0D4C7ThwLcF90Mobe3wNdNKziKpMT8G+6cPFPHa+dSGeF5y01XvjSe1OKkeqT6hVMLv5LCRBYcSGNKguT9Y=
MIME-Version: 1.0
In-Reply-To: <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com> <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com> <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com> <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
 <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Mar 2018 17:51:02 +0000
Message-ID: <CAKv+Gu8WeV+7U4omoMvECPa0LhF4Nrusvy+V0mirWVfejCebNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 17:49, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> On 13/03/18 18:39, Ard Biesheuvel wrote:
>> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>>     module_plt_alloc_fixed();
>
> Do you consider this a legal C code if without module-plts.o the function would not exist at all?
> That's too much relying on optimizer I think...
>

Yes, we rely on that in many different places in the kernel.
