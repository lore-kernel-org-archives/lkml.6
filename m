Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbeBLLMQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:12:16 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35493 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbeBLLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:12:15 -0500
X-Google-Smtp-Source: AH8x224UKhTu6WqgNSIMQqAnmOBcJ9qv9lMg/N3QlkDixCHWR/IsTAQpkUQ6hPGCbTq4qlbuB4wNZlNyIAY5Ub6JHFg=
MIME-Version: 1.0
In-Reply-To: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 12 Feb 2018 22:12:13 +1100
Message-ID: <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param xmon=off
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 7:59 PM, Vaibhav Jain
<vaibhav@linux.vnet.ibm.com> wrote:
> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line.
>
> This minor patch updates setup_xmon_sysrq() to register
> 'sysrq_xmon_op' only when variable 'xmon_on' is set.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Any specific issue you've run into without this patch? I presume
running xmon=off indicates we don't want xmon to take over in case of
panic/die/oops, why are we tying this to sysrq?

Balbir Singh.
