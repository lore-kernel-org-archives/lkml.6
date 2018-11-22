Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6168E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szfEopFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6168E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395555AbeKWBLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:11:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34652 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbeKWBLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:11:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so7906472ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F66SYXiNorKCcziqBUCIpNtB5sKv0ifwQAmsm+7k3U0=;
        b=szfEopFllWL1WAwj1UYPTJx1ouhdiFSTI4LNHW1xvcAuwWO3GP519U8I7m2XfzNu7Q
         ZTRmHBzSUXsX761Qm6jsoz5bGB7P7j07yy6TWtGaB12FjB8jbDSPoyne4iLCEnJ9QXKD
         qXRevR5kr3BPqIGTh4hBOb1AdDNn5Rq1gseEuw4ECEuuufHA3/KJl2rDUgq4iLgKQZy9
         lJ7he5KvncMEd5GpDiBybnHxEd51253by2P8eVpdePEFKpGxOIoVb9ZNIU5GyDoVl9OV
         1GS1FqP7eMdJum1GgLiCr6lSRU/0cnijdGaKuf73mEQ04BIvk8ZO8CDxu8zsLAe+HoaO
         Ep6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F66SYXiNorKCcziqBUCIpNtB5sKv0ifwQAmsm+7k3U0=;
        b=ZVhsVBqyu238InB4kGxuKSCNqK5CKQ8DM7JVzG2uIlFHFEoxRH6LyFJ+hihvte92eN
         pPDejhFi3meRVZusSU2ayeEgMSKPkhUutcGYw3E/tA0k8NdbpJEs4avgTfYJ8c8gLk8T
         cgdvm5IJXT5GmgHaGUxnC2o0M+d8tvrZ+0F2ba3929WWSUk19DCpk5Bf2PvBOBuAo6zj
         R/FnjXu7X7oWp9NLWrvzxymYyl0U6lnWQKy+HuIVo40vJW+R99r5aoSEn+gM6O663K1N
         YMgBQfzRXIWz8aaUd4N+jmisK2Nd+zTp+WR6nhlL9uW8DbAvB0+Wb9GJgYU5z58GQ8Fj
         PFIA==
X-Gm-Message-State: AA+aEWYylagb7p28EfTOiYfa1QHVCritivrQcdvgbObap29MAvAJ8hd5
        XdLaf4HBMKrzeMXqnf1XmwQ=
X-Google-Smtp-Source: AFSGD/UYUH/4Qfja4y4bMq4ENZA781xtcw/0Eb1+NRzCpoOkQxLA6e/HCuotwwDZpck8gjaR2/bKgQ==
X-Received: by 2002:a50:aa31:: with SMTP id o46mr5045524edc.23.1542897124111;
        Thu, 22 Nov 2018 06:32:04 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:e07b:5667:f20f:17b8])
        by smtp.gmail.com with ESMTPSA id t24sm7275697edb.7.2018.11.22.06.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:32:03 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:32:02 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Crt Mori <cmo@melexis.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 1/3] kernel.h: disable type-checks in container_of()
 for Sparse
Message-ID: <20181122143201.d7vifhlny7gmrhzd@ltop.local>
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:14:20PM +0900, Masahiro Yamada wrote:
> When I tried to enable BUILD_BUG_ON for Sparse, the kbuild test robot
> reported lots of "unknown expression" warnings from container_of(),
> which seemed false positive.
> 
> I addressed this in [1], but fixing Sparse is the right thing to do.
> 
> The issue was fixed by Sparse commit 0eb8175d3e9c ("fix expansion of
> function designator"), but it will take time until the fixed version
> of Sparse is widely available.
> 
> Disable the container_of() type checks for Sparse for now.

I would prefer that developers upgrade their version of sparse but ...

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
