Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983ABC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C13E206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfAHLCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:02:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7546 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbfAHLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:02:37 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08Au4Jn016914;
        Tue, 8 Jan 2019 12:02:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ptt11xepy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 08 Jan 2019 12:02:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16C1238;
        Tue,  8 Jan 2019 11:01:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8E5C2A7F;
        Tue,  8 Jan 2019 11:01:58 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.50) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 8 Jan
 2019 12:01:57 +0100
Subject: Re: New IIO/counter driver
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
 <20190108004632.GA3247@icarus>
 <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <8b2bb569-a6e0-25ec-740d-48083b30fe60@st.com>
Date:   Tue, 8 Jan 2019 12:01:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 11:57 AM, Benjamin Gaignard wrote:
> Le mar. 8 janv. 2019 à 01:46, William Breathitt Gray
> <vilhelm.gray@gmail.com> a écrit :
>>
>> On Mon, Jan 07, 2019 at 02:45:37PM +0100, Patrick Havelange wrote:
>>> Hello,
>>>
>>> I'm in the process of adding a new IIO/counter driver, however I also saw
>>> that there was a work in progress to have a separate counter subsystem (
>>> https://marc.info/?l=linux-iio&m=153974167727206 ). But it seems there is
>>> no recent progress on it.
>>> What is the state of those patches ? Is it still interesting to develop the
>>> driver as an IIO/counter , or should I use already that new subsystem ?
>>>
>>> Best Regards,
>>>
>>> Patrick Havelange.
>>
>> Hello,
>>
>> I am still open to merging this patchset and maintaining the Counter
>> subsystem. However, I took the lack of response for my latest
>> submission to indicate a loss of interest in this patchset's approach.
>> If there are still people who want this, I can rebase and resend this
>> patchset for submission; the past few versions have primarily been code
>> clarity and documentation changes so I believe the core design itself is
>> somewhat stable now.
>>
>> Just let me know how best to proceed and I shall be happy to oblige --
>> whether to continue maintaining this patchset or to drop this design in
>> favor of improving the existing IIO Counter code in the kernel.
>>
>> I'll CC those from the patchset submission to keep them in the loop.
> 
> I confirm that I still interested to get those patches merged.
> 
> Regards,
> Benjamin
Hi,

Same for me,

Regards,
Fabrice
>>
>> Sincerely,
>>
>> William Breathitt Gray
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
