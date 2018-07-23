Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E86ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5AF20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0jh5qjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5AF20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbeGWKJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:09:52 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36174 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbeGWKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:09:52 -0400
Received: by mail-lj1-f174.google.com with SMTP id u7-v6so16231708lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0O90KS3vLqzehirXWrYp7JOhJCwRR1NS7cEEis7eU2E=;
        b=s0jh5qjfAAE1+VUCPyf6pTcGORrslodD4upZgewPIxCswJo2RMJJLxNQrDolJIwn6m
         mtp4IxTBm5WXjOeb9W4RidGbGZ28A+LJcV7Bq/pIHfwxd0UW0KxISBMc3m7+obVnZRt2
         NYUFOUTmMejyMWr1J1e/Q6jLxmcn/+2XkqoVtAAFjvVLOFe4szShDo7Vnb5lykUsomh2
         H24lJ3hWCcYIvNHf0sjpPxiTS5a23lr+l+pjJEiSba8AvsbavU5bvqeaR7+gfLU3/TfA
         6bCddwJ7jr745TrvHT/YZ0J/qjFCtQSH1IjcjPMqQ/9MRRNLNvgl88X+Zs8zJwGrl8Wn
         kw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0O90KS3vLqzehirXWrYp7JOhJCwRR1NS7cEEis7eU2E=;
        b=R/F6wKiMZ+T7x7cPmI72stD4S6Sn6mZTPs47L9/q4rYIbI5jMj44l9JxK2PaPEJEpd
         /rLDT1ho298vBpoPihprr5INoYG3KBy5CKEx9UhZJ/YD5HqD16gIKoWTljgoi/GVaa3M
         hvxKlpHfW2SN8b52f2snLCxIkAnVDIy54Dowrujd7KG01x5ngGLGNtEsdR2JMIYbcDOR
         Kpc9M478int/3fN/OFgm4XWhKhYUXJ5xr5N4h5TVMS8waspSNkEcDVNWYqR48EOindGQ
         LSEOPmUt+dXwSWOVA0qrDz6G/mL/BgTRXElufqr6Sf/bMVGquHbQ3fEFeRoPftBJl8Ke
         KIJA==
X-Gm-Message-State: AOUpUlEloRLpSNXjV0aLqch5x03RtVHz4Ojy2wny8QHH2y1IQrZpzfNI
        i/9G7Sy0sZFRy8hez6zVskM=
X-Google-Smtp-Source: AAOMgpf4pnZ42bn0VcyoKFatG2LCDzXg0zTSNwpScEMQZn2/6yAzy2GDbDiP3XNbidJJIl3cEqf7ng==
X-Received: by 2002:a2e:5810:: with SMTP id m16-v6mr8781617ljb.134.1532336978617;
        Mon, 23 Jul 2018 02:09:38 -0700 (PDT)
Received: from [10.17.182.9] (ll-53.209.223.85.sovam.net.ua. [85.223.209.53])
        by smtp.gmail.com with ESMTPSA id o203-v6sm1317195lff.28.2018.07.23.02.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 02:09:37 -0700 (PDT)
Subject: Re: [PATCH v3] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180719093713.3643-1-andr2000@gmail.com>
 <20180719102416.7gnzuo4vmax44qv2@mwanda>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5d26570f-3b29-830c-9b42-97ff44bb774d@gmail.com>
Date:   Mon, 23 Jul 2018 12:09:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719102416.7gnzuo4vmax44qv2@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 01:24 PM, Dan Carpenter wrote:
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> regards,
> dan carpenter
>
Applied to drm-misc-next
