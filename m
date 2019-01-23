Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52C720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAWMBE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:01:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:38279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfAWMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:01:03 -0500
Received: from [10.218.201.250] ([88.128.80.113]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKmP-1hHR0D3ONN-014T38; Wed, 23
 Jan 2019 13:00:49 +0100
Date:   Wed, 23 Jan 2019 13:00:46 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190123075327.27366-1-joro@8bytes.org>
References: <20190123075327.27366-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
CC:     Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <BEC8FBEB-A827-44ED-9E1D-F994EB23F58D@public-files.de>
X-Provags-ID: V03:K1:n4Uk6LKnBzOT9NQtJdthhQHlUOcihyYzLT0X2yU0m4cJFFVf/vv
 PuysTMXWcpxZkl2L5IsGbt+PEi0eFmNhpRrSkQ70LTJuse9+0+blbufKStsA6O86q+oQRbt
 gwEhtKul+bhToDF7oO72D/svni6KHSxeAJKEXmSWQIrQXjcVN1Lr80353eiyilU26KsAG1+
 BGXee8g57jdUbEjeuNZkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Ro7i/tBgNg=:d1WQ70O+hFw0rGBJ7HpDr/
 iZt7x7psH5sfyIFQA9FFMq8QkLnXuRxVxhO8T4O/wMfi9meharCIzHiX+Gi0Ecjmk4NpiQMfF
 Q9+iF+j420uV6Xo2nwoqIoB8MTw7PcucZwAn33emfP2QuSetCg69yKhC5sV7VRmzkJfEqwhYA
 ds4wW+ZbwH2i9a0Vqz6YXR9X5WMNMVVMgXEDJfUYWsXOYgR3j6pXoPqy6PgwQirEQxhTYVHAO
 GUb50r37mj5JLMcbP95PvjmXlxKz2/UMrHtFm1cUqhJRdTgGgIv41wm8j+T1oWusQGW39WN3E
 gRTgyVC1KedtFTRWXq4Mh30zgIfQ4p6PQklrlsWpNOpjLjko5l1T4b2I+xlCGsLfBIVQrTNNY
 EKnueH22u3QkyxRvLq//hnwx0M6STg0J47tkMkC/FrQQ6dT+gtlEhLHQIA6ggeFppIdcZ/hmQ
 Jqq5nugUOpLHNNBFvWR/eX/R2iyYmCsyzuG2zrT3uBMtu6JVAe1CrvtOv6LumLlOCF3/aPjyT
 c+KS2SHiVUnxQwo2TrjypI8iRUyCKwX2st/Neg3vodLRmtM24O0VR3bH4EpUI50OX/aRkibio
 gDZG2Xbk4r0sCXFXdw/0wic1+AgJI2WqmAU7gMELDo0M+vmWN9drjVNryRqtGr4yce9KQUfXK
 8C2f/2tU1SjXHLjJljRxKsJwBPnpN+M4zSkRoWwqB1RVkoLga9fbwugythIq9F2O7zr/q0guq
 4LsFScljzMQvYME/W5q7V4hHz5iPtvmFYsOr6ams7Ht9LnckxAPCy7VAUYW1JsiKhfq0IzlQy
 qYldDrnRFe8QCeGT0oqruR/nqAPYYMKYbeSAzKCGM1WKrQ3vmIdttjdXaVV2dy2ScJoWXV/nI
 vGCC6/hYSeNQLkXTWMvED6ebnIAMusDighmikiPoW6DqSNUqHDbzcfuKq+RIOAknivgzZD35a
 ANxkSoiri6zn1wtNJxZNiUz1j/s/2oSQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Frank Wunderlich <frank-w@public-files.de>
