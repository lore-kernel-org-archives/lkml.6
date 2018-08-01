Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E861C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E5620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0dFUJ0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeHAVhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:37:54 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42502 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbeHAVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:37:53 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so21283940qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AQjhE/Y3KIXu/PHI4jD3V6mM1aJCngK9CXZI+6Xl0bA=;
        b=i0dFUJ0gvxvk0NoCa7PzFITHJXzd7t2RtnSW/+ETbJpVhvegq21KZ1T7qVMPDK6Umb
         vmWN4zhatHUd9QqdAtFZzP6moi6phB/PID5BvOT7uGoLEdlPki4jfPsVQA9NMWnP0kJv
         ILYgal2PB5IZBUgRcyhAfINl5700vpXM2bRPpL2hZ2q3cy5hvM0KWRHm7unwNoNqL49T
         XfyEVEBNw27gi1uZWJROI+fx7Gu/vIFw2rohpXwMbe+mjgt4U66P9paJhes+vG9eLTX6
         Gnwg7H7ZhuC9sg3xB4FmkKeCr+lqeJLax0ixxHTNkC6mHI2pk6zsAYyzerX1dD0XtPv4
         YP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AQjhE/Y3KIXu/PHI4jD3V6mM1aJCngK9CXZI+6Xl0bA=;
        b=XTsRRl8urx1w6m2W8kQU+HZPy8vE98Rd8t9rjMuuCkFdyT/6j/UVXppkUT2iiWx6xG
         Belsh8i6WLc/BTU7RVe/1XZPPrcCg4CHYCcFI8oYPaMZfNpVJKkn49NkwrGwEYCB9PCT
         WWPNrNV4PDodr8+gIDNxdQPW9Au01SdRA78EitAsFVZtQ+5MGH7lvPf1iJkp7KQycdJz
         PQndWFdbeTD8f1KhzMgffhbV88fu19EEsaGyJsFgNgtDQBgR4GCgnXlE48unV/ZuXaVN
         90kcjaumqkEtX8Y0uTwGA+aCIUtbXFZ12OleNqX22nbgeixSPub7wBzwGdCQsImCwgO+
         VyPg==
X-Gm-Message-State: AOUpUlFRePbM0lUGec9qH1hHHGkvU5qtiAqeWnc84wmHVt9O8rT/R6ag
        WS1zexclqttyAZQSg5DsUZT9eZWS5DeA1Ju/AOE=
X-Google-Smtp-Source: AAOMgpdNLzkUhMTgmHfI2B5Way2XfNyr/ZFEzznRgmbsv1lyYuobVIl8IZtg6wkPxhNIfdVoUzyfQSPNVOIRytpIhos=
X-Received: by 2002:ac8:1acd:: with SMTP id h13-v6mr26443776qtk.206.1533153029518;
 Wed, 01 Aug 2018 12:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 12:50:09 -0700 (PDT)
In-Reply-To: <CAGXu5jJUa36N+Q0K9dbc9xX_LoN=4AZ+CxrDiem==8LEXrdF=w@mail.gmail.com>
References: <20180801175815.GA25489@gmail.com> <CAGXu5jJUa36N+Q0K9dbc9xX_LoN=4AZ+CxrDiem==8LEXrdF=w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 1 Aug 2018 21:50:09 +0200
Message-ID: <CANiq72=sKO_QxujKSY7ZJSaVfT0-4atk+4U8fJFsmLJLxrjhzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] auxdisplay: panel: avoid gcc 8's
 Wstringop-truncation warning
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Sebor <msebor@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 8:47 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Aug 1, 2018 at 10:58 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> Let gcc know it is not meant to be NUL-terminated by annotating with
>> the new __nonstring variable attribute; and remove the comment since it
>> conveys the same information.
>>
>> Cc: Willy Tarreau <w@1wt.eu>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Martin Sebor <msebor@gmail.com>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>>  drivers/auxdisplay/panel.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
>> index 3b25a643058c..21b9b2f2470a 100644
>> --- a/drivers/auxdisplay/panel.c
>> +++ b/drivers/auxdisplay/panel.c
>> @@ -155,10 +155,9 @@ struct logical_input {
>>                         int release_data;
>>                 } std;
>>                 struct {        /* valid when type == INPUT_TYPE_KBD */
>> -                       /* strings can be non null-terminated */
>> -                       char press_str[sizeof(void *) + sizeof(int)];
>> -                       char repeat_str[sizeof(void *) + sizeof(int)];
>> -                       char release_str[sizeof(void *) + sizeof(int)];
>> +                       char press_str[sizeof(void *) + sizeof(int)] __nonstring;
>> +                       char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
>> +                       char release_str[sizeof(void *) + sizeof(int)] __nonstring;
>>                 } kbd;
>>         } u;
>>  };
>
> If it's not a string, why not use "u8" instead of "char"? Does the
> warning persist?

Yes, it persists (on purpose). Originally it didn't, but see the discussion at:

  https://www.spinics.net/lists/kernel/msg2737596.html

And:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84725

Cheers,
Miguel

>
> -Kees
>
> --
> Kees Cook
> Pixel Security
