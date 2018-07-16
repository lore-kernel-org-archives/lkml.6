Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3DAECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4E42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBzpNsul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4E42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbeGPVpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:45:06 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:43307 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPVpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:45:05 -0400
Received: by mail-yb0-f177.google.com with SMTP id x10-v6so15997961ybl.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Pnok3buutn8JR8JlnE4KBdJPSkhyNW/nef+ikpRMko=;
        b=CBzpNsulYTQgVLFIBLsJkAsT6TH3UdnuFbTncbGXDsAzP1HTcyfE5xIGVPNTIixVNE
         48+CWLQWFiVTWhjiGaRA1en5/VOfdpo+qd+/dTZAMZ0TnRtGlqa3+NyzI28Xa3J4JgHl
         PmMeFnBbf/Hnpt1NyarU90sy0OId26UFkJErxHRpaP1BLh/XqKm6fAvjL5kE3qcaGwc9
         OuY1JVZ0fQmqw0VLBMlwFAeyLPAmMIu8Hm9O5xEfTVIhbRy/sKWtVNCkiXYnPsb8Ull4
         8qTSAS3v1tzzQN6iMEEhhjYxByj5VOVtfsmmaUvNud6kdDtRNJuAFbLnzRd+7atMOTmq
         eNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Pnok3buutn8JR8JlnE4KBdJPSkhyNW/nef+ikpRMko=;
        b=NFcsXukYOmSIZAWNpbmRiUpjbC7EW1EIMdH+dlxzkMetVNScT0NlV73NeQAyStL9/G
         sBREcLfK6HwH1H2NrxtXOE2Xw3MpLuK8t7F2LjUhIe91t92rIAu2bBM5Z26BBLg/2YlH
         SzrhrZ03v+pxKdv9ZuRO5DBBz8Xem/y69Vt62yn48d0mzB0BEv+71k22KIq4VUgjy0F0
         EgQzTnIuTKWlMHatf7G1zI+fB/FynhFzmsXh5yKTHcM88Iasg86nXY395bMN9jHvH/Rk
         R+4WnTkvYGS5iCB/wPjAVnylJcCOOJqXf5zVBvT8ZOLEwX0c9LN3idIqYIldEWjI8scb
         cAWg==
X-Gm-Message-State: AOUpUlH/2xv5Qocu0fU+yOnlPFWAdtF5HdNkPFF9xsmVe7OPY+iilTQI
        i4QOhAEyh+JyBul2/z/eiB9EkiXrix0/H1TbSX8=
X-Google-Smtp-Source: AAOMgpdbPIiHxX/7o3gZ8L3+fI/6vz9dQX5oq5j2oTwqNd1+LVSccg+Q2czui4X4gTyLQZkyzBUrpsegAWVYtc4XOwg=
X-Received: by 2002:a25:2f93:: with SMTP id v141-v6mr9385030ybv.214.1531775752467;
 Mon, 16 Jul 2018 14:15:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:15:51
 -0700 (PDT)
In-Reply-To: <20180716135335.hnvj5kqvsrrwzp3b@mwanda>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-5-toddpoynor@gmail.com>
 <20180716135335.hnvj5kqvsrrwzp3b@mwanda>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:15:51 -0700
Message-ID: <CAO3upoYjXOKN2O+ZQuS_LfiWd3PnzAZ5UB4xHivMSFgqaNBtcQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] staging: gasket: device registration error and
 unregister fixups
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  fail1:
>>       class_destroy(internal->class);
>>
>> +fail0:
>
> GW-BASIC sytle label names are an anti-pattern.  It's better to name the
> labels after what they do, just like function names describes what the
> function does.  Here it would be "goto clear_desc;" or something.  It
> doesn't have to be perfect but so long as you *try* to name it something
> useful that's better than not trying.
>
>> +     mutex_lock(&g_mutex);
>>       g_descs[desc_idx].driver_desc = NULL;
>> +     mutex_unlock(&g_mutex);
>>       return ret;
>>  }
>
> regards,
> dan carpenter

Thanks, I'll fix up the newly-added one in a respin of this patch and
fix up existing labels in a future patch.

-- 
Todd
