Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362952089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hy6ZGdTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362952089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeJAQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:51:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55942 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbeJAQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:51:16 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181001101410epoutp01152f411ad9b4d19bac07c375da4a2645~ZdIJP28zq2631326313epoutp01L;
        Mon,  1 Oct 2018 10:14:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181001101410epoutp01152f411ad9b4d19bac07c375da4a2645~ZdIJP28zq2631326313epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538388850;
        bh=W6ACkiNK3YWsPs0d8lQO2iwwtjM5egaRp3TS7sV08uQ=;
        h=Date:From:To:Cc:Subject:References:From;
        b=hy6ZGdTpeBr2sctW6tk+U7IdOsBzdhYPJ2IyYid6gHCoMcKxdRTrJlJEkj1cUOF7N
         94SgVbVpJnpsOeT/mvBbOm89xl2CwnJL1Rjde1oV/MexilH7ZKuEsrHXW/SR3OB9vN
         agmJceX6EBQlcTh0ZpCm7UA1+9grk8BsxqlEhboo=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181001101407epcas1p219f23b863e522c15f280cf02356021d7~ZdIGVtHTG0922809228epcas1p2e;
        Mon,  1 Oct 2018 10:14:07 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.55.04015.F63F1BB5; Mon,  1 Oct 2018 19:14:07 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181001101407epcas2p133c98fcd05385608a2a5d2dca859f6cb~ZdIGBA-oS1884518845epcas2p1y;
        Mon,  1 Oct 2018 10:14:07 +0000 (GMT)
X-AuditID: b6c32a45-6a9ff70000000faf-af-5bb1f36fb978
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id AC.2A.03633.F63F1BB5; Mon,  1 Oct
        2018 19:14:07 +0900 (KST)
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PFX005W60FIIV30@mmp2.samsung.com>; Mon, 01 Oct 2018 19:14:07 +0900 (KST)
Message-id: <5BB1F36E.9090804@samsung.com>
Date:   Mon, 01 Oct 2018 19:14:06 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
MIME-version: 1.0
To:     gregkh@linuxfoundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Iuy1nOywrOyasCAoc2Ftc3VuZy5jb20pIg==?= 
        <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for v4.20
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmqW7+543RBl9vKVpMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2Rl9t8oKvvFXHD5zl7mB
        sYG3i5GTQ0LAROLv0fksXYxcHEICOxgl+nYtZAJJCAl8Z5TYMVUKpuhS0zaoog2MEvt+TmCG
        cO4ySrx+NA2sg1dAS2LX78uMIDaLgKrExT/TweJsQPH9L26wgdj8AooSV388BqsRFYiQ2Dn/
        GztEr6DEj8n3WEBsEQE5iSe3/4AtYBZoYJL4cmkCWLOwgKbEys7rYEXMQPaLL5OgbHmJzWve
        gjVICCxhk2g51AO0mQPIcZHYejIM4gVhiVfHt7BD2NISz1ZtZISob2eU+PKimRXCmcAo8eHU
        ZiaIKmOJZwu7mCA28El0HP7LDjGUV6KjTQiixENi6vWb7JDwipW4unM10wRGmVlIHpqF5NZZ
        SG5dwMi8ilEstaA4Nz212KjAEDnKNjGCE5aW6w7GGed8DjEKcDAq8fAGHFofLcSaWFZcmXuI
        UYKDWUmEN+jKhmgh3pTEyqrUovz4otKc1OJDjKbAwJ/ILCWanA9Mpnkl8YamRsbGxham5pbG
        BpZK4ryPpOdGCwmkJ5akZqemFqQWwfQxcXBKNTCKBXQ7tepFCJaur27s/XtMn3PXnuq23Vef
        rTgVJXxvycn6jPsprB6aF1uveXVXft8Ve+Xb1ifLYqpjDdt+/785c272fumlS15qL9IN4TL+
        9u8741TfZ/LGX160LC3YlWnu8Gr6hTfnn3P+aVScyHv0y/yTUd1PHA7duHZw0aONjs/Su7fq
        6ChfVmIpzkg01GIuKk4EAF1mQrBuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jQd38zxujDX5t5LKYeOMKi8X1L89Z
        LZoXr2ezuLxrDpvF7cYVbA6sHptWdbJ57J+7ht2jb8sqRo/Pm+QCWKK4bFJSczLLUov07RK4
        MvpulRV84684fOYucwNjA28XIyeHhICJxKWmbSxdjFwcQgLrGCXabv1mhXDuM0pMefOLFaSK
        V0BLYtfvy4wgNouAqsTFP9OZQGw2oPj+FzfYQGx+AUWJqz8eA9VwcIgKREh0n6iEaBWU+DH5
        HguILSIgJ/Hk9h9mkPnMAg1MEm9aF4P1CgtoSqzsvM4C0sssoC4xZUouSJhZQF5i85q3zBMY
        +WYhGTULoWoWkqoFjMyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECQ3PbYa3+HYyP
        l8QfYhTgYFTi4Q04tD5aiDWxrLgy9xCjBAezkghv0JUN0UK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYQ1NqNu2rXFmv8FBm5v2j16aZ/Py9ce9q/Yuv
        du96t5p5bvLab5evNXzL7txVtTbu7b+a/ee0evtyvMKuywub+/KfK/ffeeHvodmKK6u5o0vM
        u3revWkuWKcYtVXgU5zTlpTIs8+SPsqfjShfneMUt2vdhZcKTxqm5uw99fH6y/8LY9O6Gr4k
        RyixFGckGmoxFxUnAgCrcoMPSQIAAA==
X-CMS-MailID: 20181001101407epcas2p133c98fcd05385608a2a5d2dca859f6cb
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181001101407epcas2p133c98fcd05385608a2a5d2dca859f6cb
References: <CGME20181001101407epcas2p133c98fcd05385608a2a5d2dca859f6cb@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v4.20. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-4.20

for you to fetch changes up to 2e464ff0a9b1ab0fbb56e2ca8b1f5ff8c9f4e02f:

  extcon: int3496: Convert to use SPDX identifier (2018-08-28 11:21:15 +0900)

----------------------------------------------------------------
Update extcon for 4.20

Detailed description for this pull request:
1. Add SPDX license identifiers for Maxim and Intel extcon drivers
2. Clean-up extcon-intel-cht-wc.c driver without operation changes
3. Fix build warning of extcon core and use kasprintf instead of snprintf

----------------------------------------------------------------
Andy Shevchenko (7):
      extcon: Make static analyzer happy about union assignment
      extcon: Switch to use kasprintf() instead of open coded
      extcon: cht-wc: Return from default case to avoid warnings
      extcon: cht-wc: Fix definition names according to spec
      extcon: cht-wc: Correct USBID bit field handling
      extcon: cht-wc: Convert to use SPDX identifier
      extcon: int3496: Convert to use SPDX identifier

Krzysztof Kozlowski (1):
      extcon: maxim: Add SPDX license identifiers

 drivers/extcon/extcon-intel-cht-wc.c  | 60 +++++++++++++++++------------------
 drivers/extcon/extcon-intel-int3496.c | 12 ++-----
 drivers/extcon/extcon-max14577.c      | 24 ++++----------
 drivers/extcon/extcon-max77693.c      | 22 ++++---------
 drivers/extcon/extcon-max77843.c      | 19 ++++-------
 drivers/extcon/extcon-max8997.c       | 22 ++++---------
 drivers/extcon/extcon.c               | 15 +++------
 7 files changed, 61 insertions(+), 113 deletions(-)
