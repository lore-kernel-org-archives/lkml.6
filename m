Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B402084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GXFRACbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfAVItQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:49:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54084 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfAVItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:49:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so13243082wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=jsZVf9y2K5LHFnrE1GBsBerxCpBqq1IDtHSFbWLJLe0=;
        b=GXFRACbUCd5av9832M3y7+x0jssy3Rl6gykAD6/iyFlZsbDYt3/B3O+mwJ/9wHpGwq
         lr1XC6eYO8DrLF2sTNRAEHT+gM3ddDixAOkZM922l9bBAQVqyhtuHJX9QBrr4wLIS305
         emSys4QcKtjnie+SndHAWHue/n6RHJ3qgqUJuzOlzyW735dB2dSn8QUMqOF4CVohSMnM
         EA0tW5eGmt2KtS1E+1g3cizqQDPaD8mMJpnqE00gmuW1kbKyfHNiPCJRoiYKDkdVNfMY
         ps+12Q0IgULqBWATSicnA9Sr6n2WP3H9A2X3bk+gyvC2ZzibRVyySVv84az4ytM+yZ0l
         vX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=jsZVf9y2K5LHFnrE1GBsBerxCpBqq1IDtHSFbWLJLe0=;
        b=JvF4R4lax+9kE24hpwSao/7Q6rms65wkFE48hMxmc0nKkQtevHyutfSNl4LP+bERPs
         cpv9fp+yEHf3GTrptuBPNevufNDDvlU2mp44xK+o4UstZ5Xqn5E3jSlVShjWJiQV5TRT
         bPv7SnfXtZF1hCSGlKMJnasZk2Up9FXbPWI91Dg5Ece26Op1nUV7fQZECJYQnR5h3xBp
         ATDahmNS9QHGXTb6Lh3WvhMijO6MG4OfzH0Emoo/5ZCTQkEi2ZjvJp7KAl3GBoyPS6NR
         28tEXLJcN8pG6fwu7XVKmvZSNdvo3+6blWKyscbSeJWXDtwSUmSyaVV5I1gyFRINy84s
         mTGg==
X-Gm-Message-State: AJcUukcRTdbdevR3NwyuXVlLArMxxgu4o1Q9hMxEQkfHtYikksYLyITB
        0hqwcarM5MR170hQyHZyWoZu8Q==
X-Google-Smtp-Source: ALg8bN5PUGA1BWoPvnuNjH3HWDpP7aN0lqtUu1dsis3w0jNzwjnlhrgSXW1VdWZPoO5ZQjSgX4dXJw==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr2744114wmh.18.1548146953452;
        Tue, 22 Jan 2019 00:49:13 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n11sm33115268wrw.60.2019.01.22.00.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:49:12 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com> <CAL_JsqKVgWnLXGWxydj5HKiKeZ5Vf7HAgyr8+PkvrviUAwNW8w@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list\:ARM\/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <CAL_JsqKVgWnLXGWxydj5HKiKeZ5Vf7HAgyr8+PkvrviUAwNW8w@mail.gmail.com>
Date:   Tue, 22 Jan 2019 09:49:11 +0100
Message-ID: <86h8e113i0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 21 Jan 2019 at 21:51, Rob Herring wrote:

> On Mon, Jan 21, 2019 at 11:29 AM Loys Ollivier <lollivier@baylibre.com> 
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
>
> Generally, you should just resend the whole series unless the
> maintainer has applied some of the patches. I could apply this but
> usually the whole series goes in together.
>
> Rob

OK understood, I'll resend the whole series if needed then.

Loys

-- 
-L
