Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967957AbeBOMC2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:02:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967915AbeBOMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:02:16 -0500
Subject: Re: [PATCH] s390/console: enable dummy console for vt
To: Thomas Huth <thuth@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Farhan Ali <alifm@linux.vnet.ibm.com>,
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
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 15 Feb 2018 13:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f621e016-3811-b9c5-e044-779adc6b420c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021512-0012-0000-0000-000005B1001E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021512-0013-0000-0000-0000192D0005
Message-Id: <4116f119-b96e-a8c1-359a-dde488d61212@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 12:57 PM, Thomas Huth wrote:
> On 15.02.2018 12:26, Geert Uytterhoeven wrote:
>> Hi Christian,
>>
>> On Thu, Feb 15, 2018 at 12:14 PM, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>> To enable the virtual terminal layer with virtio-gpu, we need to
>>> provide the dummy console. This console is hidden behind CONFIG_IOMEM
>>> via the graphics support. Instead of fully enabling the graphic
>>> drivers lets just provide a Kconfig option for the dummy console.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>> New version: instead of moving around the graphic and console stuff,
>>> let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
>>>  arch/s390/Kconfig | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>>> index cbe1d978693a..a69690f616f3 100644
>>> --- a/arch/s390/Kconfig
>>> +++ b/arch/s390/Kconfig
>>> @@ -952,6 +952,11 @@ config S390_HYPFS_FS
>>>
>>>  source "arch/s390/kvm/Kconfig"
>>>
>>> +config DUMMY_CONSOLE
>>> +       bool
>>> +       depends on VT
>>> +       default y
>>> +
>>>  config S390_GUEST
>>>         def_bool y
>>>         prompt "s390 support for virtio devices"
>>
>> Really?
>>
>> You already have your own copy of HAS_IOMEM, which makes it hard for
>> people to track which one applies where.
> 
> I think I agree with Geert - let's better fix this in a proper way
> instead of doing hacks like this. I guess there will be other
> architectures in the future that might want to use the dummy console
> without CONFIG_IOMEM, so fixing this in drivers/video/ instead sounds
> better to me.

The question is, what is the proper fix?
