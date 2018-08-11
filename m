Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF0FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D9621A41
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMUp6Xi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D9621A41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeHKWqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:46:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43592 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeHKWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:46:08 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so10779959ioa.10;
        Sat, 11 Aug 2018 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r+y+Zajymd/Qx2UO0PkuaCsx985b7ym6QDvEeNYFWXc=;
        b=LMUp6Xi2gty8TFSQIF5o8frVlfncYFYTcx+KWsROiv++P4VYg4HJ7ZDlR6VU/mw3NU
         Y1iCu4D8uJcrD220LRfJLn6xfImH65z1IQTMwjlaoDQQl8eqJu1jDHyAUwRsE/0dXuAW
         pOJ+s5P3uSKOY4SZZrVOdxZCcvC7ShfDbrgkp9F0ii7mThcW0rNlsSwfzkd+HPkev6gs
         TSAsUnF25XgGahRADAM0iKJvHPoA9ax0DxL9zUz9v/KHNU5ugqNaUTfgR2vAx9dFMe+S
         D+w2kThiHodC3Jqcvj5kbsK7X9I9NZyL3gUENr4NDmoAcQeqPuzgFA9V6pZ79Aevoc0O
         AnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r+y+Zajymd/Qx2UO0PkuaCsx985b7ym6QDvEeNYFWXc=;
        b=Mgp0q52fbH1V2Yh40FI2Y/yJqc5mi0D859H8Yt3YNddgj38IgTds+e/krifLL2BBpk
         vKIQxDlIAges3dxRzpjCIgCAEbYP1iHgT8FgGJxXyEPMLWm3PbHsUzgdjSJ+wCOUtrdO
         V4i7htUXpkGYstEhKuEZs4sfsqZZM1jpZAl7Q/vtG18veSNVbXnsbai2sEVW82T237Fj
         kSyPe/WdD9ZZgZE7Y0NtFVwm6Z4oJbU1K9XyNFkezxI7wZkbxH/wxivFzadUX5S3nIUY
         WzXjFK83Y3HEPx07YUmRkAqVfKpTY9/43kPy3wjyDqd3biD1KiTkWV9KwNFS5EBnx2V6
         91CQ==
X-Gm-Message-State: AOUpUlGd5H4psPmEyZ5+jFv9xL6EJR77tmpgQNLwfRipEKaZ8j7XcEeu
        Mq3JJCfPiAAOliXVXrXd4XJFUPqvK4KRZY5hOxleVeAB748=
X-Google-Smtp-Source: AA+uWPxzci5cn3h1d03Efhlk1eEMVcdLrtqagzfvAth01jA6faf9v+uHY2cCyB//LLhWzrwGcdnkmzTlhuzX/dYp1tM=
X-Received: by 2002:a6b:9f0e:: with SMTP id i14-v6mr10228722ioe.0.1534018252394;
 Sat, 11 Aug 2018 13:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 13:10:51
 -0700 (PDT)
In-Reply-To: <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
References: <cover.1533989492.git.puwen@hygon.cn> <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Sat, 11 Aug 2018 16:10:51 -0400
Message-ID: <CAO6F7D=voK9Vof7-c-D8TNmppJUaEj4Qhd37kdRVHxOU9mZntA@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 3:56 PM, Michael Jin <mikhail.jin@gmail.com> wrote:
> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>>                 else
>>                         pvt->dram_type = MEM_DDR4;
>>                 return;
>> +       case 0x18:
>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
>
> This vendor checking is not necessary as there are no other known
> family 18h processors.

Actually, vendor checking works here. Although, AMD has not released a
family 18h yet.
