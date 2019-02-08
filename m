Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFDC282C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD8021916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBHBvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:51:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfBHBvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:51:25 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x181n3a4072141
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 20:51:23 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgvusgdvw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 20:51:23 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 01:51:22 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 01:51:18 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x181pHX131850636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 01:51:17 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4860F6E050;
        Fri,  8 Feb 2019 01:51:17 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57FE06E04C;
        Fri,  8 Feb 2019 01:51:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 01:51:16 +0000 (GMT)
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 7 Feb 2019 20:51:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208003314.GB7202@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020801-8235-0000-0000-00000E585925
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010557; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157855; UDB=6.00604097; IPR=6.00938387;
 MB=3.00025485; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 01:51:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020801-8236-0000-0000-00004461EEAA
Message-Id: <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 7:33 PM, Jarkko Sakkinen wrote:
> On Thu, Feb 07, 2019 at 06:29:43PM -0500, Stefan Berger wrote:
>> On 2/7/19 4:29 PM, Jarkko Sakkinen wrote:
>>> On Thu, Feb 07, 2019 at 07:41:56PM +0100, Alexander Steffen wrote:
>>>> On 06.02.2019 13:06, Jarkko Sakkinen wrote:
>>>>> On Wed, Feb 06, 2019 at 12:47:07AM +0200, Jarkko Sakkinen wrote:
>>>>>> Make the changes necessary to detach TPM space code and TPM activation
>>>>>> code out of the tpm_transmit() flow because of both of these can cause
>>>>>> nested tpm_transmit() calls. The nesteds calls make the whole flow hard
>>>>>> to maintain, and thus, it is better to just fix things now before this
>>>>>> turns into a bigger mess.
>>>>>>
>>>>>> v11:
>>>>>> * Drop the patch that tries to flush TPM space on system. Not a proper
>>>>>>      fallback + out of scope for this patch set.
>>>>>>
>>>>>> v10:
>>>>>> * Use void pointers to avoid unnecessary casts in functions paramaters
>>>>>>      where it makes sense.
>>>>>>
>>>>>> v9:
>>>>>> * Fixed again tpm_try_get_ops().
>>>>>> * Added missing reviewed-by's.
>>>>>>
>>>>>> v8:
>>>>>> * Re-add the check for ret < 0 after calling tpm_try_transmit() that
>>>>>>      was dropped by mistake while moving code.
>>>>>> * Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
>>>>>>      fails.
>>>>>>
>>>>>> v7:
>>>>>> *  Reorganize series so that more trivial and self-contained changes are
>>>>>>       in the head.
>>>>>>
>>>>>> v6:
>>>>>> * When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
>>>>>>      the TPM header was incorrectly declared as struct tpm_input_header.
>>>>>> * Fix return value in tpm_validate_command().
>>>>>>
>>>>>> v5:
>>>>>> * Add the missing rev's from Stefan Berger.
>>>>>>
>>>>>> v4:
>>>>>> * Return 0 from pcrs_show() when tpm1_pcr_read() fails.
>>>>>> * Fix error handling flow in tpm_try_transmit().
>>>>>> * Replace struct tpm_input_header and struct tpm_output_header with
>>>>>>      struct tpm_header.
>>>>>>
>>>>>> v3:
>>>>>> * Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
>>>>>> * Move TPM power gating code and locking to tpm_try_get_ops() and
>>>>>>      tpm_put_ops().
>>>>>> * Call power gating code directly in tpm_chip_register() and
>>>>>>      tpm2_del_space().
>>>>>>
>>>>>> v2:
>>>>>> * Print tpm2_commit_space() error inside tpm2_commit_space()
>>>>>> * Error code was not printed when recv() callback failed. It is
>>>>>>      fixed in this version.
>>>>>> * Added a patch that removes @space from tpm_transmit().
>>>>>> * Fixed a regression in earlier series. Forgot to amend the change
>>>>>>      from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
>>>>>>
>>>>>> Jarkko Sakkinen (16):
>>>>>>      tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
>>>>>>      tpm: fix invalid return value in pubek_show()
>>>>>>      tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
>>>>>>      tpm: print tpm2_commit_space() error inside tpm2_commit_space()
>>>>>>      tpm: declare struct tpm_header
>>>>>>      tpm: access command header through struct in tpm_try_transmit()
>>>>>>      tpm: encapsulate tpm_dev_transmit()
>>>>>>      tpm: clean up tpm_try_transmit() error handling flow
>>>>>>      tpm: move tpm_validate_commmand() to tpm2-space.c
>>>>>>      tpm: move TPM space code out of tpm_transmit()
>>>>>>      tpm: remove @space from tpm_transmit()
>>>>>>      tpm: use tpm_try_get_ops() in tpm-sysfs.c.
>>>>>>      tpm: remove TPM_TRANSMIT_UNLOCKED flag
>>>>>>      tpm: introduce tpm_chip_start() and tpm_chip_stop()
>>>>>>      tpm: take TPM chip power gating out of tpm_transmit()
>>>>>>      tpm: remove @flags from tpm_transmit()
>>>>>>
>>>>>>     drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
>>>>>>     drivers/char/tpm/tpm-dev-common.c |  44 ++++-
>>>>>>     drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
>>>>>>     drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
>>>>>>     drivers/char/tpm/tpm.h            |  64 +++-----
>>>>>>     drivers/char/tpm/tpm1-cmd.c       |  28 +---
>>>>>>     drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
>>>>>>     drivers/char/tpm/tpm2-space.c     |  91 +++++++---
>>>>>>     drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
>>>>>>     drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
>>>>>>     drivers/char/tpm/xen-tpmfront.c   |   2 +-
>>>>>>     11 files changed, 408 insertions(+), 421 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>> 2.19.1
>>>>>>
>>>>> Applied to master and next.
>>>> Something in this series seems to break basic TPM communication for me.
>>>>
>>>> For TPM2.0s the probe command fails, causing them to be misdetected as
>>>> TPM1.2s:
>>>>
>>>> ---
>>>> tpm tpm0: tpm_try_transmit: tpm_send: error -5
>>>> tpm_tis MSFT0101:00: 1.2 TPM (device-id 0x1A, rev-id 22)
>>>> tpm tpm0: A TPM error (30) occurred attempting to determine the timeouts
>>>> ---
>>>> tpm tpm0: tpm_try_transmit: tpm_send: error -5
>>>> tpm_tis_spi spi0.1: 1.2 TPM (device-id 0x1B, rev-id 22)
>>>> tpm tpm0: A TPM error (30) occurred attempting to determine the timeouts
>>>> ---
>>>>
>>>> And for something that actually is a TPM1.2 it fails in a similar way:
>>>>
>>>> ---
>>>> tpm_i2c_infineon 1-0020: 1.2 TPM (device-id 0x1A)
>>>> tpm tpm0: A TPM error (-14) occurred attempting to determine the timeouts
>>>> ---
>>>> tpm tpm0: tpm_try_transmit: tpm_send: error -5
>>>> tpm_tis_spi spi0.1: 1.2 TPM (device-id 0x1B, rev-id 16)
>>>> tpm tpm0: A TPM error (-14) occurred attempting to determine the timeouts
>>>> tpm_tis_spi: probe of spi0.1 failed with error -14
>>>> ---
>>>>
>>>> I see this problem across my entire range of TPM devices and test platforms.
>>>> Any idea what could be wrong here?
>>> Weird.
>>>
>>> Can you run a bisect?
>> There are 2 bugs and the following overall patch against your tree fixes
>> them. Let me comment on the individual patches in v17. I missed those
>> obviously when testing with the tpm_vtpm_proxy...
>>
>>
>>
>> diff --git a/drivers/char/tpm/tpm-interface.c
>> b/drivers/char/tpm/tpm-interface.c
>> index 02e8cffd1163..34c0da55d885 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -94,6 +94,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>> void *buf, size_t bufsiz)
>>           return rc;
>>       }
>>
>> +    rc = 0;
>>       if (chip->flags & TPM_CHIP_FLAG_IRQ)
>>           goto out_recv;
> What why?


This fix seems to only be necessary when bisecting. You may want to 
apply it!


>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index e74c5b7b64bf..52afe20cc8a1 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -799,7 +799,9 @@ int tpm2_probe(struct tpm_chip *chip)
>>       tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
>>       tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
>>       tpm_buf_append_u32(&buf, 1);
>> +    tpm_chip_start(chip);
>>       rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
>> +    tpm_chip_stop(chip);
> Thanks Stefan! I added call to tpm_tis_core as tpm2-cmd.c is to be kept
> out of chip management common case being that you call tpm_try_get_ops(),
> do 1-N TPM commands and release with tpm_put_ops(). These functions take
> care starting and stopping the chip.
>
> I fixed the 2nd issue in the master.

You also need to export the tpm_chip_start/stop symbols.


Master now seems to (still) have a problem when rmmod'ing:

A TPM error (325) occurred stopping the TPM. This happens at the same 
patch where I had to add the tpm_chip_start/stop above.




>
>   /Jarkko
>

