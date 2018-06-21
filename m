Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53108C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BADF21E97
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTbUjiVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BADF21E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeFUUHw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:07:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41523 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeFUUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:07:50 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so6090418lfa.8;
        Thu, 21 Jun 2018 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0BCEgSGQzZPHcBnXHXfO2t8YauNtYmIO5uL9j+zKnJw=;
        b=VTbUjiVdqQhkUKaxfwVpVQN2nIM0tIpYO85kHfRQ3VKnvixMyJTAM/X/4g+HP2aut5
         5UeYiwlW8GnY4+0hm/0NTP+k5dKjYF15rntpuXv0rTIdbK4Urzp7zlUR8Xvu8vRiGIpU
         nOA7HSCYU/W84lbcdyy9sshy6R+ejpKx2QCsNlTtKkOT3EnwiOCsVyBY2c36kOh0YUT/
         McTSYjMgicXN8zhCpaBBfpsTkNZPC3PCqssg8X+RJytLYJsUOwWSMWHoxjW+vM0UCTUE
         rtqCGRYZQ+r8N/VxlqI7RYsUSy2GJFOC1JfcttgS3q1ZY+OhZQuDbSd7oz7GaN9MkPjP
         o/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0BCEgSGQzZPHcBnXHXfO2t8YauNtYmIO5uL9j+zKnJw=;
        b=VgsFP3rqXEtBGG8m1ozd1l0/Y55fSJMPBsb0Atl+ATL+IsG5YD9QL3gKbkYh1xhCfO
         b6nsCFLvXL3gWrMxAusux4CDuSU6hn22anH3fvMDa3Y80ihLdOK/FhhDXHmoWsCTrFUH
         0ZwF3y1mdNKk+wWYRRwdAWtvTdkTpqmqrLcP46VFM+UAsRfiFzNdmi6na0q/gaeiLESj
         pR9yFyItdBGcqkKyayVGd16TWfnVomnMwBiyezvu+v+wh8e1iysMZoy5zQ3ssTJLicvs
         OY1VtKw5cP5kulW14giATrjgpGAPusVBHBAtiC0RQQRq2DthdmNjphnRns483cJw9tzL
         Ivvg==
X-Gm-Message-State: APt69E1aGp93GuEJcoBni6S3T2eblt0iLDtZZ0sxanYc6LsNlwQz6KBY
        s2RDBndKCDdic5C1rSN3L2P2UVfph0yaTyODUgPiWQ==
X-Google-Smtp-Source: ADUXVKIoabO5Eh8YH8SZIHzdo1I6k3mIg2LdlewoSoCKP2Olt6jWFMIIZg57BFB1cArXD2nSsMhTq0bIsZSGp/+QApI=
X-Received: by 2002:a19:c004:: with SMTP id q4-v6mr16020114lff.16.1529611668782;
 Thu, 21 Jun 2018 13:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:07:47
 -0700 (PDT)
In-Reply-To: <F6095896-5B1A-4A20-9293-086A9350F75C@dilger.ca>
References: <20180620153322.54221-1-arnd@arndb.de> <20180620153322.54221-3-arnd@arndb.de>
 <F6095896-5B1A-4A20-9293-086A9350F75C@dilger.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 22:07:47 +0200
X-Google-Sender-Auth: vUXNnI_RiVK6u1Nsiss4rALp2ms
Message-ID: <CAK8P3a1VzHpyighcfvSsG-Zfq2s7nURXcE6AdXamP7mO5C2q7Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] ext4: use ktime_get_real_seconds for i_dtime
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Tahsin Erdogan <tahsin@google.com>,
        Miao Xie <miaoxie@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 7:27 PM, Andreas Dilger <adilger@dilger.ca> wrote:
> On Jun 20, 2018, at 9:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> We only care about the low 32-bit for i_dtime as explained in commit
>> b5f515735bea ("ext4: avoid Y2038 overflow in recently_deleted()"), so
>> the use of get_seconds() is correct here, but that function is getting
>> removed in the process of the y2038 fixes, so let's use the modern
>> ktime_get_real_seconds() here.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks OK, one minor cleanup possible.
>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>>       ext4_orphan_del(handle, inode);
>> -     EXT4_I(inode)->i_dtime  = get_seconds();
>> +     EXT4_I(inode)->i_dtime  = ktime_get_real_seconds();
>
> Not strictly necessary, but it might be good from a code clarity POV
> to use:
>
>         EXT4_I(inode)->i_dtime  = (__u32)ktime_get_real_seconds();
>
> so that it is more clear we are aware that this is being truncated
> to a 32-bit value.

Right, I've been a bit inconsistent here across file systems, I've
done this in some other ones, using either a cast or a lower_32_bits()
function call. Changed it as you suggested here now.

     Arnd
