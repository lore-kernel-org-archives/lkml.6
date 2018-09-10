Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B3DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B84420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+N88pXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B84420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeIJPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:45:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeIJPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:45:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so21354954wrr.4;
        Mon, 10 Sep 2018 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/y6mXA38hlqV+5JODJZZTmTxxRCDra5wLV6+lAjyQoU=;
        b=g+N88pXF/L9TdFYRzoUD5J+r4luyZndRlMf6JPKevIoyLbAjhTCj3F73fDUbOsZiCO
         wovHgg5mDCre7iiBNgTuqjZh1jfDQcvZGKE1N26V5QozZ2tbRJmVHIC6VDyC/VCw5a4m
         cfj7r+422fT4nzY6b+mB+2NIfxJVcL2lfjJ21weJVwBxkuudhC7jJXc94l7eVdw8PYhH
         wyVUfXYujXH7vWbLpCTu/ZgJHSdpvOUsF5pBtQ5Fvau9M5bKLuPRvksmxLqJkzrqW3Fw
         PWcEEiYXKpG/8X5VJ/zcjbzveKEdmnpLn6YdjMGrjQtTPyB79PudMrSRpKc+x1kF5PB7
         Tcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/y6mXA38hlqV+5JODJZZTmTxxRCDra5wLV6+lAjyQoU=;
        b=tqbOsaBSo5ExXtavwFGEBz+Jx298uFlN4BG2/G41iuxqJEAFLABBLYFigRYv5IG96a
         Yx08dJSk97DFwaTTYUYasPcr8dD7HQW3PFkJwlMvbpg9JR/EKxoyF9iVfX04Zj1B+MV9
         LBEedq+ttsMILUjhTIA9iz0JNyVqH6jEFPY6a3qETyWcM+ZclNpGsMGg8bjEfg1F8jv0
         P7/4DuEc/qJ6RdM0oYrUXIREqka+4Yg+Pmzb9v8xYfFot9EUWACzsXVMtz7um+BlTwip
         HIvptDAMom9joddQnGXh7Gs/8bq415V8EyuRmcLQ+mxrYLO4bzLRTFEeQJgYq7NgwD9Z
         HpDw==
X-Gm-Message-State: APzg51D1MpoPJ3J9S413EVMNbJ70O+/GNbnhKBNU/d4bcM7uedbBV179
        4akKyzuWF6wElgjvAd83rMxWEMNx0WAd5j07+14Qlw==
X-Google-Smtp-Source: ANB0VdY6oklLpobFhSOItK87I+evMmfuo3hazpmFY/piniQIPWcdm5qYSVkiZzIWKr2aJ987VuhHDiGmfzh3G+iCuSc=
X-Received: by 2002:adf:b2f3:: with SMTP id g106-v6mr14975666wrd.53.1536576723415;
 Mon, 10 Sep 2018 03:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180908131345.8145-1-kernel@nospam.obeliks.de> <20180908131345.8145-3-kernel@nospam.obeliks.de>
In-Reply-To: <20180908131345.8145-3-kernel@nospam.obeliks.de>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 10 Sep 2018 12:51:51 +0200
Message-ID: <CACna6ryWCwKZJm2rq0_KeaKve8Ym9zi6AU+Kat9cpYAqtzCMdg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: add bindings for mtd-concat devices
To:     kernel@nospam.obeliks.de
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2018 at 15:14, Bernhard Frauendienst
<kernel@nospam.obeliks.de> wrote:
>
> Document virtual mtd-concat device bindings.
>
> Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> ---
>  .../devicetree/bindings/mtd/mtd-concat.txt    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/mtd-concat.txt b/Documentation/devicetree/bindings/mtd/mtd-concat.txt
> new file mode 100644
> index 000000000000..2daf3157b163
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mtd-concat.txt
> @@ -0,0 +1,36 @@
> +Virtual MTD concat device

I think you forgot to include the documentation. Please ***describe***
that binding.
