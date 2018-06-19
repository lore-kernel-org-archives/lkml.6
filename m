Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28409C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D592083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyqgjHAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D592083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030433AbeFSRvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:51:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60348 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:51:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JHmauo071608
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=L1Y3aJMaADaRYY5Ax3UX3WVKcoiEsPEuWCNs0cTsN2E=;
 b=iyqgjHAEqNHsBSKQDEJMFu37TDOp6VvvOl2PHIwdKW1kxsfmUSoJqTUFRSpYQy5VUswE
 0YbbsLQckOiGI71ZzMaZDGRjijUHLm5Z1Jm5FpSpETaLZYWQiEzjYFqgaWYvpElwE+bY
 dBOasXh+SMk8KbxxPT1/UCQhvfvaiIPuV4Onv+JYiIIkBKd8WBgHyJdZoBhF6SZnGq6N
 U8WN7Rgpgnqz9++ag8fKRy6DVkv39rcK8P6FaFbvYyKOEim18/uZgs694/B/ZwYzsFIk
 YLxReGTr9F/mbFLauyV4AXFsUZCl0w5mTrLKYQxjsqJsG2hwcJs03EJI2bzEoCjeHIp/ gw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jmt01hase-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:51:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5JHpV6g024856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:51:31 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JHpVXg027812
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:51:31 GMT
Received: from mail-ot0-f179.google.com (/74.125.82.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 10:51:30 -0700
Received: by mail-ot0-f179.google.com with SMTP id d19-v6so634989oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:51:30 -0700 (PDT)
X-Gm-Message-State: APt69E08YmvERHzaJ5Q83PEC+VwT3ABRwOOv9SucfaEgR2LfG40k0/QN
        6BYYShn4CBJnnIT/ASxuB9ECLdyVFOqlSMQ2FUU=
X-Google-Smtp-Source: ADUXVKIlrobkXmdvwZWIrCq48VpNr2UV0BhPaQHa0SIwNDuRt/O9OlW832Ru9m/38/NklZZMuMUS7MeLbQIgLj0t320=
X-Received: by 2002:a9d:4609:: with SMTP id y9-v6mr10048311ote.259.1529430690299;
 Tue, 19 Jun 2018 10:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-2-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 19 Jun 2018 13:50:54 -0400
X-Gmail-Original-Message-ID: <CAGM2reYc7bgcqjqhvattvRMQefxpNXU3FkXJdC1XrGQVpRzsxQ@mail.gmail.com>
Message-ID: <CAGM2reYc7bgcqjqhvattvRMQefxpNXU3FkXJdC1XrGQVpRzsxQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] x86/tsc: remove tsc_disabled flag
To:     tglx@linutronix.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=507
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > tsc_disabled is set when notsc is passed as kernel parameter. The reason we
> > have notsc is to avoid timing problems on multi-socket systems.  We already
> > have a mechanism, however, to detect and resolve these issues by invoking
> > tsc unstable path. Thus, make notsc to behave the same as tsc=unstable.
>
> notsc also excludes TSC from being used at all, while with your change its
> suddenly used in sched_clock().

Hi Thomas,

Thank you for the review. I will reword the patch comment. Currently,
at the end it says: "Thus, make notsc to behave the same as
tsc=unstable." To emphasize this, I will change the patch title to
this:

x86/tsc: redefine notsc to behave as tsc=unstable

And in the comment I will mention that as a consequence of this change
tsc is going to be used by sched_clock() when notsc is provided.

Thank you,
Pavel
