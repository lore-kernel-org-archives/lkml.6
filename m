Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9EA20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFY06zv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9EA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeFTMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:00:21 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41300 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFTMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:00:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so4528758lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ULnZEBUUHDHd5l/URfbrFKpTQmU8vPv7GaNb/fUdx2c=;
        b=lFY06zv7ajYsavJmfgc6j0Yg+NoBh2/nwKV1nNR2BJMUJ29CLYh0/qlbthps/kpr3T
         5CrBSemEIKMvl6imYyYeq4NVXBhGRuVvv/KzfU0PEGMs+++Us0WKqDXM/o6KhflN5tD2
         FrgS6kLPW6vgjpvIPYxSSo572g/EhSfByVmnwvAMbIXnRZe02JI00EK+daQCHJpcUv0r
         P6eUE+9e+/qVhk5N1cP2lvuaIw6454C6H9WJHQZZp3sN/7Zc+ius6eWBg2MfarL2W+Yz
         Y997BDnYLSc4uV8T2Lor1i8kQWYppRKxrLIrfWcdRH4Z4f4LSfaIf3uG580YWTtjG3Sl
         FFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ULnZEBUUHDHd5l/URfbrFKpTQmU8vPv7GaNb/fUdx2c=;
        b=BPjYJbo2QKCqsMf92aQdgYbEg67RAu9rA/wRvjUkVQpS+9h2i4FYwz5vyjLv3VcDjH
         VkmwLR/PbeYY3/Y3uN67uOIO/fUIWgi6HsD4s/C/easky+ElilSbFo0V65Ky8LzVJIdb
         ZXJ0b4StInqRP4VpW2NxLH68pbFK4U7n5fwo0kgIAtfSZ+k3uxwqWkL7MDB2GSkijQWK
         vtlF18EtckCAtoj9hgI/ewWOgxNRrO2C/QdFWztWm9IGQpH6+9MzJ7gUICd6jnXq7Gkv
         xcANdR08VSQYOIlxxfmB3co+kSTivKnsD/yctPbWDttPkzCR+iNPtHmZ1sBvyLRCOP8x
         SFtg==
X-Gm-Message-State: APt69E1DxO0FpbFiIqFck/mR0+sk2u4gfBXncd+Vt7RalLrs0bd9Mkqb
        MGxjzy4uJy31fL1b6iZ2q833xFOKASfIpVXOMdaNPQ==
X-Google-Smtp-Source: ADUXVKKROYlhLyJ5o+Ce/8YHcbkl3otlQYpT4bbv6ge7Acu0WFEYblmnprV9dYIk30euiK3B4OBlrRSbXG1fCMpuSPA=
X-Received: by 2002:a2e:99c7:: with SMTP id l7-v6mr6725813ljj.148.1529496018751;
 Wed, 20 Jun 2018 05:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 05:00:17
 -0700 (PDT)
In-Reply-To: <5320.1529492016@warthog.procyon.org.uk>
References: <20180620074647.4152617-1-arnd@arndb.de> <5320.1529492016@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 14:00:17 +0200
X-Google-Sender-Auth: fpZLVCvj2GzBv7p7C8fQlwrkPBs
Message-ID: <CAK8P3a3hjbBKyoUS_3fbhgioPv4V+2H9Y4i_C+xwJsHJxrLE+w@mail.gmail.com>
Subject: Re: [PATCH] afs: use a consistent interpretation of time values
To:     David Howells <dhowells@redhat.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:53 PM, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> which avoids the y2038 overflow
>
> No it doesn't.  The AFS protocol is limited.
>
>> +     time64_t                mtime_client;   /* last time client changed data */
>> +     time64_t                mtime_server;   /* last time server changed data */
>> ...
>> -     time_t                  creation;       /* volume creation time */
>> +     time64_t                creation;       /* volume creation time */
>
> Unless you can change the AFS protocol, this is a waste of memory.  It might
> be better to change them to u32 as they are protocol values rather than system
> values.

AFS uses 'unsigned' seconds, right? What I was trying to say there is
that with the patch, the 32-bit overflow gets moved from 2038 to 2106, so at
least the nearer problem is solved.

On 64-bit machines, we already waste a little memory here, the usual
tradeoff I took was to use time64_t for all time storage when possible for
clarity reasons, but that is easily changed if you prefer.

>> -     inode->i_ctime.tv_sec   = get_seconds();
>> -     inode->i_ctime.tv_nsec  = 0;
>> -     inode->i_atime          = inode->i_mtime = inode->i_ctime;
>> +     inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);
>
> Surely, the tv_nsec should be zero since anything else cannot be represented
> in the AFS protocol.

current_time() truncates the nanoseconds to the granularity of the filesystem.
Since AFS doesn't set s_time_gran, it gets the default 1000000000 value
leads to tv_nsec being zero. Once Deepa's patch to truncate the tv_sec
range lands, it will also ensure that this is within the range (this is less
of a problem for setting the current time than it is for utimensat() which
can set arbitrary future timestamps of course).

> I will grant, however, I should be consistently using them as unsigned values.
>
> Note that the answers to the above may change if and when I start supporting
> the YFS protocol extensions, but for the AFS protocol, this is simply not
> there.

Ok, good to know this exists.

      Arnd
