Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE27C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F78F20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+Fi5qmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F78F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeK0F7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:59:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36465 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0F7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:59:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so6601258pgm.3;
        Mon, 26 Nov 2018 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MtYXmw71JsKEVFzPfgd3EMUj0wL60qkaxOAZzf75FQM=;
        b=N+Fi5qmLWLPF206H+ss0H/KbpYbx/2PjUOmJ7n/ZblhNxugd3rJToEuOJjDUCEQLQF
         qka0L9QHQ/D6xsaIzAHgN3rh5ERhjgUvjwaxC8X9Zmn2gD1O4/v47SlBUQwQLJkqLf7b
         IkYZr38zxnWDQQrQpLcfE9qW1tfKotb4QWS1aix7FnRwdT80NDo1R7/V/uICJ2CA1Kal
         wWFgXR2tUWR1HabOXwM3dnjPi967sm6avAJwcrc3J46hKMStw1Zvf+cUfR2HsBIUyB1j
         4h3vFQkc2gQrBqaMCYOt5UPZRvfHIoS6W/09CheXyvfUUtZYG6CiQr09M5RI+TP9GDVJ
         VDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MtYXmw71JsKEVFzPfgd3EMUj0wL60qkaxOAZzf75FQM=;
        b=rgoGlqLyz2rDjXgPBxLVOgt9vkNzx+F+U3e2P81uEWDwhOa9bKxmBRgmNgxNnVPjQy
         8kFI1W5ukDCANmxNHja7NXTg23ItfP+H4PXkcMJrnnV5TUIJHG8pMsZeK5JVOQbzlGFz
         8D59EuS2+3b3BPf6LqYREIiRXxJXgvjYid9MzpQ0b06YSKiRv8EJ1lVX9e3ApC1Hajv3
         YvhyUcxtjt8vDgZm1kBO8un6kLg3dZU3GOsg0JADMZJJoKkDlgD/hblRrYUTbgnUzbqy
         /qr/UAy0rZYzgladPm+ywukzvAouOm2zr5h5jf0R/y4UajEoiK+3rD5Uu1+1ntJFeONH
         B1vg==
X-Gm-Message-State: AA+aEWZipM63PQm5VSNCvrsmxsY0I+vWQUao1+JqLvcYqPsFOIv5J+w8
        422iCcCJMHh/mJ8oNl3ldYE=
X-Google-Smtp-Source: AFSGD/WlJwVdt1Kg4BYnr/gocpM4cdoBFM0+2513R8uROl2UPk2geZZvVThFcenTl45+NOEj/x2N3A==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr26356665pgb.242.1543259068219;
        Mon, 26 Nov 2018 11:04:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x125-v6sm1398063pfx.38.2018.11.26.11.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:04:27 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:04:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/46] 4.9.141-stable review
Message-ID: <20181126190426.GB14137@roeck-us.net>
References: <20181126105045.447291262@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:50:49AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.141 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 28 10:50:18 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 285 pass: 285 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
