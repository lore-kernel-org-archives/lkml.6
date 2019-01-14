Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773E020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfANTvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:51:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbfANTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:51:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EJmq1e075275
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:51:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0x5d73xu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:51:52 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Mon, 14 Jan 2019 19:51:51 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 19:51:49 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EJpmaF22610058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 19:51:48 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F930AE063;
        Mon, 14 Jan 2019 19:51:48 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E18AE068;
        Mon, 14 Jan 2019 19:51:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 19:51:48 +0000 (GMT)
Subject: Re: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
To:     "Safford, David (GE Global Research)" <david.safford@ge.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 14 Jan 2019 14:51:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19011419-2213-0000-0000-0000033D4DCA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010405; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146483; UDB=6.00597126; IPR=6.00926769;
 MB=3.00025124; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-14 19:51:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011419-2214-0000-0000-00005CF88ED7
Message-Id: <268c3238-b4fe-ef9f-d656-4d34479ec481@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 3:28 PM, Safford, David (GE Global Research) wrote:
>> -----Original Message-----
>> From: linux-integrity-owner@vger.kernel.org <linux-integrity-
>> owner@vger.kernel.org> On Behalf Of Stefan Berger
>> Sent: Wednesday, January 09, 2019 5:11 PM
>> To: linux-integrity@vger.kernel.org; jarkko.sakkinen@linux.intel.com
>> Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Subject: EXT: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
>>
>> This series of patches extends the TPM subsystem's PPI support to support
>> TPM PPI revision 1.3 where more commands are supported (up to 101) and
>> the TPM 2 command code '23' takes an additional parameter.
>>
>> For the command code '23' see this document here on document page 39:
>> https://trustedcomputinggroup.org/wp-content/uploads/Physical-
>> Presence-Interface_1-30_0-52.pdf
>>
>>     Stefan
> You might mention that this is an important feature, as on at least some
> systems, ppi function 23 is the only way to enable/disable PCR banks.

'The only way' depends on how good or bad the firmware support for this 
is. SeaBIOS will have a menu item that lets one toggle the activation of 
the PCR banks in the firmware menu -- assuming my patch makes it 
upstream :-)


>
> I have tested this patch set on my HP Spectre laptop, and I am finally
> able to turn the sha-1 bank on and off. Much appreciated!
>
> Tested-by: David Safford <david.safford@ge.com>


Thanks.


     Stefan


>
>> Stefan Berger (5):
>>    tpm: ppi: pass function revision ID to tpm_eval_dsm()
>>    tpm: ppi: rename TPM_PPI_REVISION_ID to TPM_PPI_REVISION_1
>>    tpm: ppi: Display up to 101 operations as define for version 1.3
>>    tpm: ppi: Possibly show command parameter if TPM PPI 1.3 is used
>>    tpm: ppi: Enable submission of optional command parameter for PPI 1.3
>>
>>   drivers/char/tpm/tpm_ppi.c | 78 ++++++++++++++++++++++++++++--------
>> --
>>   1 file changed, 58 insertions(+), 20 deletions(-)
>>
>> --
>> 2.17.1


