Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B827FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FE120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncSUx/CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FE120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIMNK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:10:28 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35433 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeIMNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:10:28 -0400
Received: by mail-it0-f67.google.com with SMTP id 139-v6so6649711itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cz17QLutfTFy0OH0lAS7ooB9qZwadL6Dr6fDuVfdDiU=;
        b=ncSUx/CAJYyX9EuAtNg8VF8LZXyG83naV3fVYTCsTNdvtmkJ8TB/kUgxTEye0AZ+Rf
         /QESKe1iE9+jbyS9RAaARso8S/2mL/RXNP/BlWbEqfS7+MbT4X8DxP16XN0VYHEh0RSj
         FkRn79KoXR86G4+YViLLbiZSjwH7hfH8OxiC1h4uTDf4UoVWRjntivvaE9MN5cP0Q9tE
         Nvz38z+P2MxF7TSLG7vQ+kEs4Q186+TtDoGc4A+ny8+Cf8rS/NJUDW234uczm7gPfl5r
         zGUL48GAGaQT2QW5+/EjAf4JZ7SwG3YhEpfHmuAxXNw2HqD1gfUk1JWve2zglIcd+OYA
         6oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cz17QLutfTFy0OH0lAS7ooB9qZwadL6Dr6fDuVfdDiU=;
        b=rdlCcD9mFnDSlDonGZGzMQ+Wvv6U3WBXLnd6fSwD2L8QeMnL56nE59Q+cbCrFCNmR1
         b7YjHVSuw+7ashteRoM9UgPjWOhL4iY1QBzqzrY9UnUaYwpZMaBzBQT8nq5JjCBadQzv
         Mal8yRLpz3GEI9Hn2HvlF6Tj9o/eZFwacQHT9w5YBMGqwiS2341mqVJQk2R6jPu4c9F8
         29+ka/9PnvIhQiRL0D8QpI5q1H0lcaaAWmuEgQlkF6gQdvexyGQrx2MFnoK+49NA/vhi
         nHdjrO4DH2SefZDPzoyE5RkxKQIil0ntv12tqzqbz/lH52K2/6dt0c/P9ddXGAfHPDGD
         TGeg==
X-Gm-Message-State: APzg51AtCmmVrNQqHDNnOdIodJDE5PtC/wLCTozp6Q5KY9W8puVO2mh2
        eq7l+aJ194ydIOB2lNygzdg6RaAKAnZCBRgqRZxTpJ9QfHI=
X-Google-Smtp-Source: ANB0VdaJyGN2dM2wt5roL72IYtMS3ZeasillkW/sdr5JiRRB98+8BegTc7v7k6iCVJN0/jT7AiyXD40t+ABnq6eQ+VA=
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr5608804jaa.19.1536825728115;
 Thu, 13 Sep 2018 01:02:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 01:01:47
 -0700 (PDT)
In-Reply-To: <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
References: <000000000000038dab0575476b73@google.com> <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Sep 2018 10:01:47 +0200
Message-ID: <CACT4Y+Y0ShhnxOXdFHYz40zq58Je1eZ47oLLYaC4gH1zwQNN7Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        SELinux <selinux@tycho.nsa.gov>,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>, peter.enderborg@sony.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:02 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> syzbot is hitting warning at str_read() [1] because len parameter can
>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
>> this case.
>>
>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
>> ---
>>  security/selinux/ss/policydb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>> index e9394e7..f4eadd3 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>>         if ((len == 0) || (len == (u32)-1))
>>                 return -EINVAL;
>>
>> -       str = kmalloc(len + 1, flags);
>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
>>         if (!str)
>>                 return -ENOMEM;
>
> Thanks for the patch.
>
> My eyes are starting to glaze over a bit chasing down all of the
> different kmalloc() code paths trying to ensure that this always does
> the right thing based on size of the allocation and the different slab
> allocators ... are we sure that this will always return NULL when (len
> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> configurations?

Yes, it's the blessed way to do it. We have lots of similar cases:
https://elixir.bootlin.com/linux/v4.19-rc3/ident/__GFP_NOWARN
