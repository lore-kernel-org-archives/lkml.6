Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDXPnO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:43:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59640 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDXPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:43:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180424154310euoutp02831470712d70fcfbd8873bb96ee51361~oaZuesT5J3228032280euoutp02s
X-AuditID: cbfec7f5-b5fff700000028a9-8a-5adf5086eb96
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: adaplas@gmail.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: savage: Replace mdelay with usleep_range
 in savage_init_hw
Date: Tue, 24 Apr 2018 17:42:51 +0200
Message-ID: <7431484.AHk4tMfvN6@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <1523322359-27598-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djP87ptAfejDP5PFLX42f2FzWLdxIVM
        Fif6PrBaXN41h82BxWPnrLvsHp83yQUwRXHZpKTmZJalFunbJXBlHFp5nbFgG3vFjn+vGRsY
        G9m6GDk5JARMJD7cmwpkc3EICaxglJj+4QgzhPOFUeLn+xWsIFVCAp8ZJd52ACU4wDoOzHCA
        qFnOKLH5zh+o7g+MEqc27WQEaWATsJKY2L4KzBYRUJc4vWwX2CBmgSCJHYvmg9nCAvESM/6t
        BDuDRUBVoufxazaQBbwCmhIvWwVAwqICXhJb9rUzgdicAu4SX08eBBvJKyAocXLmExaIkfIS
        HZcbWUFukBD4ziYxo2c1E8RrLhIt83ug3hSWeHV8CzuELSNxenIPC0RDM6PEtx17mCESExgl
        9qwXgrCtJQ4fv8gKchAz0EHrd+lDhG0lzrxcxwYJCD6JG28FIW7gk5i0bTo0fHglOtqghqhJ
        bFi2gQ1ma9fOlVCLPCQauhcwTmBUmoXkm1lIvpmFsHcBI/MqRvHU0uLc9NRi47zUcr3ixNzi
        0rx0veT83E2MwFRx+t/xrzsY9/1JOsQowMGoxMP74/fdKCHWxLLiytxDjBIczEoivHvl7kUJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES543TqIsSEkhPLEnNTk0tSC2CyTJxcEo1MCYeC697P3Vz
        1bvaKTNX1NYuZxc2Z9KOO+E4h/Pr06c3C1Q1qvpNw2P7FHmdm7VYrI+KJ6skG+hI31U+ttFP
        lPnLG7nva0oX1iyzyviraHUtbMIpx60fbj4p7v0Te12YU3nj3Fe+wm2VC6fKMU2s/iv95dG9
        iFlNjhdtm6Ya6typubr0q+P090osxRmJhlrMRcWJACO/99ERAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Xd3GgPtRBgd6tCx+dn9hs1g3cSGT
        xYm+D6wWl3fNYXNg8dg56y67x+dNcgFMUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
        5rFWRqZK+nY2Kak5mWWpRfp2CXoZh1ZeZyzYxl6x499rxgbGRrYuRg4OCQETiQMzHLoYuTiE
        BJYySsxrXM8IEZeROL6+rIuRE8gUlvhzrYsNouYdo8THO21sIAk2ASuJie2rGEFsEQF1idPL
        drGC2MwCARJLHk9nAbGFBWIlHt08D1bPIqAq0fP4NdheXgFNiZetAiBhUQEviS372plAbE4B
        d4mvJw8yQuyawSjxYHEr2ExeAUGJkzOfsEDMl5fouNwItUtHYsHuT2wTGAVnISmbhaRsFpKy
        BYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKjYNuxn1t2MHa9Cz7EKMDBqMTD++P33Sgh
        1sSy4srcQ4wSHMxKIrx75e5FCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MELzSuINTQ3N
        LSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwrqn2qYn2+H3jedKrX8tjclbN
        6knU/1X60dxq8cnnrhNvrDS6Kd05WWA9782wwt4lZw9/0stVerjc4Jib0lKlWVr+0bum5XJ/
        nybPO7fhQO30mNwquYyNHxzkBdYUMXr+mCL+/M+7S/8eMAb+FTtZpL0lVJZ3ykOb1zciPzeE
        T50ecuj34sXxqUosxRmJhlrMRcWJAAZNvleYAgAA
X-CMS-MailID: 20180424154259eucas1p251ecfe14db1576598ea2d5b33472cb76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424154259eucas1p251ecfe14db1576598ea2d5b33472cb76
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410010607epcas4p2d1b0cb70e0676a6d6f215fe7e204e699
X-RootMTR: 20180410010607epcas4p2d1b0cb70e0676a6d6f215fe7e204e699
References: <CGME20180410010607epcas4p2d1b0cb70e0676a6d6f215fe7e204e699@epcas4p2.samsung.com>
        <1523322359-27598-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 09:05:59 AM Jia-Ju Bai wrote:
> savage_init_hw() is never called in atomic context.
> 
> The call chains ending up at savage_init_hw() are:
> [1] savage_init_hw() <- savagefb_probe()
> [2] savage_init_hw() <- savagefb_resume()
> 
> savagefb_probe() is only set as ".probe" in struct pci_driver.
> savagefb_resume) is only set as ".resume" in struct pci_driver.
> These functions are not called in atomic context.
> 
> Despite never getting called from atomic context, savage_init_hw()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
