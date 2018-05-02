Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEBMgL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:36:11 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44094 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeEBMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:36:09 -0400
X-Google-Smtp-Source: AB8JxZrgmb6lxNyKatz5u1mHFUtXjKXwXPsqPlq4RKXq9aQJMtdBCW0ivRnBHYsKa3MI+rREV9+A7cenPTdZyrRHmfs=
MIME-Version: 1.0
In-Reply-To: <2587c245-1d02-22a2-d24b-90b498183fc9@synopsys.com>
References: <20180501210130.GA47709@beast> <2587c245-1d02-22a2-d24b-90b498183fc9@synopsys.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 05:36:08 -0700
X-Google-Sender-Auth: GIeNUnPnbeAuuH62exUqkzOTYvg
Message-ID: <CAGXu5jKrpEOrUVng7zrq0Em9DsAwKfidaqa2AKGrz3ZSXXLn1g@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Avoid VLA usage
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42CaJuu014154

On Wed, May 2, 2018 at 1:54 AM, Jose Abreu <Jose.Abreu@synopsys.com> wrote:
> Hi Kees,
>
> On 01-05-2018 22:01, Kees Cook wrote:
>> In the quest to remove all stack VLAs from the kernel[1], this switches
>> the "status" stack buffer to use the existing small (8) upper bound on
>> how many queues can be checked for DMA, and adds a sanity-check just to
>> make sure it doesn't operate under pathological conditions.
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_CA-2B55aFzCG-2DzNmZwX4A2FQpadafLfEzK6CC-3DqPXydAacU1RqZWA-40mail.gmail.com&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=TBD6a7UY2VbpPmV9LOW_eHAyg8uPq1ZPDhq93VROTVE&s=4fvOST1HhWmZ4lThQe-dHCJYEXNOwey00BCXOWm8tKo&e=
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>
> I rather prefer the variables declaration in reverse-tree order,
> but thats just a minor pick.

I can explicitly reorder the other variables, if you want?

> Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Thanks!

> PS: Is VLA warning switch in gcc already active? Because I didn't
> see this warning in my builds.

It is not. A bunch of people have been building with KCFLAGS=-Wvla to
find the VLAs and sending patches. Once we get rid of them all, we can
add the flag to the top-level Makefile.

-Kees

-- 
Kees Cook
Pixel Security
