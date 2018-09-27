Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90530C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B97A21570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p78YxPGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B97A21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeI0IqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:46:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52044 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeI0IqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:46:02 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180927023003epoutp04820b75dd210b70237243ad74bd80d322~YINxgQfQr1919219192epoutp04Z
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180927023003epoutp04820b75dd210b70237243ad74bd80d322~YINxgQfQr1919219192epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538015403;
        bh=za60Zgc4i8rWpm9TmFc5Xwo1Cgu6xOcLbE0wQNh3qUE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=p78YxPGLhTwYLNH8hwFvLnTwULct6pDyzj5l97qSOaq7YsOr+EVKs+VQYL7mFYIfU
         QliaHZWWV4+Ws7najulPiChcu7+BNLnSccrXnt8+Xn5OqWObeZ7/sUysE3A1cNPeKe
         4kNvO+iBFDxrlH39Yj/gV9z/sQKlDD1yniiqXAjQ=
Received: from epcpmgr01 (u28.gpu120.samsung.co.kr [203.254.230.28]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180927023003epcas1p215bc29cbab333035f418368676847bf2~YINw-r7Ci0571505715epcas1p2j;
        Thu, 27 Sep 2018 02:30:03 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH] PM / devfreq: remove redundant null pointer check
 before kfree
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     zhong jiang <zhongjiang@huawei.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1537535923-46240-1-git-send-email-zhongjiang@huawei.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <529236451.01538015400755.JavaMail.epsvc@epcpmgr01>
Date:   Thu, 27 Sep 2018 11:25:36 +0900
X-CMS-MailID: 20180927022536epcms1p7377840ca08dabad3a7f4007630390b80
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20180921133110epcas4p3d2914c21c881e2dfb6a2e2d9708f7a43
References: <1537535923-46240-1-git-send-email-zhongjiang@huawei.com>
        <CGME20180921133110epcas4p3d2914c21c881e2dfb6a2e2d9708f7a43@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C2=A0
> kfree has taken the null pointer into account. hence it is safe
> to remove the redundant null pointer check before kfree.
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/devfreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1..c37021d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -675,8 +675,7 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>  =09device_unregister(&devfreq->dev);
>  =09devfreq =3D NULL;
>  err_dev:
> -=09if (devfreq)
> -=09=09kfree(devfreq);
> +=09kfree(devfreq);
>  err_out:
>  =09return ERR_PTR(err);
>  }
> --=20
> 1.7.12.4

=C2=A0
--
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Autonomous Machine Lab., AI Center,=C2=A0Samsung Research.
Cell: +82-10-6714-2858
