Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDXPsY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:48:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47081 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDXPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:48:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180424154820euoutp016ec79159105ed0204b9c029330c7d4c6~oaeOuYknN1804018040euoutp01U
X-AuditID: cbfec7f5-b5fff700000028a9-b1-5adf51c062ca
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: paulus@samba.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: aty: aty128fb: Replace mdelay with msleep
 in aty128_set_suspend
Date: Tue, 24 Apr 2018 17:48:05 +0200
Message-ID: <12527186.HoBsF7gLxN@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <1523324435-28719-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned0DgfejDPb9ZbFYN3Ehk8WJvg+s
        Fpd3zWGzWHNkMbsDi8fOWXfZPebu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj4IJnzAXXOCrW
        Nj5nbmCczN7FyMkhIWAi8fbKX1YQW0hgBaPEuedhXYxcQPYXRonGU3vYIJzPjBIXXi5ig+n4
        8f88VGI5o8TEWcfZIZwPjBLHG2eBzWUTsJKY2L6KEcQWEVCXOL1sF9AODg5mgUCJWWvBwsIC
        KRJrpu5iBrFZBFQlut61s4DYvAJaEgc3PgQbIyrgJbFlXzsTiM0p4C7RP7GLFaJGUOLkzCdg
        9cwC8hIdlxtZQW6QEPjNJvFm7xOo31wkNu55B2ULS7w6vgXKlpH4v3M+E0RDM6PEtx17mCES
        Exgl9qwXgrCtJQ4fvwh1tKbE+l36IKaEgK3Eo1cpECafxI23ghAn8ElM2jadGSLMK9HRBjVD
        TWLDsg1sMEu7dq6E2uMh8ezTS5YJjEqzkDwzC8kzsxDWLmBkXsUonlpanJueWmycl1quV5yY
        W1yal66XnJ+7iRGYNE7/O/51B+O+P0mHGAU4GJV4eH/8vhslxJpYVlyZe4hRgoNZSYR3r9y9
        KCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbGOdyputmi
        R2Mv90w55L8g0mY+a8XB/amtNpsZt0/NrE0/NcW1T25BX2DGmYboWcsigwy2PWJonllz9r6M
        9CXzu8zbn+3/wJCTpKZ/OqX374PFr/Yc8BNY6VBg0Pvny1KxSKv52hxey1wbjWMECuc4GHQK
        2KvMvs3DvDb23uusFQl/37DoXYpQYinOSDTUYi4qTgQAG/Sr2xYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd3dgfejDE5tUbZYN3Ehk8WJvg+s
        Fpd3zWGzWHNkMbsDi8fOWXfZPebu6mP0+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4IJnzAXXOCrWNj5nbmCczN7FyMkhIWAi8eP/
        eTYQW0hgKaPEiisRXYwcQHEZiePryyBKhCX+XOsCKuECKnnHKNHWt5IJJMEmYCUxsX0VI4gt
        IqAucXrZLlYQm1nAX2L/7UksILawQJLEr9UdYPNZBFQlut61g8V5BbQkDm58CHaDqICXxJZ9
        7WAzOQXcJfondrFCLJvBKHH/0gZGiAZBiZMzn7BALJCX6LjcCLVMR2LB7k9sExgFZyEpm4Wk
        bBaSsgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI2LbsZ+bdzBe2hh8iFGAg1GJh/fH
        77tRQqyJZcWVuYcYJTiYlUR498rdixLiTUmsrEotyo8vKs1JLT7EaAr03URmKdHkfGC05pXE
        G5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYNS8EyrLPDHn2lvbfPFn
        K9NtOlqvfwwNi0t6KLEkQPMax75sz9bNi69KJPu+qrXTu7Yv58N17ptdgY2yPRv6WX09ry72
        P9Qz121+j+lNL701PxLv3Tq3SkB+6hnh6ydVKyff9jlyrbn6oq/EfwZFv13Wrhbi56NPVjIL
        iimG7X6T2Wx/fREPuxJLcUaioRZzUXEiAHlC76WeAgAA
X-CMS-MailID: 20180424154813eucas1p21bb86b9ba63d75274cc827d93bc41a3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424154813eucas1p21bb86b9ba63d75274cc827d93bc41a3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410014047epcas1p28c608903eaf0d74930dfded2f82297e6
X-RootMTR: 20180410014047epcas1p28c608903eaf0d74930dfded2f82297e6
References: <CGME20180410014047epcas1p28c608903eaf0d74930dfded2f82297e6@epcas1p2.samsung.com>
        <1523324435-28719-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 09:40:35 AM Jia-Ju Bai wrote:
> aty128_set_suspend() is never called in atomic context.
> 
> The call chains ending up at aty128_set_suspend() are:
> [1] aty128_set_suspend() <- aty128_pci_suspend()
> [2] aty128_set_suspend() <- aty128_do_resume() <- aty128_pci_resume()
> [3] aty128_set_suspend() <- aty128_do_resume() <- aty128_early_resume()
> 
> aty128_pci_suspend() is set as ".suspend" in struct pci_driver.
> aty128_pci_resume() is set as ".resume" in struct pci_driver.
> aty128_early_resume() is never called.
> These functions are not called in atomic context.
> 
> Despite never getting called from atomic context, aty128_set_suspend()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() to
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
