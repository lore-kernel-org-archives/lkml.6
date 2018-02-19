Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeBSOBd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:01:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752686AbeBSOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:01:30 -0500
Subject: Re: [PATCH] s390/console: enable dummy console for vt
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
References: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
 <20180215111423.96598-1-borntraeger@de.ibm.com>
 <CAMuHMdWCK1V3PWXHMNZUmFVMCSqi5xhs72mT_M=gE96TSzMN9w@mail.gmail.com>
 <f621e016-3811-b9c5-e044-779adc6b420c@redhat.com>
 <4116f119-b96e-a8c1-359a-dde488d61212@de.ibm.com>
 <b2615fca-2784-4f0a-2f21-7e7074c6760b@linux.vnet.ibm.com>
 <ef45a7d8-206b-3583-404e-f9078b7023b2@de.ibm.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 09:01:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <ef45a7d8-206b-3583-404e-f9078b7023b2@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18021914-0004-0000-0000-000013AFE779
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008560; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992017; UDB=6.00503942; IPR=6.00771362;
 MB=3.00019635; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 14:01:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021914-0005-0000-0000-0000862684A2
Message-Id: <b8948d24-3351-2a8c-de2a-1c1c94685778@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2018 08:37 AM, Christian Borntraeger wrote:
> 
> 
> On 02/19/2018 02:35 PM, Farhan Ali wrote:
>>
>>
>> On 02/15/2018 07:02 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 02/15/2018 12:57 PM, Thomas Huth wrote:
>>>> On 15.02.2018 12:26, Geert Uytterhoeven wrote:
>>>>> Hi Christian,
>>>>>
>>>>> On Thu, Feb 15, 2018 at 12:14 PM, Christian Borntraeger
>>>>> <borntraeger@de.ibm.com> wrote:
>>>>>> To enable the virtual terminal layer with virtio-gpu, we need to
>>>>>> provide the dummy console. This console is hidden behind CONFIG_IOMEM
>>>>>> via the graphics support. Instead of fully enabling the graphic
>>>>>> drivers lets just provide a Kconfig option for the dummy console.
>>>>>>
>>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>> ---
>>>>>> New version: instead of moving around the graphic and console stuff,
>>>>>> let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
>>>>>>    arch/s390/Kconfig | 5 +++++
>>>>>>    1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>>>>>> index cbe1d978693a..a69690f616f3 100644
>>>>>> --- a/arch/s390/Kconfig
>>>>>> +++ b/arch/s390/Kconfig
>>>>>> @@ -952,6 +952,11 @@ config S390_HYPFS_FS
>>>>>>
>>>>>>    source "arch/s390/kvm/Kconfig"
>>>>>>
>>>>>> +config DUMMY_CONSOLE
>>>>>> +       bool
>>>>>> +       depends on VT
>>>>>> +       default y
>>>>>> +
>>>>>>    config S390_GUEST
>>>>>>           def_bool y
>>>>>>           prompt "s390 support for virtio devices"
>>>>>
>>>>> Really?
>>>>>
>>>>> You already have your own copy of HAS_IOMEM, which makes it hard for
>>>>> people to track which one applies where.
>>>>
>>>> I think I agree with Geert - let's better fix this in a proper way
>>>> instead of doing hacks like this. I guess there will be other
>>>> architectures in the future that might want to use the dummy console
>>>> without CONFIG_IOMEM, so fixing this in drivers/video/ instead sounds
>>>> better to me.
>>>
>>> The question is, what is the proper fix?
>>>
>>
>> How about we only fence off sub menu items such as DRM or GPU or Fbdev, which actually uses io memory, in drivers/video/Kconfig? Similar to what Thomas suggested for moving the CONFIG_IOMEM dependency for fbdevs?
> 
> Can you spin a patch?
> 
Yes, I will post it as V3.
