Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C583C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3651206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="gQzTn882"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3651206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeLBEaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:30:24 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:34353 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeLBEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:30:24 -0500
Received: by mail-pl1-f177.google.com with SMTP id w4so4362650plz.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhhCzzqfgFryJo3T3cBYcS3tdz27sZPbeH0hJSDfLGs=;
        b=gQzTn882KGZLjqtEuDrYRyO03YqYd2lKdXtHa4GgKKuXn/W3/KpEbxX7Ta3mmiFnjf
         vjF51y/JoiEEheFVOLAp4TC/0KK8THeUeCFB7sfp/D9YumhwA4KsMF8rWnZS6Ap6cY9Z
         rxNbO6WmjSsdW5RWaL+FQKNtB0HVUAUCkmodj7xqi/WUfbXiZo/ED8U32E70TU2tr5BS
         Hxnlzi/KM4DLpLKu5ZBkU2wWFAs3+AmChUj6FyAfpr2nDRS9vcKMC+AK21aobxOUI9vF
         FHUsLq/iSMSgA+QzAI35Cs8GN2BovmAkZ+sKSXYmfdhrPSQ8TwvNm+xszp4OXMlfbKrE
         0VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhhCzzqfgFryJo3T3cBYcS3tdz27sZPbeH0hJSDfLGs=;
        b=qS8+rSpigARfsocbcJ4Tls50NA8M8uz0d3DWu6NlnKa1v0JCyXuBwRBW5sfKPNkuYV
         TujhFQcGsM0AfXcdXbG9cQjCa0u59DrEXjW7DJ7IYnxNwqTpzJ9s9mh7yBr4P37uqvPc
         br5THF73EIM4c/JtVy5/5yBA9zUgCldL1imM7sBOMGcoY6p2AMAQkdMTy0V5mBGiXvgi
         q4j49dUZmpUKdhqilMgyd6eb+Yny9OcXojYKi/b94w4uEEpwevf91tzyjtFm/ocQ3/9Q
         pWQOc4Ap+OiP/MYIjxSRhuZN5Z4Zha/DH/kMbgvNHautQBXLjUXXmPlpbb1wk1OEpbBN
         ykpw==
X-Gm-Message-State: AA+aEWZSnuTFTO6FmKIHN8iVJanwjR2h61hvDIj10Hu2J/U5GgYx5Gvs
        WTkzDnz6I5mxBKTQ6QVIuBIEig==
X-Google-Smtp-Source: AFSGD/XlsHD4wXfK0SQhL+yWQxzNs2CRAksrOxrGrqWywlCDU9JD1uTyNIp1py1ot+RjwnV0SoNIIg==
X-Received: by 2002:a17:902:365:: with SMTP id 92mr9421091pld.327.1543684645379;
        Sat, 01 Dec 2018 09:17:25 -0800 (PST)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id q25sm10611592pgb.2.2018.12.01.09.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 09:17:25 -0800 (PST)
Date:   Sat, 1 Dec 2018 09:17:22 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Qian Cai <cai@gmx.us>
Cc:     davem@davemloft.net, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core: tidy up an error message
Message-ID: <20181201091722.6c9a8f06@xeon-e3>
In-Reply-To: <20181201045153.4035-1-cai@gmx.us>
References: <20181201045153.4035-1-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 23:51:53 -0500
Qian Cai <cai@gmx.us> wrote:

> +			    weight,
> +			    !strchr(dev->name, '%') ? dev->name : "unknown"

Agree with Joe, use netdev_err_once or use netdev_name().
