Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A773BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C820858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoLa7ZHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338C820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeGVONt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:13:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeGVONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:13:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so15281007wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tRJvhg4rFbqfgBJwf50vI6Jnfv4QnY/K8EVi/v6Y8BY=;
        b=uoLa7ZHuPuiTSUiCWnyaqGPtGTm2IvqIQUyPQLxoCTm9OvtJhIHIhQAIDATsozMJPe
         GDlQhbfBmt1bOwbbawFI8etlRpA+cuh3jqk1IEHM4E0a7zJAXF5opwVqvfDejxREb9yg
         uIAzj9JwF/jbyEEiUq07v6UY3PYwsDjmEj/Xzc0k88s9cVzwvF8Vnfk9CGuS/cBNDaf0
         7+ijZNHpFUjypz0b21pqDv/92iWNWQ0ICXYpAfo6aUvBV9MlUeOiv6gzUA7V3tJHOo6q
         fQbBb6OtpiztKY/XDlUSDhcLggYy68+5jRkPh7iNRS8XTbGheUrNytXnufhhCiUAIZNl
         knaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tRJvhg4rFbqfgBJwf50vI6Jnfv4QnY/K8EVi/v6Y8BY=;
        b=jmvoiTnAmjKHzDKviOETI93lq5IjRiS5S6Y4thl319unrCzh2/wXUVbZ6LAkC6Xob+
         TQpP8DGb4Q5FXbegUh6jDypXrX2GlPUEhpaMQ1ipOMWBwL3poXtKuc5nCWm7UApI3yi0
         h8av6JITv3D9ABCbTQPCD9MFJqzUk509md75ApeBZ27k6GBPpRraXk2NH2k/I7CLGmSu
         1NoET83aREyo1Ttz4+m9ovP284+WECeL9IPYoIALGKGugTDZpz/u1eYDxs5g66cI7Px8
         NI1ByF+J7vcD06T6fTqQmj54lW9Lu4FYJiHcPn8ZyfTdNhjCPNUawIpKTLFUp+87ILEA
         gktA==
X-Gm-Message-State: AOUpUlG7lWa4ZNkj5mvMnI17zEjcruKvxtTe9RfcutoisqXX0ciQFbO0
        FUdNv0OzB7F0ap+ttgFBxIJgXHWNYEbIvRhT9czutA==
X-Google-Smtp-Source: AAOMgpdBLoNtvVzIKZtntuDv0CSj6pmqjJZ1kw9ljVaONJiA5LgcoO++OLtgrxH4CGPGJi+NAguWDPyLGpUTUZkuKPQ=
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr5918489wri.199.1532265428282;
 Sun, 22 Jul 2018 06:17:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4812:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 06:17:07
 -0700 (PDT)
In-Reply-To: <b2b2e3e0-14b7-9f46-434d-2134d1d0cfad@alliedtelesis.co.nz>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <f1c6c3cc0c8850e143594afd57b50d30cd8bb5f8.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <20180720000431.GA30522@ZenIV.linux.org.uk> <b2b2e3e0-14b7-9f46-434d-2134d1d0cfad@alliedtelesis.co.nz>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 22 Jul 2018 15:17:07 +0200
Message-ID: <CAFLxGvyTmz8JQVn-OJFSVdns74o49XgdWbhGpPsqYe5S2uahYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] jffs2: Provide jffs2_sync files to track gc POLL progress
To:     Theuns Verwoerd <Theuns.Verwoerd@alliedtelesis.co.nz>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[fixing CC list]

On Fri, Jul 20, 2018 at 2:54 AM, Theuns Verwoerd
<Theuns.Verwoerd@alliedtelesis.co.nz> wrote:
>
> On 07/20/2018 12:04 PM, Al Viro wrote:
>> On Fri, Jul 20, 2018 at 11:50:12AM +1200, Theuns Verwoerd wrote:
>>
>>> +ssize_t jffs2_sync_file_read(struct file *f,
>>> +          char __user *b, size_t len, loff_t *ofs)
>>> +{
>>> +    struct jffs2_sb_info *c = file_inode(f)->i_private;
>>> +
>>> +    while (c->tidemark)
>>> +            schedule();
>>> +
>>> +    return 0;
>>> +}
>> Brilliant.  So when that gets called with c->tidemark being true and
>> need_resched() - false, we shall...
> By my reading, schedule() will happily force a reschedule (once) when
> need_resched() is false.  Every time the process is granted a time
> slice, it'll check the condition and surrender if not ready.
>
> What do you believe will happen?
>> Bonus question: what happens if that is called after that jffs2_sb_info
>> gets freed?
> That is probably a valid critique - if jffs2_kill_sb() gets called the
> cleanup in exit_jffs2_fs() is not sufficient.

Beside of that, IMHO this debugfs file is a gross hack.
Did you look into the possibility to add the GC phase into the unlink code?

-- 
Thanks,
//richard
