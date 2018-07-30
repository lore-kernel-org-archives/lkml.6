Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7513F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D888920881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icYsBCiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D888920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeG3Lnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:43:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3Lnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:43:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so12200446wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BIqVTRkARYqsCyYmq6+v9VatArlx6WTLrTfgvbj+yOA=;
        b=icYsBCiPdS0IoPJ86qN3qM4XyaHyCzXgb4P8414A9EUaQBcKGXDaSa+2cX+nvEOx7X
         dYZFuX7vnuDVxgsPsmUHaQ9yfG2+d+965U6krEvDvtABDguMHqkrtVDhexpUjoZnQsjB
         gVVzZJsHR4rLvvP2CaBAZCXhbj7vyjRLjpUsA5fG4nj745SXpd6vK2bTlpWXN0dyC+0o
         c/HGjm7PTvOKrp5jj1VRsdEHsml7+8C2NDYnsB+gZbghxP357ml19yFop1JVxjg2l2xk
         Q3j0t0yRIbAWLUEcbKLqdUAq/E28HrA+hAsUj2n7Qf9Jdsggx4BoM+Ls4aokTZRIMIMO
         WT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BIqVTRkARYqsCyYmq6+v9VatArlx6WTLrTfgvbj+yOA=;
        b=eWL5Av9VzWWNYiC5rkDHOPIdXHnphB39FxubqBVLXBNupITQ9YteKlzVmCAN+oK0Wn
         IuiQFug59mrZn5EaIhyixtfdZnirea+a11XxwLIqTUrWa3U1toH5Wt9sf+Y+2LnOyOYf
         hKGnE8wRgsMVwLX/0CHpM+b+SwCPi7jypldaEOsWlkC2QbMzhqTf+dZ0rR5APhbsAk4F
         HQ97HUKG7b1cwCfdIiExw/I2ASuatfZaeXhFaex9JQMh4PGEVFM7sF0s50Na2TXIRSQt
         ZVHttT/JJRccaw/PvkspW0V8qQmQq0NnjhKgSEkye1SU9Xs8jkeLrME9Z/GnMlS0aAA1
         XM7A==
X-Gm-Message-State: AOUpUlGZiwjoCrat89TYbjq88Ao4iLrr/repQgSHw2tBHcvsKJuUHKy+
        nroRehCANxoy0eRSfv0UVAIbQ8IB
X-Google-Smtp-Source: AAOMgpeorj17Qw9CZLhnHDO1Ez4dDxRJ6IgGn8HLUuNy2fcwquJ82ENcf+3lCJadlaRjNhK8Y8IuDw==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr7184970wre.29.1532945355948;
        Mon, 30 Jul 2018 03:09:15 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n7-v6sm7272857wmc.2.2018.07.30.03.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 03:09:15 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] staging: rtl8188eu: remove unused
 rtw_handle_tkip_mic_err()
From:   Michael Straube <straube.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180729185447.19903-1-straube.linux@gmail.com>
 <20180729185447.19903-3-straube.linux@gmail.com>
 <20180730090216.GA19163@kroah.com>
 <9ab9ce0f-4b2b-912b-04af-736ee9f23d4e@gmail.com>
Message-ID: <7f238d0f-3d65-8f43-61a0-647147ecafdc@gmail.com>
Date:   Mon, 30 Jul 2018 12:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9ab9ce0f-4b2b-912b-04af-736ee9f23d4e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/18 11:27, Michael Straube wrote:
> On 07/30/18 11:02, Greg KH wrote:
>> On Sun, Jul 29, 2018 at 08:54:43PM +0200, Michael Straube wrote:
>>> The function rtw_handle_tkip_mic_err() is never used, so remove it.
>>> Discovered by cppcheck.
>>
>> That's a bad tool then, as this is used, and the build breaks when this
>> patch is applied :(
>>
>> I've dropped it now.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Hm, that's weired, I also checked with:
> 
> git grep -n rtw_handle_tkip_mic_err drivers/staging/rtl8188eu/
> 
> There were/are no uses and the driver builds and works fine here.
> I don't see what I may have missed here. :(
> 
> Regards,
> Michael

The use of rtw_handle_tkip_mic_err() was added back in commit

69a1d98c831ec64cbfd381f5dcb6697e1445d239
Revert "staging:r8188eu: Use lib80211 to support TKIP"

which was applied with 'Merge 4.18-rc7 into staging-next'.

That was not applied when I sent the patch yesterday,
sorry for the trouble.

Michael


