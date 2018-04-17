Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeDQI1z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:27:55 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:57604 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751793AbeDQI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:27:53 -0400
Subject: Re: EXT: Re: [PATCHv1] Input: atmel_mxt_ts - fix the firmware update
To: Nick Dyer <nick@shmanahar.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
CC: Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
 <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
From: Nandor Han <nandor.han@ge.com>
Message-ID: <18fcfdcc-d43a-6ee3-07d5-af618b600e12@ge.com>
Date: Tue, 17 Apr 2018 09:37:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [3.159.19.191]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804170060
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/18 21:47, Nick Dyer wrote:
> On Thu, Mar 22, 2018 at 05:43:30PM +0100, Sebastian Reichel wrote:
>> The automatic update mechanism will trigger an update if the
>> info block CRCs are different between maxtouch configuration
>> file (maxtouch.cfg) and chip.
>>
>> The driver compared the CRCs without retrieving the chip CRC,
>> resulting always in a failure and firmware flashing action
>> triggered. The patch will fix this issue by retrieving the
>> chip info block CRC before the check.
> 
> Thanks for raising this, I agree it's definitely something we want to
> fix.
> 
> However, I'm not convinced you're solving the problem in the best way.
> You've attached it to the read_t9_resolution() code path, whereas the
> info block is common between T9 and T100 and works in the same way.
> 
> Would you mind trying the below patch? I've dusted it off from some
> work that I did back in 2012 and it should solve your issue.
> 
> It also has the benefit that by reading the information block and the
> object table into a contiguous region of memory, we can verify the
> checksum at probe time. This means we make sure that we are indeed
> talking to a chip that supports object protocol correctly.
> 

Thanks Nick. This looks like a better solution.
Sebastian will test this and we can see the results.


Nandor
