Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C9F05C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DD208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kk+gNoUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4DD208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934067AbeFKR71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:59:27 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46223 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933523AbeFKR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:59:25 -0400
Received: by mail-ua0-f193.google.com with SMTP id e8-v6so14108626uam.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pYCppnVIy43p4TCBtrwiiTAi+zZ69XLjF8uxCAI02SE=;
        b=kk+gNoUOvpW4BGXmToN6yPZcmXoUNlqUegUgtKdfQS5zfrkRHZntmfTrAxIqnzGHuE
         M7RAs7Aye/Kb4/ZvOvYLu7b5WMAchChuYQLX73++dR+y40W2s1SfGGPbArq7sTcoHXsm
         Zbz1HqXD1EpsSZjfvAEiCAZd+xvXdd0pSPOTbYPkcZZQm/dmPEKlkBwrasqLYY3WNJKP
         IJInFPW/GI3ewT3CzyBTUzbGTtoeMpUHa7R5carMizQmSpCUfYrTwTjbeXg4Y+Diho5Q
         0RlfcMYQ5GXQSP2Cf5t0x9bq/SDYAUYpoTEF9kDE7OaQerDFEykEwtOBoK8/MD2Bcf7A
         +Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pYCppnVIy43p4TCBtrwiiTAi+zZ69XLjF8uxCAI02SE=;
        b=ez/klda7On0CaTHhy65cimNI9zZFaqQEwzakuUw3D++EM1SgL0p9T4RRASkfZQFszD
         7G7GZrSbdsRjSwe27O3o06T6HoqdHP7lantJHcMIhVp2vSyCq2jLiv+ZMcjtQkykiz0H
         YD+M6sq0swE27gF5iEqMiK9dGyx7gRq5gm3VF86qufP0DbGeYofsLvlQcVqIgJDW/7gE
         6PQ2JAwympjolpgu6DZjMybVj54tjQ6a5lawdwnl9qVtVl3IhtuyC99Rg+7zx3jAYo3/
         vnATE6Wq91qSaQSjflahelsPn70bWKVQ1VokjQtDG2wd6ESkCn7GX7cFq2sOxj254GSa
         5s6Q==
X-Gm-Message-State: APt69E2taPbk4vO28FpQ/dacv3cijLMzB7vg+2NCKlxOa4R1nZfm2I42
        M13rOj+D6pOZ9rbFehVdE3H/D9Y761x/VWn2Tk2LBw==
X-Google-Smtp-Source: ADUXVKLbrlJK8CkEFUM3eCyMj1Z97qdxzRJY6BiJCggC0OUjNwsg84XV9l4thR7kKOBeQbgLVvXAJdHBjMcA0MvsFwI=
X-Received: by 2002:a9f:37eb:: with SMTP id q98-v6mr127863uaq.152.1528739963624;
 Mon, 11 Jun 2018 10:59:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:80d4:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 10:59:03
 -0700 (PDT)
In-Reply-To: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
 <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
 <20180606231130.GA57957@decatoncale.mtv.corp.google.com> <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@google.com>
Date:   Mon, 11 Jun 2018 10:59:03 -0700
Message-ID: <CAOGSYL0dCWZvA1TYTFMWwJ7QGSSmwQcWxmJ+JZerxxt6=vx9Sg@mail.gmail.com>
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Benson Leung <bleung@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Hopefully this will clear things a bit.

1. Why is this patch needed ?
 Consider the following scenario.
      1. User left the device idle for some time.
      2. A deamon in the userland that controls suspend policy might
suspend the device. The lid is still open.
      3. Now the user returns and wakes the system up by pressing a
key. The system resumes.
      4. In the current implementation we call pm_wakeup_event() (if
the lid is open) irrespective of whether we have received a notify
signal.
      5. The deamon in the userland tries to identify what might woken
the system up based on the wakeup_count.
      6. The deamon sees a wakeup_count  increment for both keyboard
and lid and is confused.
 This patch is an attempt to address the same.

2. Will it break any existing logic ?
   AFAIK pm_wakeup_event() serves 2 purposes.
               1. Helps preventing a race between system wide suspend
and wakeup event.
               2. Helps identifying the device that woke the system up.

As far as preventing races during suspend is concerned, in the
existing implementation, we increment the wakeup_count only when there
is a lid open. Thus only lid open can prevent the system from
suspending (if lid is a wake enabled device). But with my previous
change, we will end up incrementing the wakeup_count for both lid
close and lid open. Fixed this in V2,  so that we do not  increment
the wakeup_count when there is a lid close.

And currently we cannot identify if the lid is the reason for wake
anyway.  So this patch can only make things better here.

Thanks,
Ravi

On Wed, Jun 6, 2018 at 4:21 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 1:11 AM, Benson Leung <bleung@google.com> wrote:
>> Hi Rafael,
>>
>> On Wed, Jun 06, 2018 at 09:00:43AM +0200, Rafael J. Wysocki wrote:
>>> > @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>>> >                 /* fall through */
>>> >         case ACPI_BUTTON_NOTIFY_STATUS:
>>> >                 input = button->input;
>>> > +               acpi_pm_wakeup_event(&device->dev);
>>>
>>> Not really.
>>>
>>> There already is an acpi_pm_wakeup_event() call in the else branch below.
>>>
>>
>> Ravi removes that other call below.
>
> OK, I missed that, not sure why, sorry.
>
>> The intent for this is to call
>> acpi_pm_wakeup_event() regardless if the button->type is ACPI_BUTTON_TYPE_LID,
>> in case that event is ACPI_BUTTON_NOTIFY_STATUS.
>
> Well, the patch really drops the acpi_pm_wakeup_event() call from
> acpi_lid_notify_state() and so it has to ensure that this function
> will be called here for ACPI_BUTTON_NOTIFY_STATUS regardless of the
> button->type value.
>
> That's fine, but still the changelog doesn't make it clear why the
> acpi_pm_wakeup_event() call in acpi_lid_notify_state() is not
> necessary in general.
>
> Thanks,
> Rafael
