Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36210606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeFFOpq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:45:46 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37733 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeFFOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:45:45 -0400
X-Google-Smtp-Source: ADUXVKKiGC4s13aDjl+c9onK+fVGQJH3q4dymdtBDcPHCvN71ARg/nZNNeqKBQI8zBTg5P6bTWrGpigmTU3Wx0RlSjs=
MIME-Version: 1.0
In-Reply-To: <20180605171604.GA221901@dtor-ws>
References: <20180605171604.GA221901@dtor-ws>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 6 Jun 2018 16:45:43 +0200
Message-ID: <CAO-hwJ++CB6xy9jwRmBz1Gj0LjF368D8w5nYiqkObo5Xy3g84g@mail.gmail.com>
Subject: Re: [RFC/PATCH] Input: make input_report_slot_state() return boolean
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:16 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Let's make input_report_slot_state() return boolean representing whether
> the contact is active or not. This will allow writing code like:
>
>         if (input_mt_report_slot_state(input, obj->mt_tool,
>                                         obj->type != RMI_2D_OBJECT_NONE) {
>
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
>                 ...
>         }
>
> instead of:
>
>         input_mt_report_slot_state(input, obj->mt_tool,
>                                    obj->type != RMI_2D_OBJECT_NONE);
>         if (obj->type != RMI_2D_OBJECT_NONE) {
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
>                 ...
>         }
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me as well.

In case you still need it:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redaht.com>

Cheers,
Benjamin
