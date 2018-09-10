Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A372086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zs9wV7cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A372086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeIJSRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:17:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39681 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbeIJSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:17:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so21478419wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Extuo57D7b6IxYnnjNidkebQ6ls1GuVyeNcyf/IAdus=;
        b=Zs9wV7cgJDSzMkcmSBiITf35KMC5KgiL23GIqG5QjWauEWlaGSlMabfgt9Zw6Mj0Nd
         9Hnslc0wtz8mhRImBxAKgJ29+qJeSuop9sfHk8IxmOKhSbYY6Hu2dmcKQY70AIJ+GhyT
         J0UltVeglRXoS7tnnKxyjLnjR/hFg6Zd8TMxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Extuo57D7b6IxYnnjNidkebQ6ls1GuVyeNcyf/IAdus=;
        b=ivZkKakCmZFGri66P8sflD8uEcyaPR09P5N550F66nYP6RL4CbnteSfBxN3lQ0ZDu3
         Y6QPcNlL+6LDE40f6Mjm/gXqIXVt+/ahR8Xk3l7FKDS9hLWXdF5lPyPBpaP0CCXiFUFi
         /XiA8jPCBA4TXLCMkJKmuOT/FUmoZcKxL+XI5xZbTo6eg9CfrsF0Xb76vC+5iG2Hl4zx
         nljCQfE7zZvAlqV7RTOF9+5UPtmwYvpxSmnt2CuqfuLgLqCwGn3n5NZCBEjD/HOOSFgD
         4ehnCze1d+Raz+oyjNmObuTbAyiM5rtlPmx/ltZGj7n1e78wNIr57EEQVsZouNYtdroH
         qQew==
X-Gm-Message-State: APzg51Dljrl1qOUgpTH7RP4GnCZN7J9oblfl3I5p1eJIBSRSpTDns48M
        2jZ9xtuCYGcfsQlrt6a5CK2QVg==
X-Google-Smtp-Source: ANB0VdZ4os43tFzCITWoEyNH9CWsmsHFasfvOYEy7WO66/idMyqARwqPkUfNgeUwZbtJBAxgPSWO7Q==
X-Received: by 2002:a1c:752:: with SMTP id 79-v6mr707079wmh.59.1536585816922;
        Mon, 10 Sep 2018 06:23:36 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w10-v6sm20717032wrp.31.2018.09.10.06.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 06:23:36 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org>
 <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
 <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
 <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
 <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org>
 <20180910141820.6c715895@bbrezillon>
 <CAMRc=Mdew1s35=M+vh=Fxc--0+rYxRXT96KVOJRhAX9f8QwtkA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d74205d4-f8c1-1151-413b-e1a80aa6b74c@linaro.org>
Date:   Mon, 10 Sep 2018 14:23:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mdew1s35=M+vh=Fxc--0+rYxRXT96KVOJRhAX9f8QwtkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 13:22, Bartosz Golaszewski wrote:
> While one can argue that nvmem_device_cell_read/write() may be needed
> in some strange corner case now, once we add the cell lookup API, we
> can safely remove it and force users to do the right thing.
I agree!

I don't have very strong reason to stop removing 
nvmem_device_cell_read/write().
Lets see how it turns out!

I would still want nvmem config to have ability to setup static cell list.

--srini

