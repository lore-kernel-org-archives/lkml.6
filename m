Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0341C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B2920883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S0BzgH5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B2920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbeFULRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:17:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58948 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754278AbeFULRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:17:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LBBiO9151155
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=iVppyWIrrZXV72cy3/gHLjhiseETaM76zxgLE0rEvpk=;
 b=S0BzgH5kstAiFvbty/Uub39yAGe25Tc3+g0s2lDV8+qOAjSJpBeonxjKvMF+tL3o5PXM
 PF08kTmto+OIxXzg487bjTKla4S7tGKCurDASzIrXFAajZto6TH48rcFcTLqcu0H5kNW
 lUkslxiXWXV5r4D6o7xRbqoBXA7nmURx8Y/dqHR67QC5e4Iinnok0jDYTEotuMlvtkXS
 W+YTMIBgMWyHMAeR7lb/Xe82ZqDRM6YiAmDU5uEpjC3XZuTdf4nO3NL0lW2xeU3/LUZ+
 fluS21Lpxfg9muCF5JGl0ShSW2eu1TI2tE7vC+VNAcp0fu3zXuPMJhlJDXmyRbkSqdpH Uw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6y082j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:17:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5LBH9xi000652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:17:09 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5LBH86X022978
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:17:08 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 04:17:08 -0700
Received: by mail-oi0-f47.google.com with SMTP id l22-v6so2560319oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:17:08 -0700 (PDT)
X-Gm-Message-State: APt69E0J7NicspYIs791/It04R0L6bghgtBCA4gmz5fXwuIlvyhto79x
        GJDGdslVLg8zCeuonsaUfKoBARmSRxi8ZDEobpU=
X-Google-Smtp-Source: ADUXVKL8ejEIXyEmrbZhwsJdV/LuQCcETqQTv1wPbkSLQyKSzfQN3pZyBNfUbjcc0KpUjH1f+x7Y/YHz6dnTgnSqOPk=
X-Received: by 2002:aca:56c8:: with SMTP id k191-v6mr13073913oib.221.1529579828550;
 Thu, 21 Jun 2018 04:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
 <20180620212700.29178-7-pasha.tatashin@oracle.com> <20180621055144.i65hhyqe5dofop33@shbuild888>
In-Reply-To: <20180621055144.i65hhyqe5dofop33@shbuild888>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 21 Jun 2018 07:16:32 -0400
X-Gmail-Original-Message-ID: <CAGM2reYethiqDLM0dRRSihvRCi24b_B=eBR05G=nWVQSL9LVww@mail.gmail.com>
Message-ID: <CAGM2reYethiqDLM0dRRSihvRCi24b_B=eBR05G=nWVQSL9LVww@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] x86/tsc: use tsc early
To:     feng.tang@intel.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=618
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do we still need add a static_key? after Peter worked out the patch
> to enable ealy jump_label_init?

Hi Feng,

With Pete's patch we will still need at least one static branch, but
as I replied to Pete's email I like the idea of initializing
jump_label_init() early, but in my opinion it should be a separate
work, with tsc.c cleanup patch.

Thank you,
Pavel
