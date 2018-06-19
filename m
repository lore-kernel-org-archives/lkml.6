Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DDF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q820sSwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DDF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756918AbeFSJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:24:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbeFSJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:24:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J9O8ie119881;
        Tue, 19 Jun 2018 09:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=KleL0LT4iSQdyr/o+vFq/arzkGgQxjKvsv1KwT8tmVg=;
 b=q820sSwd77dNrGytcPsmZp9Ch57zmjGYcujwblUDXyaetW3hzG7rpQDwMiK+D/IQ/can
 RRVZkGu3pv/sl3RZ3qCxj0nYgtV/qsbRxAdyE3kHaJSldmlbSjMNwRdruPcBGVHG9Sy3
 MjcveFriMDkjW0YW9EQa0tSrfeeuWhKHrAgJaBpNlVbJLF0NUSBUkn9dx5pLhW88VwFP
 AwggX8rRWNfIBJu6PREfXrr4MhPYMEfzh4XsKnX/ld+8JNGvDwMZDN+3lq1bDCrCortc
 r9oGbGKOtF5ITrU9mhxZNoH1ssx9rkbt2Xxeh+e3g8mah0CTRr8Xm5ORBcyzeGo4L0Fh 5A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jmu6xqa49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 09:24:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5J9OF36016787
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 09:24:15 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J9OEA0021426;
        Tue, 19 Jun 2018 09:24:14 GMT
Received: from [10.191.10.231] (/10.191.10.231)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 02:24:14 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] x86/microcode/intel: Ensure new microcode processor flags
 match with cpu's pf
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        hpa@zytor.com
References: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
 <20180618195619.GH24921@zn.tnic>
 <ed92d414-9869-cd06-eee1-1035cc574cf4@oracle.com>
 <20180619091205.GA30870@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <a9c21f46-af2c-28aa-b539-a8b6a6fc666b@oracle.com>
Date:   Tue, 19 Jun 2018 17:24:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619091205.GA30870@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/19 17:12, Borislav Petkov wrote:
> On Tue, Jun 19, 2018 at 12:49:40PM +0800, Zhenzhong Duan wrote:
>> Imagine kernel already found a microcode blob A with extended sig/pf
>> matching current cpu, then another microcode B is checked which doesn't
>> match current cpu...
> Do you see the
> 
> 	if (!microcode_matches(mc_header, uci->cpu_sig.sig)) {
> 
> call a couple of lines earlier?
Sure, but it didn't ensure a match in stepping and pf, is that expected?

Thanks
Zhenzhong
