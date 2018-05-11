Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEKP5P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:57:15 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:53246 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:57:12 -0400
X-Google-Smtp-Source: AB8JxZpFFqpMm7PBvwSnQT71PdDvUZ7oB6VektFEoas4PR4TVW+EUq1hK7Lck3hFto7VY6fzRz6qF2/NTiN3Benhyv0=
MIME-Version: 1.0
In-Reply-To: <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
References: <CGME20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1@eucas1p1.samsung.com>
 <2484918.HKVQc3yJkt@bear> <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
 <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
 <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com> <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com> <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
 <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Fri, 11 May 2018 11:57:11 -0400
Message-ID: <CAJz5OpfqGW73=XpJww-qOTTV2H0G+sY8UHt7c6L6k8aiAyAu-g@mail.gmail.com>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 8:57 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Okay, so you don't have any evidence that DMA transfers done in single
> reads/writes is broken with the current cmd_pause implementation.

I think the easiest way to test this empirically would be to just hack
dmatest to do a bunch of mem-to-mem transfers which it pauses and
checks the copied data is consistent with the reported residue.  Also,
it would need to check the source/destination address registers in the
pl330 for evidence of bytes read but not written.  And the pl330.c
driver would need to be fixed to not ignore the requested maxburst
when doing mem-to-mem transfers.
