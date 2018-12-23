Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C89218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugT4w0n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393170AbeLWEMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:12:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43079 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbeLWEMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:12:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so10253352qtj.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=J+/TcwVsoJ+3cTMst9tkhI4i0BW3VJcwin1HI+8BFO8=;
        b=ugT4w0n2vZFiu/XIeGuRjl79Aw3tXLVqh+6aG93MDBxkMvH9wsDBfHvPi9JmSEYJkS
         3R96nDi6MmdK5ZfLGA2iI/9OqmxTZOIbv6jBo/pcja9HlEpnP5wukWzLZm7K0xF5XR7z
         LIXFRNDTXJf9b8hmVfZ7u1y+iMOrfNK28LBZbZox73Ircm4pxYitKecOj5Jw16xS2pp+
         kO/hDTasSmrg5+n3aFXRwmL/OOo91Hbzv3LEnhE3nBcK6HpZcrb2Ooy6yAQO6/crNPmK
         nwrQWYr2HBsg5w0BrvAV8ifOL54ZGa9LMKixTN18hNUm3v+yaj87lPZf9AzV5+v2tYgc
         /OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=J+/TcwVsoJ+3cTMst9tkhI4i0BW3VJcwin1HI+8BFO8=;
        b=SvoMWOg+OI3Nyc5pD0brDxTVOYTeciy9zt6CpYXTJODQUPVpjdV3FITjP7cqFKm5cI
         YP2eA6nlf1KzRDi5C981VaLcjCaqaSHj/9/rzKdiKq/SJj8wZIY8JXR70sII368JVWbP
         s4N/POwoSifklN9xh4ocbTfefIR++4MBBGxRh4cJ39YX9PlVC+Hh1ohLK+BSWaVug4r7
         MO40YYwew8/WyQWZ4zfKa/IOxLxRoNzs6IiT0gxKaleUiYB/ahfww/JWJC8lcRw+yClY
         EaMOrKepHQA7wHUhSl12i3QZ5yQT6xO3YGjfMEPSyITvUPIOEbcqjuk4rao5+J9yZTUY
         Wf+Q==
X-Gm-Message-State: AJcUuketvCjKtqYVXEXVtJrIa46KDD/u9orwZDERLPHH4mYytiWngAuv
        Jp4ulUp4i507X6XPAzyXyFA=
X-Google-Smtp-Source: ALg8bN6IXVmWkg4GVBgnukdZlDhR67im3/6f8zGWeZDaqDMRGUp95HvvxGntSalU6huWK3uenybsGQ==
X-Received: by 2002:ac8:44d4:: with SMTP id b20mr5961065qto.340.1545538356651;
        Sat, 22 Dec 2018 20:12:36 -0800 (PST)
Received: from ?IPv6:2001:470:1d:7b6::245? ([2001:470:1d:7b6::245])
        by smtp.googlemail.com with ESMTPSA id f14sm8692333qka.18.2018.12.22.20.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:12:35 -0800 (PST)
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     Gabriel C <nix.or.die@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christian.brauner@canonical.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <seth.forshee@canonical.com>
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
 <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
 <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
 <CAEJqkgjF7HBcvD=2QHTTipjv1kmpWwRATp1VLnu8KDe6cGMvhg@mail.gmail.com>
From:   Ellie Reeves <ellierevves@gmail.com>
Message-ID: <d5ab1cb4-6d4a-4d57-0c70-3377549086e2@gmail.com>
Date:   Sat, 22 Dec 2018 23:12:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <CAEJqkgjF7HBcvD=2QHTTipjv1kmpWwRATp1VLnu8KDe6cGMvhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to thank you all for reacting to this issue so quickly, and 
I am really sorry for sending the message several time. I thought there 
was a problem with the way it was formatted or some such, hence why I 
sent it several times, because none of the messages seemed to get through.
So yeah, real sorry about that bit, and thanking you all

Gabriel C a écrit :
> Am So., 23. Dez. 2018 um 00:02 Uhr schrieb Linus Torvalds
> <torvalds@linux-foundation.org>:
>>
>> On Sat, Dec 22, 2018 at 2:49 PM Christian Brauner
>> <christian.brauner@canonical.com> wrote:
>>>
>>> To be fair, no one apart from me was pointing out that it actually
>>> breaks people including systemd folks
>>> even though I was bringing it up with them. I even tried to fix all of
>>> userspace after this got NACKED
>>
>> Seriously, the "we don't break user space" is the #1 rule in the
>> kernel, and people should _know_ it's the #1 rule.
>>
>> If somebody ignores that rule, it needs to be escalated to me.
>> Immediately. Because I need to know.
>>
> 
> I do that usually but I didn't saw Christian's revert the time and I
> never hit that issue.
> Just saw that now because the unusual  [BREAKAGE] prefix.
> 
>> I need to know so that I can override the bogus NAK, and so that we
>> can fix the breakage ASAP. The absolute last thing we need is some
>> other user space then starting to rely on the new behavior, which just
>> compounds the problem and makes it a *much* bigger problem.
>>
> 
> Yes and you are right ..
> https://github.com/lxc/lxc/pull/2438
> 
> I've added an comment there about 4.20.0.
> 
> BR,
> 
> Gabriel
> 
