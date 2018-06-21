Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED4BC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F19721EF4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se8Hfu9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F19721EF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeFUURq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:17:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33675 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeFUURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:17:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so6170305lfy.0;
        Thu, 21 Jun 2018 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HBdrQoaD5bjjMLvB6e/mSy6a3raKpiaxGlYsuZGn5XQ=;
        b=Se8Hfu9Bls/xjPO7TUvxjwEzsqPFPvVLA1NBe3GDV0Ed5B2qty7uU+u7Wj+pzJ8HDk
         MKyzfWN4etoUokXT/W8OfYduqmYq1cktY6PZRKny0yXWJLajbSctRub9CaWpeHjn3NTN
         zYa/V7sqrbzFs4xATxEdoXA0bZok55pEMjkihvbpwGNl2Jmb8ZxysFgAOgpTkRL313a+
         xLYPXQQ657XOjLtYK0yEvuIHMknUls0uA25JnbjqxW4WhWOuhkiXeFmQZoaHDOY7yf+B
         KIWm9qP5bIjE+qV/cYLvkJM3yqJk5LPyvym8Z+4x8xo0uXI5IGFdRqU9VPqUYNQc6Zhq
         tmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HBdrQoaD5bjjMLvB6e/mSy6a3raKpiaxGlYsuZGn5XQ=;
        b=RTWD5qmqdaInWGVLp21JpOZn2lO2+7p+xIjxcUjT7Ueyq9B3NcN6aLsovNnYGtSGzk
         aRWx2VQ+QKxlsTcDGr5fMqFBq/ZulU8WI/KbTXXoDIhQmp8JoDjLe7ieb6fpjy8FfuNp
         wYtrrxT7S0r1imMEycNtOdu4RIGKtAZRDzmGOqQ/CWKiZ6SI/AzbKk8TE42eG7rJIn0J
         v07gGoCCsxpyzHz5hV4J1K3DlcGDkZz/fQB7GXTUgUT8RWN3QhmgKkCZEqtFOGNh8JaM
         +PIJTl9pWdkVsFGe82hEOHlnghp6ALWBXngvTRYuirXqnQqTBXiKw5p4djV5R/JTb4vU
         ZO7A==
X-Gm-Message-State: APt69E0KuoVDoEVNkRyl5LcKcMko1+c5To/EUsbEzk5ULpQcEg8WaKhm
        hR59VZjeclOhutKWcjH9gjeIV8Hma5vLdfcoOJk=
X-Google-Smtp-Source: ADUXVKLpWulzn2bWMmTAAjdjUiGH4+AyuV54cAO3mstyT0i1M7eost+SbvhDbTM7WG7mR+rnzD0N1x/bPfL+G6Jv3A4=
X-Received: by 2002:a19:ef0c:: with SMTP id n12-v6mr2748834lfh.48.1529612262483;
 Thu, 21 Jun 2018 13:17:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:17:41
 -0700 (PDT)
In-Reply-To: <EA2C7036-ACD4-4E0A-80A1-373B000A7DA4@dilger.ca>
References: <20180620153322.54221-1-arnd@arndb.de> <20180620153322.54221-6-arnd@arndb.de>
 <EA2C7036-ACD4-4E0A-80A1-373B000A7DA4@dilger.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 22:17:41 +0200
X-Google-Sender-Auth: JSNcY4p_QGY6dOWo47gL4S8iE_U
Message-ID: <CAK8P3a1X=hGS=tAec2uUFtRpLyw2J_nd58ookw0jePjd0mAdhA@mail.gmail.com>
Subject: Re: [PATCH 6/6] [RFC] ext4: super: extend timestamps to 40 bits
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Tahsin Erdogan <tahsin@google.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 7:46 PM, Andreas Dilger <adilger@dilger.ca> wrote:

>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 0c4c2201b3aa..2063d4e5ed08 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -312,6 +312,20 @@ void ext4_itable_unused_set(struct super_block *sb,
>>               bg->bg_itable_unused_hi = cpu_to_le16(count >> 16);
>> }
>>
>> +static void ext4_update_tstamp(__le32 *lo, __u8 *hi)
>
> Would it be better to wrap this in a macro, something like:
>
> #define ext4_update_tstamp(es, tstamp) \
>         __ext4_update_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
> #define ext4_get_tstamp(es, tstamp) \
>         __ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
>
> So that it can be used in the callers more easily:
>
>         ext4_update_tstamp(es, s_last_error_time);
>         time = ext4_get_tstamp(es, s_last_error_time);

I generally try to avoid concatenating identifiers like this, as it makes
it much harder to grep for where a particular symbol or
struct member gets used.

>> +{
>> +     time64_t now = ktime_get_real_seconds();
>> +
>> +     now = clamp_val(now, 0, 0xffffffffffull);
>
> Long strings of "0xfff..." are hard to get correct.  This looks right,
> but it may be easier to be sure it is correct with something like:
>
>         /* timestamps have a 32-bit low field and 8-bit high field */
>         now = clamp_val(now, 0, (1ULL << 40) - 1);

Yes, good idea. I'm surprised we don't have a generic macro for that yet
(or maybe I just couldn't find it)


>> @@ -249,6 +251,12 @@ static void *calc_ptr(struct ext4_attr *a, struct ext4_sb_info *sbi)
>>       return NULL;
>> }
>>
>> +static ssize_t print_time(char *buf, __le32 lo, __u8 hi)
>
> It would probably be more consistent to name this "print_tstamp()"
> since it isn't strictly a "time" as one would expect.

Ok.

>> +{
>> +     return snprintf(buf, PAGE_SIZE, "%lld",
>> +                     ((time64_t)hi << 32) + le32_to_cpu(lo));
>> +}
>
> Similarly, wrap this with:
>
> #define print_tstamp(buf, es, tstamp) \
>         __print_tstamp(buf, &(es)->tstamp, &(es)->tstamp ## _hi)

Ok. I'll integrate all of the above and post as a non-RFC patch then
after some testing.

      Arnd
