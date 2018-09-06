Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD64C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459A22083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ID5KZONS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459A22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIFGHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:07:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57212 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeIFGHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:07:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w861XuPT159409;
        Thu, 6 Sep 2018 01:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1C6P/E/U7nlLfH228zNe/dwLC0AaWREnJS5SrKXIOzE=;
 b=ID5KZONShurMG/8LIqD2qXabxGk4wodS/i4pYqIeWCDRren+2fbS+u4xlnLbmvkDIxW6
 97ycoQpMNBNlk3fQkOf0YftkL8rKBmiZb3/kipHbGPMeAs0314sUp0t/zqbeQfz2rYVS
 HtppY0YeahKZskqhSQodNa2MyYFPZUxHGuGvdu5VN89CLl4hqIifIvuFZKPufpolrtn9
 GFvLRR1a0qV27gHSs0MroLKdOhGkbnAjzLKTbgSHLRvCabIuaPILobueMlvl3c17MC7c
 T2XGnAgkZMj7Q/LKf5H42/hNkhlQZ9+ORKwscbb55PWfRQFeqg8uDsJK8DrgCheVYtCY lA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2m7kdqqavs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 01:34:20 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w861YJK7029236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 01:34:20 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w861YJNo020018;
        Thu, 6 Sep 2018 01:34:19 GMT
Received: from [10.182.69.224] (/10.182.69.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 18:34:19 -0700
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        ming.lei@redhat.com, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536162485.11534.3.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ebeffce9-4136-1b4d-1253-b5c045eff3f7@oracle.com>
Date:   Thu, 6 Sep 2018 09:35:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536162485.11534.3.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 09/05/2018 11:48 PM, Bart Van Assche wrote:
>> The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
>> issue above.
> Hello Jianchao,
> 
> Is this patch series based on a theoretical concern or rather on something
> you ran into? In the latter case, can you explain which scenario makes it
> likely on your setup to encounter an NVMe timeout?

It is a theoretical concern. But I think it is very obvious.
It could be very easy to reproduce if simulate IO timeout in software.

Thanks
Jianchao
