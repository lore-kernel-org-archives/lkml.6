Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE4BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6849F20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c8KXapT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6849F20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeJXA4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:56:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53460 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:56:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NGSU3K055577;
        Tue, 23 Oct 2018 16:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=McY+dQyCqzEx4oPTIYKh+PHxEFAxeTuksHAfj1XF3pI=;
 b=c8KXapT8lZvGpLYhQtsTw3gR2KlHYPbinlX3R0ePu39LY9+TXikXRZEHgAwATge54p3t
 ZTbeYx+KvOVkdBeChs2dPAzL1aOU68skd5r9g8cW3OygZaZ1koEm1vUdkUn/KrYijvmW
 iLJv4Ozcnz8TreiI3w9ooFZl3mOPhMkB0x9g2qMo9jycqPd9jScGy6ZbLQaMn350EotW
 2MzCZMpG8+HC3JDCPYqsfJiqBh0nBp40w78neJzWoiSLFhEnZiFNRcX1sJ0Kqhvv4h6Y
 xPdbvyzNFZj5YN/T47sKvw01HVqPdfqTDAlqxi3GiOGrO0qhf6TDLWdfp9rvm/rFmDRc 4A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n7vapxgdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 16:31:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9NGVfWc015553
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 16:31:42 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NGVf20003146;
        Tue, 23 Oct 2018 16:31:41 GMT
Received: from dhcp-10-172-157-159.no.oracle.com (/10.172.157.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 09:31:40 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [v2,0/2] net: if_arp: use define instead of hard-coded value
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20181023.091115.1241170918401068592.davem@davemloft.net>
Date:   Tue, 23 Oct 2018 18:31:37 +0200
Cc:     netdev@vger.kernel.org, stephen@networkplumber.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BA8702C-06CA-4855-82CA-E3389252183F@oracle.com>
References: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
 <A1A93434-9496-4029-9A53-2D64D56CB846@oracle.com>
 <20181023.091115.1241170918401068592.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3445.100.39)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=370
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23 Oct 2018, at 18:11, David Miller <davem@davemloft.net> wrote:
>=20
> From: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> Date: Tue, 23 Oct 2018 14:30:57 +0200
>=20
>> Just a friendly reminder.
>=20
> Reminder for what?
>=20
> Your patch was applied to the net-next tree right after it was posted,
> what more do you want?

Oh, my bad then. Was expecting review comments or an "Applied, thanks". =
Will check the respective tree next time. No need for the v2 then I =
assume.


Thxs, H=C3=A5kon

