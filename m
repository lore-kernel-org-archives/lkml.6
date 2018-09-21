Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB777C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817F02156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR3ta/GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817F02156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391501AbeIVDl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:41:59 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:54428 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVDl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:41:59 -0400
Received: by mail-it1-f175.google.com with SMTP id f14-v6so3776524ita.4;
        Fri, 21 Sep 2018 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fftBqt+y52v6mLNCt3UqLaPF4zvxbFL0Tac8GYZ+F8=;
        b=cR3ta/GFXUVRe0i9E3gLIY2krfYm7kZxRMbXj/hoTlXaxW4+4E/KoAIf1fk9tGoRek
         0TbACQqpZGNTFhSvT3keFvFpreO0jhj/ffEVSkjanK4KIyDw7QsrfAT+kGpfTio584Sc
         eqLUPImK+mf4KAyJcA1CEdP7XC8t5mcA88NIjMPLK7n36gRNatG2aigv+r1FL2zpDq8u
         e1xN66knJCOP2JdWDvS8+EA38ZkVUNzIoOGHtIVlgZO19Uhqlveyu6Z6re+5B/dC0vv/
         iX6xYH0BINnVZVsVIAitqXLzc/i0ulFnROtGOnxhESyEVY8qHx9yu2xAfNzyLQog8VSz
         7aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fftBqt+y52v6mLNCt3UqLaPF4zvxbFL0Tac8GYZ+F8=;
        b=mBdk3JxrnN5Gp4qqCuEgvaliOEVGozre4WvcydqVJr7pGWhrW1iL4J1c3ZT4w9byE8
         oElmb92xxSUvJfkLo88OZSGHtUPQ+aqZlx4GEurt8fgOZ2MA2lsGha8uSdErCaGSvhQ+
         4wWD4jZKKtY9D8rxwyNP3LlF2jWDVQ8z26hCXXVPCLjQb2TegFx7eNy4zunTiMOcZo7w
         MXkvw3viZFFDfOz3dOAPPPUBIq74xZLhYrs+GywCZ0WAVTlvLoibrpHIC2XRMwa4p1x8
         lFzTj8Vn2lz6+w+67yEsBjbvCXLNXOO6aTWvNF76trwQ7FuO1l/ljAwa8HwmU6w3A/lW
         /7CA==
X-Gm-Message-State: APzg51Bybb+TWaRqjx/ThV0WFcHZy8LBJxtjX+h+NLyiE1gNtDDvfHWd
        lndpIBVSqsWZgo8R3lEpgSv79/nsgsw382nX0EA=
X-Google-Smtp-Source: ANB0Vdbodv+e0y6z2zW5tm4E13/G4uqhiB/30/xUYTa8M1axb8urBfdfDoQ6bZ3vbw6gTrD2EISkEToVCIOAEDSpFgc=
X-Received: by 2002:a02:41d8:: with SMTP id n85-v6mr42578511jad.108.1537566672828;
 Fri, 21 Sep 2018 14:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180921201252.12875-1-nicoleotsuka@gmail.com> <20180921201252.12875-2-nicoleotsuka@gmail.com>
In-Reply-To: <20180921201252.12875-2-nicoleotsuka@gmail.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Fri, 21 Sep 2018 14:51:01 -0700
Message-ID: <CAGoOwPTEEdzND3gCUP81weTUh3wkUeaLTqgmFANHknnyEaEijQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found two mistakes at this doc, sending v3.

On Fri, Sep 21, 2018 at 1:12 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -0,0 +1,38 @@
> +ina3221 properties
> +

Should be a description of the doc.

> +  VDD_GPU {
> +          shunt-resistor = <5>;

Should be <5000>.
