Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC59C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C520989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="oSzgRQq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfA1OnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:43:22 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25483 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1OnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:43:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548686584; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=cMczlve8Bex5B+yLjN5e9xf060MfmuJ9JY4lX339+QgrN4F2DIiXntmUPiRV1sfQIQNUhTRYbhmc9YvOc4JlcuTjCFdclujDrbU8lS+5T172MiJ4yHAgY67Y0t47xiLwACkVaZe2Hh0Up2QnmhKYuKgJupR2Or1r3SUXCGy/fqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548686584; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=ZgZtxHJ6LEtr0BkDiqHgRQZH6s3FtIHS4V4O7wcBBKA=; 
        b=bvd6OJKvf/9gyZ9Y5YJmDDfPaua8Vavp0UvQq1nISVKcAQ811k8gBsWN862GzUwGVhgyaBwFvUFwD2NKMBkjXy1VkdEXIKdTCSw6df5n1MxB1APx6RS0ackGnO+ZtjKZdEbQzjJJirq9HfPU0yAJviRdYCENp2bpEnf3paXp4K8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=imWEDmqwJsLlqXPMW6+mB84T4KjrCkrbf3p5J4Q8MjMT59DgNx2k1+3/ro7YvxOB7nUOOG65nSfh
    U6a2Hg0uWreq0VaoWEhThGk9ya0FaTeEKTO4+RtxbuHbMHgnmP5Q  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548686584;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=560; bh=ZgZtxHJ6LEtr0BkDiqHgRQZH6s3FtIHS4V4O7wcBBKA=;
        b=oSzgRQq0UgdnAFXi1/WdfX1dOR0Fq/3TSAET9ljM6gUOIZBFvwLG5+JMsOEl6yuR
        KIOeAFY9pzhKWhg8Ie8tgfJEfQYNAOS8wpDC5gCiQR4Ecxi9B2qXbJbpEoqef0KiLc9
        4OSArhBSrKtdv33aG65NHqi+8wBOVT4qUydFEAdI=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548686582123671.5794415177415; Mon, 28 Jan 2019 06:43:02 -0800 (PST)
Subject: Re: [PATCH RESEND 1/4] Pinctrl: Ingenic: Fix bugs caused by
 differences between JZ4770 and JZ4780.
To:     Linus Walleij <linus.walleij@linaro.org>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548410393-6981-2-git-send-email-zhouyanjie@zoho.com>
 <CACRpkdYe2NsBFC-KBQXhmsSJ-S7wN9cZZuEPKHSfQe4HZUXTPg@mail.gmail.com>
Cc:     linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>, syq@debian.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, 772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4F14E9.7030203@zoho.com>
Date:   Mon, 28 Jan 2019 22:42:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYe2NsBFC-KBQXhmsSJ-S7wN9cZZuEPKHSfQe4HZUXTPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply. I am working on v2, and I have removed the=20
fourth patch in v2,
so there will be no warnings at compile time. But this will cause some=20
warning messages
when checkpatch, I am confused whether I can ignore these warnings.

On 2019=E5=B9=B401=E6=9C=8828=E6=97=A5 21:59, Linus Walleij wrote:
> This series looks good to me, but it would be nice if you could
> fix the warning pointed out by Paul, and I would also
> like some ACK from Paul C on the patches so I know this is
> fine with him.
>
> Yours,
> Linus Walleij



