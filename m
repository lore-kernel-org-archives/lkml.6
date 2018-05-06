Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeEFK0o (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:26:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35455 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEFK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:26:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180506102638epoutp024507b93eab48a34799a8fb5c597193da~sB0xg42Qo0201502015epoutp02T
X-AuditID: b6c32a46-145ff70000001024-06-5aeed85da967
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net, alim.akhtar@samsung.com
Subject: [PATCH 0/4] Add required changes to ufshcd to support exynos ufs
 hci
Date: Sun, 06 May 2018 15:44:14 +0530
Message-id: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCmhW7sjXdRBoeO8Fk8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8mi1PXP7NZ3Fi8k81ix8IqixM/dzA7cHpc7utl8tg56y67x4NDm1k8
        rpxoYvX4+PQWi0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlvHv+iangPmfFpol3WRoYf7B3
        MXJySAiYSOzfOpe1i5GLQ0hgB6PEmg3vWSCc74wSex6vY4Wp6jk1lxEisYFRYlbjK2YI5wej
        RPedD2BVbALaEnenb2ECsUUEbCTO33zABFLELLCJUWLBxOVsIAlhAX+JOW2bmUFsFgFVib19
        E8AaeAXcJd5e/MYMsU5O4ua5Tii7h01i4hlbCNtF4vQjmBphiVfHt0A9IS3xbNVGRgg7W+LD
        8ZNQNTUSsy72skHY9hIHrsxhAbGZBfgkOg7/BerlAIrzSnS0CUGUeEj82rSdESLsKDFrvzRI
        WEggVuLmu7XsExglFzAyrGIUSy0ozk1PLTYqMNIrTswtLs1L10vOz93ECI5PLbcdjEvO+Rxi
        FOBgVOLhncDxLkqINbGsuDL3EKMEB7OSCG/geqAQb0piZVVqUX58UWlOavEhRmkOFiVx3gbf
        M1FCAumJJanZqakFqUUwWSYOTqkGxqNHtz6p8mbM4HxhKnlYj5NbKTzfTTP69aVdvSJKgVbH
        7hReKxF+fWnKK1b/zxX5S1WO3VYsmGT0SWTxYfW9r5Tu5jv1cUvNb5C8wnNer98jdIKlPsd8
        X8YFp2WauCa/Dw96rXWOj3fSrstGV8OXZU4LPvigYkLb66idbhec/6ybsVKrOOEOpxJLcUai
        oRZzUXEiAKbjJabLAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42I5/e+xoG7MjXdRBveea1o8mLeNzWLVxDyL
        y7vmsFl0X9/BZrH8+D8mi1PXP7NZ3Fi8k81ix8IqixM/dzA7cHpc7utl8tg56y67x4NDm1k8
        rpxoYvX4+PQWi0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlvHv+iangPmfFpol3WRoYf7B3
        MXJySAiYSPScmsvYxcjFISSwjlFi0/O3rBDOD0aJ5/tXs4BUsQloS9ydvoUJxBYRsJE4f/MB
        E0gRs8AmRonZT8+DFQkL+EpM/XUVbCyLgKrE3r4JYA28Au4Sby9+Y4ZYJydx81wn8wRGrgWM
        DKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQKDZ9thrf4djI+XxB9iFOBgVOLhncDx
        LkqINbGsuDL3EKMEB7OSCG/geqAQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZ
        qakFqUUwWSYOTqkGRlUVV8/OpM3Fdwz10rm+tbtev/QiQZF310bWqiR2bmud+V4x2opaeyb8
        LDv8/s3r2EneCmqrTHWUI75NumOzxPTuZs8tvglOV39NeX0k+Ottj5mZjHfKuXj2V9deK923
        yqQ4Jvbgw7cpYqcCdzTwG5vtmsS4M5ez/qLqzbNL672vVxQHTsuqU2Ipzkg01GIuKk4EANAw
        x5AaAgAA
X-CMS-MailID: 20180506102636epcas2p3432b71e5c867f6cfec16cf2a8c74b0e2
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180506102636epcas2p3432b71e5c867f6cfec16cf2a8c74b0e2
X-RootMTR: 20180506102636epcas2p3432b71e5c867f6cfec16cf2a8c74b0e2
References: <CGME20180506102636epcas2p3432b71e5c867f6cfec16cf2a8c74b0e2@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

These patches are part of a larger patch series [1] which attempts upstreaming
EXYNOS UFS driver support. There was not much activities after v5 of that
series. In between I saw there were other teams in Samsung tried upstreaming
the same, but that has not really gone anywhere.
I have taken this task again and here is another attempt to upstream exynos-ufs
driver support. I have divided the patches into two series, one which adds
required infra in the ufshcd core needed by exynos-ufs driver and other part
will have actual exynos-ufs driver. Splitting this has a advantage of less
reviewing over head.

I am floating these as a new patch set.

[1] https://www.spinics.net/lists/linux-scsi/msg90292.html

These patches are based on mainline v4.17-rc3.

Alim Akhtar (4):
  scsi: ufs: add quirk to fix mishandling utrlclr/utmrlclr
  scsi: ufs: add quirk not to allow reset of interrupt aggregation
  scsi: ufs: add quirk to enable host controller without hce
  scsi: ufs: make ufshcd_config_pwr_mode of non-static func

 drivers/scsi/ufs/ufshcd.c | 104 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/scsi/ufs/ufshcd.h |  18 ++++++++
 2 files changed, 114 insertions(+), 8 deletions(-)

-- 
2.7.4
