Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACDC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8A221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBHCPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:15:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726916AbfBHCPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:15:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x182EaBr080735
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 21:15:02 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qgyv2243g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 21:15:01 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 02:15:01 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 02:14:57 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x182Etbc14549244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 02:14:56 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 991B4BE056;
        Fri,  8 Feb 2019 02:14:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A29AEBE04F;
        Fri,  8 Feb 2019 02:14:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 02:14:54 +0000 (GMT)
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
From:   Stefan Berger <stefanb@linux.ibm.com>
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
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
Date:   Thu, 7 Feb 2019 21:14:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020802-0012-0000-0000-00001706D967
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010557; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157863; UDB=6.00604101; IPR=6.00938395;
 MB=3.00025485; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 02:14:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020802-0013-0000-0000-0000561EDEE0
Message-Id: <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 8:51 PM, Stefan Berger wrote:
> On 2/7/19 7:33 PM, Jarkko Sakkinen wrote:
>> On Thu, Feb 07, 2019 at 06:29:43PM -0500, Stefan Berger wrote:
>>> On 2/7/19 4:29 PM, Jarkko Sakkinen wrote:
>
>
>>
>>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>>> index e74c5b7b64bf..52afe20cc8a1 100644
>>> --- a/drivers/char/tpm/tpm2-cmd.c
>>> +++ b/drivers/char/tpm/tpm2-cmd.c
>>> @@ -799,7 +799,9 @@ int tpm2_probe(struct tpm_chip *chip)
>>>       tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
>>>       tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
>>>       tpm_buf_append_u32(&buf, 1);
>>> +    tpm_chip_start(chip);
>>>       rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
>>> +    tpm_chip_stop(chip);
>> Thanks Stefan! I added call to tpm_tis_core as tpm2-cmd.c is to be kept
>> out of chip management common case being that you call 
>> tpm_try_get_ops(),
>> do 1-N TPM commands and release with tpm_put_ops(). These functions take
>> care starting and stopping the chip.
>>
>> I fixed the 2nd issue in the master.
>
> You also need to export the tpm_chip_start/stop symbols.
>
>
> Master now seems to (still) have a problem when rmmod'ing:
>
> A TPM error (325) occurred stopping the TPM. This happens at the same 
> patch where I had to add the tpm_chip_start/stop above.
>
>

Here's my current overall patch against your master. I suppose the other 
tpm2_shutdown() for power management doesn't need the chip start ?

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 9865776ee2cd..f7147706a9c3 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -115,6 +115,7 @@ int tpm_chip_start(struct tpm_chip *chip)

      return 0;
  }
+EXPORT_SYMBOL_GPL(tpm_chip_start);

  /**
   * tpm_chip_stop() - power off the TPM
@@ -131,7 +132,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
      if (chip->ops->clk_enable)
          chip->ops->clk_enable(chip, false);
  }
-
+EXPORT_SYMBOL_GPL(tpm_chip_stop);

  /**
   * tpm_try_get_ops() - Get a ref to the tpm_chip
@@ -474,8 +475,11 @@ static void tpm_del_char_device(struct tpm_chip *chip)

      /* Make the driver uncallable. */
      down_write(&chip->ops_sem);
-    if (chip->flags & TPM_CHIP_FLAG_TPM2)
+    if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+        tpm_chip_start(chip, 0);
          tpm2_shutdown(chip, TPM2_SU_CLEAR);
+        tpm_chip_stop(chip, 0);
+    }
      chip->ops = NULL;
      up_write(&chip->ops_sem);
  }
diff --git a/drivers/char/tpm/tpm-interface.c 
b/drivers/char/tpm/tpm-interface.c
index 02e8cffd1163..fcd845ad8c3c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -124,6 +124,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip 
*chip, void *buf, size_t bufsiz)
          dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
      } else if (len < TPM_HEADER_SIZE || len != 
be32_to_cpu(header->length))
          rc = -EFAULT;
+    else
+        rc = 0;

      return rc ? rc : len;
  }




>
>
>>
>>   /Jarkko
>>
>

