Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeDPVNb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:13:31 -0400
Received: from mailout.micron.com ([137.201.242.129]:30791 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDPVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:13:30 -0400
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "rajatja@google.com" <rajatja@google.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVx2ZtjVpJ9kJAR4mgs6eLh3g9fQ==
Date: Mon, 16 Apr 2018 21:10:57 +0000
Message-ID: <97d36126b86443f680aacfac23b0a04e@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23786.005
X-TM-AS-Result: No--15.916400-0.000000-31
X-TM-AS-MatchedID: 150567-139010-700648-703523-106660-704421-700022-851106-7
        00075-188019-708060-700476-701618-705388-702358-702039-709251-187067-700767
        -710207-702150-708712-707163-709584-706719-701099-704049-704425-707663-7029
        31-711432-105700-703378-700107-148004-148046-148133-148980-10013-20043-4200
        0-42003-29961-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GLDbQD013474

Hi, Bart

>mingo@redhad.com; linux-block@vger.kernel.org; rajatja@google.com
>Subject: [EXT] Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI
>trace events
>
>On Mon, 2018-04-16 at 14:31 +0000, Bean Huo (beanhuo) wrote:
>>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u
>prot_sgl=%u" \
>> -		  " prot_op=%s cmnd=(%s %s raw=%s)",
>> +		  " prot_op=%s tag=%d cmnd=(%s %s raw=%s)",
>>
>> [ ... ]
>>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u
>prot_sgl=%u" \
>> -		  " prot_op=%s cmnd=(%s %s raw=%s) rtn=%d",
>> +		  " prot_op=%s tag=%d cmnd=(%s %s raw=%s) rtn=%d",
>> [ ... ]
>>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u " \
>> -		  "prot_sgl=%u prot_op=%s cmnd=(%s %s raw=%s)
>result=(driver=" \
>> -		  "%s host=%s message=%s status=%s)",
>> +		  "prot_sgl=%u prot_op=%s tag=%d cmnd=(%s %s raw=%s) " \
>> +		  "result=(driver=%s host=%s message=%s status=%s)",
>
>Which tools process these strings? Has it been verified whether or not the
>tools that process these strings still work fine with this patch applied?
> 

I don't use one certain special tool to analyze this string, I am using ftrace with event.
With tag information, I can see how many tasks in storage device and easily to trace each request
under multiple thread workload. 
Event there is someone who using certain tool to analyze this string, after adding additional
tag printout, in my opinion, they are happy to see it there. 

Again, you said if we add new feature in legacy block, we will also add new feature in blk-mq.
I still don't understand here.  "include/trace/event/block.h ... scsi.h" will be changed?
If yes, how? Because blk-mq is still using the events defined in include/trace/event/block.h.

Bean Huo

>Thanks,
>
>Bart.
>
