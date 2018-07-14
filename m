Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69244ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290720875
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZPsGgGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2290720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeGNAiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:38:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45726 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbeGNAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:38:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6E0JaGR145230;
        Sat, 14 Jul 2018 00:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6XIpyK294Xbr8ige6yulYwmQrYj6TdB8WF4n0ua3Vw4=;
 b=KZPsGgGvnIe7/dxH5o5umejbk5W61wlURP8qdyZSIeGGzqUmZsf3MmZXDsmuFClhj09A
 Rk2dFVGAuQTm6Dq0fXhmdFw+HlJYPKlalioDXEz0P6JE8YRedEu5mY1eE5APL1N9fQWR
 pylePhfewwF/9zxDB0CtoqwEOzSwFxWOHIjzhc0qEDzHA4xtq5pktfNPnhHfIUVnlMwG
 gGZ25BfgAK6iZHrhIemddYtpG+aqmEQPftlUfCJLcHu9sr7wHr9wTZQpaYzway15fbqS
 yqkRB0+fxJGjMnyPPmH/e8n/DiAg4OCUwvSGm+0LaBQExQfuvpiGOAUg5y2jhNF8XVKO wQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k2p769js9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jul 2018 00:20:43 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6E0KgvK032680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jul 2018 00:20:42 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6E0KfZi025197;
        Sat, 14 Jul 2018 00:20:41 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 17:20:41 -0700
Subject: Re: [patch 0/7] x86/kvmclock: Remove memblock dependency and further
 cleanups
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
References: <20180706161307.733337643@linutronix.de>
 <CAGM2reaKmu=h8QosuoJvJzzdTy2QfGRp9YxaKK-9UzpsfL-MoQ@mail.gmail.com>
 <alpine.DEB.2.21.1807140049200.2644@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <a82c80d1-f2ff-779b-7f90-a6fe9c51b7a4@oracle.com>
Date:   Fri, 13 Jul 2018 20:20:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807140049200.2644@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8953 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=889
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807140002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/13/2018 06:51 PM, Thomas Gleixner wrote:
> On Wed, 11 Jul 2018, Pavel Tatashin wrote:
> 
>>> So this still will have some overhead when kvmclock is not in use, but
>>> bringing it down to zero would be a massive trainwreck and even more
>>> indirections.
>>
>> Hi Thomas,
>>
>> In my opinion, having kvmclock page in  __initdata for boot cpu, and
>> setup it in init_hypervisor_platform(). Later, switch to memblock
>> allocated memory in x86_init.hyper.guest_late_init() for all CPUs
>> would not be too bad, and might be even use fewer lines of code. In
>> addition, it won't have any overhead when kvm is not used.
> 
> Why memblock? This can be switched when the allocator is up and
> running. And you can use the per cpu allocator for that.
> 
> I'm not having cycles at the moment to look at that, so feel free to pick
> the series up and enhance it.

OK, I will add your series into my series, and fix all the comments that were raised by the reviewers.

Pavel
