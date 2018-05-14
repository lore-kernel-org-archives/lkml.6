Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeENMu5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752985AbeENMuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:50:55 -0400
X-Google-Smtp-Source: AB8JxZqxPo44pLsLeq+d3K+tTnl186hoQGjiUU1qfDDpWalct/AcEAPp5Ju0OMsmD9l04WwRC/veyQK1W5JFT6Sf0gU=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc6Yj0+Z6zd-Gm-fYvfQB4rPPn0k6ED8bWScJ-tdZ=Ysw@mail.gmail.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
 <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com> <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
 <4c61c422-a036-8fec-1153-d612fe5df878@samsung.com> <CAJKOXPc6Yj0+Z6zd-Gm-fYvfQB4rPPn0k6ED8bWScJ-tdZ=Ysw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 May 2018 14:50:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeNJtmU2+8CdMRwXignMTetn=LScdcMspfkP3MVmTSHrg@mail.gmail.com>
Message-ID: <CAJKOXPeNJtmU2+8CdMRwXignMTetn=LScdcMspfkP3MVmTSHrg@mail.gmail.com>
Subject: Re: [FAIL bisect] Sound card probe error
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 2:45 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, May 14, 2018 at 2:40 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 05/14/2018 02:29 PM, Krzysztof Kozlowski wrote:
>>> Ah, I missed these messages because I was looking at err dmesg level
>>> (and for some reason these are warn). Anyway do you have any thoughts
>>> how is it connected with missing Odroid XU3 sound card and max98090
>>> codec?
>>
>> One reason is that the DRM driver registers an ASoC codec object which
>> is required for the sound card registration to complete. But I wonder
>> why there is no any error messages related to this.
>
> Thanks Marek and Sylwester. Another point is that probably OOPS later
> should not happen...

Separate topic (trim Cc list):

... and this means that disabling Exynos DRM causes lack of Audio. I
tried it now and indeed without DRM there is no audio again. I think
it is not nice... There are not many such use cases but there are
(playing audio from console/ssh with a headless board).\

Best regards,
Krzysztof
