Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20392C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D282184E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3KsTHSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeL1V1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:27:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38354 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeL1V1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:27:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so10916858pfi.5;
        Fri, 28 Dec 2018 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5iPiWsvCy5meq6gvxZwYTszE0d7Srus8iy4n60Xn0j4=;
        b=r3KsTHSh7Sus5nwwRr/UkjVs8/mtc74YjS8RF8aF9T8IJGi21zbCEiwU97lLR8/Vbt
         5/Z507zoxQ7eG5tFfSVueEve6mpD+QSuuA17glAHW4OLfdZ3ESOPIt7l1b3y24aCWfXs
         aYDsr2vfieY4ZeD3r25SbgwjbvtcuQQKuQcTx3I8Lq49pUfvuJyG33OqZp9EBfi24Hhr
         G6vCiYhdwQkjeAIKv1qDq5oCzziJA6SqCtridcg4oq5JeUUYZ8VGe/jJZTcHP30wXDWm
         uIOnaHtkIx9BgupX51+CFZmM0cMkG9wX+wvvRO60FUA/1Nul4hhusOAsvBxXlUzL2NWy
         J0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5iPiWsvCy5meq6gvxZwYTszE0d7Srus8iy4n60Xn0j4=;
        b=oSG99AYHRThD8gRtM0kVCbZYMrUpC3mT2qxuB5+d+B+hB6HfLWvvdB8MvcyVAoQtYb
         kb0ormPjX3xyg8ze6cJINO2XV04mtpP5BJOoOYM5wYkusdYcBIc+/kAiM4SsuM2ylnz4
         y0WPwOBjo0y6k7Yzy1qB4fy5L4lcL8mSiZWPGBFDV6XoA3AYkMTOv1ry6gEYLmpp41Pt
         mflZZYWCwcXlmNBignWFh1cB45SDl8Qx3A/Y3Sq7aDF4ISZPnFSb4VGWlOUUGDciOsb+
         VVSlsQ/7HQ915trKkt0oDc18rQiIAyf8w484iTbH7Jl0j5RRwQaSiaV2LE7Rx9cem+8U
         N7zA==
X-Gm-Message-State: AJcUukeNRU8QIATkA32W5U9ad+zBPDtOsslDTLDct7WIRlql0fPpd9jh
        e1+pCmtZDuNcS0+pwLkKNeX6yo5i
X-Google-Smtp-Source: ALg8bN7O7JqBf5aOA1EAK94U/xc0i/tyYpw+WdLfCzNjMjyKgpVNQl+emeuXKx0xpU5LiMyUzfqOcA==
X-Received: by 2002:a63:6150:: with SMTP id v77mr27139270pgb.266.1546032436225;
        Fri, 28 Dec 2018 13:27:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm63422434pgd.53.2018.12.28.13.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:27:15 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:27:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/22] 4.9.148-stable review
Message-ID: <20181228212713.GA32706@roeck-us.net>
References: <20181228113126.144310132@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:52:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.148 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 30 11:31:00 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 305 pass: 305 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
