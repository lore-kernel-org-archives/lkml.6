Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E64ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E30D20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FC9Pwx7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E30D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeKIDta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:49:30 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33956 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeKIDt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:49:29 -0500
Received: by mail-pg1-f169.google.com with SMTP id k1-v6so9203761pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xCBFRhUC2oKl7CRIJ9MvCx2S4hPxyGXMN33ieQ4CQJU=;
        b=FC9Pwx7KY1Gwe5gjuSTtMaQTAiRZFTQOy9F7VRFK/8vQPxT5QqGdKB56ddNoGDJ7xL
         N/627UWlnEe1qOH09PfwzrkWlXJiXdM7XNfdFKrS5ZbUoka0dKwAqNEy23AOOpfxMh/N
         pBEKA/HEM2XPYfIVgFL965pn0jNtjOGfePE7RGQ7C94T9muAiiWgjGIp5aDoAzjxJd/y
         re0icrq1Qb18PBhSoRbNXd2c+jNueBz0LEZIRP9hb3BnBvTSt4x6GDJ9S/qoky9/rhG9
         0CwQgL48BWfyNc4Jrv6Q66kXNiy3bC41IK3Eus0mDH8qAT3WHGfotdFCBWdmcx6sVSh8
         AzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xCBFRhUC2oKl7CRIJ9MvCx2S4hPxyGXMN33ieQ4CQJU=;
        b=LEAy+BP8+YHvIbokgD8iM07+X9dg6M3k+if2y4a7YKDwFQ3H/7FdqqIjwlgLzadWRi
         qxHMijRUHTKOZVDxqJWQ68oUBj/cpYO2TR7POd9PLXiJ2FPGwUSpxtqYIJqjKQMaAsKS
         yf6DQIOp6kaFHcKLPVP3NGANmnJMKSVVg9Cto0k86R2HJFMwxXoX+aO7pCKR/Ar7myVk
         yLz5FTFofz68e0yXaAyP+AXMHF0WNVTxUFfzFZxN7rNFQ1OHeId3ax2mWCn7Mnxdpa9b
         /qaGpdCyNq9spOFARgotohMN5qC/skkjx8ZJE3hwYY9KflWN+kpMQQ14Qeix2+55EaAn
         4LUQ==
X-Gm-Message-State: AGRZ1gKECXW5u7xZVnhmClobRskpwXSd1R+J/0sFXnlWf5A2lb7hx01T
        uVXTa3Ap+VlUcs7hzv9GzUNvxg==
X-Google-Smtp-Source: AJdET5cZNWextEu3twWJRYhdDQrEc+cDZ+Wsdhm7ep0MAPQZscPPfpKlHlwq7nJWGNxndA1vmRaiRg==
X-Received: by 2002:a63:9402:: with SMTP id m2mr4421959pge.93.1541700767019;
        Thu, 08 Nov 2018 10:12:47 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id a11-v6sm4217030pff.8.2018.11.08.10.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 10:12:46 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        gustavo.padovan@collabora.com
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Tim Bird <tbird20d@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter\,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
In-Reply-To: <CAPhKKr-ntHmEiFwpvtnY890MUyTLH-6YuEPiN2-zGJQ-GY-V_A@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com> <70eba492-0b3d-1fe1-f17c-88964254124a@collabora.com> <CAPhKKr-ntHmEiFwpvtnY890MUyTLH-6YuEPiN2-zGJQ-GY-V_A@mail.gmail.com>
Date:   Thu, 08 Nov 2018 10:12:45 -0800
Message-ID: <7hefbve8v6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dhaval Giani <dhaval.giani@gmail.com> writes:

> On Mon, Nov 5, 2018 at 10:05 AM Gustavo Padovan
> <gustavo.padovan@collabora.com> wrote:
>>
>> Hi Dhaval,
>>
>> On 9/19/18 7:13 PM, Dhaval Giani wrote:
>> > Hi folks,
>> >
>> > Sasha and I are pleased to announce the Testing and Fuzzing track at
>> > LPC [ 1 ]. We are planning to continue the discussions from last
>> > year's microconference [2]. Many discussions from the Automated
>> > Testing Summit [3] will also continue, and a final agenda will come up
>> > only soon after that.
>> >
>> > Suggested Topics
>> >
>> > - Syzbot/syzkaller
>> > - ATS
>> > - Distro/stable testing
>> > - kernelci
>> > - kernelci auto bisection
>>
>> Having 2 kernelci talks don't make too much sense, I discussed with
>> Kevin and we thing it would be a good idea to merge them together. Could
>> you do that?
>>
>
> OK, we can make that happen. 45 minutes for the 2 combined topics?
>

Yes, that will be enough.

Thanks,

Kevin

