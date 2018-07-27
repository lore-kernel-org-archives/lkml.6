Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B8820897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzHze4Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B8820897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbeG0Syn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37450 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389096AbeG0Sym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so10406366oib.4;
        Fri, 27 Jul 2018 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6wGwNogDjJfuKX+hReNxzUsYfZR9rMBDhXYR9pF05w=;
        b=PzHze4YbzguB8a7hK+Z5yeWxpCaJ04DqSoPOdcRHPichuj/Df9QuQ6JYriDZtHQiQX
         opWnhkYEz81S9t/l1Va+NUbp/VG6tzIPaYvGTBCvNwP9l/AbqU+IhHFZuFNBVjmrzKj5
         fO+EML9nouo7IJDiKu+WKOKqyHRTZ72Au+hcrq+oJIAC1p9BESXeAOoKbmQoMp4bCTin
         vEgI8Z4JqJjggOGF2bU33oLK+umLJr/jQO/IRkOn37zCZ3v888O0shHB3UW+5K92oUdM
         xH36WN+hbtyHhK1Ov1pAWYZ+6zVfTpStwWtsx+oYKnuN1qxcCvefUcSbh+JNzRNTmqVZ
         E+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6wGwNogDjJfuKX+hReNxzUsYfZR9rMBDhXYR9pF05w=;
        b=AvHadBL4e74uZlaZZ1pXuECBP82fETkRPXCAtkWIu8qvCt67Djv/41McW7QkJJicVD
         DMcDsvUy2uN8V/SF/qgAdA60y3r0jRolVQXS0d5T+PEOYx2fN30vWUw61/gp1LlUBvCb
         5BzLCpp4qnefJlLAzy1Xk8tdcMZDzgX2UD3kqigiaSWRKjpQQ+amf1IfeqvJlFoVmmgK
         bWsJxVPMM0kexP/FeMtTrM/J52AwDDcFXz/WXwo2qxL6wuLvnUBnxuXEio4ksdnMxkQ7
         ASwMHf2sUM96G/pZzWGE/6iFdF4RnbR4lzmJat2wVdQM2SAPQmXNJsG/QiF/1bDygNWT
         NKtw==
X-Gm-Message-State: AOUpUlGRa+RUJ/D2VFPj0yETg0VNU4jvMsx0a7l8w58s6OBOKDmLhH89
        75okyZbW+wHXQydc0PwShTc=
X-Google-Smtp-Source: AAOMgpeuqcUsUqR80mNROHr2gYQMeuH6qLN/P6YJKf3QwvgcQMuLTgGe0igwYKkcNnBZRNyJ909xkg==
X-Received: by 2002:aca:45d6:: with SMTP id s205-v6mr8127316oia.147.1532712709712;
        Fri, 27 Jul 2018 10:31:49 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e204-v6sm6244120oif.21.2018.07.27.10.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:49 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:31:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/66] 4.17.11-stable review
Message-ID: <20180727173148.GE4564@roeck-us.net>
References: <20180727093809.043856530@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:44:53AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.11 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 09:37:38 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 177 pass: 177 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
