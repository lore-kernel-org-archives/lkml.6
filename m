Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92879C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CE9240CB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxqwLKUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CE9240CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGEANH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 20:13:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54404 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbeGEANE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 20:13:04 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so9628207itb.4;
        Wed, 04 Jul 2018 17:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9bswVDL9rHANKusce/tq54cJqcTe6GaejPKqjT1A5is=;
        b=BxqwLKUSvqrxdRm4OVA0dGKazTOloeBMiEIhXAPF5IF0w4oTg28SBvDhfXJVocVPVc
         R4ys7mcMjsi39H6ipIzTr9nI9PAkM+629aw/Wn0KO16afpfmgy/7qqUqf83MFDspivd9
         eEbUmby2TyR+SIu7SGorZbG2T7mAxtjmkoFw3TQwTRsfFRATUtPLgZk5fb/E6f5Mx6Tm
         6KQxdR7yJ4rKb0fXuaCNif3cCQj/6Pe0NVm5yMsbOuyK4r+r+Hzpvg5LRRaxVscTECuE
         29eWqnUosnl53TK0U5n1bS7YncAWKx7PK2k5T41p7+O5a1hCJi7d+GhfTJdfXyt4douj
         1xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=9bswVDL9rHANKusce/tq54cJqcTe6GaejPKqjT1A5is=;
        b=ulfqSLT0VByyJHdIEy+knRHkvzOee6bW88n7dD97v3WUb/DnZrtR+kEJbaurRnjFuQ
         /NypdLJiZc0FNvOkZ0yzefcW82ZrwDKpbHCPtqWNHilkejl5T9iWCWWr0CCFpHONBgcp
         4v5xsMufAlkpWRVEPMxpMpQRrsa1FWLiRSXZ36eN5QZsQnbX8rXCRbWztm/ZnzdAype6
         OzwR3XOjMFlUoCh9Mi/O8j+BnElcW/LW+8Tx+DXVYw3OemCPsa7RI5IAs7NODoK4BEdR
         Kv0wlUxMmTgviERV59jNr8UFUpTyWeELm//mpGnNjfU+cXTidZmwP5CYYgxt5OT7Uj4N
         pAeQ==
X-Gm-Message-State: APt69E3cQLM8dxngdWrwaNtochQ/BYE7BGLGR0GiDq4rymSP3aelOoD/
        jb1D8sZ+jLzdcjnD52qa6L9VBigS/N7FRAAP0qU=
X-Google-Smtp-Source: AAOMgpev5xw/hKla4ACh5hy05k/9k7gnCa4lMnwX5l9GQREd9cLUBH8IEZTkx8FxHdpsfYHQmBJGN0o/qtYAxUIcylE=
X-Received: by 2002:a24:50d1:: with SMTP id m200-v6mr3151200itb.11.1530749583146;
 Wed, 04 Jul 2018 17:13:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2d44:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 17:13:02 -0700 (PDT)
Reply-To: cwchoi00@gmail.com
In-Reply-To: <20180704084550.7565-1-enric.balletbo@collabora.com>
References: <20180704084550.7565-1-enric.balletbo@collabora.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 5 Jul 2018 09:13:02 +0900
Message-ID: <CAGTfZH315DM0r4qxZ28rW=0SpWOJHjFoBij0=c8-OTG5BxeLAQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, kernel@collabora.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

2018-07-04 17:45 GMT+09:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> When the devfreq driver and the governor driver are built as modules,
> the call to devfreq_add_device() or governor_store() fails because the
> governor driver is not loaded at the time the devfreq driver loads. The
> devfreq driver has a build dependency on the governor but also should
> have a runtime dependency. We need to make sure that the governor driver
> is loaded before the devfreq driver.
>
> This patch fixes this bug by adding a try_then_request_governor()
> function. First tries to find the governor, and then, if it is not found,
> it requests the module and tries again.
>
> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v5:
> - Requested by MyungJoo and Chanwoo.
>   - Fix returning without the lock acquired after request_module.
> - Requested by Chanwoo.
>   - In request governor function check if governor name is NULL or not.
>   - Remove some unrelated changes (added/removed some blank lines).
>
> Changes in v4:
> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>   the unlock of governor_store(). Requested by MyungJoo Ham.
>
> Changes in v3:
> - Remove unneded change in dev_err message.
> - Fix err returned value in case to not find the governor.
>
> Changes in v2:
> - Add a new function to request the module and call that function from
>   devfreq_add_device and governor_store.
>
>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0b5b3abe054e..aa92fbf9f0dd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c

(snip)

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
