Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934600AbeEIJFO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:05:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934094AbeEIJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:05:11 -0400
Subject: Re: [PATCH 0/3] scsi: arcmsr: Add driver parameter cmd_timeout for
 scsi command timeout setting
To: Ching Huang <ching2048@areca.com.tw>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        hch@infradead.org, colin.king@canonical.com
References: <1525675401.8876.9.camel@Centos6.3-64>
 <yq1in7ywvo8.fsf@oracle.com> <1525761166.4261.8.camel@Centos6.3-64>
 <1525761818.4261.12.camel@Centos6.3-64>
From: Steffen Maier <maier@linux.ibm.com>
Date: Wed, 9 May 2018 11:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525761818.4261.12.camel@Centos6.3-64>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18050909-0012-0000-0000-000005D4529B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050909-0013-0000-0000-0000195167F3
Message-Id: <d84beeb7-b502-c465-ea39-7d85bdcdb72f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090088
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/08/2018 08:43 AM, Ching Huang wrote:
> On Tue, 2018-05-08 at 14:32 +0800, Ching Huang wrote:
>> On Tue, 2018-05-08 at 01:41 -0400, Martin K. Petersen wrote:
>>> Hello Ching,
>>>
>>>> 1. Add driver parameter cmd_timeout, default value is ARCMSR_DEFAULT_TIMEOUT.
>>>> 2. Add slave_configure callback function to set device command timeout value.
>>>> 3. Update driver version to v1.40.00.06-20180504.
>>>
>>> I am not so keen on arcmsr overriding the timeout set by the admin or
>>> application.
>>>
>>> Also, instead of introducing this module parameter, why not simply ask
>>> the user to change rq_timeout?
>>>
>> This timeout setting only after device has been inquiry successfully.
>> Of course, user can set timeout value to /sys/block/sdX/device/timeout.
>> But user does not like to set this value once command timeout occurred.
>> They rather like timeout never happen.
>>
> This timeout setting apply to all devices, its better than user has to
> set one bye one for each device.

Udev rules?

Something roughly like bottom of:
https://www.ibm.com/support/knowledgecenter/ST3FR7_8.1.2/com.ibm.storwize.v7000.812.doc/svc_linux_settings.html
or better doing the assignment with udev builtins (fix the syntax error 
with model):
https://www.ibm.com/support/knowledgecenter/ST3FR7_8.1.2/com.ibm.storwize.v7000.812.doc/svc_zs_statechange_3fgeri.html

-- 
Mit freundlichen Grüßen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
