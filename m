Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061E9218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfBAPin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:38:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730408AbfBAPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:38:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11FUnSq002259
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 10:38:41 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qcrhx9buy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:38:40 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 1 Feb 2019 15:38:39 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 15:38:37 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11FcX3B22741082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 15:38:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C644AE05F;
        Fri,  1 Feb 2019 15:38:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DAEBAE060;
        Fri,  1 Feb 2019 15:38:33 +0000 (GMT)
Received: from [9.80.198.122] (unknown [9.80.198.122])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 15:38:33 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
 <20190201090159.GC3770@osiris>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 1 Feb 2019 10:38:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190201090159.GC3770@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020115-0064-0000-0000-000003A14D72
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010516; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154865; UDB=6.00602249; IPR=6.00935305;
 MB=3.00025389; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-01 15:38:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020115-0065-0000-0000-00003C41CB45
Message-Id: <a02f611b-370c-85b3-9e3d-c7dc2462004d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 4:01 AM, Heiko Carstens wrote:
> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
>> On 1/30/19 1:32 PM, Sebastian Ott wrote:
>>> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>>>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>>>> +void ap_bus_cfg_chg(void);
>>>> +#else
>>>> +#error "no CONFIG_ZCRYPT"
>>>     ^
>>> I don't think that's the right thing to do here.
>>
>> I'd like to leave it. If somebody edits .config
>> and sets CONFIG_ZCRYPT=n, then the build will
>> fail. The preprocessor error above tells them
>> why.
> 
> No, the kernel build should never fail if a config option is not set.
> Also the above should be "#ifdef CONFIG_ZCRYPT".

Will do.

> 
> In addition (this isn't quoted unfortunately) the alternative function
> in the header file is missing the "inline" attribute. Can you please
> add that too?

I can.

> 
> static inline void ap_bus_cfg_chg(void) { }
> 
>>>> +* A config change has happened, Force an ap bus rescan.
>>>> +*/
>>>> +void ap_bus_cfg_chg(void)
>>>> +{
>>>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>>>> +
>>>> +	ap_bus_force_rescan();
>>>> +}
>>>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
>>>
>>> There is no need for the export symbol - you don't call that function
>> >from module code.
>>> As an unrelated question, just to be sure: ap_bus.c is compiled as
>>> built-in even with ZCRYPT=m, right?
>>
>> No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
>> into the zcrypt.ko module. Through some other magic, the zcrypt module
>> is loaded when linux boots.
> 
> If that happens, then we have a build problem that needs to be
> fixed. What exactly are you doing to get the ap code linked into the
> zcrypt module?

To tell you the truth, I don't know. The build configuration precedes my
creating this patch by many years. I only discovered these anomalies by
playing with the CONFIG_ZCRYPT option in response to Sebastian's
comments. I will have to take this up with our internal IBM maintainer.

> 

