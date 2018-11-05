Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614992081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANHjKwyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614992081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeKFAzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:55:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33667 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeKFAzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:55:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so15433178qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GkVfspZFm9D4z++Yp3U3M/ae8F5kglGu1Adb3Gu7oDQ=;
        b=ANHjKwyW36j8PHvq7An8zM3ZQODaAeVdJ00aRFvJMkV5+u21b8SQ1wp+1G8u4iT3LA
         TrocLCfxpEpU9xz9WAUdYpm9QteA86byNxKn5qzru+oKShgs/sS6ZD079oNWMhb+xDAz
         obSETR92TV6uaYakRp0fNBrH6Z4sj3gNESoVQYSwIStPtxRPmJ/A1/S5EIuoNp3Vbwhi
         4N+VmrFX8w+nzVDj0qgp7Pf47EHtDN0FhMWNqxzpfB0B9QvkCMfSI2MpZvr1Squq+pyl
         3aFZsTSjUUg3mG8u62W8Iu2+JSY6vAhwSLUs6LJPKMuXbxRs4e9y6l4WPPm+pS+aQRUX
         a93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GkVfspZFm9D4z++Yp3U3M/ae8F5kglGu1Adb3Gu7oDQ=;
        b=qa6fSSTHY5WX1V0hXvtV5KXYmJqiy8NpKabJ/bKgdIJyQFJmcjEacedn3+1eQJWELY
         UDn5RAepyN9wwd/u+6MCCt/mL+/CgMzaM1GlYvpFZ6OO5LFcT1WpL2gi44tUKeuaq5l6
         K+4MfM610NmwncyG4CsCjN7ASpwTHgvc7TWF9JCp5HsrwAcX4CsAk7Fr1Y1neyjLDVSv
         y9iNkn3Dq/376bpeMnww6sZNXz9rPFKhCkBlzBE8nGherXIHptHLnt12bwMqDvqOnqoy
         VZoNqmOy3BXFgHFkf6rdfLzhmz8zJqd3AypyjmTlH/bKcZGGd34J7AiBMeQsafXGC31f
         5Y/A==
X-Gm-Message-State: AGRZ1gKHKf7D6ZoYQYzgy1Woo6FDHL7FOXP1iYbkqWasZSTJmXoSMLYG
        o4G/vIkCu0u/SNkHI0OS1wNEAFSPdzJ3uDRmVxc=
X-Google-Smtp-Source: AJdET5fu/Cgx5UwOnjumifdFvogWTbRgkzsodk5AFeL41JV3dnADz2MExSF4+Vuin4ZlG2/cXLcSfJYfChM9P7kmx1Y=
X-Received: by 2002:aed:2ba7:: with SMTP id e36mr19080415qtd.319.1541432108456;
 Mon, 05 Nov 2018 07:35:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 07:35:08 -0800 (PST)
In-Reply-To: <20181105090114.GD6953@quack2.suse.cz>
References: <20181102153138.1399758-1-arnd@arndb.de> <20181105090114.GD6953@quack2.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 16:35:08 +0100
X-Google-Sender-Auth: TV_XfckLSCr44a1TteYItc0uDjc
Message-ID: <CAK8P3a0sC1p5dHBpc8ktWEt59Q0FVRUZGiX4bn6v0kOhbbYyvg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix uninitialized variable warnings
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wang Long <wanglong19@meituan.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Jan Kara <jack@suse.cz> wrote:
> On Fri 02-11-18 16:31:06, Arnd Bergmann wrote:
>> In a rare randconfig build, I got a warning about possibly uninitialized
>> variables:
>>
>> mm/page-writeback.c: In function 'balance_dirty_pages':
>> mm/page-writeback.c:1623:16: error: 'writeback' may be used uninitialized
>> in this function [-Werror=maybe-uninitialized]
>>     mdtc->dirty += writeback;
>>                 ^~
>> mm/page-writeback.c:1624:4: error: 'filepages' may be used uninitialized
>> in this function [-Werror=maybe-uninitialized]
>>     mdtc_calc_avail(mdtc, filepages, headroom);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page-writeback.c:1624:4: error: 'headroom' may be used uninitialized in
>> this function [-Werror=maybe-uninitialized]
>>
>> The compiler evidently fails to notice that the usage is in dead code
>> after 'mdtc' is set to NULL when CONFIG_CGROUP_WRITEBACK is disabled.
>> Adding an IS_ENABLED() check makes this clear to the compiler.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'm surprised the compiler was not able to infer this since:
>
> struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
>                                                      &mdtc_stor : NULL;
>
> and if CONFIG_CGROUP_WRITEBACK is disabled, mdtc_valid() is defined to
> 'false'.  But possibly the function is just too big and the problematic
> condition is in the loop so maybe it all confuses the compiler too much.

On second thought, I suspect this started with the introduction of
CONFIG_NO_AUTO_INLINE in linux-next. That also caused a similar
issue in 28 other files that I patched later. I wrote this patch before I
saw the others, and then didn't make the connection.

Let's drop the patch for now, and decide what we want to do for the
others. I fixed those by adding 'inline' markers for whatever
function needed it.

       Arnd
