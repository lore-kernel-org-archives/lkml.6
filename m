Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5AAC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CF420875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoLZGajW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeFTVgB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:36:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43948 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeFTVf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so455191plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=G2auKOMxQ9wI7wBvMKoDy9J9i6w5RWJR8sEiBNhapYo=;
        b=DoLZGajWtFM8THj6hgvGfGflmQ+DUWNv5t12YB1f8f106cYJeKWDt81J/oqHs/OQZM
         97hF6fIyA9FRaHWN0EKeFWSzVS7jXfFijdibW9H7ofg7JYkl9kUpmuKy9fb1HAXliQZ5
         MFdQCZaS1d0u3GyuEbgzqS5ryvT9eDL+Ap4dg5W1JZ818cwrKiw+AIXa64EnGxR1S0A5
         i6TvH33NuJT+jC5eqE3nF3IhaubV9y0lte0gvpgNY2ynaPFMikv1dwV7GXlhlhJDZ9y8
         mDAfnyb8nXRzt+hJlqlMf4YYStgklpu4sxr58Z6kq9UzWJY4rFOKY9CRKERFxNEb9x8Z
         QL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=G2auKOMxQ9wI7wBvMKoDy9J9i6w5RWJR8sEiBNhapYo=;
        b=g1W3KJBAnCIjmTYLH9LA7dm1NUeZqbadEZkEBn3yxtCNPK9B/BKUNo2WKwhUDO9cUw
         9YayPXne7qxnWNUzCrPf+JEhr4kstgezPuhs6HsdpCEYrIfEMab55g6/MpOYUuOPEdnK
         6pD+kEtn5BN38XM0U5nd4CrAGFIN6kbQS3NwwHBigwaMFCjrr6/yMQVvxkeYWHO5zbmw
         lh7JybFduNi7V6qHL+7qptwV2uHjXWR+aRE3taEPDpeukK7uc4Z8j/ws4mIpVa310GDd
         AQl3mVL1Ycl/AP4BdEcj8AE+2iocEBBlmpcgZwFRIGkZGXMVmmjYwllT1hiVKrNcWXUU
         Px7A==
X-Gm-Message-State: APt69E2mINeYEc8k8KGtAU/nL8T/9xnQuXy4Vp37UBnghX777ppHmtbU
        EyDSGmw3f9/co9Mil1snLPT6o0BWG6M=
X-Google-Smtp-Source: ADUXVKIZBaRDmufpOWgikOtaogXejXnTYy70vDCobJ62R+7CoraTqzoOrw3Iz7fqctyAjurFPm6Ayg==
X-Received: by 2002:a17:902:6f0f:: with SMTP id w15-v6mr24939491plk.216.1529530558892;
        Wed, 20 Jun 2018 14:35:58 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k12-v6sm3917825pgo.31.2018.06.20.14.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 14:35:58 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:35:57 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Greg Thelen <gthelen@google.com>
cc:     Andi Kleen <andi@firstfloor.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] trace: fix SKIP_STACK_VALIDATION=1 build
In-Reply-To: <20180608214746.136554-1-gthelen@google.com>
Message-ID: <alpine.DEB.2.21.1806201435430.255247@chino.kir.corp.google.com>
References: <20180608214746.136554-1-gthelen@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018, Greg Thelen wrote:

> Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
> SKIP_STACK_VALIDATION=1 fail.
> Example output:
>   /bin/sh: init/.tmp_main.o: Permission denied
> 
> commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
> added a mismatched endif.  This causes cmd_objtool to get mistakenly
> set.
> 
> Relocate endif to balance the newly added -record-mcount check.
> 
> Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
> Signed-off-by: Greg Thelen <gthelen@google.com>

Tested-by: David Rientjes <rientjes@google.com>
