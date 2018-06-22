Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3769CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63424388
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfW2Pv0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF63424388
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFVOTk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:19:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33847 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933196AbeFVOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:19:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id e13-v6so9073997lfc.1;
        Fri, 22 Jun 2018 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fayUXbLSROJfndb7c6G80mP57u3NdazVH22qYr+aVkE=;
        b=BfW2Pv0DDkwrkxtccP9RL6s+K50TjE/cElAYn2A6IWqPx4EEyL7DEw7hKhQ9sP+yUz
         9lnGXybz9ODKiNajjvrBxTcu5rYHQQylKDku/qmKD1E7tEJ6lDuO5rN/5y/zZsRJ0FCb
         PqZfstBNZ8kkhf7HaMW5xkdZaYNv50+X636BBNaVy1XE1WHSAyyhfLyJ6Fmmvt1asbEL
         +fRkm7tJ/gJrlGiOb6wttcphRVqrHxVkGwLUCZY3RWa5S5dP8hGIPDIg4XWLlZYXeKFa
         0F2RuN/CRAkpFIqcXhrD4V+x7WzZ8wOVGFktiboYzgSECI+YNNu61K23NeJXaD1edGf4
         JAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fayUXbLSROJfndb7c6G80mP57u3NdazVH22qYr+aVkE=;
        b=MbqcE662sNQKA7WY0LLjTZyROfslA/8Udzbr5P5He+iWnUStk2YZtNR53kWdcuY4d2
         BuK9Kqa+randIK9HzGBet1r5vY09icWlbOHGQfxhCGQgW3qcbR+g75Ni+62jxqhQUqKA
         CYjFJaVFWTr51I5IMuZCvbSZH4uz1CD+xKKqZ7rLkAHuTImgqBLeeD9TXTYJBnux++XG
         GKCq6AsL+LgFAzO9t8XIlt8AdnPx9bwc6t6AP2WSAVl1FbP1STF0XTJmg5VxadcFmIx2
         WGLCpD1JEkgG39P9ymh3+2OYEQ+z/CDkEzsk3NvCcRPCgUwTW9bIKD9DnXyyu8Xedxo8
         SuaQ==
X-Gm-Message-State: APt69E1NXc284fQ93q3pfc92EQwX5uLBDjqLzEayhY2uvvKfqd0wDMw0
        Wc3pRWCGly4W89JYkGHmgTyVmucprsAogZ34MIk=
X-Google-Smtp-Source: ADUXVKJ2XYf0Lle8pMbLNq6TQANTq02HmloEdSr9Yxhnd9bDYhcxIDi3Q2PI+T6ug1n1/tz6APy1m9H16cWAUyjn/8A=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr1368211ljg.22.1529677176608;
 Fri, 22 Jun 2018 07:19:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 07:19:35
 -0700 (PDT)
In-Reply-To: <CAK8P3a2X134US86LAecGqx4cd1AbhQgyp5NqFgymKs0v9Hx7dQ@mail.gmail.com>
References: <20180619160223.4108556-1-arnd@arndb.de> <1529427809.2624.16.camel@dubeyko.com>
 <CAK8P3a0WNPxDqSNJUuijY0P9UwGXPD_DCAUw9AH_OvAg-cPf1Q@mail.gmail.com>
 <1529513708.5833.29.camel@dubeyko.com> <CAK8P3a2X134US86LAecGqx4cd1AbhQgyp5NqFgymKs0v9Hx7dQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jun 2018 16:19:35 +0200
X-Google-Sender-Auth: 7i2Er5ZW24xVAA_jFgO8-KGXIv4
Message-ID: <CAK8P3a2u11+Ccoxk2hJpYTeyOVSOwZHyT6PZAE6_RSTMStN_pA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hfs: stop using timespec based interfaces
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 9:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jun 20, 2018 at 6:55 PM, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>> On Tue, 2018-06-19 at 21:42 +0200, Arnd Bergmann wrote:
>>> On Tue, Jun 19, 2018 at 7:03 PM, Viacheslav Dubeyko <slava@dubeyko.com> wrote:

>>>  /* time macros: convert between 1904-2040 and 1970-2106 range,
>>>   * pre-1970 timestamps are interpreted as post-2038 times after
>>> wrap-around */
>>> -#define __hfsp_mt2ut(t)                (be32_to_cpu(t) -
>>> 2082844800U)
>>> +#define __hfsp_mt2ut(t)                ((time64_t)be32_to_cpu(t) -
>>> 2082844800U)
>>>  #define __hfsp_ut2mt(t)                (cpu_to_be32(t +
>>> 2082844800U))
>>>
>>>  /* compatibility */
>>>
>>> I can submit that separately so that it can get backported into
>>> stable kernels if you like, with the type changes as a follow-up
>>> on top.
>>>
>>
>> Sounds good.
>
> Ok, I'll send an updated version with that patch first then.

I've now sent that patch with additional information that I got from reading the
XNU sources. Interestingly, that also uses the 1970-2106 time range that
I had in my original series, not the 1904-2040 time range that is documented.

      Arnd
