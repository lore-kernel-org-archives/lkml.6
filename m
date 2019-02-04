Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E3BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDF32087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfBDKGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:06:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727217AbfBDKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:06:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x149t5iQ113373
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 05:06:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qejxx9dc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 05:06:16 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Mon, 4 Feb 2019 10:06:14 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 10:06:13 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14A6BHx2228626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 10:06:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F9675204E;
        Mon,  4 Feb 2019 10:06:11 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA2CB52050;
        Mon,  4 Feb 2019 10:06:10 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com,
        cohuck@redhat.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
 <20190201090159.GC3770@osiris>
 <a02f611b-370c-85b3-9e3d-c7dc2462004d@linux.ibm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Mon, 4 Feb 2019 11:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a02f611b-370c-85b3-9e3d-c7dc2462004d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19020410-0020-0000-0000-0000031148A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020410-0021-0000-0000-000021625365
Message-Id: <e42e9ddb-e771-2789-727c-917ca3e176f2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.19 16:38, Tony Krowiak wrote:
> On 2/1/19 4:01 AM, Heiko Carstens wrote:
>> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
>>> On 1/30/19 1:32 PM, Sebastian Ott wrote:
>>>> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>>>>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>>>>> +void ap_bus_cfg_chg(void);
>>>>> +#else
>>>>> +#error "no CONFIG_ZCRYPT"
>>>>     ^
>>>> I don't think that's the right thing to do here.
>>>
>>> I'd like to leave it. If somebody edits .config
>>> and sets CONFIG_ZCRYPT=n, then the build will
>>> fail. The preprocessor error above tells them
>>> why.
>>
>> No, the kernel build should never fail if a config option is not set.
>> Also the above should be "#ifdef CONFIG_ZCRYPT".
>
> Will do.
>
>>
>> In addition (this isn't quoted unfortunately) the alternative function
>> in the header file is missing the "inline" attribute. Can you please
>> add that too?
>
> I can.
>
>>
>> static inline void ap_bus_cfg_chg(void) { }
>>
>>>>> +* A config change has happened, Force an ap bus rescan.
>>>>> +*/
>>>>> +void ap_bus_cfg_chg(void)
>>>>> +{
>>>>> +    AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>>>>> +
>>>>> +    ap_bus_force_rescan();
>>>>> +}
>>>>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
>>>>
>>>> There is no need for the export symbol - you don't call that function
>>> >from module code.
>>>> As an unrelated question, just to be sure: ap_bus.c is compiled as
>>>> built-in even with ZCRYPT=m, right?
>>>
>>> No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
>>> into the zcrypt.ko module. Through some other magic, the zcrypt module
>>> is loaded when linux boots.
>>
>> If that happens, then we have a build problem that needs to be
>> fixed. What exactly are you doing to get the ap code linked into the
>> zcrypt module?
>
> To tell you the truth, I don't know. The build configuration precedes my
> creating this patch by many years. I only discovered these anomalies by
> playing with the CONFIG_ZCRYPT option in response to Sebastian's
> comments. I will have to take this up with our internal IBM maintainer.
>
>>
>
As Martin already pointed out the ap bus code is statically build into the kernel
with this line in the Makefile:
  obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
So CONFIG_ZCRYPT may have the value 'm' or 'y'
and this is also the reason why a simple #ifdef CONFIG_ZCRYPT does not
work, instead #if IS_ENABLED(CONFIG_ZCRYPT) has to be used.

Only the ap stuff (which is: ap_bus.o, ap_card.o and ap_queue.o) is statically
build into the kernel. The zcrypt kernel module is loaded as a dependency
when a crypto card is detected. So detecting a CEX4 forces kernel module
zcrypt_cex4.ko which forces the zcrypt.ko to insert into the kernel.
So all global functions in ap_bus.c are available when CONFIG_ZCRYPT is
enabled. However, I thought the symbol still needs an EXPORT_SYMBOL()
statement. Otherwise I should throw out all these statements.

Harald

