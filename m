Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055DAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B160B21718
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="scfv7gkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B160B21718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeFUQvk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:51:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933429AbeFUQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:51:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LGo28g178248
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=JlBZAgNmkno0j16DEKxn9yBN1wOPn0NDUhmaOfx7U3k=;
 b=scfv7gktbJYckZRzqqfhq0f+P+IpYjPdnNkBHDENjBCr0LKj+mDcx85M4U8P6RjVwerX
 p5BwG6Xc//P4b8H5UZZk5wRreK3JiZoXhA/79wCLLtxI5W2c7wvpLr8WlZ37qyEXRde9
 SujvvxTJk0VETZYgsdpczLt061Luw+6gfU1LtlFrS6fs/nEvCDRNzB4x0xkifajHPPCi
 +i8c2esWqSYho+78wRgJ7xM8rx/qgt+IORZN03p6/Jcg4VYM1+E+EAwr7YO4W2S9gQYG
 44WdDA6PjLTdy6GePd7iGhoBkuHMe3UMsQI9Ttcb639eBejr9/IEJZoTx88vteU5hGDX Hg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jmt01sn6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:51:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5LGpbvf018721
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:51:38 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5LGpbiY015410
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:51:37 GMT
Received: from mail-ot0-f173.google.com (/74.125.82.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 09:51:37 -0700
Received: by mail-ot0-f173.google.com with SMTP id r18-v6so4367485otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:51:37 -0700 (PDT)
X-Gm-Message-State: APt69E1aXUzDlRhuJ4ZuaGfei+Ygq5Yhf7p/AbRAl/fOP/M0ttxeM33t
        B3zR6lhMct7csKkSlJM7DPBKrudexF/YCEHEnMs=
X-Google-Smtp-Source: ADUXVKLVkhc71Rs1HjiTfT+8+SYi+UIcA8Y726yc77hD3n46EyIdLhGc3Wm+/h9RvSihHviHRdqfaO2SG/3btA3pEQ8=
X-Received: by 2002:a9d:72dd:: with SMTP id d29-v6mr17197825otk.345.1529599896563;
 Thu, 21 Jun 2018 09:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
 <20180620212700.29178-4-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806211811060.1591@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806211811060.1591@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 21 Jun 2018 12:51:00 -0400
X-Gmail-Original-Message-ID: <CAGM2reaGwtgvc=CBDvF2K3zQKieeL82zLy0155yWYs7VU6tL9w@mail.gmail.com>
Message-ID: <CAGM2reaGwtgvc=CBDvF2K3zQKieeL82zLy0155yWYs7VU6tL9w@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] time: replace read_boot_clock64() with read_persistent_wall_and_boot_offset()
To:     tglx@linutronix.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=533
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't make that a wholesale patch. I surely indicated the steps
> which are required and the steps can be done as separate patches easily,

Hi Thomas,

I will split it into several patches in the next version.

Thank you,
Pavel
