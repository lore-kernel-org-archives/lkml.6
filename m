Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeEVJKD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:10:03 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40004 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeEVJJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:09:47 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w4M99gvi010069
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AB8JxZqpRfhvF0K3fQk31uBoC1e4xwadAI8s/s/M/u4Q4oNlxKT8yDEkwHHg8iaG5XLO6SD4hrQ9rPdI8ISZ76kr42c=
MIME-Version: 1.0
In-Reply-To: <20180522090647.pmy7c4zwax4jlp7w@gmail.com>
References: <20180518115619.jqb4hqdym7fmrs2p@gmail.com> <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
 <20180522082117.p2b5jt5qtuwarqwo@gmail.com> <CAK7LNARgW-YdGbtT3sJt_UpE02CEAvE9csm8Oc2SoSZo71Bt8w@mail.gmail.com>
 <20180522090647.pmy7c4zwax4jlp7w@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 18:09:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATK3iUG4q7EAwt1Kynjp5Aihw144O=SveZe3fdzPbWp_g@mail.gmail.com>
Message-ID: <CAK7LNATK3iUG4q7EAwt1Kynjp5Aihw144O=SveZe3fdzPbWp_g@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-22 18:06 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> On Tue, May 22, 2018 at 05:41:48PM +0900, Masahiro Yamada wrote:
>> I see some new motivations for this patch now.
>>
>>   - The current code includes 'Kconfig' in ALLSOURCE_ARCHS,
>>     but it should not.
>>
>>   - Simplify the code, removing the find_all_archs().
>>
>>
>> If you are motivated for v5,
>> how about this?
>>
>>   - Remove the double-quotes from "${tree}arch/"
>>     (Because the rest parts of this script do not have double-quoting,
>>      I do not see point in adding it in this line only.)
>>
>>   - Update the git-log to not mention the hypothetical space things.
>
> Alright, that sounds reasonable. What do you think of:
>
>> ALLSOURCE_ARCHS=$(find ${tree}arch/ -mindepth 1 -maxdepth 1 -type d -printf '%f ')
>
> The double quotes surrounding the arguments have been removed to be more
> consistent with the other find commands in the script.
>
> The ' %f' was changed to '%f ' so that you don't get that weird leading
> space; I couldn't think of a way this could break anything but I wanted
> to be 100% sure instead of needing to make a v6, heh.


Fine with me.







-- 
Best Regards
Masahiro Yamada
