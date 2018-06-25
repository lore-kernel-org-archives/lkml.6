Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6832C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B31D25982
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LfrrOW1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B31D25982
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbeFYMqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:46:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeFYMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:46:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PChwuR160139;
        Mon, 25 Jun 2018 12:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=tzzuq4By/P4W12zUzNLO4UFnNZ0bm07RMOJOVNILpWQ=;
 b=LfrrOW1XBObYzEFJnYsnsLh7SWaLV71wjhDxD3Anas3Jxm1na+0T75efDzteP/blUHNc
 jcRTIXkkqHzBLPsmmYnzw3tFxfBJXYaV9iezUt7KG/1zxm+MWyApAK5IxdiMz40OO0po
 vNUiFqEGWY6MxoHAppWgp/4HB5naHZOy8QiOU2WVoK2srIF4BFUnfaNqMYIq1ofbUvUy
 jWlFlUquQt+2urFdWHsZ/VBvXuysHjQxHZ4vsLi/EZ/Wi48aSjkjVMRT+RFzNJz9WIkI
 wiFvn515UFo5afM/qTq33UG09oA0Mu/kqKmfehB2o71QS5nKbnHcGqVnlQHjNe2IXUkH xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jt8a7jgrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:46:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCkYoS026363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:46:34 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5PCkYCm009269;
        Mon, 25 Jun 2018 12:46:34 GMT
Received: from mail-ot0-f169.google.com (/74.125.82.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 05:46:33 -0700
Received: by mail-ot0-f169.google.com with SMTP id w16-v6so6217712otk.5;
        Mon, 25 Jun 2018 05:46:33 -0700 (PDT)
X-Gm-Message-State: APt69E1GS5TyWP05zWcFDQG4k9DuAHsKZMl+PRsoRanmQGa5aXnbPEwS
        tSHGrP27rO4yPKEYYyj2ZwwwJn/cKywUvW30Yz8=
X-Google-Smtp-Source: AAOMgpcXm+2PuYLKK3zzC1RyForJP6a8hiQrfVFIlfKSK/D6w0CTan/hVahE9flI+qjrKJ1U8uPkLONbFNf5THaMob0=
X-Received: by 2002:a9d:ea7:: with SMTP id 36-v6mr3150001otj.323.1529930793220;
 Mon, 25 Jun 2018 05:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-6-pasha.tatashin@oracle.com> <20180625090741.776c8914@mschwideX1>
In-Reply-To: <20180625090741.776c8914@mschwideX1>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 25 Jun 2018 08:45:57 -0400
X-Gmail-Original-Message-ID: <CAGM2reYtrntTJr5FdrV-mBdcR7mCMpGx+rTLOJTVPATD7-4oGw@mail.gmail.com>
Message-ID: <CAGM2reYtrntTJr5FdrV-mBdcR7mCMpGx+rTLOJTVPATD7-4oGw@mail.gmail.com>
Subject: Re: [PATCH v12 05/11] s390/time: add read_persistent_wall_and_boot_offset()
To:     schwidefsky@de.ibm.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=679
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:09 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> From a s390 standpoint this looks reasonable.
>
> Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>

Thank you Martin!

Pavel
