Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A15ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB1520857
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHxYNU1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB1520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeGTOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:22:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41572 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeGTOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:22:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so11348217wrr.8;
        Fri, 20 Jul 2018 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdUOjV0q1QqtZgW4SggVdEr8W5QM5DeDX/rxKz1J0n8=;
        b=uHxYNU1dCzoYw4mlLnxz+QTlaYJiZIQwxY0i0KW9GtHMj+tZdh4rYB9F8N3EjaD0VG
         rEQmzcJyeQlNvdQzjdJb4FCYhnj0n94MTWPPOszYUUT41AnNxv6ZZsinxoN0OghyqSqz
         cZizCSsV8SmshuWwtSHwUF/6A+Ta7ZYubGDy0LjYOE5oUiBminJO0aA6TByjdjwYvpYr
         EuMVRBvxW9+Pjt3t/YhozAJyRroINWoi9DT/9jaVyOwDScyHO2v2p7x59KvAhq/AYlvb
         59lcdTya0arbBdp+ACXZ67fVRC+EWRVcu3aiwMzHvJ1IpFLpdxfK5UDfqYi7QRfVvyUj
         x+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdUOjV0q1QqtZgW4SggVdEr8W5QM5DeDX/rxKz1J0n8=;
        b=nUmMw/kLLnXvC7x3Xe6AYWhwAsDC7CNsATjErK2kxJJQDEYqwCS3TRqlT5K5E4YH/q
         seYgttm6Qc0kky2sQPdvxn2HKrB9BdqWxNRVwt6+fneusoBVpdmBOuspfxbsxpZa692K
         aMuhic83ymz6iog5laoVU5AbxQWK8tHzWJumCrVvoxw/RCskvYAHNgkbrZcf842ccTdt
         kF6sOaavjEs1BsGoeo3iUTj/I9gFgPFmd/huBu4XFoHQ42hPtJAYsgpluE6cH8FJ/i6J
         vMrYJNWaqtAxtgFfcqj6uYXqHr/AiBqP+Ohep8ai28lLIzqJIhIbQrKlKsMDmmQo1rS4
         nN9w==
X-Gm-Message-State: AOUpUlGF2XOAHwCZy8GXfy0s4N9dCeuO9qpsoWcc5hcV0xMph/fzpZ6X
        YgbhKwHm6yJShJkU6yDeH21D4IctLt0XiQ==
X-Google-Smtp-Source: AAOMgpfaQnaITqLVXh1QWtyYxihdNbXO873PUzWOIYFcO+lQ2YEooy296t4pwRYuh1jmwhj83Ymf4A==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr1566624wri.36.1532093642310;
        Fri, 20 Jul 2018 06:34:02 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2040481wrj.35.2018.07.20.06.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 06:34:01 -0700 (PDT)
Date:   Fri, 20 Jul 2018 06:34:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/31] 4.4.143-stable review
Message-ID: <20180720133400.GB31668@flashbox>
References: <20180720121340.158484922@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:13:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.143 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 12:13:28 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
