Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23FC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bPItQ11I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfAUR3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:29:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfAUR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:29:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so24299623wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fevEhq1ZsnQYiONWisKFgrF2FMIWgLVBZ7cBkGFWRzs=;
        b=bPItQ11IUHbzpz1QxTtVdytwKZ6VWQGLR1BKJlsmQpd1iF+RkD/0fAmDud7Z+VsRXL
         aZAqRuQ4llXIAUAuPCmlNCSReP/t8k8OglRq6+mEllr31JCvZdicbWT8v0m8Nn8vprUy
         /HeEXzeWBau0iG+u+RJQT/0cVF64sxlEKbbQkdkYBoPQ1XdsYXdnb2tBDHVQS75Up+Zl
         G8FT1zIcbXuJFjG2sSvtz03LmBo/08f0a07mjrAtair27m4IDrKZmAAUG7hdBd12Yfqx
         EE20FgB5kE3xCovE5j2+t5Eom3iiW+3vvQe+4AzmP/Xfhft1H5NJlCKZV1v6j2BjibUd
         D0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fevEhq1ZsnQYiONWisKFgrF2FMIWgLVBZ7cBkGFWRzs=;
        b=jfBAyWxl9C71m2vwWc5S5+bKdl2fS23lBO3T+pN25zFIbepEF+O2u+w00U9WO8Xxpw
         9gAdkNFUEH7HUUQBdzD6rgiYVjatP0yV+UlzXOugO5AvkZsADEQHi04FqP6DkVfx4F9O
         /aPO/oXvPtOwfql/v5OsnsDS0d0Yz8XYVBGhl3/6ehnMBwJf3setj5iRjnLyEAvnSk7/
         rmEE05QKYF8gOao39s1jKZqNVuOLK2ubG2NJnKsiP2HTiu4H6txvTapemvkeaGsMqGDN
         bK4Mdor/b4CfDFLmA0HfGmJ/S5UODY430qx7yGjc521bJIAPsIh3VY6TKMkhJGRKbbTt
         5myA==
X-Gm-Message-State: AJcUukesOh2Z3cRhHn0/osdiKWC9jv7n6npAzMbErQ/iLLZdlwkx/8o4
        Cpx170yuYXxCtOhrGhQdFHJLIg==
X-Google-Smtp-Source: ALg8bN7tpv/auSIsJ0/uj08hI1z/+4n+sDSx17gm5FI5xX5pj1+MbZykBPpq3Rv5o3PcpmbODvDkWQ==
X-Received: by 2002:adf:9168:: with SMTP id j95mr28466115wrj.217.1548091772762;
        Mon, 21 Jan 2019 09:29:32 -0800 (PST)
Received: from localhost (amontpellier-658-1-219-17.w109-210.abo.wanadoo.fr. [109.210.118.17])
        by smtp.gmail.com with ESMTPSA id s5sm32686088wmh.37.2019.01.21.09.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 09:29:32 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com> <1547744074-28308-3-git-send-email-lollivier@baylibre.com> <20190121171019.GA2903@bogus>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190121171019.GA2903@bogus>
Date:   Mon, 21 Jan 2019 18:27:14 +0100
Message-ID: <86imyhapl9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:

> On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
>> Add binding for Mediatek-based GNSS receivers.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> 
>> v2:
>> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> Moved current-speed as an optional propertie.
>> Removed the status line in the example.
>> Added "mediatek,mt3339" compatible.
>> 
>>  .../devicetree/bindings/gnss/mediatek.txt          | 39 
>>  ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> 
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob,
If there are no objections by others, I'll stop sending these two patch
(1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
on those two.

-- 
-L
