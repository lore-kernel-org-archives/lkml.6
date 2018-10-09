Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A177C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C4F214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxpAdctR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C4F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJIQcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:32:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37829 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeJIQcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:32:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so668631lfa.4;
        Tue, 09 Oct 2018 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NndqybpdRCvqtSDKr/HQGhZXjLQeW/vj4ypt29NZte8=;
        b=lxpAdctRCLriYeX33zVJttO1aqF+XczolP1PNnSV8J9/bhQ/37GcZlAboj0uGUa0ft
         U2BfCZq9shHWHuAfOojVq0t3Jg4vlK78PiViBR5cxtmR3DzpamUDzc47bID+RdQbvpVo
         PPiI2mD8T754gbjWDqRSES2k7IcDDyzV7NqPOxyg4UCna4wNj0Is38pB5gCMELXllLNq
         0H+9TQbr7Kj8f0/H0qi5m+2m9/kAX2sGje8lInyJfHtaUYUaNGqkJ9RvUO3V1HIA3XGb
         UVFyQeFt/IqFz7Pqu2kELBpR8jTKyqZCadq7l7ZCLnoV49kmc5A3dlirgRUUlILgy7NN
         cSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NndqybpdRCvqtSDKr/HQGhZXjLQeW/vj4ypt29NZte8=;
        b=CzVoGMN5fqsY/aWb0N2udZEmKduFpLooPp+dafGRrPg6dUh8F2+9XanO/kaaG6e9DK
         IEyCZVmOdZF/qlliOXOH/U6QE9n2XwEJY0apNePjtxNFc1jE3UJgC9k+Y9dh/PcdE0s6
         A3jtMupWAGLegreqmfmWmNyNY3KfPP8vg9zg9c39KQTciCKZsvzShCU4swmZjDV7KpW+
         txdoLKs8Tpny4b8YIhuOf36fl9Iry1JPM1p0uimr+IT+tDysZuMTRHafSEtLaEmaKktZ
         lcpkxNEYv7Fpfg39eA3caucLD9htVKL3Yr3TLpQLQKh03O8WJOFN9zkUH7638iiSQcFZ
         voCA==
X-Gm-Message-State: ABuFfojMT7hM0woBJFe58B6BKf67iZvM26NGfPj7NROj1DAuCBdzIlma
        1MAm7S3niU5jky3g7jLpvVi5i0bH
X-Google-Smtp-Source: ACcGV62bF8cvMOFAmDZh4VwOnDyN9DGtF2aDK8bivRjuik0i5UVvMwIg+oJlhPKPRea7KcUKs7fe6w==
X-Received: by 2002:a19:3b0f:: with SMTP id i15-v6mr15412825lfa.56.1539076606477;
        Tue, 09 Oct 2018 02:16:46 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id w1-v6sm4045699lfe.93.2018.10.09.02.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 02:16:45 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] gpu: host1x: Continue CDMA execution starting with
 a next job
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180807130713.1016-1-digetx@gmail.com>
 <20180807130713.1016-4-digetx@gmail.com>
 <b508bf7e-e329-b903-e851-d679bac93027@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a1001994-f14f-2e19-01aa-9682bdda6d11@gmail.com>
Date:   Tue, 9 Oct 2018 12:16:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b508bf7e-e329-b903-e851-d679bac93027@kapsi.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 8:10 AM, Mikko Perttunen wrote:
> Reviewed-by: Mikko Perttnuen <mperttunen@nvidia.com>

Thank you :)

