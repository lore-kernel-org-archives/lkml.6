Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeE2Lbt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:31:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33501 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeE2Lbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:31:46 -0400
X-Google-Smtp-Source: AB8JxZpfMceNhCfzzDq5x5p2K/lw81zMqh92D7K7YJ7Pz0ZVzJQJ/sCK3VxzSd3IUrjCVvVGgaU+R3Hd8iFZurwqlrw=
MIME-Version: 1.0
In-Reply-To: <20180529042047.GE2259@tuxbook-pro>
References: <20180524192141.20323-1-ramon.fried@gmail.com> <20180529042047.GE2259@tuxbook-pro>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Tue, 29 May 2018 14:31:44 +0300
Message-ID: <CA+Kvs9mpjPDxFwzg=UGAYa1QQhM=WwXXQktar+Y-V5+d0JW3HQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 7:20 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Thu 24 May 12:21 PDT 2018, Ramon Fried wrote:
>
>> Sometimes that rmtfs userspace module is not brought
>> up fast enough and the modem crashes.
>> disabling automated boot in the driver and triggering
>> the boot from user-space sovles the problem.
>>
>> Signed-off-by: Ramon Fried <ramon.fried@gmail.com>
>
> Thanks for your patch Ramon. While this nudges the behavior to make
> things work slightly better I think we need to describe the explicit
> dependency between the mss firmware and the existence of rmtfs.
>
> As our remoteprocs are essentially always-on I would prefer that they
> start "automatically" and not through use of the sysfs interface.
>
> But we're at the point where this is a real problem on 410, 820 and 845,
> so we have to come up with some way to tie these pieces together. If
> your patch suits that solution I will happily take it.
Yes. it was tested on 410, and it did the trick.
>
> Regards,
> Bjorn
>
>> ---
>>  drivers/remoteproc/qcom_q6v5_pil.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
>> index cbbafdcaaecb..719ee96445b3 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -1133,6 +1133,8 @@ static int q6v5_probe(struct platform_device *pdev)
>>               return -ENOMEM;
>>       }
>>
>> +     rproc->auto_boot = false;
>> +
>>       qproc = (struct q6v5 *)rproc->priv;
>>       qproc->dev = &pdev->dev;
>>       qproc->rproc = rproc;
>> --
>> 2.17.0
>>
