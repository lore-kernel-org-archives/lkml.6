Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3EA21E5B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+K9/QFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3EA21E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeFUUHT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:07:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40506 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFUUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:07:17 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so6107788lfc.7;
        Thu, 21 Jun 2018 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HgRjKNoTeCAPAYU9QegKSOApGYdlgkUUQJvt3S9V5/s=;
        b=Q+K9/QFRZ+65CRW2jt6oy45TdNN8UZBzh9bdkgyfCVP65MrGLxVsJghWgzndMEkRlO
         lp81jMaEhxnCNssVAsL9OoBVfRP3X0lzqWyAkVh4zQeD2nV86qBoW/2/H+A7usJgJ1bO
         3w1UVdUWbQHJIUSFOMTqVXkJTZP1nOzAJQqOo3qZUuW2EXPhqfoX8GRlCjhPaSYKOvJz
         rdyPTAUR6dAvnDXwFCNQPF4k/rR9CTgZ5fBpYqv5HU6LAlqf9ipBcOwxs8pELyYTS/4e
         U1Wh+f+/rX7PraJSeQZZDjInbHac5UOAVmffYcCGuLIeZno7ZvX8ApfeJHWugzSHPvo/
         lurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HgRjKNoTeCAPAYU9QegKSOApGYdlgkUUQJvt3S9V5/s=;
        b=mb5eZJ16YBApIwcRNIZnXGT5whZgGddfyvbFxBlyXFdRQd7fxsORAr4DXAgWRSGqqn
         DJKq0sgkrtyHlsY4xiLSNrh7jlLyK+50ZaAJ7KmYHiiU9uHSgV8de44+8cjExCwkginv
         vMATnmrhxquF+bKvW0M3N5TD7+wVv579uRJwxggbotNcn+LlDna/iTFy8mZ1F3ZXVO1G
         /NNTGxb45pwsDPgjzC1e5Q8HZrzILzyO8GkeorBsCexV2idwAdqJ0td14T/mkBKj/lFo
         rAtzu4TeDyofYt5v2d0tbi4PQ786nHZ3ENLMfT5HdCNSW/F8F5X8iDYPsw6XL0TNljpp
         0grA==
X-Gm-Message-State: APt69E3d5GJp70JC+C9sGof5zB/qQrCI2WSyEKNxAOma2nHkRJb36pUj
        9zRaU5H/o/kayboBuM6TFwKAz1Pfv2eKWtj3kkW9Vyqg
X-Google-Smtp-Source: ADUXVKKc12YBOpeUXaqkcWgpOSDWR6yxU+RxCIkSNc+FVxSqga8lJp+43mHu0IbZpE61mmaFZMBhUxlZjlM8ffIDR7I=
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr14207334lfi.83.1529611635939;
 Thu, 21 Jun 2018 13:07:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:07:14
 -0700 (PDT)
In-Reply-To: <4D58091B-6028-4E24-9EDD-0B4D53314FB8@dilger.ca>
References: <20180620153322.54221-1-arnd@arndb.de> <4D58091B-6028-4E24-9EDD-0B4D53314FB8@dilger.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 22:07:14 +0200
X-Google-Sender-Auth: n_zX6qDbYnZXmScEXlfiTQ5L2ok
Message-ID: <CAK8P3a3ZRZKRn=6LB6ZtRGTezKc6cC8MRcnaN-86g6Z3whXNqA@mail.gmail.com>
Subject: Re: [PATCH 1/6] ext4: sysfs: print ext4_super_block fields as little-endian
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Tyson Nottingham <tgnottingham@gmail.com>,
        Riccardo Schirone <sirmy15@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 7:49 PM, Andreas Dilger <adilger@dilger.ca> wrote:
> On Jun 20, 2018, at 9:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> While working on extended rand for last_error/first_error timestamps,
>> I noticed that the endianess is wrong, we access the little-endian
>> fields in struct ext4_super_block as native-endian when we print them.
>>
>> This adds a special case in ext4_attr_show() and ext4_attr_store()
>> to byteswap the superblock fields if needed.
>>
>> In older kernels, this code was part of super.c, it got moved to sysfs.c
>> in linux-4.4.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 52c198c6820f ("ext4: add sysfs entry showing whether the fs contains errors")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I was wondering why this didn't just use le32_to_cpu() all the time,
> but I see that these functions are being used for both ext4_super_block
> (on-disk) fields, as well as ext4_sb_info (in-memory) fields.  A bit
> ugly, but I don't think there is a better solution.
>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

One alternative that I considered was to just do away with helpers
for the ext4_super_block structure and only use them for ext4_sb_info,
especially after the last patch that changes this again. However,
as a bugfix for stable backports it seemed best to keep the change
as simple as possible.

Thanks for the review,

      Arnd
