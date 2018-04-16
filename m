Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeDPU3d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:29:33 -0400
Received: from mailout.micron.com ([137.201.242.129]:26322 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeDPU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:29:31 -0400
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Bart Van Assche <bart.vanassche@wdc.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rajatja@google.com" <rajatja@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVwUmBGJhhKEdfRWiDz1LGRhoC8w==
Date: Mon, 16 Apr 2018 20:27:13 +0000
Message-ID: <5b2fdd1b29b54590889194eba90debfb@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23786.005
X-TM-AS-Result: No--8.854100-0.000000-31
X-TM-AS-MatchedID: 150567-139010-702931-704425-707663-700023-704421-711432-7
        02020-705901-106420-707800-702358-700604-700276-700107-703788-710842-700767
        -188019-703829-701236-187067-701450-701583-707163-703378-705861-851106-1480
        04-148046-148133-148980-42000-42003-29961-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GKTiGI009856

>>> This patch is not acceptable because it adds support for tag tracing
>>> to the legacy block layer only. Any patch that adds a new feature to
>>> the legacy block layer must also add it to blk-mq.
>>>
>> To be honest, I don't understand your point, can you give me more
>explanation?
>
>The legacy block layer will be removed as soon as blk-mq provides all the
>functionality of the legacy block layer and as soon as it performs at least as
>well as the legacy block layer for all use cases. If new features are added to
>the legacy block layer but not to blk-mq that prevents removal of the legacy
>block layer. Hence the requirement I explained in my previous e-mail.
>
>Bart.

Thanks for your information.
I have several questions again.
When the legacy block layer will be replaced by blk-mq? 
And "include/trece/event/block.h .. scsi.h" will also be changed? 
Do you have the related git rep or mail list about this topic?
Maybe this is great big change, I am very interested in that. And want to have a look at.

By the way, these patches are not to add new feature, they are just to add print tag along with the other exist
Printed request parameters.  The blk-mq is now still using "include/trace/evet/block.h" defined trace events.

For example: 
void blk_mq_start_request(struct request *rq)  
{
...
...
trace_block_rq_issue(q, rq);
...
...
}
Do you mean that this will also be removed/replaced by someone else?

Bean Huo
