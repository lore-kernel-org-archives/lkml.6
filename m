Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeEGKtn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:49:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5547 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbeEGKtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:49:39 -0400
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Timeout issues in wait_for_avail function
Thread-Topic: Timeout issues in wait_for_avail function
Thread-Index: AdPl5MJ+cxjQClOhSGWGXpknWcpfpw==
Date: Mon, 7 May 2018 10:49:34 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C8D7B4E@DGGEMM506-MBS.china.huawei.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w47Ankue016267

Hi perex and tiwai:

I have met a timeout case when capture audio from snd-usb-audio device, 
when the host call the pcm_read and get into the wait_for_avail function.
The following happends
1.  No available data for capture(maybe because of the late response audio data by the uac device)
2.  The current thread falls into sleep state and no one wakes up it.
3.  The current thread will sleep 10s(schedule_timeout(1000)) and then wakeup.

I have two question about the wait_for_avail:
1. The timeout value too long, is it a reasonable value? 
2. Is there any mechanism to wake up the thread if there is data from the hw.

Regards
Zengtao
