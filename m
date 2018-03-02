Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428529AbeCBOLH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:11:07 -0500
Received: from a8-62.smtp-out.amazonses.com ([54.240.8.62]:44130 "EHLO
        a8-62.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1425035AbeCBOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:11:03 -0500
Subject: Re: [PATCH] scsi: sd: Keep disk read-only when re-reading partition
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
 <20180302120038.4mgcn2lmft4ygqz4@linux-x5ow.site>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <01000161e70d459d-67080961-ba28-43ff-b519-2432ce5313f7-000000@email.amazonses.com>
Date: Fri, 2 Mar 2018 14:11:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302120038.4mgcn2lmft4ygqz4@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2018.03.02-54.240.8.62
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 07:00 AM, Johannes Thumshirn wrote:
> On Thu, Mar 01, 2018 at 02:08:10PM +0000, Jeremy Cline wrote:
>> If the read-only flag is true on a SCSI disk, re-reading the partition
>> table sets the flag back to false.
>>
>> To observe this bug, you can run:
>>
>> 1. blockdev --setro /dev/sda
>> 2. blockdev --rereadpt /dev/sda
>> 3. blockdev --getro /dev/sda
> 
> hi Jeremy,
> 
> Do you mind wiring up a testcase in blktest [1] for this? Given that
> you already have a rather trivial reproducer.
> 
> [1] https://github.com/osandov/

Hi Johannes,

Sure, I'll take care of it.

Regards,
Jeremy
