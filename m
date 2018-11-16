Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A266B2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI6TQ4eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbeKQANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:13:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35302 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeKQANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:13:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so15008609edx.2;
        Fri, 16 Nov 2018 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uojQ3jmQnDLdqiPS4J2fwHR55hMRqMzFUE/S+ZhIoms=;
        b=CI6TQ4eNxEx/6m8yKVN1Wd1CdBVk7x0kUxADdV8VsIX89MqBpOvTVIQIRtCGr6MnrV
         fu4NKVs80pG+I5yvEjaVkpJuToFpeDSjtuWQlCHKDCpit/U1INWHzAbK1ICA03Rwdw9x
         xx46iZZnTxm+7cijUfxYJXD9k+Ux5Vj9OM0ocmomZg1UmaOMApFZrpcAk/1R2l1uDgrm
         TjNZl16p92YAsuhi88A/QNv3MZzX2ntxwbhNvxPxqFRegtZ0B4WYOTbvZY7UliopeSmg
         OAh4a6PwOP74tePZFbARNfdu3rEb7ZJBxDcKcGm+vKLMqVaFeUel5GUARNlJxh41fC+W
         ZbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uojQ3jmQnDLdqiPS4J2fwHR55hMRqMzFUE/S+ZhIoms=;
        b=G8OlRrTowIUkyYxlULp8I8LC+d7SDEXbdeHNnFRYG4HgABKaczC06Hbf2ZidJgUuCQ
         kCzQLyr1aIJauw8VofKUZodP1e8xn8F9y+Olni6jpL9H23F0FASP+J3TfbF8TLW2SoQa
         /+H3L/nvDhdowFIV13JJy+Aka+dxLwlLw88IjCa6JYc0xeFdbdNFlrNanlcInZ0VTqxX
         Vnws0mpWd1rybbodgq6mHAQfFZrXd+uKcmhdEPKqjtG54cGd/hfDCBVObFwB+4GTtYlp
         BOPmQnjOZ8VMmb993HnujHYxn4hon8Cq+9cCUiooOC++2yKid5gwKLQ1jSluxJocFe4e
         S3dA==
X-Gm-Message-State: AGRZ1gKLtd2tEW8TvK8+g7gs7UqXN4etonLdbicwqFzRfol5SOJ+Tixq
        jCjUm5h/Ts3ubbDbmQlmOzE=
X-Google-Smtp-Source: AJdET5cVXvU5E0DbbAR6lkhMXFJ09pYKAcumolEaNTYGp2SbBJQEfkkjpsGQHA7JAjjrr2aK5tjh4g==
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr9981899edg.121.1542376843485;
        Fri, 16 Nov 2018 06:00:43 -0800 (PST)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id k31sm6753883ede.5.2018.11.16.06.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 06:00:42 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gNefk-0003vf-N4; Fri, 16 Nov 2018 15:00:36 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: add libretech aml-s805x-ac board
References: <20181116093938.26373-1-jbrunet@baylibre.com>
        <20181116093938.26373-3-jbrunet@baylibre.com>
Date:   Fri, 16 Nov 2018 15:00:36 +0100
In-Reply-To: <20181116093938.26373-3-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 16 Nov 2018 10:39:38 +0100")
Message-ID: <8736s1t94r.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jerome" == Jerome Brunet <jbrunet@baylibre.com> writes:

 > From: Neil Armstrong <narmstrong@baylibre.com>
 > Add Libretech aml-s805x-ac board (aka 'La Frite') support

 > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
 > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

 > +	vcck: regulator-vcck {
 > +		compatible = "regulator-fixed";
 > +		regulator-name = "VCCK";
 > +		regulator-min-microvolt = <3300000>;
 > +		regulator-max-microvolt = <3300000>;
 > +		vin-supply = <&dc_5v>;
 > +
 > +		/*
 > +		 * This is controlled by GPIOAO_9 we reserve this but
 > +		 * claiming it as done bellow reset the board anyway

The 'bellow' typo is still here?

-- 
Bye, Peter Korsgaard
