Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A0CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A5320878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0PdD/IT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A5320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLDJVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:21:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50780 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:21:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB49J3aH100707;
        Tue, 4 Dec 2018 09:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=bByOGUD+Vx0sbKYxDqhb5PoOLsg3yFzFSNLF3IJHqg4=;
 b=0PdD/IT3hQdil+80sqQyfvyLaE/MrSUAXCkBjlBnkj1RSxJSSXSL0FAE/qBmyGCN4bSg
 jA6hKBuaZX/Kg+WEdjW7LI9hzE3Cds7HXvlPAibxZo5TPSYDTDLvncDAqvwIPgZMPlGz
 KMOT0KY8Q0d+Rrw+HeWMl5h/QUei4dU0hFULDGDLgyQmUOlvbL2g44pQQ/Sfr50AvGqw
 CU4Cj/aa4wK/r2lLTq4jb0YN3di9HNBYKwGFApagINYdgZhhqUwu8SHVNM1Oc0MvGEWb
 ffCcdkQaz8U8rKl1lKl+EHeZFQtRO/aG9QicZiaK/ySNkU4aIzfQsr5kN8bYgLfUj154 iw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqtu5jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 09:21:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB49LBxD003190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 09:21:12 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB49LBSs020938;
        Tue, 4 Dec 2018 09:21:11 GMT
MIME-Version: 1.0
Message-ID: <723e6e0b-9469-4b11-9571-a65ef4f830f0@default>
Date:   Tue, 4 Dec 2018 09:21:11 +0000 (UTC)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <tglx@linutronix.de>, <mingo@kernel.org>, <fweisbec@gmail.com>
Cc:     <srinivas.eeda@oracle.com>, <joe.jin@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tick/broadcast: Remove redundant code in
 tick_check_new_device()
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

When cleanup my mailbox for free space, I see this patch is missed in upstr=
eam.
Checked code again, I think that code indeed could be removed safely.

So could anyone Ack or NAK it? Thanks very much.

Regards
Zhenzhong

----- zhenzhong.duan@oracle.com wrote:

> There is no way a timer used as broadcast clockevent device is also
> used as
> percpu tick clockevent device currently.
>=20
> -v2: remove meaningless description suggested by tglx
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  kernel/time/tick-common.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 49edc1c..9bcc866 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -320,13 +320,8 @@ void tick_check_new_device(struct
> clock_event_device *newdev)
> =20
>  =09/*
>  =09 * Replace the eventually existing device by the new
> -=09 * device. If the current device is the broadcast device, do
> -=09 * not give it back to the clockevents layer !
> +=09 * device.
>  =09 */
> -=09if (tick_is_broadcast_device(curdev)) {
> -=09=09clockevents_shutdown(curdev);
> -=09=09curdev =3D NULL;
> -=09}
>  =09clockevents_exchange_device(curdev, newdev);
>  =09tick_setup_device(td, newdev, cpu, cpumask_of(cpu));
>  =09if (newdev->features & CLOCK_EVT_FEAT_ONESHOT)
> --=20
> 1.7.3
