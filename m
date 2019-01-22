Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E354C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D88217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfAVWjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:39:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfAVWjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:39:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MMXuK7114780
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:39:02 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6942f18g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:39:01 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 22 Jan 2019 22:39:00 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 22:38:56 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MMctM216974054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 22:38:56 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E42D67807A;
        Tue, 22 Jan 2019 22:38:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA1B978069;
        Tue, 22 Jan 2019 22:38:51 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.185.73])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Jan 2019 22:38:51 +0000 (GMT)
References: <20190122211758.8317-1-bauerman@linux.ibm.com> <bc09628a-d329-bb95-d737-b7c618860c6a@amd.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     "Lendacky\, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu\@lists.linux-foundation.org" 
        <iommu@lists.linux-foundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 1/2] dma-direct: set_memory_{en,de}crypted() take number of pages
In-reply-to: <bc09628a-d329-bb95-d737-b7c618860c6a@amd.com>
Date:   Tue, 22 Jan 2019 20:38:46 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012222-0004-0000-0000-000014D6AD71
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010458; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01150328; UDB=6.00599461; IPR=6.00930660;
 MB=3.00025245; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-22 22:39:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012222-0005-0000-0000-00008A521BC7
Message-Id: <87womwfhc9.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:

> On 1/22/19 3:17 PM, Thiago Jung Bauermann wrote:
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 355d16acee6d..bc78c37220ba 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -166,7 +166,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>>  
>>  	ret = page_address(page);
>>  	if (force_dma_unencrypted()) {
>> -		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>> +		set_memory_decrypted((unsigned long)ret, 1);
>
> The get_order() function will return the order for the specified size. To
> then get the number of pages you perform the shift as is being done. The
> change is definitely wrong since you are now hardcoding the page count to
> 1. The call to __dma_direct_alloc_pages() will allocate more than one page
> if the size is greater than a page.

<facepalm>

You are correct, of course. Sorry for the noise and thanks for explaining.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

