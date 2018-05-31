Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeEaHnT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:43:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753740AbeEaHnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:43:18 -0400
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [alsa-devel] Timeout issues in wait_for_avail function
Thread-Topic: [alsa-devel] Timeout issues in wait_for_avail function
Thread-Index: AQHT6qbW0DvOfS0K70aSvYL4PbK3FaRJizRA
Date: Thu, 31 May 2018 07:43:10 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C91AA6C@DGGEMM506-MBS.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED0C8D7B4E@DGGEMM506-MBS.china.huawei.com>
 <s5h1sef96ua.wl-tiwai@suse.de>
In-Reply-To: <s5h1sef96ua.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4V7hkx9022025

Hi Takashi:

Thank you for your reply.

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Sunday, May 13, 2018 6:40 PM
>To: Zengtao (B) <prime.zeng@hisilicon.com>
>Cc: perex@perex.cz; tiwai@suse.com; alsa-devel@alsa-project.org;
>linux-kernel@vger.kernel.org
>Subject: Re: [alsa-devel] Timeout issues in wait_for_avail function
>
>On Mon, 07 May 2018 12:49:34 +0200,
>Zengtao (B) wrote:
>>
>> Hi perex and tiwai:
>>
>> I have met a timeout case when capture audio from snd-usb-audio
>> device, when the host call the pcm_read and get into the wait_for_avail
>function.
>> The following happends
>> 1.  No available data for capture(maybe because of the late response
>> audio data by the uac device)
>
>Hrm, in the case of capture, the data must be available.
>If it's not the case, something is wrong.
>
>> 2.  The current thread falls into sleep state and no one wakes up it.
>> 3.  The current thread will sleep 10s(schedule_timeout(1000)) and then
>wakeup.
>>
>> I have two question about the wait_for_avail:
>> 1. The timeout value too long, is it a reasonable value?
>> 2. Is there any mechanism to wake up the thread if there is data from the
>hw.
>
>The scenario above shouldn't happen, so no need for discussion.
>Rather we should check why it's woken up even though no data is available.
>

It really happens on my platform, and anyway 10 seconds timeout seems
not a reasonable value. And I don't there is any guarantee that there must be avail
data when we reach wait_for_avail, in fact, inside the wait_for_avail, there is branch
when no data is available.

>You can check the tracepoints to see the action of PCM stream, and confirm
>whether it's really no data, or it's just lost by some reason (or looks as if so).
>
I trace the data flow, we reach the wait_for_avail function before the usb snd data arrives, 
so we wait until 10 seconds timeout. 

>
>Takashi


Regards
Zengtao 
