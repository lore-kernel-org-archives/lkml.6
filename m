Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54083C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4F207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IR5wlphb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B4F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeJWUyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:54:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWUye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:54:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NCIwgv155035;
        Tue, 23 Oct 2018 12:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=90MT7XtsCbinloaz7k9574doEX2AI8a8qv8DUTuV0Vw=;
 b=IR5wlphb4R7MBsUHEHdOeqLFO4bPc5N8P5BY4bc8KeM/C9McG2F7PXjLo0JOK7ZTZZYj
 q4rnhGIDkeHHqN3SYr88PXwFCe3/KxeFgApmU2eQC2hZWES8wYEjy4yrN7h6KSxTl5gq
 rICWfsFlxNg49K+QZxxvnDlqWGkptvqz6ERaSYR9ZSlX5XAqCuhXvjmPkAX9aak1RrpY
 8Z3t92wAyo8+jnno2YAPsQtKXwbNZMik/QxlP6dgJ4VXCvHd6M/bYHSqjUrmfnzYa374
 HIcfqzwHP2N5Pf6G5ozOnc9jecJalvZK6k5vYBmNaNY0OKB80BRuB3pTEj8BmupX8TZs zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qmskt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 12:31:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9NCV2iY017885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 12:31:02 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9NCV1VC005424;
        Tue, 23 Oct 2018 12:31:01 GMT
Received: from dhcp-10-172-157-159.no.oracle.com (/10.172.157.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 05:31:01 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [v2,0/2] net: if_arp: use define instead of hard-coded value
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
Date:   Tue, 23 Oct 2018 14:30:57 +0200
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "David S . Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1A93434-9496-4029-9A53-2D64D56CB846@oracle.com>
References: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
To:     netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.39)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=383
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 9 Oct 2018, at 16:27, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
> Struct arpreq contains the name of the device. All other places in the
> kernel, the define IFNAMSIZ is used to designate its size. But in
> if_arp.h, a literal constant is used.
>=20
> Fixed by explicitly including uapi/linu/if.h, where IFNAMSIZ is =
defined.
>=20
> The series also fixes some incorrect indents.
>=20
>=20
> v1 -> v2:
>   * Include uapi/linux/if.h from if_arp.h
>   * Added Stephen's t-b
>=20
> H=C3=A5kon Bugge (2):
>  net: if_arp: Fix incorrect indents
>  net: if_arp: use define instead of hard-coded value
>=20
> include/uapi/linux/if_arp.h | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
> ---
> 2.14.3

Just a friendly reminder.


Thxs, H=C3=A5kon


>=20
>=20
> =46rom a36b99413ea5beca1539f4faf065f33c7c19e6a5 Mon Sep 17 00:00:00 =
2001
> From: =3D?UTF-8?q?H=3DC3=3DA5kon=3D20Bugge?=3D =
<Haakon.Bugge@oracle.com>
> Date: Fri, 21 Sep 2018 11:28:36 +0200
> Subject: [PATCH 0/2]
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Struct arpreq contains the name of the device. All other places in the
> kernel, the define IFNAMSIZ is used to designate its size. But in
> if_arp.h, a literal constant is used.
>=20
> As it could be good reasons to use constants instead of the defines in
> include files under uapi, it seems to be OK to use the define here,
> without opening a can of worms in user-land.
>=20
> This because if_arp.h includes netdevice.h, which also uses
> IFNAMSIZ. For the distros I have checked, this also holds true for the
> use-land side.
>=20
> The series also fixes some incorrect indents.
>=20
> H=C3=A5kon Bugge (2):
>  net: if_arp: Fix incorrect indents
>  net: if_arp: use define instead of hard-coded value
>=20
> include/uapi/linux/if_arp.h | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> --
> 2.14.3

