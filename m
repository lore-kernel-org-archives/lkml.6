Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933484AbeE2LwF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:52:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39609 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933315AbeE2Lv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:51:59 -0400
X-Google-Smtp-Source: ADUXVKLo7WqkKJaXALLEq0A+rjSm2DwnYNbKGEpGyYPcN5h5fdJNsc138EeaS6rxRDDovrkOmOm2gw==
Subject: Re: [PATCH 5/5] remoteproc: Introduce prepare and unprepare for
 subdevices
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-6-elder@linaro.org>
 <3580eff5-56ef-c2a0-c8eb-c27850598587@st.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <d2d120c3-a875-7feb-00a9-e8e4d3e4dfbe@linaro.org>
Date: Tue, 29 May 2018 06:51:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3580eff5-56ef-c2a0-c8eb-c27850598587@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 04:16 AM, Arnaud Pouliquen wrote:
. . .

>> +unroll_preparation:
>> +	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
>> +		if (subdev->unprepare)
>> +			subdev->unprepare(subdev);
>> +	}
> Here you could call rproc_unprepare_subdevices instead of duplicating
> the code.

I thought the same thing, but it won't work because we only want to
unprepare those devices that were successfully prepared.  Here we are
unwinding the work that was partially done; in rproc_unprepare_subdevices()
*all* subdevices have their unprepare function called.

					-Alex
