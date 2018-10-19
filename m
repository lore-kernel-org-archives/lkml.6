Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D70C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAEE2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XXlMQ+U2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAEE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeJSIbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:31:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:31:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0NbH1006032;
        Fri, 19 Oct 2018 00:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gZUWIHRxBCWO/Hu9Bcek6ZhqmzPDzzIWZIqGiyhJ8bA=;
 b=XXlMQ+U2TRJ0SOsqSmeNECVkYyUU+0PvU6vQQ8T2PbEFOhB66vwC3243q9M3O2oy9tne
 8HxXGnWRvLpwscu25tP9HPaqiNZcSNLa/wB+dD/1EJaNTyqtq+H0cqzwjqQzKyLkVkD1
 kQWq9vOv2dzQqhshrr3ywFu96gMgpqokc86o23XchTnJn1bqZ8u4lXjopm3uwTej+jDB
 1v/7oyq48W3aubEm6IgKDJTMDgBwPMD5MlHzSyanhqShWLt/DjuvuJDk8I4FFt/tdGlq
 h7ZlmENEp4eob5Or2rnO9jCdMxiD/yYaMBWYNo7P54rMCaXR4RIVyd/zS1h7BVUwaEUP ug== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38nqhf8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:27:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0Qx6J028899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:26:59 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J0QxqY002191;
        Fri, 19 Oct 2018 00:26:59 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:26:59 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <b80700f3-feda-ce05-75e2-7ab3566727fb@oracle.com>
Date:   Thu, 18 Oct 2018 17:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 9/7/18 2:39 PM, Jan H. Schönherr wrote:
> The collective context switch from one coscheduled set of tasks to another
> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
> that all tasks of the previous set have stopped executing before any task
> of the next set starts executing, an additional hand-shake/barrier needs to
> be added.
>
Do you know how much is the delay? i.e what is overlap time when a thread
of new group starts executing on one HT while there is still thread of
another group running on the other HT?

Thanks,
Subhra
