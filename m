Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E2FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B20B20857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N5AxRYNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B20B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGRPXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:23:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37320 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbeGRPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:23:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so2151594plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbNduuDbHJs01tCvbE4Q8zclKRgVyTkXcGVUqDQ8PBY=;
        b=N5AxRYNq8vbeQC8w2P98Ji82qXPeat2PMGiqbF8p0o+VDGuGLDGRknie9rRmY1rgI3
         Ut76IAr9Lid1p3BHyMUub4wwuwBOl4crrgtJCDSn9WwFx5lBWQ/1i2mOMebeSysiUepl
         BITKfhsY45wHGE2ehlpVmZ9u4y30VNCw2Oy0206my6SHFKTXDtOvauVpW6/+pw7JpOvm
         /DOy7kxTo6yE4Za5w4Pj6PqlYpZmCgNNpGlSgmL60dHxMAS6YMTICnpwCJ18v6lzSjnx
         EE1kDhPzDNI1m07eIirMhHC7h0hUJzqxHWrkWZHFDHMHDDreatuelUt+0KiGIIkZ8k//
         6q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbNduuDbHJs01tCvbE4Q8zclKRgVyTkXcGVUqDQ8PBY=;
        b=cRw5S9N1xs19xF9MGNgGvBYMRTFReJjiuXSkJT1E/YTcXeMyvjbyMEJMtS5rHGIIzQ
         hIG10AXjMFM5wUEVAM1up2NFK+hxq5d2NXedN9UwZj62CTKbDfPkFoaxh9llOzpmx+kE
         e1fqdHWWGU+/G5fBNX0qZsAh5QMC1iWq/CGXpV2A8Wi0g67HTdy0gk1k6mr1EyfqGtJ8
         4Id1yBR6xnf8karptzRO5Od+0LIK232NXU8j63ZxboNsMSGG0j/dCGJOW7Ug9UXNvG6J
         /LyakmxZkyULlGgdZAm/MsJYPq8T7OSiL+sh4OrkySgtX+N8kVfkked6XlnzgaXnr0Ii
         tmlg==
X-Gm-Message-State: AOUpUlHmWY+szhorh02ekWSZWzxEAagtcjJOviBdxGG5chAjD+TCYWqp
        uXWU9nV1WvaKk/p4UiqUYTZBzw==
X-Google-Smtp-Source: AAOMgpe0vwBHFDAmroC9q+UTk7sR76a0exxjPkjPR//Se0SJs+89eVQyUdNUC8o7zIzB1/JZjPk8nQ==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr6365880plt.288.1531925127106;
        Wed, 18 Jul 2018 07:45:27 -0700 (PDT)
Received: from [192.168.1.56] (206-212-239-179.static.onlinenw.com. [206.212.239.179])
        by smtp.gmail.com with ESMTPSA id r71-v6sm11672106pfg.43.2018.07.18.07.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 07:45:25 -0700 (PDT)
Subject: Re: [PATCHSET v3] block: Separating discards from writes in Linux IO
 statistics
To:     Tejun Heo <tj@kernel.org>
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org
References: <20180718114741.2580313-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <263aa14f-b465-0e57-90ee-04574d1d595c@kernel.dk>
Date:   Wed, 18 Jul 2018 08:45:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180718114741.2580313-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/18 5:47 AM, Tejun Heo wrote:
> Hello,
> 
> Changes from v2: Refreshed on top of for-4.19/block.

Applied for 4.19, thanks Tejun.

-- 
Jens Axboe

