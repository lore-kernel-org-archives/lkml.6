Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDXPvp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:51:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47867 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeDXPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:51:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180424155139euoutp01a9234bb35c26e7879294f0eeeadc3ac1~oahIYBDvj1921819218euoutp01v
X-AuditID: cbfec7f5-f95739c0000028a9-c1-5adf52853c5b
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: benh@kernel.crashing.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: aty: radeon_pm: Replace mdelay with
 msleep in radeonfb_pci_suspend
Date: Tue, 24 Apr 2018 17:51:23 +0200
Message-ID: <7290517.RXRYeCv1u3@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <1523324840-28830-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd3WoPtRBr1bjCzWTVzIZPGhqZXZ
        4kTfB1aLy7vmsDmweOycdZfdo+dNC6vH501yAcxRXDYpqTmZZalF+nYJXBm7pn1kLGhkqzi+
        bR5zA+Nbli5GTg4JAROJmzceMHUxcnEICaxglNjX+Y4RwvnCKLFy5yxWCOczo8SKjweYYFqm
        HutigUgsZ5S40vuQDcL5wCixZ/lnNpAqNgEriYntqxhBbBEBdYnTy3axgtjMApES0+++BIsL
        C6RLNB/6DRZnEVCVeHRgG5jNK6Ap0ba0C8wWFfCS2LKvHWwzp4C7xJ3n11kgagQlTs58wgIx
        U16i43Ij2KkSAr/ZJFY3fWWDONVFYuXNFVC2sMSr41vYIWwZif875zNBNDQzSnzbsYcZIjEB
        6IX1QhC2tcTh4xeBpnIAbdCUWL9LH8SUELCV2LmSH8Lkk7jxVhDiBD6JSdumM0OEeSU62qBm
        qElsWLaBDWZp186VUHs8JFrPbGWcwKg0C8kzs5A8Mwth7QJG5lWM4qmlxbnpqcXGeanlesWJ
        ucWleel6yfm5mxiBieP0v+NfdzDu+5N0iFGAg1GJh/fH77tRQqyJZcWVuYcYJTiYlUR498rd
        ixLiTUmsrEotyo8vKs1JLT7EKM3BoiTOG6dRFyUkkJ5YkpqdmlqQWgSTZeLglGpgZPdy4jlS
        Z7CGWcD+0Ov6+7MlZA7bhkz6kRe1aBr3qS2LX91on+rJsGXKu3hd+e3bfjlOPX5y7+5o/rzm
        Da+muTY5/7rNvnNXo4ho/AetOgnbgNzkC/VFVSc3H6kvms3FvmXaTZNbvSksl/gTPJ2eNRmy
        GdqZcqi9umR48+8hvkN3Om1zSx16lViKMxINtZiLihMBY3A2+BgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Xd3GoPtRBk9+Clqsm7iQyeJDUyuz
        xYm+D6wWl3fNYXNg8dg56y67R8+bFlaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSM
        TCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ2TfvIWNDIVnF82zzmBsa3LF2MnBwSAiYSU491
        AdlcHEICSxkldpz9z9jFyAGUkJE4vr4MokZY4s+1LjaImneMEm/2HGMCSbAJWElMbF/FCGKL
        CKhLnF62ixXEZhYIlzh8rIkZxBYWSJX4u2wmmM0ioCrx6MA2sBpeAU2JtqVdYLaogJfEln3t
        YDM5Bdwl7jy/DnXQDEaJmQs3M0I0CEqcnPmEBWKBvETH5UaoZToSC3Z/YpvAKDgLSdksJGWz
        kJQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgT24793LyD8dLG4EOMAhyMSjy8P37f
        jRJiTSwrrsw9xCjBwawkwrtX7l6UEG9KYmVValF+fFFpTmrxIUZToO8mMkuJJucD4zWvJN7Q
        1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAMj841eyxT1Bgu7KC9pJaNl
        t3+wsxr+VtjGez44qrdHdzGH3WfdraueZltYKHSbq198H7VaX/T4784y3f9X/t4NULiz6K5U
        /DXlzXa2PXPaZ+5sMVD1Tny+lvW5MNPtjQf5SwTD3c7rcJlpv1z4xHL3yWMlR9zPqZsK/7/8
        ffGXefIMPw496bdUYinOSDTUYi4qTgQA9fPw958CAAA=
X-CMS-MailID: 20180424155131eucas1p14e13f5793d807ff47366308d250b9513
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424155131eucas1p14e13f5793d807ff47366308d250b9513
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410014725epcas1p2f9db790e2df6754f108048b00f399130
X-RootMTR: 20180410014725epcas1p2f9db790e2df6754f108048b00f399130
References: <CGME20180410014725epcas1p2f9db790e2df6754f108048b00f399130@epcas1p2.samsung.com>
        <1523324840-28830-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 09:47:20 AM Jia-Ju Bai wrote:
> radeonfb_pci_suspend() is never called in atomic context.
> 
> radeonfb_pci_suspend() is only set as ".suspend" in struct pci_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, radeonfb_pci_suspend()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() 
> and usleep_range() to avoid busy waiting.
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
