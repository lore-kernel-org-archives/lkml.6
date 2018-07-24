Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EAB2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvRHuhSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EAB2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeGXQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:35:38 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45885 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGXQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:35:38 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so2852772qkg.12;
        Tue, 24 Jul 2018 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CL4cDMIRjJhSUtfYehZsb+gGtz4jCO+QPOox9zUqR3w=;
        b=VvRHuhSKLtG7oddwijG/YQCj2hhJ9SKJWVDf4o3s5Ym9W/byyrPLyQVJOl504bg2wW
         h2KK2rCRjyBqI1flUcPgzljegBCehmLQBqAtJTJOE2ChWf/ZRrUg2PRvMWHwY0SlHKnA
         0iH8sTvRgD917YeN42SGObonCUuMtRRjCpa8eX5hkDbRHt7IioWBoHX3qWHcX/o/TvWT
         FqQSnc4MJHMsrMdMtE4noSPQ3xMSJAjeyA32VfEkKkZPV54QjZY2vIyb3xjxecejJL50
         AkrzUmun+Y3DNTSPZBWM7biGCtXWoIG7tH2UN9k1ezA7fTtTDC/stXGXCEfKHxvvVxE+
         AVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CL4cDMIRjJhSUtfYehZsb+gGtz4jCO+QPOox9zUqR3w=;
        b=ZYgZ9KbvSwKuDDONsO/Gua2ZtACF7BMrCq+Ec0r/jLRdqkCnTSsH7nsPp3QMI8Kf3q
         dXE0Msa1TjJyPqCxYhzcQSx4jCg9E2BVohokt8duvA5v1JlLDo5yqOtqx64o2pS+Qgpk
         4n8vGmxruYQUAH6jucBXyH3iNjLEbq5SdBASzGA0Llyj0fADE9Ju7rfxoQZgUR0djLGE
         NooWNs98Gt5gnAFDFGuLjXAdD9W8qC2gJmdyuUWvQ6yBevvg//JamVT100kmv3cu3c3A
         /AhdHjWcAmIM023VQerdh4u1qqmbC7wkLohyIlsNBqwxMiLccOW4kHLqCLX/H8a8LDeV
         vvwA==
X-Gm-Message-State: AOUpUlFXQltKayMdecUGyjyZZ0HhzJ+8+t9QTkulIvLky/IoOkCbh2o/
        ilHJ92MztWe9Fu/LPKQIjh0Sbogm3LoQuYRliv8=
X-Google-Smtp-Source: AAOMgpfpGIzQhmFgtN3HrK1u/qMGmEaJElVY8VvUUANydqzsombDwVIULI8GIUhNus+zxHq0AMtT3mH+GCBx7+jYFvo=
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr15357755qkd.32.1532446116721;
 Tue, 24 Jul 2018 08:28:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:28:36
 -0700 (PDT)
In-Reply-To: <20180711224625.airwna6gzyatoowe@eaf>
References: <20180710214131.4106527-1-arnd@arndb.de> <20180711224625.airwna6gzyatoowe@eaf>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 17:28:36 +0200
X-Google-Sender-Auth: 2_SW_kCiYXfwcu5Y2Yu5mmk0nlc
Message-ID: <CAK8P3a2NXEC_+VNw4bkorisUCfVg_94ooTNN+SZe78dF_uqmWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v2] hfs/hfsplus: follow MacOS time behavior
To:     =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:46 AM, Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:

>> -#define __hfs_u_to_mtime(sec)        cpu_to_be32(sec + 2082844800U - sy=
s_tz.tz_minuteswest * 60)
>> -#define __hfs_m_to_utime(sec)        (be32_to_cpu(sec) - 2082844800U  +=
 sys_tz.tz_minuteswest * 60)
>> +static inline time64_t __hfs_m_to_utime(__be32 mt)
>> +{
>> +     time64_t ut =3D (u32)(be32_to_cpu(mt) - 2082844800U);
>> +
>> +     /*
>> +      * Times past 2040-02-06 06:28 are assumed to be invalid,
>> +      * matching the MacOS behavior.
>> +      */
>> +     if (ut > 2082844800U + UINT_MAX)
>
> I'm not sure what you were going for here, but this isn't right. Times
> as early as 2036 will be considered invalid.

Right, the calculation makes no sense, I have no idea how I ever
got there. I was trying to check for the 2040 date, and rearranged my
code multiple times for that. What I probably meant was

     if (ut + 2082844800U > UINT_MAX)

or

    if (ut > UINT_MAX - 2082844800U)

>> +             ut =3D 0;
>> +
>> +     return ut + sys_tz.tz_minuteswest * 60;
>> +}
>>
>> +static inline __be32 __hfs_u_to_mtime(time64_t ut)
>> +{
>> +     ut -=3D - sys_tz.tz_minuteswest * 60;
>            ^^^^^
>         An extra minus.

I saw that Andrew had added a fix on top and assumed he got it right, but
upon checking again later I see that it's still there.

>> +
>> +     /*
>> +      * MacOS wraps "invalid" times after 2040 when writing back, so
>> +      * let's do the same here.
>> +      */
>> +     return cpu_to_be32(lower_32_bits(ut + 2082844800U));
>> +}
>>  #define HFS_I(inode) (container_of(inode, struct hfs_inode_info, vfs_in=
ode))
>>  #define HFS_SB(sb)   ((struct hfs_sb_info *)(sb)->s_fs_info)
>>
>> -#define hfs_m_to_utime(time) (struct timespec){ .tv_sec =3D __hfs_m_to_=
utime(time) }
>> -#define hfs_u_to_mtime(time) __hfs_u_to_mtime((time).tv_sec)
>> +#define hfs_m_to_utime(time)   (struct timespec){ .tv_sec =3D __hfs_m_t=
o_utime(time) }
>> +#define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)
>
> Are the new spaces intentional?

No, I should drop that.

>>  #define hfs_mtime()          __hfs_u_to_mtime(get_seconds())
>>
>>  static inline const char *hfs_mdb_name(struct super_block *sb)
>> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
>> index d9255abafb81..7f0943e540a0 100644
>> --- a/fs/hfsplus/hfsplus_fs.h
>> +++ b/fs/hfsplus/hfsplus_fs.h
>> @@ -530,9 +530,29 @@ int hfsplus_submit_bio(struct super_block *sb, sect=
or_t sector, void *buf,
>>                      void **data, int op, int op_flags);
>>  int hfsplus_read_wrapper(struct super_block *sb);
>>
>> -/* time macros */
>> -#define __hfsp_mt2ut(t)              (be32_to_cpu(t) - 2082844800U)
>> -#define __hfsp_ut2mt(t)              (cpu_to_be32(t + 2082844800U))
>> +/* time helpers */
>> +static inline time64_t __hfsp_mt2ut(__be32 mt)
>> +{
>> +     time64_t ut =3D (u32)(be32_to_cpu(mt) - 2082844800U);
>> +
>> +     /*
>> +      * Times past 2040-02-06 06:28 are assumed to be invalid,
>> +      * matching the MacOS behavior.
>> +      */
>> +     if (ut > 2082844800U + UINT_MAX)
>
> Same as before, 2036-2040 will be invalid.
>
>
> For the record, your original solution (supporting the 1970-2106 range)
> still makes more sense to me. It seems Apple is not using the 1904-1970
> range for anything; if they are still supporting hfsplus by the 2030s I
> assume they will deal with this in a similar way.

I'm definitely fine with it either way. The current approach was based on
the feedback I got from Viacheslav Dubeyko, and on what I found
in the various other implementations. Viacheslav, are you ok with
changing the hfs code back to my original interpretation of the
timestamps, using the 1970..2106 range?

Andrew, can you drop both my hfs/hfsplus patches for now? At
this point it seems better to start from scratch than to fix up the
bugs individually.

      Arnd
