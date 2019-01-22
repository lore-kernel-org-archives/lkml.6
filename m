Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8022084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uM6MvBg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfAVIry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:47:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfAVIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:47:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so13354054wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=kZr0fYXLTDuQhA7Idwn8AXJc8cbOUQt42CeU5kkGDzM=;
        b=uM6MvBg20Qq29jwM8GsPMKR9cmQ2IwbVjzJWQRJbIKtfHk/YMlI/y9l2jhdRxNrUqC
         W8DULMM40djroBFBgxiSzwKtAEHM3HMJC3JaL45AS3w2xxCzGUv3A0oifxCuWiLK2Lmv
         Rvq1fZlE4RVqfoKaWZSXhGUa8dkkSF1pNCxqqf/S4UrRR+XJPeSXF3ydYKeZFbNLph85
         cUMAIK23+V846EyJbzly4lQp24CGWg94vAIqxxM9qSZUqGLkiBdpXyblmiQnwdRXgNwl
         WhZ1vvWDD8hZ3zhq1Xn2kHiR1ojSw3FvHROCgcNMjoRBKCToJG6N9tB/J2FynqZWpg8o
         crtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kZr0fYXLTDuQhA7Idwn8AXJc8cbOUQt42CeU5kkGDzM=;
        b=JfxHaAjpCsH6JtWclg7MmzsSElFdVKrLwuHvmg8pcMEsEjOlFHCngZ7zgSa8iPwtz7
         JSUSySeIdkLXcRj/HvamQ5nJd2o+upY4D737m4+Q8Oq3AEs94DoB1xO/0SmnND5o1m6Y
         UEWHvP3QydmFbG3S89G+3VYpn4yfhIu5p3qHLs5FT9Qn4oOeoNY1pjn4duk8ZXtk3wWG
         iv/xQfE1lKob1LUPK9M22LsNts6btuC5DykjOX4c0w/ER3FyViNoIktTgM8FxgibYyJK
         UVP3QUDh5FDtUg7gfyRmVMLliiM4z3UlJgRrvzZCg3XhBVaSHsXo5kuIWj8TRnEvMY9Z
         qgKg==
X-Gm-Message-State: AJcUukcDJOg1jNj/Xw49GmqvxAkHUUoXggoZ24ojcOYtBA83a7YvsoIH
        PQU/36xIWyOLC1XgipZTZejqAg==
X-Google-Smtp-Source: ALg8bN4hP9cUm8TfDSALBx3GgvgF7ZFeOYtqq7C86ZxIP4jA64gAuD4khKmkql26XdrLqVWmVWmNRA==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr2654672wmt.4.1548146870859;
        Tue, 22 Jan 2019 00:47:50 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f191sm9370369wmg.12.2019.01.22.00.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:47:50 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com> <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
Date:   Tue, 22 Jan 2019 09:47:48 +0100
Message-ID: <86imyh13kb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 21 Jan 2019 at 18:44, Sean Wang wrote:

> On Mon, Jan 21, 2019 at 9:29 AM Loys Ollivier <lollivier@baylibre.com> 
> wrote:
>>
>>
>> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
>>
>> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
>> >> Add binding for Mediatek-based GNSS receivers.
>> >>
>> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> >> ---
>> >>
>> >> v2:
>> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> >> Moved current-speed as an optional propertie.
>> >> Removed the status line in the example.
>> >> Added "mediatek,mt3339" compatible.
>> >>
>> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
>> >>  ++++++++++++++++++++++
>> >>  1 file changed, 39 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> >>
>> >
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> Thanks Rob,
>> If there are no objections by others, I'll stop sending these two patch
>> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
>> on those two.
>>
>
> Hi Loys,
>
> Thanks for adding the first GPS device driver. It's really nice to see
> more device drivers added to upstream support.
>
Hi Sean,

Glad to know you're supporting this initiative.

> Do you mind send the series again with Cc linux-mediatek@lists.infradead.org 
> ?
>
The series already has linux-mediatek@lists.infradead.org in Cc. Does it
need a resend ?

> Sean
>
>> --
>> -L
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek


-- 
-L
