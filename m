Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7FAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CB82245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieqsZLfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CB82245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeKMOIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:08:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35567 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:08:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so5343410plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 20:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jk9ChPBtGkAIdSXqaOUioa55dzVhJHhKEMRrot7K27g=;
        b=ieqsZLfIEWS1G6A1EHAjtXM1w4/zi43VxqoMjM5WDi0VxnURHm3IN8MPC/lvtWvuHY
         whwS96g86LDctg5Zh/bMY0u0jelwEgCAK/r/ssSTHU6HRrzXgWJbN3jsZxXJnmWTTmic
         9aMQ43mKhbb3lxVLArn4E4lFwwY7ZgbCUhE1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jk9ChPBtGkAIdSXqaOUioa55dzVhJHhKEMRrot7K27g=;
        b=jpyB8i90KVzQlVxUfy7ln4KKrKGvrFlEwRVuG6ymfVgD2iLPGWd8u+SMnN82yMRPDP
         5Vp//H1Nqe0jYG+syPmM5TwzJ4rTVlfUlz9Uh+xvSoWeS9BB9r2l8qyfO70sf5ncShEN
         UHqP4rtI98An7bGDYf0K22VbowcupK03aAXFJLlWa+9aIwppNGgD58mWcrnMdNhNiqy8
         nmEg/GvHFSxV3j5/9AEzzeH+j9JDShef6YSn1IwZhY0qAu5GRyqeWCl2VyLSiVdqdE+f
         tEMjM6XiZRhCm9Npz0I6iDpMMxFQ+cazcWmLXbIlCR7jhbuAP8wLoF3d4/avweYsVRcg
         aKhQ==
X-Gm-Message-State: AGRZ1gKoQOkAJ54frZk4RodJtB9u2C8i8cfwWXXjd/Y7513If/64RDT0
        HUsL5en5VEaSFFfB0Kzw/FseZQ==
X-Google-Smtp-Source: AJdET5fVy4dW8i3zbK/dVzdTEm090YfBog1lr2F343oAbzma4YBD9c0SNK3HhKGG660nDCRYsA3tfg==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20-v6mr3509414plp.115.1542082325451;
        Mon, 12 Nov 2018 20:12:05 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id t4-v6sm19033131pfh.21.2018.11.12.20.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:12:04 -0800 (PST)
Date:   Tue, 13 Nov 2018 09:42:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        d-gerlach@ti.com, t-kristo@ti.com
Subject: Re: [PATCH 0/2] opp: ti-opp-supply: Fixes
Message-ID: <20181113041201.vvkkzjlhjktrnvvi@vireshk-i7>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-18, 10:04, Keerthy wrote:
> The series brings in couple of fixes to the ti-opp-supply driver.
> One of them updates u_volt_min dynamically and avoids hang due
> to lesser static u_volt_min and the other fixes the supply in
> _get_optimal_vdd_voltage.

Applied both patches after manually adding below:

Cc: 4.16+ <stable@vger.kernel.org> # v4.16+

Thanks.

-- 
viresh
