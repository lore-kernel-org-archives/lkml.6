Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A511EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610E520856
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hW2HQCmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610E520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGQPKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:10:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbeGQPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:10:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HEXTJ9059436;
        Tue, 17 Jul 2018 14:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=kb7VZG9kHN9YTsQxh3Q1PD4iBlaLxkVhGu+IzWVeecY=;
 b=hW2HQCmgpNq8OR0amRUNG+Lfez0OvLmTl8kuuMZsgCaOz7pfcSs1FTS4V9CuM/PejPCQ
 1u0qsTLZe21139a0jf69eBUM/rKhfq9/wDF2pIeJeQYFaIF9bzDc9juKqimTzwEha4JT
 TTvVCpqdepX3UFjHo6EFGqoHlRS4tFtDmbZYzyMgBtAN836+dz1AW52/Axo+ZIWw4Rzy
 N5J97mB7CcFPnsZa0DDDMRAK4tFThwC391yXcuHSP4UdX+QviST/3pEoFwqhTTxn6faG
 EIorA1hjGe4PcvOksxhARxubQ+rDnE7M6zswNlyas0kW6E4VaWRCUFpdnts73Sl+cRtM 8w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2k7a3t9122-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:37:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HEb4Za013610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:37:04 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HEb3xO011177;
        Tue, 17 Jul 2018 14:37:03 GMT
Received: from mail-oi0-f52.google.com (/209.85.218.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 07:37:03 -0700
Received: by mail-oi0-f52.google.com with SMTP id y207-v6so2408637oie.13;
        Tue, 17 Jul 2018 07:37:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlF80K7wJLH0oqnzosshmsVrXZtucTRjBgxshthL4f7g7l0mbSae
        jeJrwXPvyJ3jaYFxu9866gWMEWGq+YrvJ14P1R4=
X-Google-Smtp-Source: AAOMgpfKA5tktxdsU4IGxad/NaJ1FlX7Wb13iw+Eq6ajro0V2wuihEO3q2qXBIe7MJPeAqdPNWLSfItBuK0AKUNN310=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr2077710oiy.191.1531838223222;
 Tue, 17 Jul 2018 07:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com> <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
 <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
 <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com> <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
 <4f6b295d-c88b-2204-0557-ae85ed443a31@cn.fujitsu.com>
In-Reply-To: <4f6b295d-c88b-2204-0557-ae85ed443a31@cn.fujitsu.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 17 Jul 2018 10:36:27 -0400
X-Gmail-Original-Message-ID: <CAGM2reZJHRXuWNaLpJRtkbx0V4FJD78dvCNAsMg8X4cF2qeQuw@mail.gmail.com>
Message-ID: <CAGM2reZJHRXuWNaLpJRtkbx0V4FJD78dvCNAsMg8X4cF2qeQuw@mail.gmail.com>
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
To:     douly.fnst@cn.fujitsu.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=593
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Oops, yes, my mistake. I will test the patchset with Thomas's kvm patch
> for you.

Thank you Dou. Please wait for updated series before you test it. I
will include patches from Thomas in the updated series.

Thank you,
Pavel
