Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeERKGf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:06:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47006 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeERKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:06:33 -0400
X-Google-Smtp-Source: AB8JxZqb9dDce3eNWUSmxnPMsORJgjA5TuQcjirhZ5TU6TNhA2xsBl6MeTAPwfTsTai9almYiGuDH6GjctTFg49fUP0=
MIME-Version: 1.0
In-Reply-To: <58c8d2d16995e80f5527370e224045e2@codeaurora.org>
References: <20180517113250.16517-1-ramon.fried@linaro.org> <58c8d2d16995e80f5527370e224045e2@codeaurora.org>
From: Ramon Fried <ramon.fried@linaro.org>
Date: Fri, 18 May 2018 13:06:31 +0300
Message-ID: <CAODu4NqG9aTtoOx70cNk3=z3L-AKcrvxRPBO1xc9=vpWvqw-XA@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Add support for Factory Test Mode (FTM)
To: Jeff Johnson <jjohnson@codeaurora.org>
Cc: kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Eyal Ilsar <eilsar@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2018 at 21:37, Jeff Johnson <jjohnson@codeaurora.org> wrote:
> On 2018-05-17 04:32, Ramon Fried wrote:
>>
>> From: Eyal Ilsar <eilsar@codeaurora.org>
>
> ...
>>
>> +int wcn36xx_smd_process_ptt_msg(struct wcn36xx *wcn,
>> +                               struct ieee80211_vif *vif, void *ptt_msg,
>> size_t len,
>> +               void **ptt_rsp_msg)
>> +{
>> +       struct wcn36xx_hal_process_ptt_msg_req_msg *p_msg_body;
>> +       int ret = 0;
>> +
>> +       mutex_lock(&wcn->hal_mutex);
>> +       p_msg_body = kmalloc(
>> +               sizeof(struct wcn36xx_hal_process_ptt_msg_req_msg) + len,
>> +               GFP_ATOMIC);
>
>
> NULL check required?
>
>> +       INIT_HAL_PTT_MSG(p_msg_body, len);
>> +

Thanks Jeff. will fix it and send again :)
