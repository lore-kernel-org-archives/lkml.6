Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A712089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmqXXKRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A712089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934173AbeGJP0M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:26:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33481 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:26:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id t21-v6so17052445lji.0;
        Tue, 10 Jul 2018 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=MsyxdTDW+5YCxjUrZ4Rdza7bf/aLTFz9sI/59pjfE7Q=;
        b=OmqXXKRpuGVYEIfffVA770yKy77qhnDhpqAOzbcqei4usj+ENmX7teGdZ5gJmGlEMX
         XDB3aRDH4IDSGQvOaJoOm5LE++1uOVRNafswZ5P6cD8mwO/ppvfg2r8+6wHLnpduGpOA
         /KeTEvvrn40TfP9B5s4pYRuWvWwX3Tg7UerTF0ILnr7l3niRThywtgAfFMOz2JM5B7A0
         SHnRz9l6zF/8XS+eYUSwu6bHbbBxn+lwu6L1q8pW6E6EN5YO7Ag/PEFuMpAz0KPIFrFv
         CP/lYJ5HoBmOUbqbVVsAtiH4AaYPplAV1EDxZ6l9gn9qSoUN/rJJYu9pq2Fh7BqoiGMD
         fIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=MsyxdTDW+5YCxjUrZ4Rdza7bf/aLTFz9sI/59pjfE7Q=;
        b=uRy1whPI4zZrHPgie909081kJbF8q+qer6J3TI/MaOeEh4uKGiJKjaDdkmO9svZ5Iu
         +uVJcp7mAgBOkNmWlclBseBIwPpnyNCltbYywwavNpXEiGYildvCiVJjblzbNHJiAfxw
         7wtZRJRslcuj97Z4zvtIQtXJtUxS6eOskbG7LZa7lGSkf8gGw1frpkhSr/6JXLiTjZWh
         hFmJszHmhPzqTsXOGWwBUn5lDefZyjELqzb0mHux1Bf6ifVPzzLki9xi5evcjyq/svkR
         D97IU/pyPE0LI2UzlFM1nTvywWDFeW62Jdcn/dseBJe9M2eheFccDqtJx+XRTtwrh1mN
         BxRA==
X-Gm-Message-State: APt69E30ZY9hpBM0Wu84ZV8/cNWlif2bs2PZjlDgcaDedTcnxD0O588S
        OM5GTGz3uqANPUzIVflgDccnkC2ew7Nr6xxttzY=
X-Google-Smtp-Source: AAOMgpenMT0SNUnnhyhyqnSWvtk56pgHV2Oj3R0tAm029J1mr2w0hjVRNW4h8cCE2FjWTDSXtlUfpMvuH+P3fTiyz5U=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr16050253lje.129.1531236368514;
 Tue, 10 Jul 2018 08:26:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:26:07
 -0700 (PDT)
In-Reply-To: <20180623060052.ufrlbybeys2xxt5l@eaf>
References: <20180622141758.229589-1-arnd@arndb.de> <20180623060052.ufrlbybeys2xxt5l@eaf>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Jul 2018 17:26:07 +0200
X-Google-Sender-Auth: jg4Txwk_AUom30vJMlVEOafv2RM
Message-ID: <CAK8P3a0Ag-rZmDO0H6Yvp6++=0Mr4ObLM+Y3f-n6jUvzbZsyUg@mail.gmail.com>
Subject: Re: [PATCH] hfs/hfsplus: use documented official timestamp range
To:     =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Cc:     Vyacheslav Dubeyko <slava@dubeyko.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 8:00 AM, Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:
> On Fri, Jun 22, 2018 at 04:17:32PM +0200, Arnd Bergmann wrote:
>> According to the official documentation for HFS+ [1], inode timestamps
>> are supposed to cover the time range from 1904 to 2040 as originally
>> used in classic MacOS.
>>
>> The traditional Linux usage is to convert the timestamps into an unsigne=
d
>> 32-bit number based on the Unix epoch and from there to a time_t. On
>> 32-bit systems, that wraps the time from 2038 to 1902, so the last
>> two years of the valid time range become garbled. On 64-bit systems,
>> all times before 1970 get turned into timestamps between 2038 and 2106,
>> which is more convenient but also different from the documented behavior=
.
>>
>> The same behavior is used in Darwin and presumaby all versions of MacOS =
X,
>> as seen in the to_hfs_time() function in [2]. It is unclear whether this
>> is a bug in the file system code, or intentional but undocumented behavi=
or.
>
> But the to_bsd_time() function considers wrapped timestamps as invalid,
> doesn't it? So it seems they simply don't care about the post-2040 (or
> pre-1970) case?

Sorry for the late reply. Just got back to looking at what remains for the
file systems.

You are of course right, my mistake: Apple writes a wrapped date when
converting from bsd time to on-disk format, but does treat the wrapped
dates as invalid when reading
>> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
>> index d9255abafb81..57838ef4dcdc 100644
>> --- a/fs/hfsplus/hfsplus_fs.h
>> +++ b/fs/hfsplus/hfsplus_fs.h
>> @@ -530,8 +530,9 @@ int hfsplus_submit_bio(struct super_block *sb, secto=
r_t sector, void *buf,
>>                      void **data, int op, int op_flags);
>>  int hfsplus_read_wrapper(struct super_block *sb);
>>
>> -/* time macros */
>> -#define __hfsp_mt2ut(t)              (be32_to_cpu(t) - 2082844800U)
>> +/* time macros: convert between 1904-2040 and 1970-2106 range,
>> + * pre-1970 timestamps are interpreted as post-2038 times after wrap-ar=
ound */
>
> This comment seems to be from the original series, maybe you forgot to
> change it?

Correct. I'll change it and resend it with a fixed changelog.

      Arnd
