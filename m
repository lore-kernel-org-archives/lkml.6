Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA19924DFB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA19924DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeGCISB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:18:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43293 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbeGCIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:17:59 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so815921qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VyyBQEPjzsX4JSExyA6bThl9OxFWCIZcvp8f9y5GTUs=;
        b=KOeMwPAhIcOHYEa2Tc6TfjflniFXwQrfvrtZ0KCjNyr4ZqivqlSPI7zWbnO/vhQ/xb
         cvHAnYcSZ4uejRXR2Pg8jQUYK4AbeGx8IT0S76JC2Y9/A87tmpEWv8hMer5QbTIpTGYR
         G9b8sB+nOl8WQXTK2szvrP3Quo9qqgLHdYV+t7ZCkik4RTtmZCwUBgQ05XejNSu99oER
         G+NBtQBns1BcooHGltrbN63kYA27/u31z0t9K7spteS396iLB0aNPLniBNi6VPvFUs+M
         qFl5HbR9VBYgA4SvlcVcLdocevTLFlPhVDreZXKlG4QmKh8uE4zZTUmO9jX8BSNwVlB5
         wiPg==
X-Gm-Message-State: APt69E3O1Ilaj6JyENh3RMIHMgObTuwf6iYQpYcgO4OyME8TmZDHaz0e
        tWoWDWon0o+T7WDX528tE4dDjpViP/e0dv108TVTDQ==
X-Google-Smtp-Source: AAOMgpc/6GMY1IfxBNTRrGijv8LxvvfM/zQLoD67WSx27Vb/HWAvt2SKY6XzOAm+6V+hcpaN6kMkWDsWmqcjXmexRGg=
X-Received: by 2002:ac8:1a18:: with SMTP id v24-v6mr16146591qtj.115.1530605879061;
 Tue, 03 Jul 2018 01:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2fca:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 01:17:58 -0700 (PDT)
In-Reply-To: <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 3 Jul 2018 10:17:58 +0200
Message-ID: <CAO-hwJ+ZHb8xyr=1RgVROvP2=yzmepccVOqZM5qP3hbOEYEo9g@mail.gmail.com>
Subject: Re: [PATCH 4/4] HID: multitouch: remove unneeded else conditional cases
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Elide lone `else` cases and replace `else if` clauses
> with plain `if` conditionals when they occur immediately
> after return statements.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>

This one looks good.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Just FYI, I sent out a big refactor of the hid-multitouch code. Jiri
should be still reviewing it, so I am not so sure who will have to
rebase which series on top of the other, but someone between us will
have to do it :)

Cheers,
Benjamin

>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 08b50e5908cecdda66..30b1a2c67f39a41325 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -205,12 +205,12 @@ static void mt_post_parse(struct mt_device *td);
>
>  static int cypress_compute_slot(struct mt_device *td)
>  {
>         if (td->curdata.contactid != 0 || td->num_received == 0)
>                 return td->curdata.contactid;
> -       else
> -               return -1;
> +
> +       return -1;
>  }
>
>  static struct mt_class mt_classes[] = {
>         { .name = MT_CLS_DEFAULT,
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
> @@ -803,12 +803,12 @@ static int mt_compute_timestamp(struct mt_device *td, struct hid_field *field,
>         delta *= 100;
>
>         if (jdelta > MAX_TIMESTAMP_INTERVAL)
>                 /* No data received for a while, resync the timestamp. */
>                 return 0;
> -       else
> -               return td->timestamp + delta;
> +
> +       return td->timestamp + delta;
>  }
>
>  static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
>                                 struct hid_usage *usage, __s32 value)
>  {
> @@ -1110,11 +1110,12 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>          * HID_DG_CONTACTCOUNT from the pen report as it is outside the physical
>          * collection, but within the report ID.
>          */
>         if (field->physical == HID_DG_STYLUS)
>                 return 0;
> -       else if ((field->physical == 0) &&
> +
> +       if ((field->physical == 0) &&
>                  (field->report->id != td->mt_report_id) &&
>                  (td->mt_report_id != -1))
>                 return 0;
>
>         if (field->application == HID_DG_TOUCHSCREEN ||
> --
> 2.18.0
>
