Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E5526129
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAXgpeDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E5526129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeFYWPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:15:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45819 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeFYWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:14:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id 188-v6so14028360oid.12;
        Mon, 25 Jun 2018 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ThBbUOBn+R6VpGkNExmDZxoJRzHPGWoNtrzFo/QO6ss=;
        b=JAXgpeDEPpp3/xUNpZnES3lfbkAvBaJ9em2I33T2RfxSwuqqrKoAbSpONT4SqJ6Jnt
         6+uGGgYB9xEw7tJqvW/ElW3JmD6+vDDH45XebtPbN3v2LG6vjuoKuT+FgP3EYIzPGgrL
         GT4D6opakJzlMHEhejG6oI5Z48Kq8hC037uYDi9QfthM1t8x2xWYa4Ixm1e2q5/U8Ete
         rFEgj4ACSvvEXSFbgFCNj6J6VQxWqoABeq1GXKcYLdIly5Vgu9l+ieDKIgT2avY3s+p/
         m2akvq5DD/AiCo8CdLgqliyc+gAuEbD8v3Hcw+l+JbY1CqVhAfxtG038Gzph/4AkFymL
         YVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ThBbUOBn+R6VpGkNExmDZxoJRzHPGWoNtrzFo/QO6ss=;
        b=KslVaGi2ANr1XjJkqkh1y6KtFhSH6kVYop3me0Y+acAuPQExchR4wUaHutSBf8duUo
         alochjhCHwCZLLGceDbSgq2WqBP6lX9xXeGZ5mRBRruWjWBZEWb5/UhofnMt6oDc4ZrF
         thADR3OV2TxzhWSEFhb5a7nTJ0JIPBzaMYi/+hFQ0ZBCfdQXV/x1zkBpF2xQzyKfOofG
         zkCOQBLvvZZRiEr9PS6vft+N2ob1RTJ8cawfUSJo3GycRedJQ99cRnzLTVx25PqBZBQd
         TXAoJWDTlLg6mT0Ikiu4+HucJ4bfu99/l3ao0qXz9R9ZAqtjisu0WpNPgyUKHsgEaN3g
         KEDw==
X-Gm-Message-State: APt69E3opyfUbyv5S+ekDdmin8j+94LSGe8Rj07mqzGv7Dt4LLu0Zqa2
        UZU0E/EWAmDaUD75BD31TCD9ze6DU29S9f+vV/M=
X-Google-Smtp-Source: AAOMgpfBOYGPpXoM5gOsTR7Lustndd0jSjB1x8mDE3JRjMbr6VzixFcq//1kWx/+0a88zDmsOeoD2SgOSJJQGNBu0UY=
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr7685251oic.358.1529964897829;
 Mon, 25 Jun 2018 15:14:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 15:14:57
 -0700 (PDT)
In-Reply-To: <20180625115913.GD17001@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com> <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd> <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
 <20180625115913.GD17001@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jun 2018 00:14:57 +0200
X-Google-Sender-Auth: Bnz56HbKillBvz1EfpPUQ3dm_To
Message-ID: <CAJZ5v0jPp5GyrHCGLxXzbUOM2MzSL1ikkiEAMt32mcsuY1Gp4Q@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:59 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
>
>> > Well, AFAICT in this case userland has the key and encrypted data are
>> > on disk. That does not seem to be improvement.
>>
>> Not really.
>>
>> With the encryption in the kernel, if the kernel is careful enough,
>> use space will not be able to read the image even if it knows the
>> passphrase, unless it can also add itself to the initramfs image
>> loaded by the restore kernel, which (at least) can be made way more
>> difficult than simply reading the plain-text image data via an I/F
>> readily provided by the kernel.
>
> I still do not see the improvement. If you are root, you can modify
> the initramfs and decrypt the data.

Even so, this requires additional effort which already makes the life
of attackers harder.

> Please explain in the changelog how this is better than existing solution.

That can be done.

>> >> Besides, the user space part of what you are calling uswsusp has not
>> >> been actively maintained for years now and honestly I don't know how
>> >> many users of it there are.
>> >
>> > I'd assume distros want progress bars so they still use it?
>>
>> I'd rather not speak for distros, but if hibernation images are
>> written to fast storage, progress bars are not that useful any more.
>> They are not used on Windows any more, for one.
>>
>> > Anyway, there's solution for encrypted hibernation.
>>
>> Which is suboptimal and you know it.
>
> If this is better, please explain how in the changelog.
>
>> > If Intel wants to invent different solution for that, and put it into kernel, they
>> > should explain what the advantages are, relative to existing solution.
>>
>> I'm not sure what "they" is supposed to mean here, but the advantages
>> are quite clear to me: better security and reduced syscall overhead.
>
> Better security against which attack?

If kernel memory is encrypted by the kernel, it doesn't have to worry
about bugs in user space utilities and similar, for example.

> Syscall overhead is not a problem for hibernation, and you know it.

Oh well.

I wrote the majority of the code you seem to be defending and I don't
really share your enthusiasm about it.  It was good enough at the time
it was written, but not today and this discussion is over as far as
I'm concerned.
