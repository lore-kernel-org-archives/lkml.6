Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0682EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64602087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64602087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeJLRSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:18:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47494 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbeJLRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:18:03 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9C9hvKC022198;
        Fri, 12 Oct 2018 11:46:22 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n0se73c2y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 12 Oct 2018 11:46:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82D9D31;
        Fri, 12 Oct 2018 09:46:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18BA527A4;
        Fri, 12 Oct 2018 09:46:20 +0000 (GMT)
Received: from [10.201.23.162] (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 12 Oct
 2018 11:46:19 +0200
Subject: Re: [PATCH V4 0/4] Add TIOCM Signals support for RPMSG char devices
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Arun Kumar Neelakantam <aneela@codeaurora.org>, <ohad@wizery.com>,
        <clew@codeaurora.org>, <sricharan@codeaurora.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
 <a64808ba-3c67-3ee9-9c13-3787e5ce7ab1@st.com>
 <20181008162325.GA1331@tuxbook-pro>
 <a3bba20d-1913-ec4c-f0a9-66413276efd8@st.com>
 <20181009182712.GC28399@tuxbook-pro>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 xsFNBFZu+HIBEAC/bt4pnj18oKkUw40q1IXSPeDFOuuznWgFbjFS6Mrb8axwtnxeYicv0WAL
 rWhlhQ6W2TfKDJtkDygkfaZw7Nlsj57zXrzjVXuy4Vkezxtg7kvSLYItQAE8YFSOrBTL58Yd
 d5cAFz/9WbWGRf0o9MxFavvGQ9zkfHVd+Ytw6dJNP4DUys9260BoxKZZMaevxobh5Hnram6M
 gVBYGMuJf5tmkXD/FhxjWEZ5q8pCfqZTlN9IZn7S8d0tyFL7+nkeYldA2DdVplfXXieEEURQ
 aBjcZ7ZTrzu1X/1RrH1tIQE7dclxk5pr2xY8osNePmxSoi+4DJzpZeQ32U4wAyZ8Hs0i50rS
 VxZuT2xW7tlNcw147w+kR9+xugXrECo0v1uX7/ysgFnZ/YasN8E+osM2sfa7OYUloVX5KeUK
 yT58KAVkjUfo0OdtSmGkEkILWQLACFEFVJPz7/I8PisoqzLS4Jb8aXbrwgIg7d4NDgW2FddV
 X9jd1odJK5N68SZqRF+I8ndttRGK0o7NZHH4hxJg9jvyEELdgQAmjR9Vf0eZGNfowLCnVcLq
 s+8q3nQ1RrW5cRBgB8YT2kC8wwY5as8fhfp4846pe2b8Akh0+Vba5pXaTvtmdOMRrcS7CtF6
 Ogf9zKAxPZxTp0qGUOLE3PmSc3P3FQBLYa6Y+uS2v2iZTXljqQARAQABzSpBcm5hdWQgUG91
 bGlxdWVuIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT7CwX4EEwECACgFAlZu+HICGyMFCQlm
 AYAGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEP0ZQ+DAfqbfdXgP/RN0bU0gq3Pm1uAO
 4LejmGbYeTi5OSKh7niuFthrlgUvzR4UxMbUBk30utQAd/FwYPHR81mE9N4PYEWKWMW0T3u0
 5ASOBLpQeWj+edSE50jLggclVa4qDMl0pTfyLKOodt8USNB8aF0aDg5ITkt0euaGFaPn2kOZ
 QWVN+9a5O2MzNR3Sm61ojM2WPuB1HobbrCFzCT+VQDy4FLU0rsTjTanf6zpZdOeabt0LfWxF
 M69io06vzNSHYH91RJVl9mkIz7bYEZTBQR23KjLCsRXWfZ+54x6d6ITYZ2hp965PWuAhwWQr
 DdTJ3gPxmXJ7xK9+O15+DdUAbxF9FJXvvt9U5pTk3taTM3FIp/qaw77uxI/wniYA0dnIJRX0
 o51sjR6cCO6hwLciO7+Q0OCDCbtStuKCCCTZY5bF6fuEqgybDwvLGAokYIdoMagJu1DLKu4p
 seKgPqGZ4vouTmEp6cWMzSyRz4pf3xIJc5McsdrUTN2LtcX63E45xKaj/n0Neft/Ce7OuyLB
 rr0ujOrVlWsLwyzpU5w5dX7bzkEW1Hp4mv44EDxH9zRiyI5dNPpLf57I83Vs/qP4bpy7/Hm1
 fqbuM0wMbOquPGFI8fcYTkghntAAXMqNE6IvETzYqsPZwT0URpOzM9mho8u5+daFWWAuUXGA
 qRbo7qRs8Ev5jDsKBvGhzsFNBFZu+HIBEACrw5wF7Uf1h71YD5Jk7BG+57rpvnrLGk2s+YVW
 zmKsZPHT68SlMOy8/3gptJWgddHaM5xRLFsERswASmnJjIdPTOkSkVizfAjrFekZUr+dDZi2
 3PrISz8AQBd+uJ29jRpeqViLiV+PrtCHnAKM0pxQ1BOv8TVlkfO7tZVduLJl5mVoz1sq3/C7
 hT5ZICc2REWrfS24/Gk8mmtvMybiTMyM0QLFZvWyvNCvcGUS8s2a8PIcr+Xb3R9H0hMnYc2E
 7bc5/e39f8oTbKI6xLLFLa5yJEVfTiVksyCkzpJSHo2eoVdW0lOtIlcUz1ICgZ7vVJg7chmQ
 nPmubeBMw73EyvagdzVeLm8Y/6Zux8SRab+ZcU/ZQWNPKoW5clUvagFBQYJ6I2qEoh2PqBI4
 Wx0g1ca7ZIwjsIfWS7L3e310GITBsDmIeUJqMkfIAregf8KADPs4+L71sLeOXvjmdgTsHA8P
 lK8kUxpbIaTrGgHoviJ1IYwOvJBWrZRhdjfXTPl+ZFrJiB2E55XXogAAF4w/XHpEQNGkAXdQ
 u0o6tFkJutsJoU75aHPA4q/OvRlEiU6/8LNJeqRAR7oAvTexpO70f0Jns9GHzoy8sWbnp/LD
 BSH5iRCwq6Q0hJiEzrVTnO3bBp0WXfgowjXqR+YR86JPrzw2zjgr1e2zCZ1gHBTOyJZiDwAR
 AQABwsFlBBgBAgAPBQJWbvhyAhsMBQkJZgGAAAoJEP0ZQ+DAfqbfs5AQAJKIr2+j+U3JaMs3
 px9bbxcuxRLtVP5gR3FiPR0onalO0QEOLKkXb1DeJaeHHxDdJnVV7rCJX/Fz5CzkymUJ7GIO
 gpUGstSpJETi2sxvYvxfmTvE78D76rM5duvnGy8lob6wR2W3IqIRwmd4X0Cy1Gtgo+i2plh2
 ttVOM3OoigkCPY3AGD0ts+FbTn1LBVeivaOorezSGpKXy3cTKrEY9H5PC+DRJ1j3nbodC3o6
 peWAlfCXVtErSQ17QzNydFDOysL1GIVn0+XY7X4Bq+KpVmhQOloEX5/At4FlhOpsv9AQ30rZ
 3F5lo6FG1EqLIvg4FnMJldDmszZRv0bR0RM9Ag71J9bgwHEn8uS2vafuL1hOazZ0eAo7Oyup
 2VNRC7Inbc+irY1qXSjmq3ZrD3SSZVa+LhYfijFYuEgKjs4s+Dvk/xVL0JYWbKkpGWRz5M82
 Pj7co6u8pTEReGBYSVUBHx7GF1e3L/IMZZMquggEsixD8CYMOzahCEZ7UUwD5LKxRfmBWBgK
 36tfTyducLyZtGB3mbJYfWeI7aiFgYsd5ehov6OIBlOz5iOshd97+wbbmziYEp6jWMIMX+Em
 zqSvS5ETZydayO5JBbw7fFBd1nGVYk1WL6Ll72g+iEnqgIckMtxey1TgfT7GhPkR7hl54ZAe
 8mOik8I/F6EW8XyQAA2P
Message-ID: <8efdf3c6-2c52-cff2-d99f-3abb0b54cb31@st.com>
Date:   Fri, 12 Oct 2018 11:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009182712.GC28399@tuxbook-pro>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/09/2018 08:27 PM, Bjorn Andersson wrote:
> On Tue 09 Oct 09:02 PDT 2018, Arnaud Pouliquen wrote:
> 
>> hello Bjorn,
>>
>> On 10/08/2018 06:23 PM, Bjorn Andersson wrote:
>>> On Mon 08 Oct 06:08 PDT 2018, Arnaud Pouliquen wrote:
>>>
>>>> Hi Arun, Bjorn,
>>>>
>>>> On 10/08/2018 08:38 AM, Arun Kumar Neelakantam wrote:
>>>>> Glink transport support signals to exchange state notification between
>>>>> local and remote side clients. Adding support to send/receive the signal
>>>>> command and notify the clients through callback and POLL notification.
>>>>
>>>> Please correct me if i'm wrong...My concern here is that this patchset
>>>> implements a rpmsg service in the rpmsg core. I would separate this from
>>>> the rpmsg core, as this is not part of the rpmsg protocol but seems
>>>> linked to the serial protocol itself.
>>>> Could it be implemented in rpmsg_char, using a dedicated channel...?
>>>>
>>>
>>> rpmsg_char does expose a rpmsg channel (be it virtio, smd or glink) to
>>> user space. This patch series add support for invoking TIOCMGET and
>>> TIOCMSET on these channels.
>>
>> I'm not familiar with this concept, that could explain that i don't
>> understand this patchset...
>>
>> TIOCMGET and TIOCMSET is related to the serial/console flow control, to
>> control remote modem/processor, right?
>>
> 
> Correct, using the known tty ioctls for flow control we allow userspace
> to communicate flow control information to the rpmsg_char driver.
> 
>> it seems be implemented only to support the rpmsg_char ioctl interface.
>> When i have a look to the glink code, signal is treated by a message
>> sent to remote processor. Therefore it seems that it could be treated as
>> a service on top of rpmsg (so treat it in rpmsg_char instead of extend
>> the rpmsg protocol to treat it in glink driver).
>>
> 
> The glink message is a control message, so it's not possible to pass
> this inside a channel. As such it's not possible to solve this entirely
> in rpmsg_char.
> 
> Looking at SMD, this is a set of bits in a per-channel control
> structure. So there it's clearer that it's some side-band control
> information.
> 
> 
> Further more, the rpmsg_char driver just exposes a channel to user
> space, it does not care about the data inside. As such it's not possible
> to generically extend it to support this with in-band messages.
> 
>>>
>>> In addition to adding the client side of this to rpmsg_char it provides
>>> this support for glink, but the same mechanism exists in smd - while
>>> this is not supported (today) by the virtio rpmsg.
>> This is my main concern, i would like to be sure that this service is
>> not related to specific needs introduced by the rmpsg char implementation:
>> In this case this should not be part of the rpmsg core but perhaps some
>> ops directly provided to the rpmsg_char on registration
>> (rpmsg_chrdev_register_device?)...
>>
> 
> Arun's imminent need is for a user space client that needs to flow
> control the incoming data stream. But the possibility of controlling the
> incoming flow of data is useful in a number of situations.
> 
>>>
>>>
>>> I'm uncertain of how we could implement this mechanism for virtio rpmsg,
>>> given that it as a transport doesn't really have a concept of
>>> channels/flows - but it's really useful to have!
>>>
>>> PS. rpmsg_set_signals() can be called from any rpmsg device to perform
>>> flow control of the communication channel.
>>
>> For my point of view this patch-set extends the rpmsg protocol to add
>> channel flow control.
>> Does it make sense to have a flow control in rpmsg protocol?
>> if yes, should it be linked to a channel or to the remote processor itself?
>>
> 
> Having per-channel flow control particularly useful in scenarios where
> one has multiple types of data flowing over a shared underlying FIFO -
> such as virtio rpmsg. As this allows these different applications to
> limit the data rate without having to use application specific side band
> controls.

Agree that per-channel flow control could be useful to give priorities
an limit data flow rate. And as discussed yesterday in Openamp meeting,
rpmsg seems the well place to add a kind of channel controller.

That's means than we should probably need a generic way to configure
flow control, not based on TTY ioctl protocol, but compatible with its
associated feature.

If you need a short term solution, perhaps, a first step could be to
define a more generic API, that would be bypassed to the rpmsg backend
driver...

From my POV, a blocking point in current patch is that rpmsg_set_signals
and rpmsg_get_signals create dependency between the client the back-end
driver in term of parameters. Both have to know the signification of
these parameters, that are not defined in the interface, but in user
ioctl API. This seems not suitable for non rpmsg_char client that would
use flow control.
Other concern is that the term "signals" seems too generic if it is
dedicated to flow control.

Regards,
Arnaud

> 
>> Extra comment: associated documentation update is missing.
>>
> 
> Good catch, we should have a section in Documentation/rpmsg.txt
> describing this mechanism.
> 
> Regards,
> Bjorn
> 
>> Regards,
>> Arnaud
>>
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> Regards
>>>> Arnaud
>>>>
>>>>>
>>>>> Changes since v1:
>>>>> - Split the patches as per functional areas like core, char, glink
>>>>> - Add set, clear mask for TIOCMSET
>>>>> - Merge the char signal callback and POLLPRI patches
>>>>>
>>>>> Changes since v2:
>>>>> - Modify the rpmsg_get_signals function prototype
>>>>>
>>>>> Changes since v3:
>>>>> - Correct the TICOMGET case handling as per new rpmsg_get_signals prototype
>>>>> - Update the rpmsg_get_signals function header
>>>>>
>>>>> Arun Kumar Neelakantam (4):
>>>>>   rpmsg: core: Add signal API support
>>>>>   rpmsg: glink: Add support to handle signals command
>>>>>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
>>>>>   rpmsg: char: Add signal callback and POLLPRI support
>>>>>
>>>>>  drivers/rpmsg/qcom_glink_native.c | 126 ++++++++++++++++++++++++++++++++++++++
>>>>>  drivers/rpmsg/rpmsg_char.c        |  74 +++++++++++++++++++++-
>>>>>  drivers/rpmsg/rpmsg_core.c        |  41 +++++++++++++
>>>>>  drivers/rpmsg/rpmsg_internal.h    |   5 ++
>>>>>  include/linux/rpmsg.h             |  26 ++++++++
>>>>>  5 files changed, 269 insertions(+), 3 deletions(-)
>>>>>
