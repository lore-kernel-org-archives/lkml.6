Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9BAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA2C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XnqB5Z5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA2C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbeGSReT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:34:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeGSReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:34:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JGdL3V159007;
        Thu, 19 Jul 2018 16:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=QgWD6uaBfqchZxuaYHJUzK/cVDuKIOiMNXckq5gSxQY=;
 b=XnqB5Z5/jqvKLc8AkVKm/bRjR0MPtrzuDoe2VkZKXPRShqsdsfiWyYz8fKqf6PP5yEsK
 RV1rEqTBHTe93Tm7Wgs6ckeUYZ8iEeQCRlfonMkO8zfFrSllb44CNgwx62nzKFXjD9Fd
 sV1ZhC1DTzxdPG8lw3mOIgj5Yh09LODX9sjZ2hoJ7I9lPocfiTUdBiMn+VKPUFsx3yCH
 8wzTNKzGiHWe217QRDwux3KOpwmc10Nnig27PEuXJJdfA9bA7LFxJsoFb32H5GpSUTwH
 44EBG9TC4WgJij3GLj67SjDvhbRe2GoGAgfmFNiz4qqJCMF7P82ACSV8um4MQ2OlUggs 4A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k9yjx80fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 16:50:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JGoESY028075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 16:50:14 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JGoEbH009169;
        Thu, 19 Jul 2018 16:50:14 GMT
Received: from mail-oi0-f50.google.com (/209.85.218.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 16:50:14 +0000
Received: by mail-oi0-f50.google.com with SMTP id n84-v6so16177145oib.9;
        Thu, 19 Jul 2018 09:50:14 -0700 (PDT)
X-Gm-Message-State: AOUpUlGRoAga3pGP0gzV/OpScYvKubtAXSMKnbcNE3Fwu8qXL1/DMVcs
        0w99xJO4e6pCMSe1RPchYRWfcxY0Xhni97TDqlE=
X-Google-Smtp-Source: AAOMgpfMKi9AT8f54p77uyFGupQtNPM60mryif0SmfBpgO+DpPaTRvGFp3Y6nDgn7hpUCgbRx0rdoIOgbiPra6CQwv4=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr12408933oia.156.1532019013951;
 Thu, 19 Jul 2018 09:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
 <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com> <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 19 Jul 2018 12:49:37 -0400
X-Gmail-Original-Message-ID: <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
Message-ID: <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=419
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So create two functions. native_...early..() and native....(). The early
> one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
> with the late one which contains all of it.

Good idea. Actually, the late one will contain only hpet/pmtimer and I
will set it only if tsc frequency was not determined only.

Thank you,
Pavel
