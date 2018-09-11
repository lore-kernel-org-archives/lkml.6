Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q3gDY39m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF14C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeIKTNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:13:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIKTNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:13:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8BE4Ssr143720;
        Tue, 11 Sep 2018 14:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lmGimO6mmUFDrITB/4MbPtLU/wF3eZKfQkeqvIlBCoQ=;
 b=Q3gDY39mrqC1zNf9Y9QMzXpJo3wGLT+n2qYXS2oELf4WPYZXpb08EsYySKYZlfB6tdfe
 KBv9gMW6kEXdtXGdUo8NcMQlvuUsT+ukNeGF5YUI3+sAj1Q2tZEpkAThQZ+WnGoLedPL
 kYg1n2fWwzqsQeDYPoHrxI6pbPruO1Ala8EXCNh9TvXnB6OdNHD+znsaTd/Tu4d4QHEZ
 Sx/HLq8gaiLHxqBhubEVh0jWI18rY+qFFE9XCd6aTopm69br/ekwMljcY5V6WISaW++5
 jhsm/ff/eEPlTuK2RiyeLW1bhSv/0Bx1KPH0T5YZoOSEOd18EzgWE+8CcDW/5lFoeSKL oQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cpmfxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 14:13:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8BEDPFf026013
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 14:13:25 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8BEDPtZ027774;
        Tue, 11 Sep 2018 14:13:25 GMT
Received: from [10.191.3.83] (/10.191.3.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 07:13:25 -0700
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To:     Tejun Heo <tj@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
 <20180911134404.GF1100574@devbig004.ftw2.facebook.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e18c28d9-24dd-3048-a5e0-e3ed96643706@oracle.com>
Date:   Tue, 11 Sep 2018 22:13:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911134404.GF1100574@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=630
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tejun

On 09/11/2018 09:44 PM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 11, 2018 at 12:40:36PM +0800, jianchao.wang wrote:
>> (long)(sum (every cpu's refcounter)) + atomic refcounter
>>
>> and when switch to atomic mode, there could be value left in atomic refcounter.
>> then the unsigned long percpu refcounter cound be decreased from 0.
> 
> It can always do that.  Imagine a task getting a ref on one cpu,
> migrating and putting it on another.  The only thing which matters is
> that the sum of everything adds upto what it should be.
> 

Thanks for your kindly response.
I have got the point here.

Thanks
Jianchao
