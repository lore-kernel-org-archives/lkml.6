Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeBIE34 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 23:29:56 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35076 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBIE3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 23:29:54 -0500
X-Google-Smtp-Source: AH8x226B4yvj5s/foaJN4Gh8kUOMOVUeAjtiHaGC/BD7IIXiaDa0nSS27xHDJsBiBq7q5PXh7NKkH9fd7uUzqoX4wR0=
MIME-Version: 1.0
In-Reply-To: <41824374-cdea-a3ef-0109-20565dbba43e@redhat.com>
References: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
 <20180208.153453.774785043965984772.davem@davemloft.net> <41824374-cdea-a3ef-0109-20565dbba43e@redhat.com>
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Fri, 9 Feb 2018 09:59:52 +0530
Message-ID: <CA+sq2Cdkycu2BXOfywMTksUNOJcUS6-NStOXk=WHSZ9sT7np4Q@mail.gmail.com>
Subject: Re: net: thunder: change q_len's type to handle max ring size
To: Dean Nelson <dnelson@redhat.com>
Cc: David Miller <davem@davemloft.net>, Vadim.Lomovtsev@cavium.com,
        Robert Richter <rric@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 3:27 AM, Dean Nelson <dnelson@redhat.com> wrote:
> On 02/08/2018 02:34 PM, David Miller wrote:
>>
>> From: Dean Nelson <dnelson@redhat.com>
>> Date:
>>
>>> The Cavium thunder nicvf driver supports rx/tx rings of up to 65536
>>> entries per.
>>> The number of entires are stored in the q_len member of struct
>>> q_desc_mem. The
>>> problem is that q_len being a u16, results in 65536 becoming 0.
>>>
>>> In getting pointers to descriptors in the rings, the driver uses q_len
>>> minus 1
>>> as a mask after incrementing the pointer, in order to go back to the
>>> beginning
>>> and not go past the end of the ring.
>>>
>>> With the q_len set to 0 the mask is no longer correct and the driver does
>>> go
>>> beyond the end of the ring, causing various ills. Usually the first thing
>>> that
>>> shows up is a "NETDEV WATCHDOG: enP2p1s0f1 (nicvf): transmit queue 7
>>> timed out"
>>> warning.
>>>
>>> This patch remedies the problem by changing q_len to a u32.
>>>
>>> Signed-off-by: Dean Nelson <dnelson@redhat.com>
>>
>>
>> Applied, thanks.
>
>
> Thank you!
>
>>
>> Another way to solve this could have been to encode that length
>> as "length - 1"
>
>
> True. I had pondered that, but felt that since changing q_len's type
> didn't add any length to the structure and that it was less impactful
> from a number-of-lines of code changed perspective, I'd opt for this
> route.
>
> Cavium, if you'd prefer this goes the route that Dave just mentioned,
> please let me know and I can make a new patch against what's been
> applied?

Thanks for fixing this and i think the current patch is fine.

Thanks,
Sunil.

>
> Thanks,
> Dean
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
