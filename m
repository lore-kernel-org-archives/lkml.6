Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AABC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA44D2190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZqQlUiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfBLSmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:42:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40881 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbfBLSmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:42:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so2814803lfk.7;
        Tue, 12 Feb 2019 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5uqO8MDZBV35mxd59/a4QMk3BPjUAXIGRvXre3djf0=;
        b=DZqQlUiXQgDQA76jTarzgyM9S92uisA9vqM5ykHc+2996/VK9C3vck84VjxzE4omyI
         eele1rqvzCBLtYxYLs+FE9aA3ucqL4VpkcBvX6vw7s7R5EWdijM3D6tnTWHYM9Tg46+/
         yndBkonuR6LpoUhKXK7hcYt7kieLbd3wQAUKzHmOk/KBp9ukq2ZPhBu72WDRsPPYZIZO
         DQxzQDXbKIl4tan9Jp94Wqnl5P8qVtyKq+JmqfDUy1FQg7qezyaGfwMs1d3oPDCvOBLo
         GWF6H4iU7R40lRhd7E7ii5p792EONKOzAS6iZa6Rh9tWcTMf9GQqAflQD3MlYrSvhSBI
         xvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5uqO8MDZBV35mxd59/a4QMk3BPjUAXIGRvXre3djf0=;
        b=EEzbV0pgXJ6DXmW578QC1irzNnpg8Ywxlh8alP9t679B/17Pm5WcrlHRofQiFKCyIH
         yZLm9qbHOSsliDtIhQ/F2NmFcR73Q8OKGCJlipte+AYnYykFFFGGXkBAorb6Nybu18ZK
         KDh3j4IIHrp5pR8kcH6sdrCZrzF+vq2XkWRe0qOHYDE6qW2gAZylEfAfUAYvwu4mYdZN
         Wiup4UdeQNAbTKuoYBjyhXe8TxF9AQZ+VzcMG/g5dsPd/rB36myDOahn3uLvh/dEudsT
         Qm/GWYNcY1ThGzWsRsnzsyU6ng4QVcxPmhkTYE/904tWcVR6904Sf6VrUAXEh9hKTVN8
         IMJQ==
X-Gm-Message-State: AHQUAuaitlHVl27sslJ2yR4EBfFBkm58QGWnQn8HWSLAgnmNXib52oLr
        U9YOZd8GKCTsuzPkb2SFhTja2tgi
X-Google-Smtp-Source: AHgI3IaCd8YhILb57beP4dhpACsOoGeV2txKysq6peGotz2YkYfXmNUHsJpTnSsoA3sCifWfMVEomw==
X-Received: by 2002:ac2:415a:: with SMTP id c26mr3547883lfi.62.1549996941321;
        Tue, 12 Feb 2019 10:42:21 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t23sm3144905lfl.59.2019.02.12.10.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 10:42:20 -0800 (PST)
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549996081-6858-1-git-send-email-skomatineni@nvidia.com>
 <BYAPR12MB3398679040C6ED2E129CEBFBC2650@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7143cefd-8c8f-e010-90db-5ac46aa96105@gmail.com>
Date:   Tue, 12 Feb 2019 21:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398679040C6ED2E129CEBFBC2650@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.02.2019 21:32, Sowjanya Komatineni пишет:
> Please ignore all Patch V19 series. Will resend.
> 
> Dmitry/Thierry
> I am using below stable tags in commit message based on V18 feedback to get patch applied to old kernels
> Git send email considers whole text after Cc as email address and reports badly formatted address.
> 
> Is there any format that I should follow to specify kernel versions along with stable tag?
> 
> Cc: stable@vger.kernel.org # 4.4+
> Cc: stable@vger.kernel.org # 4.20+

You could ask send-email to not auto-include CC's from the commit message: 

git send-email --suppress-cc=all

Also see https://git-scm.com/docs/git-send-email#git-send-email---suppress-ccltcategorygt for more options.
