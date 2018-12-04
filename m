Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC1C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB002082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HU70lnAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB002082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeLDPAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:00:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37015 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeLDPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:00:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so9619911wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FBLaADd8sswfEpin3P/Oq4cisopQsoVq5TfE3mJptgI=;
        b=HU70lnADugz4Kg/Z5h/C16ianYDHjOv6oG55ivmjxZd+k74qQkxxVos37qCJEgYZ8o
         5qzOmBvioE8pMV1z7171XnKbkCzsqIsfGNEbyq3NBI7LaLU4X5lv9VHEXPU246eGZ+gE
         g29BYtvhUhrq0hMBp4uaQ7kSidT+WhFwcmzG2sFwvF+2isw2uzDAADfad5xC0P4NesJ8
         EPJ+KHT5fM5AblBU3VN7ouxfBqEW/OYKMFS0LNtRbF4EeAJb2YzhvVxqX1yGmej7Zy+f
         Mt8L9w7SNz3ocL8frXL/PsitQ+XUfSQGue+mBp7OFh3uEVHdzeBWyW+brDodzrnfHF81
         zP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FBLaADd8sswfEpin3P/Oq4cisopQsoVq5TfE3mJptgI=;
        b=DvhE0El9q2EQ0HvTUTCOz7rjhwsGiXmtIt6n6WxoR/08TGgcPMe0E5JNLnaiSSesMf
         6pNq0X4JkiPXRJzv24wXb3zfrBNn0EieobPHng8QQtuQuIOsn40/o3DAyaeR2wgsRRfO
         5bjBfq/VP5Nsq0A6Xm5Av1C8b8JCESoZM0RIMn/G7+xAXeaNGdy8uQHs0uEOZWaHRSuK
         698rsRAFiClYeiC+94Xh07cjtbEb3Nfyv2FlYjczHXW3ZSUawHP/f/bvlxVg93ZnQgGh
         X1OoOS0lWGzGbT/1VcSacoJMeKB3sK6TvS79yWNijwq9poTQhghSlEJd+eiZXTJ8mx5X
         6ypQ==
X-Gm-Message-State: AA+aEWbC3Wm6j7E7akptD9ujA/LSEdxlRKJRcNV6aaDCiJyi1tZecshs
        ionJK6KN9gR0uiBV4HTGhq9+sJCtCoHOBw==
X-Google-Smtp-Source: AFSGD/VNr542c3cIjBtxQYiqT6fdD+9tHilEe7kPUaw8xwWAmdyI6wMjHBRLTpDd8c3mD9nrPDBALw==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr12193068wmc.113.1543935645511;
        Tue, 04 Dec 2018 07:00:45 -0800 (PST)
Received: from broadband.bt.com ([2a00:23c4:f7a1:ce00:1581:6f5a:196:51f2])
        by smtp.gmail.com with ESMTPSA id b131sm13216791wma.21.2018.12.04.07.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:00:44 -0800 (PST)
Message-ID: <eaf25e588c5ab78c607e7168e22871464e7ec8d7.camel@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself from the list
From:   Carlo Caione <ccaione@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 04 Dec 2018 15:00:43 +0000
In-Reply-To: <928e27de-cb7b-cf40-b8b6-2aa43a69ee39@baylibre.com>
References: <20181201151749.10932-1-ccaione@baylibre.com>
         <928e27de-cb7b-cf40-b8b6-2aa43a69ee39@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 11:21 +0100, Neil Armstrong wrote:
> On 01/12/2018 16:17, Carlo Caione wrote:
> > Kevin is basically doing all the work. Remove my name as co-
> > maintainer.
> 
> Sure, but couldn't we move you as reviewer and add Martin as reviewer
> aswell since he is dedicated to the Meson8X support ?
> 
> Or maybe add a separate entry with Kevin as maintainer and Martin as
> reviewer for Meson8X ?

This. At this point I don't think I will be going to work on the
Meson8X for a while and Martin proved to be the right guy for this job.

So, let's remove my name from here first and then Martin can add a new
entry for Meson8X.

Cheers,

--
Carlo Caione

