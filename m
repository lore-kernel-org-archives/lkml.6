Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4F720823
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwUVEXpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfBRUfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:35:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38088 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfBRUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:35:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id j19so14702836ljg.5;
        Mon, 18 Feb 2019 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9sqScGffgWjjkSk+WJqDgbhGPjV0C/5mo8FPgm40iQw=;
        b=EwUVEXpTt8+m3Ih9483AfBAyxy5wp0E7R8C87JFSptqSxL58w8xqL8rG8qkt0UvRUX
         V9f+deVh/fLzuyiKY5SRyAVovOS3y03SQXSA54zTnhoC6keGK0hyXO5GXSkQtGLzxNxu
         HuQXkSu+jRkqv+9gpE/Q83CJqAecn1HQDepahpvtZ29W+FQ6q/FP/uk/D7bZxS63YrIb
         k8A4fN34XTwilddubURJ3ZAzLIJ/a9zEW1eEDPN9ZdaMG4YLIIJubEM8EOQzhYWr6sEv
         wwSTJrQBC+5LehxKKOZXIhlx+w9fvEh5vXrUvJzs2TO5h1ojSmGunsxUdllS7bve0LID
         DTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sqScGffgWjjkSk+WJqDgbhGPjV0C/5mo8FPgm40iQw=;
        b=HiUgcknJhK8rm2ujAXKK9Gf+eYDiw0/1FXBK8PAk3RP0/Kvs0VWpX9l0xzsFovWX35
         FzUlGeELX3C6GzxUSr59NEyho3cuboMY+FlmOwb7B/+SR9LF+bkSgH/9sCoVar6eWW0g
         hrO+lP0uGeGCDVtDfdxidjh6FLJAMQUCO/AnRgDCoWo5yn+LZ9WpOReuLhZNcRuvMLVg
         iqafQbHc0Xkq1AooIlwySDKDyYlGuYfpxPELN4WIqqRoSt2ghkDrpktGL6pu+ecS6cuN
         6tcoRCpp00ojXabgKflQ0dyWwEFFe0Zhm3K24FgbBj6srLvKqYHHM0xjbaUkaCarY/Io
         Tt5g==
X-Gm-Message-State: AHQUAubDWUXjb8fMPg10IDhldkvlKyKLNHGaoSNCF7/wwzAoAsNO8vRM
        ac1aRIullufrGk5gi5pvFCpGixEuC/M=
X-Google-Smtp-Source: AHgI3IYfEbo9hTx/KDxpk65htkaVu69uSNoGKuqiMjIVklONpUQowcpHEbK+toZi30vfuwibBXrLXg==
X-Received: by 2002:a2e:7614:: with SMTP id r20-v6mr15071447ljc.175.1550522109246;
        Mon, 18 Feb 2019 12:35:09 -0800 (PST)
Received: from [192.168.255.6] (6-191-187-93.customer.senator-telecom.com. [93.187.191.6])
        by smtp.gmail.com with ESMTPSA id x16sm4369069lff.72.2019.02.18.12.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 12:35:08 -0800 (PST)
Subject: Re: [PATCH v3 2/2] dt-bindings: rtc: add ABEOZ9 support
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190217185321.2189-1-panfilov.artyom@gmail.com>
 <20190218154607.GA651@bogus>
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Message-ID: <03d1ac1f-581b-d9ee-9c24-ff246ebb30c7@gmail.com>
Date:   Mon, 18 Feb 2019 23:35:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218154607.GA651@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Acked-by:
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Thanks for the feedback. I missed that point.

Best Regard,
Artem
