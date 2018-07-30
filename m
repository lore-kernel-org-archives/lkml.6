Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD234FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E9F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E9F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeG3P6N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:58:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbeG3P6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:58:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UEELd8122715
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:22:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kj20n6xxf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:22:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 30 Jul 2018 15:22:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 15:22:52 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UEMp1k42270868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 14:22:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1112342047;
        Mon, 30 Jul 2018 17:23:04 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E9804204B;
        Mon, 30 Jul 2018 17:23:02 +0100 (BST)
Received: from skywalker (unknown [9.199.40.54])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 30 Jul 2018 17:23:02 +0100 (BST)
Received: (nullmailer pid 13366 invoked by uid 1000);
        Mon, 30 Jul 2018 14:22:48 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Subject: Re: [PATCH 3/3] powerpc/pseries/mm: call H_BLOCK_REMOVE
In-Reply-To: <877elcj0oa.fsf@concordia.ellerman.id.au>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com> <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com> <877elcj0oa.fsf@concordia.ellerman.id.au>
Date:   Mon, 30 Jul 2018 19:52:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18073014-0008-0000-0000-00000259F50D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073014-0009-0000-0000-000021C084B7
Message-Id: <87fu00olaf.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi Laurent,
>
> Just one comment below.
>
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
>> index 96b8cd8a802d..41ed03245eb4 100644
>> --- a/arch/powerpc/platforms/pseries/lpar.c
>> +++ b/arch/powerpc/platforms/pseries/lpar.c
>> @@ -418,6 +418,73 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
>>  	BUG_ON(lpar_rc != H_SUCCESS);
>>  }
>>  
>> +
>> +/*
>> + * As defined in the PAPR's section 14.5.4.1.8
>> + * The control mask doesn't include the returned reference and change bit from
>> + * the processed PTE.
>> + */
>> +#define HBLKR_AVPN		0x0100000000000000UL
>> +#define HBLKR_CTRL_MASK		0xf800000000000000UL
>> +#define HBLKR_CTRL_SUCCESS	0x8000000000000000UL
>> +#define HBLKR_CTRL_ERRNOTFOUND	0x8800000000000000UL
>> +#define HBLKR_CTRL_ERRBUSY	0xa000000000000000UL
>> +
>> +/**
>> + * H_BLOCK_REMOVE caller.
>> + * @idx should point to the latest @param entry set with a PTEX.
>> + * If PTE cannot be processed because another CPUs has already locked that
>> + * group, those entries are put back in @param starting at index 1.
>> + * If entries has to be retried and @retry_busy is set to true, these entries
>> + * are retried until success. If @retry_busy is set to false, the returned
>> + * is the number of entries yet to process.
>> + */
>> +static unsigned long call_block_remove(unsigned long idx, unsigned long *param,
>> +				       bool retry_busy)
>> +{
>> +	unsigned long i, rc, new_idx;
>> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
>> +
>> +again:
>> +	new_idx = 0;
>> +	BUG_ON((idx < 2) || (idx > PLPAR_HCALL9_BUFSIZE));
>
> I count 1 ..
>
>> +	if (idx < PLPAR_HCALL9_BUFSIZE)
>> +		param[idx] = HBR_END;
>> +
>> +	rc = plpar_hcall9(H_BLOCK_REMOVE, retbuf,
>> +			  param[0], /* AVA */
>> +			  param[1],  param[2],  param[3],  param[4], /* TS0-7 */
>> +			  param[5],  param[6],  param[7],  param[8]);
>> +	if (rc == H_SUCCESS)
>> +		return 0;
>> +
>> +	BUG_ON(rc != H_PARTIAL);
>
> 2 ...
>
>> +	/* Check that the unprocessed entries were 'not found' or 'busy' */
>> +	for (i = 0; i < idx-1; i++) {
>> +		unsigned long ctrl = retbuf[i] & HBLKR_CTRL_MASK;
>> +
>> +		if (ctrl == HBLKR_CTRL_ERRBUSY) {
>> +			param[++new_idx] = param[i+1];
>> +			continue;
>> +		}
>> +
>> +		BUG_ON(ctrl != HBLKR_CTRL_SUCCESS
>> +		       && ctrl != HBLKR_CTRL_ERRNOTFOUND);
>
> 3 ...
>
> BUG_ON()s.
>
> I know the code in this file is already pretty liberal with the use of
> BUG_ON() but I'd prefer if we don't make it any worse.
>
> Given this is an optimisation it seems like we should be able to fall
> back to the existing implementation in the case of error (which will
> probably then BUG_ON() 😂)
>
> If there's some reason we can't then I guess I can live with it.

It would be nice to log the error in case we are not expecting the
error return. We recently did
https://marc.info/?i=20180629083904.29250-1-aneesh.kumar@linux.ibm.com

-aneesh

