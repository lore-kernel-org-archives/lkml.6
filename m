Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C8C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7iZyZ4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C8C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeGRM56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:57:58 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33051 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:57:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id u14-v6so3308788lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4ryN5WhZvrIDan3fV43Pm3ctRDexLzpc6pBcsfxz/N4=;
        b=B7iZyZ4/imCTIoofUs8JlBduVnxs++1TzjYZI42tuRiBo2YqzCz42b/Mii2quno77I
         5x73KD1VDy8jP37o8NoeOCFCTjfdjSOSiu8EP3eURY971CWwq1cfVqlB/H1tWufIBHr6
         tXpewGAMoG1MOfiRopJWJm8Y4kGiuk/ZG03vZ7CzBzvTE/cNCpBbnY28txjl5uQiV/5+
         vNOj/Hi2mJgWmLlgj/XIJ/bag3fqBK8a1yYMIl1sUiyk6bPUi3aijb5wBq/bunAx9Jf2
         navFrcfVDX/dwP+ZISJOfMxhs8oRel0XX/8jX2AVUtlw1Y/e3VjbnqtxApDEcTSZgP+e
         0wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4ryN5WhZvrIDan3fV43Pm3ctRDexLzpc6pBcsfxz/N4=;
        b=gRX96p8KbKHp4pjwSaghMBTnMEKKD8dv2782alHsOIwWFJ7s/7fsWBvZ3/ApGS/LYb
         zi3hKW28QxM8WPjb4VZIDHhPYjKcwZv7C1YrUX+2VTXeWTS71X9esDNrizzewUC/gJrT
         uh8KultecyNhOLGZsOdAEJqDUl2faFtklNANuyrkpUyJpWi72TN9jYsEi3rjhFsmalag
         DBfoojoL3J1jnVpnd2yZvWimIkI3BlaMdWsSCzix33XZqcMSrK6vBlOvBZYkw+2nuID5
         FJQuXaXKpfR+WflBO9yIiXwi37KJF8+SJdYbcaKi1EtuaisGreGWBeoF7WqAA/n++yga
         qKoQ==
X-Gm-Message-State: AOUpUlGDc5Evw0g9qGLqEdz3fj8aVXFLB3n6kV/jwnhYp73oh2JRD1wI
        V6btWovqyMwyJpfEtUWc4KOZqic8QfyTGqgoiiM=
X-Google-Smtp-Source: AAOMgpc1ym+gVz7746Xcvg2iGYwt2Gnxn6eecvBaETAOoQFq8oTrp07A+RmENEG1JKEOxzHQ1zOhYPoSBMZSnKc6S1M=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr3803717lfh.19.1531916409798;
 Wed, 18 Jul 2018 05:20:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 05:20:08
 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com> <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jul 2018 14:20:08 +0200
X-Google-Sender-Auth: BWyy0FgqsA4N_J6X6sDtICzDtIk
Message-ID: <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:02 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 18 Jul 2018, Geert Uytterhoeven wrote:
>
>>
>> Thanks for your patch!
>>
>> Applied and queued for v4.19, with the WARN_ON() dropped.
>>
>
> The patch you've committed to your for-v4.19 branch has this hunk:
>
> @@ -269,8 +275,12 @@ static long via_read_time(void)
>                 via_pram_command(0x89, &result.cdata[1]);
>                 via_pram_command(0x8D, &result.cdata[0]);
>
> -               if (result.idata == last_result.idata)
> +               if (result.idata == last_result.idata) {
> +                       if (result.idata < RTC_OFFSET)
> +                               result.idata += 0x100000000ull;
> +
>                         return result.idata - RTC_OFFSET;
> +               }
>
>                 if (++count > 10)
>                         break;
>
> That looks bogus to me, since result.idata is a long.



> Also, the following hunk seems a bit pointless (?)
>
> @@ -291,11 +301,11 @@ static long via_read_time(void)
>   * is basically any machine with Mac II-style ADB.
>   */
>
> -static void via_write_time(long time)
> +static void via_write_time(time64_t time)
>  {
>         union {
>                 __u8 cdata[4];
> -               long idata;
> +               __u32 idata;
>         } data;
>         __u8 temp;
>
>
> But if data.idata needs to be changed to __u32 here, why not change the
> same struct member in via_read_time() also?

Hmm, apparently I forgot to update via_read_time(), that one
is indeed bogus and now inconsistent with the other functions.

The change in via_write_time() seems at least consistent wtih
what we do elsewhere, and using __u32 makes this code
more portable. (yes, I realize that 64-bit powermac doesn't
use the VIA RTC, but it feels better to write code portably
anyway).

I'd suggest we do it like below to make it consistent with the
rest again, using the 1904..2040 range of dates and no warning
for invalid dates.

If you agree, I'll send that as a proper patch.

       Arnd

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index bf8df47a6d09..8335509969f1 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -255,12 +255,13 @@ static void via_write_pram(int offset, __u8 data)
  * is basically any machine with Mac II-style ADB.
  */

-static long via_read_time(void)
+static time64_t via_read_time(void)
 {
        union {
                __u8 cdata[4];
-               long idata;
+               __u32 idata;
        } result, last_result;
+       time64_t ret;
        int count = 1;

        via_pram_command(0x81, &last_result.cdata[3]);
@@ -279,12 +280,8 @@ static long via_read_time(void)
                via_pram_command(0x89, &result.cdata[1]);
                via_pram_command(0x8D, &result.cdata[0]);

-               if (result.idata == last_result.idata) {
-                       if (result.idata < RTC_OFFSET)
-                               result.idata += 0x100000000ull;
-
-                       return result.idata - RTC_OFFSET;
-               }
+               if (result.idata == last_result.idata)
+                       return (time64_t(result.idata) - RTC_OFFSET);

                if (++count > 10)
                        break;
