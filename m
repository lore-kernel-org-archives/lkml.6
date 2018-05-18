Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeERJxe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:53:34 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26806 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeERJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:53:32 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w4I9rT3M007543
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AB8JxZqSmT3yl72U829z4WcKJw7rELoQscDXmDonIoIBby9UufprWFk9XZFcxFj17fHNBEVPJZz9qpXOkq6IpLbSGNI=
MIME-Version: 1.0
In-Reply-To: <20180518093131.7g5m4mu3mtrgb7so@gmail.com>
References: <20180518062553.kodjjrlrosrg7vfq@gmail.com> <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
 <20180518093131.7g5m4mu3mtrgb7so@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 18 May 2018 18:52:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYiKYzD11anXzCqjWaqeezHo4R1db+qAdCAAJLkvuf9A@mail.gmail.com>
Message-ID: <CAK7LNATYiKYzD11anXzCqjWaqeezHo4R1db+qAdCAAJLkvuf9A@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/tags.sh: don't parse `ls` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-18 18:31 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> On Fri, May 18, 2018 at 04:08:44PM +0900, Masahiro Yamada wrote:
>> I do not like hard-coding the file(s) in arch/.
>>
>> Don't you have an idea to list only directories?
>> 'find -type d' or 'ls -F' or something?
>
> How do you feel about the following?
>
>>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>>  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>>          ALLSOURCE_ARCHS="${SRCARCH}"
>>  elif [ "${ALLSOURCE_ARCHS}" = "all" ]; then
>>          ALLSOURCE_ARCHS="$(cd "${tree}arch/" && find . -maxdepth 1 -type d | paste -sd' ')"


Why is 'paste' necessary?


>>          ALLSOURCE_ARCHS="${ALLSOURCE_ARCHS//[.\/]}"
>>  fi
>
> If something like that if acceptable, I'll use that for the v4.
>
> --
> Cheers,
> Joey Pabalinas



-- 
Best Regards
Masahiro Yamada
