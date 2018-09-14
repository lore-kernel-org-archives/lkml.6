Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21684ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4DB20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV+gdKQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4DB20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeINWeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:34:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42569 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINWeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:34:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id g13-v6so5555845qki.9;
        Fri, 14 Sep 2018 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5OPgBkdJRgk054tf6vwLYGqHX4ORw551EbO7vbnM2Sc=;
        b=cV+gdKQuiJFEGLNEaQCEQqwjXShu91ZCg9ILhGvDusji/vSKOpSv2SSEqbxlJ2I5RI
         gEouwZ8DgUgDp6LczYD6uPSVJCtvwsU+wAt47HEMhOoUZV554NhKadOKclsjRJFhN+2Z
         Dds5ISnteQa14zMXV9/1iJ7a6679NZjg6M10WqB5iRACGcdsWy/7mfLTadlnuuQeUH9j
         8pVG+O1MAydSozXdJhptsRdRHGXDTQwBI7FsL2bApEJto3EiJdTB8gEm3ygTfBU92hY2
         UF44z0jjo2oCVGrAugm/9jv9n6KXY5qDFlLKX6PdlBj+PPYxoFJJPKd7Xw43ax78vGh1
         452A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5OPgBkdJRgk054tf6vwLYGqHX4ORw551EbO7vbnM2Sc=;
        b=oQLcK20e1qZ/AeAfofQJP+aXff1cFOc6R6FX8juDWGY8MvxIlcZ8l3njVgSgfyIIVQ
         woBUZZ99doli+rKh1JjeRVmlQEqxWkoLucYzYoISH6Gshci93YkL56mwl7AXaByLRszF
         SpaW45lgH56AntfHaOTWhOgYKoihzfPRpWEuHCTYkA1mvVTXgDT9aJ4Anr7AUvk4jIiP
         UFT2aREcbd6SQKMTAYdVZ7B3QOjSUX+b+rZNBOYuWpQY7uyfPs7SrGEdhXKq8/Cxt+IR
         uiikrxORGmNakxkRs/5pMrD9IcThYeAinwbhDF5xCzGLr1TCbdW++M+jzIM+5/XMZpYi
         X29A==
X-Gm-Message-State: APzg51Drt22FvtYUIIGUS/41+0XmU33FM96975d3cVS84urJI/4hNgoD
        bjnYBr7JwqD2LmWX78CjML9lPb9UePWvetwKuZ8=
X-Google-Smtp-Source: ANB0VdZw9S1yOWPQGzh/FIlHiWAm4MfgOIMRcF3G3MtXQpkImCEmxM1z67123rJ3EXu+ftkxoQ3W3lxOlB8ZTH+PZUM=
X-Received: by 2002:ae9:e118:: with SMTP id g24-v6mr9163380qkm.306.1536945518509;
 Fri, 14 Sep 2018 10:18:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 10:18:18
 -0700 (PDT)
In-Reply-To: <CANiq72=xNMKJv3tT9+-jxEOx9033ytRrbUV+TQ6kVL7QY06jDA@mail.gmail.com>
References: <20180914104427.3900-1-harshitjain6751@gmail.com> <CANiq72=xNMKJv3tT9+-jxEOx9033ytRrbUV+TQ6kVL7QY06jDA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Sep 2018 19:18:18 +0200
Message-ID: <CANiq72kgU8ibWg4d4orU+VYp4fn_U78f8_y6p5Yt6=kQFPeLkw@mail.gmail.com>
Subject: Re: [PATCH] scripts: unifdef: fix stringop-truncation warning
To:     Harshit Jain <harshitjain6751@gmail.com>
Cc:     stable@vger.kernel.org, Harshit Jain <dev-harsh1998@hotmail.com>,
        Tony Finch <dot@dotat.at>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 7:12 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> Hi Harshit,

Another two nitpicks:

  * Since this is the second version of the patch, write "[PATCH v2]"
in the title instead; that way people know you have sent an earlier
version. On top of that, you should explain the differences between
each version after the "---" line (i.e. the part that does not belong
to the commit message).

  * You may want to write down who you CC'd (e.g. Tony and the stable
mailing list) in "Cc: ..." lines before the Signed-off-by line.

Thanks for the patch!

Hope that helps,
Miguel

>
> On Fri, Sep 14, 2018 at 12:44 PM, Harshit Jain
> <harshitjain6751@gmail.com> wrote:
>> From: Harshit Jain <dev-harsh1998@hotmail.com>
>>
>> * This commit resolves the following warning when the mainline kernel is build with the android environment.
>
> Typo: built
>
>>
>> -> warning :-> https://gist.github.com/dev-harsh1998/757427b16a58f5498db3d87212a9651b
>
> Try to avoid links to external pages (specially if they are only 2 lines :-).
>
>>
>> * This warning is persistant in all the currently maintained android kernel i.e 3.18, 4.4, 4.9, 4.14.
>
> Typos: persistent, kernels, i.e.
>
>>
>> Signed-off-by: Harshit Jain <dev-harsh1998@hotmail.com>
>> ---
>>  scripts/unifdef.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/unifdef.c b/scripts/unifdef.c
>> index 7493c0ee51cc..4ce008eda362 100644
>> --- a/scripts/unifdef.c
>> +++ b/scripts/unifdef.c
>> @@ -395,8 +395,8 @@ usage(void)
>>   * When we have processed a group that starts off with a known-false
>>   * #if/#elif sequence (which has therefore been deleted) followed by a
>>   * #elif that we don't understand and therefore must keep, we edit the
>> - * latter into a #if to keep the nesting correct. We use strncpy() to
>> - * overwrite the 4 byte token "elif" with "if  " without a '\0' byte.
>> + * latter into a #if to keep the nesting correct. We use the memcpy()
>> + * from the string header overwrite the 4 byte token "elif" with "if  ".
>>   *
>>   * When we find a true #elif in a group, the following block will
>>   * always be kept and the rest of the sequence after the next #elif or
>> @@ -450,7 +450,7 @@ static void Idrop (void) { Fdrop();  ignoreon(); }
>>  static void Itrue (void) { Ftrue();  ignoreon(); }
>>  static void Ifalse(void) { Ffalse(); ignoreon(); }
>>  /* modify this line */
>> -static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
>> +static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }
>
> Seems like keyword shouldn't use __attribute__((nonstring)), so this
> looks right.
>
> Cheers,
> Miguel
>
>>  static void Mtrue (void) { keywordedit("else");  state(IS_TRUE_MIDDLE); }
>>  static void Melif (void) { keywordedit("endif"); state(IS_FALSE_TRAILER); }
>>  static void Melse (void) { keywordedit("endif"); state(IS_FALSE_ELSE); }
>> --
>> 2.18.0
>>
