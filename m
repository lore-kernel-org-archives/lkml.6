Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161097AbeCAS5x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:57:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034092AbeCAS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:57:50 -0500
Subject: Re: [PATCH 2/3] tpm: reduce poll sleep time between send() and recv()
 in tpm_transmit()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
 <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
 <20180301092222.GC29420@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 00:26:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180301092222.GC29420@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030118-0056-0000-0000-00000426C582
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008609; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996910; UDB=6.00506857; IPR=6.00776227;
 MB=3.00019805; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-01 18:57:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030118-0057-0000-0000-00000868C68A
Message-Id: <6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 02:52 PM, Jarkko Sakkinen wrote:
> On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
>> In tpm_transmit, after send(), the code checks for status in a loop
> Maybe cutting hairs now but please just use the actual function name
> instead of send(). Just makes the commit log more useful asset.
Sure, will do.
>
>> -		tpm_msleep(TPM_TIMEOUT);
>> +		tpm_msleep(TPM_TIMEOUT_POLL);
> What about just calling schedule()?
I'm not sure what you mean by "schedule()".  Are you suggesting instead 
of using usleep_range(),  using something with an even finer grain 
construct?

Thanks & Regards,
      - Nayna

>
> /Jarkko
>
