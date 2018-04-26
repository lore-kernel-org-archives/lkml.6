Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755413AbeDZKaM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:30:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44370 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754883AbeDZKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:30:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180426103005epoutp04a8d2b96514e542e0feda15ce46c47e81~o9a8EDSJr3131831318epoutp04l
X-AuditID: b6c32a39-8bdff70000000fed-9f-5ae1aa2b365d
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <396f24f0-2b51-9218-8d15-fd77f49735e8@samsung.com>
Date: Thu, 26 Apr 2018 19:30:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmrq72qodRBidWc1is+3qbyaJj+RxW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWRz5389oMeP8PiaL1jtrmSzuPFnPanF8bbgDt8emVZ1s
        Hneu7WHz2Lyk3uPvrP0sHlv2f2b0+LxJLoAtKtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrSh
        oZGeoYG5npERkDaOtTIyBSpJSM049Go6e8F/kYqOZ8vYGhhf8XcxcnJICJhIdD1rZ+1i5OIQ
        EtjBKDHx+kZmCOcTo8Si6VfZIJxvjBIHXj8GKuMAa9n6TgGkW0hgL6PEl3MhEDWvGSUOd+1k
        B6kRBqr5+UocpEZEwF/i66pWsKHMAieZJI7+Oc8GkmAT0JHY/u04E4jNK2AnMefDOhYQm0VA
        VWJK6ySwuKhAmMTK2xehagQlTs58AlbDKeAk8fPqe2YQm1lAXOLWk/lMELa8xPa3c8CWSQi0
        s0u8f7iAEeJPF4nvkx6wQtjCEq+Ob2GHsKUkXva3QdntjBJnZwtDNE9hlFgxo5sJImEs8Wxh
        FxPIZ8wCmhLrd+lDhG0l3lz4ygixmE/i3dceaADxSnS0CUGUqEhcev2SCWbV3Sf/oU7wkDgx
        4QTLBEalWUhem4XknVlI3pmFsHgBI8sqRrHUguLc9NRiwwJTveLE3OLSvHS95PzcTYzgJKtl
        uYPx2DmfQ4wCHIxKPLwBCx9ECbEmlhVX5h5ilOBgVhLhjW99GCXEm5JYWZValB9fVJqTWnyI
        0RQY8hOZpUST84EZIK8k3tDUyNjY2MLE0MzU0FBJnPepz5koIYH0xJLU7NTUgtQimD4mDk6p
        BsZFPOvUT8YevbhRy+vJnjmTv800vyW1z23FidMXLsXJRxxqYvcp6Z0vyfmi+danHYxZZ3dM
        SJsstSt2hUyC36/7s2R5+IrPiuuXdHYpqNbmzZgdIC2Q9fPDume7jn4Ifdm8UPbtkqhHu+Wb
        rMJ9DQMCnU8m2M6+VhYzY+NGVfUHPzT9vS4vXVOgxFKckWioxVxUnAgAWpUUKcgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnK7WqodRBo9nqVus+3qbyaJj+RxW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWRz5389oMeP8PiaL1jtrmSzuPFnPanF8bbgDt8emVZ1s
        Hneu7WHz2Lyk3uPvrP0sHlv2f2b0+LxJLoAtissmJTUnsyy1SN8ugSvj0Kvp7AX/RSo6ni1j
        a2B8xd/FyMEhIWAisfWdQhcjF4eQwG5GiXldnSxdjJxAcSmJz0+nskHUCEscPlwMEhYSeMko
        8eeMPUhYGKj15ytxkLCIgK/ErXkLmEDGMAucZJLoX/eAGWLmVEaJm3f3g81kE9CR2P7tOBOI
        zStgJzHnwzqwOIuAqsSU1klgcVGBMImrZ+ewQdQISpyc+QSshlPASeLn1ffMIDazgLrEn3mX
        oGxxiVtP5jNB2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5x
        Ym5xaV66XnJ+7iZGcIRpae1gPHEi/hCjAAejEg9vwMIHUUKsiWXFlbmHGCU4mJVEeONbH0YJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYLS5mvvBJMs2
        /ZuvuWWlwoOv5hpvHxz19Mpfc9U50ux4dXDBI24LYZP3h1XU39zf8d/rydS+IxYvI01Pb3iv
        wNSxvHL67N7DB4J5fZsrNM79XnnprNZaUbHbGwtiPnPz3jicxCJ24wLb+us8vlXzw7rd7jF/
        vlOrmv5x9U3Xad8PHr5x3GbXmiYlluKMREMt5qLiRADAYu86rAIAAA==
X-CMS-MailID: 20180426103002epcas1p4eb6d3125ee847acad31b0313ad2186e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180426103002epcas1p4eb6d3125ee847acad31b0313ad2186e7
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180417121325epcas2p319c672feee4203d8b90131da461f4bd6
X-RootMTR: 20180417121325epcas2p319c672feee4203d8b90131da461f4bd6
References: <CGME20180417121325epcas2p319c672feee4203d8b90131da461f4bd6@epcas2p3.samsung.com>
        <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/17/2018 09:11 PM, Eugeniy Paltsev wrote:
> This series consists of two patches:
> 1. revert removal of previously existed "pseudo-multislot" support.
>  * Revert "mmc: dw_mmc: remove the deprecated "num-slots""
>  * Revert "mmc: dw_mmc: fix the wrong condition check of getting num-slots from DT"
>  * Revert "mmc: dw_mmc: remove the unnecessary slot variable"
>  * Revert "mmc: dw_mmc: update kernel-doc comments for dw_mci"
>  * Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
>  * Revert "mmc: dw_mmc: remove the 'id' arguments about functions relevant to slot"
>  * Revert "mmc: dw_mmc: change the array of slots"
>  * Revert "mmc: dw_mmc: remove the loop about finding slots"
>  * Revert "mmc: dw_mmc: deprecated the "num-slots" property"
> 
> 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
>  * Add missing slot switch to __dw_mci_start_request() function.
>  * Refactor set_ios function:
>    a) Calculate common clock which is
>       suitable for all slots instead of directly use clock value
>       provided by mmc core. We calculate common clock as the minimum
>       among each used slot clocks. This clock is calculated in
>       dw_mci_calc_common_clock() function which is called
>       from set_ios()
>    b) Disable clock only if no other slots are ON.
>    c) Setup clock directly in set_ios() only if no other slots
>       are ON. Otherwise adjust clock in __dw_mci_start_request()
>       function before slot switch.
>    d) Move timings and bus_width setup to separate funcions.
>  * Use timing field in each slot structure instead of common field in
>    host structure.
>  * Add locks to serialize access to registers.

Sorry for late. :(
Well, I will read the other comments..and reply soon. 

Best Regards,
Jaehoon Chung

> 
> NOTE: this patch is based off of v4.17-rc1
> 
> NOTE: as of today I tested this changes (in singleslot and multislot
>    modes) only on Synopsys HSDK board. But I will get ODROID-XU4 board
>    (with Exynos5422 which has DW MMC controller) the next week
>    so I will test it on this board too to catch any regressions.
> 
> Eugeniy Paltsev (2):
>   dw_mmc: revert removal multislot support
>   dw_mmc: add multislot support
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   5 +
>  drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
>  drivers/mmc/host/dw_mmc-pci.c                      |   1 +
>  drivers/mmc/host/dw_mmc.c                          | 486 +++++++++++++++------
>  drivers/mmc/host/dw_mmc.h                          |  35 +-
>  5 files changed, 387 insertions(+), 144 deletions(-)
> 
