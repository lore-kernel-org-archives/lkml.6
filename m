Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188ECC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74062148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74062148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbeHPMif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:38:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731397AbeHPMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:38:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7G9Zwed042447
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 05:41:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw6ffrurc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 05:41:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 10:41:12 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Aug 2018 10:41:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7G9f7gp18743454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Aug 2018 09:41:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E329A4040;
        Thu, 16 Aug 2018 12:41:11 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DC10A405D;
        Thu, 16 Aug 2018 12:41:10 +0100 (BST)
Received: from [9.145.158.193] (unknown [9.145.158.193])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Aug 2018 12:41:10 +0100 (BST)
Subject: Re: [PATCH 3/3] powerpc/pseries/mm: call H_BLOCK_REMOVE
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
 <877elcj0oa.fsf@concordia.ellerman.id.au>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Thu, 16 Aug 2018 11:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877elcj0oa.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18081609-0028-0000-0000-000002EB9AF2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081609-0029-0000-0000-000023A4C482
Message-Id: <fb69ba85-eaee-d582-3254-26bb5da4828d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808160102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 15:47, Michael Ellerman wrote:
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

The first one is clearly not required. But I would keep the following twos
because this call is not expected to fail except if there is a discrepancy
between the linux kernel HASH views and the hypervisor's one, which could be
dramatic in the consequences.

> 
> Given this is an optimisation it seems like we should be able to fall
> back to the existing implementation in the case of error (which will
> probably then BUG_ON() 😂)

I don't think falling back to the H_BULK call will be helpfull since it is
doing the same so the same errors are expected. Furthermore, this hcall can do
a partial work which means complex code to fallback on H_BULK as we should
identify to already processed entries.

> If there's some reason we can't then I guess I can live with it.

I'm proposing to send a new series with _only_ 2 calls to BUG_ON().

Furthermore this patch is not correct on the way the huge pages are managed. I
was too hurry to push it last time.

Cheers,
Laurent.

