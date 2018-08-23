Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B903C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028B620684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsK4/N3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028B620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeHWXl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:41:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39723 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHWXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:41:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so3369869pff.6;
        Thu, 23 Aug 2018 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OzH+onkWCm6i9KB2W+ZsCkfmr2kzg1YkJ4pM2UI68Y8=;
        b=FsK4/N3CUhndlLiG5n+DI418x2NhAppa1RXA8OB/W35fxJCH4qwu3/i8rQcO6jU88g
         VJ4A/ItXRMqT0jbzWmdPdMHAfVSg6KmYzcqV0GVqxU8fi1ctdREcusWYwydBNON8/5pM
         zChKQlC7E7CAmZsBUJDtm1BlG4LgWfRfNSbEY3XAmjmgLAfpWHVuQszosGDLmMNICZOy
         SklK5eqMwQ3hz4L+UvbtnPoFW3hPu8B3L73yb6djNHC6Goe1d0Lk5XHWAlA9d8yYr6ii
         o8b4uhoD5AXRnRqnpciOFcy6tysdAVmSlkOsmrg8TxvI9IHoGn/0khVOtDuifqf/mS+q
         2Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OzH+onkWCm6i9KB2W+ZsCkfmr2kzg1YkJ4pM2UI68Y8=;
        b=g0j40+LLZQbm2jtDvao+jfkBfwAYHmJyMwBuo9eH7aKrkYpfGvMPrHR0+FBhYeYeWJ
         REUZ/Mi4A0f2EIjvnFVxk/jzhTAaTxsFKoQS4JTdH+BK6x3A1ptE+DuZmafTHfqFJ0tq
         VLjen63hKs8N3vUgDM5x4IRS6bEuTOuC2CSrudYvCdk12djvwo8RF+xtyL3is8qCM+gB
         +r5w3x83r491+3Yi12CLvZHrW/JMA3pgtSJzCnh0oc2U4jZ5GpVzvDZPQ1TsIlv6ofiv
         ZlN4wFtXKBR21wJrwYZXC1ZBl38LITe2x7jEhDomMIww6+BF0F/sgCytbElBveSEj+E3
         R1wA==
X-Gm-Message-State: AOUpUlHBUy+bxIIyp6oVQrB4Y3BzIuvkmUurhpZzjQ6F1rLvQu+qU7w/
        DmwGzvzyb2/lMBUAj38S6w0=
X-Google-Smtp-Source: AA+uWPyt0Pa6MhBf8rb/55N8NCwwyAWdBGzvn8eypVoqN6c/ftZzt2f0EWZYvFOWXn558B9Gnewv6A==
X-Received: by 2002:a63:3e8b:: with SMTP id l133-v6mr29562025pga.355.1535055040142;
        Thu, 23 Aug 2018 13:10:40 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t21-v6sm8602733pfi.73.2018.08.23.13.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:10:39 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:10:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/79] 4.4.152-stable review
Message-ID: <20180823201038.GB9368@roeck-us.net>
References: <20180823074918.641878835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:52:36AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.152 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 25 07:48:51 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.151-79-gb068527:

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 269 pass: 269 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
