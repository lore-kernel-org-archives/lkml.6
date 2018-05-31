Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeEaOSV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:18:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755261AbeEaOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:18:18 -0400
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Edward A. James" <eajames@us.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
 <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
 <8aaa7fa9874bf140354964535ce5cf023012c3f4.camel@kernel.crashing.org>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Thu, 31 May 2018 09:18:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8aaa7fa9874bf140354964535ce5cf023012c3f4.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18053114-0008-0000-0000-0000030F5EAF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009102; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040332; UDB=6.00532530; IPR=6.00819460;
 MB=3.00021393; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-31 14:18:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053114-0009-0000-0000-0000396BB9DD
Message-Id: <b268046f-fd9c-8a04-5fe5-adf0ae036186@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2018 04:16 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2018-05-30 at 10:47 -0500, Eddie James wrote:
>>>> +       if (!list_empty(&i2c->ports)) {
>>> My gosh, this is done already in list_for_each*()
>> No, list_for_each_entry does NOT check if the list is empty or if the
>> first entry is NULL.
> NULL is never valid for a list. It does however check for an empty list
>
> It does it implicitely in the test part of the for () statement,
> checking if the next pointer points back to the head.

Thanks Ben. My mistake on this one; I misread the macro. I will remove 
the check in v9... going to wait a little for any further comments now.

Thanks,
Eddie

>
> Cheers,
> Ben.
>
>
