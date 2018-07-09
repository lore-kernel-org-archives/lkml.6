Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E15B20844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="er8DB/eo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHK8mx8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E15B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeGIP45 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:56:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38028 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933795AbeGIP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:56:52 -0400
Received: by mail-yw0-f194.google.com with SMTP id r3-v6so6711859ywc.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PS8BtBPfGUDCIP/Z18WZjD36gkEa562cx00sbrL6f28=;
        b=er8DB/eo/cttzSzBz76wsogvEXVMRpgq4iyL0ZR5xchOIHtHPsHPjFYKll19W27qK9
         +pc3pYWf/WYJYYgWU/ua827iLDGqssCqgNMz1t27K0srIrR8W7iKSYB2tLem0r229lum
         sztJT8DTHwRP3SIGmEEFNpf8SdHGzTsSvSaGavZPcyCkh7NUj49Ql1oKrBRKg02DObDc
         CuXBRMIBbuSfUXmJ2pd1p4bnXFBHkNlRAO6E9DvK0ZhqZE+/G1GzQPU0fnlKvGBjQwkc
         ZI4FhhbeCnoWHZPuZQqGyVI22ic1cPvpGiByHmBEYLHpkEwpwgQOvNQWa8JMWRqBKb9s
         4bcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PS8BtBPfGUDCIP/Z18WZjD36gkEa562cx00sbrL6f28=;
        b=YHK8mx8N71L8nzdoumCaxy2X3yjqCve/ZqNKuVMwAgshLAdal/3MjECIPItfEyhbx4
         tE1BxtoJis1fXy3mFjMhuO/7Amyqz1KEVLkbkQ2tASze/ZrwqyZTfseNpJT56gvoRElE
         StdZ5crrX2zsWmPi35P1DNoERyo1Y/AMjF55M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PS8BtBPfGUDCIP/Z18WZjD36gkEa562cx00sbrL6f28=;
        b=T9/DnZitGrdZ/AluT45Wp3IzC4RdWWYZvk2pYhhkDN1BDVVeAU0ujHx+h51Jm7bMZZ
         y7FZDg0vYkLSDQS930uZ+4osZFsEHrEfp8hn+bW9+70u8Dj8a/n/89UlwDTmTOt2ikOO
         cCYLmuvUKhuANiOKqqc7ATZFypTJskG9bEJddiyfCQK70L8OKNtX9rszVv6qitmhIVvE
         +TQ0VnGGb3ZjwV9CmZXGb75DlHzzWlEs6cYpAIJP5EJy7C1rSopUZmESG3s/oh89jryt
         /v4vc/DbFY9/kX4GUFSSWTcwA35Ev1rUf1dFCU4lRLC0RRBX/fneIq63rzjEx7Rqaml1
         4SgQ==
X-Gm-Message-State: APt69E0vRsZIbodg/d7B1xP6fI0xEmswuGiTGnqgxFbYdcWRIc5b/Xi0
        AZ+3b+OIiMggzeiNWOKAMnvbcqDM9Pm6Lo9Zt3iG9w==
X-Google-Smtp-Source: AAOMgpcbjOHOih83uPmG4iLCDfknFjQQrcfwklesYxWp3/E2KRT+TLvNc4QTFUUt3c5r8zdnnsI0CCDGzpDAQ1nVh44=
X-Received: by 2002:a81:3b04:: with SMTP id i4-v6mr10096357ywa.38.1531151811608;
 Mon, 09 Jul 2018 08:56:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 08:56:50 -0700 (PDT)
In-Reply-To: <20180708202315.GA2239@infradead.org>
References: <CAGXu5j+mgGZkTDS6EDRspJKKbU=vMT4ehv9T-SekPba=ESoGDg@mail.gmail.com>
 <9A0BC289-4203-4C77-A012-AAB07F42061F@kernel.dk> <CAGXu5jJsGWDsZNDJvUUqncSaAcvond_B_J7=BbvVW0X3r6Sxww@mail.gmail.com>
 <aa150272-ffeb-fb8f-7303-0d9502cf9a71@kernel.dk> <20180523142545.GA16248@infradead.org>
 <24d36869-e037-042d-cb16-20a81b34eb76@kernel.dk> <CAGXu5jJn=1Rz=D8VUwv_VoaGoLtaD=+tcPZxQxntweZoZwFa5Q@mail.gmail.com>
 <f4eb4cd5-8976-3990-69b0-26cca054aa45@kernel.dk> <20180524080015.GA2866@infradead.org>
 <CAGXu5j+pRUWgny+h5ToVQXBP8nANjreVhnXjk5TVgy84ufNsRg@mail.gmail.com> <20180708202315.GA2239@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 08:56:50 -0700
X-Google-Sender-Auth: yKZBeBG8M8HswZOjsC-pI7Ic_yY
Message-ID: <CAGXu5jKvUydp6nc3EUCyoGWbUUoiiASMFcBfVVOph1uc_oCNSg@mail.gmail.com>
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Sun, Jul 8, 2018 at 1:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, May 24, 2018 at 10:06:59AM -0700, Kees Cook wrote:
>> On Thu, May 24, 2018 at 1:00 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> > On Wed, May 23, 2018 at 03:14:19PM -0600, Jens Axboe wrote:
>> >> Ugh, so that would necessitate a change there too. As I said before,
>> >> I don't really care where it lives. I know the SCSI folks seem bothered
>> >> by moving it, but in reality, it's not like this stuff will likely ever
>> >> really change. Of the two choices (select entire SCSI stack, or just move
>> >> this little bit), I know what I would consider the saner option...
>> >
>> > Oh well.  How about something like this respin of Kees' series?
>> >
>> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/sense-cleanup
>>
>> Does the CONFIG_PCMCIA in drivers/scsi/Makefile now get exposed in
>> weird config cases?
>>
>> Otherwise, yeah, looks good to me. Thanks!
>
> Btw, did you plan to resend the series with this and your changes
> applied?

Yeah, I've gotten distracted. I'll try to get to it in the next few days.

Thanks for the reminder!

-Kees

-- 
Kees Cook
Pixel Security
