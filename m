Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4687EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAEB20880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z19c99Tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAEB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeJ3DOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:14:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34284 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeJ3DOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:14:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id g8-v6so5910853ljk.1;
        Mon, 29 Oct 2018 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQsqP1jMPEYoUK/NirO70xA7rgncoklO52Kh4LosBOE=;
        b=Z19c99Tr6DUlqEV4Y4eBQFp7ieNkbsS/PlMLpYfM3FMFvsQXUZLru3HrZCzs6/ueem
         puV7UKDBGBMgrFnkhQqufZkpfzIDnNu42AGx4UxeyYlGtfr6hZjyS+mGsd/NzGlhfWWZ
         T4nvAnRI0dZ1RgBJGg8R2xkY5LzR0wG8Ku3NXdCC0BAz+x9chaa2L21XYQ4sRhcuVVdj
         qMWZPzHOuggM24nWfyKXORq0OthST+kDUnVFdmjISgHcr/0mciI6lxd4WpuB5CRfNfC0
         5eMzN+raycv2JkEMRcrDXwsO4/b2DQEbOHVEsq3H3uSzxJRGGkDJAFPVWshn3QMua8GK
         XWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQsqP1jMPEYoUK/NirO70xA7rgncoklO52Kh4LosBOE=;
        b=Hy2Od7Uw5Pwlkwe6uzEiP/1zf/4CquOGbjFlsI9BfEqHYFEAgzzUU1Nwfn50BKM6OO
         NE4Hh86KFHj125bobbtaF5dRyJ98tm01Mn8hcUhait18PYsAi7Z2eRbsj4igQPm6EXl+
         4idN2Y5blErv21jhcy35GsBXaEFgpOPlnkPdW6WBST6JpcVui8BL6miLO0XlgRi9MWhl
         PbnL5M6oN7yslMDUXrFUxnyvmUncvlISzvFrFoyujnw4fckOIrBmyyASHwgCSiR3VrGa
         E8ZqPCyXTIVa9sk1GbxLSM+Y0oAjsOXZFd5Rp42fJdWVPfGh01rohf1PLgzwCT8N7Pk+
         THRw==
X-Gm-Message-State: AGRZ1gLefxS9uoa3/PrQbdaf+3v4V54hupr1U7+otxnWMDbB50jEdPkK
        84A4Hrd+OA3UXD/ykxcHcWk0e07f47zAQw==
X-Google-Smtp-Source: AJdET5fsj6uapIMpUaqXTNDKOljDDuEqFFCZ6rnQPkNKAulfGbxQVIwVV2heGjTyi1/rxmvnRDHcTQ==
X-Received: by 2002:a2e:330d:: with SMTP id d13-v6mr2219532ljc.0.1540837486183;
        Mon, 29 Oct 2018 11:24:46 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id e201-v6sm3314921lfg.42.2018.10.29.11.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:24:45 -0700 (PDT)
Subject: Re: [PATCH 09/17] prmem: hardened usercopy
To:     crecklin@redhat.com, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-10-igor.stoppa@huawei.com>
 <cd768a99-5afa-999c-989a-efee66fa0ddb@redhat.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d1f3f3b3-80b5-c194-dae7-b192e43a9dd1@gmail.com>
Date:   Mon, 29 Oct 2018 20:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cd768a99-5afa-999c-989a-efee66fa0ddb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2018 11:45, Chris von Recklinghausen wrote:

[...]

> Could you add code somewhere (lkdtm driver if possible) to demonstrate
> the issue and verify the code change?

Sure.

Eventually, I'd like to add test cases for each functionality.
I didn't do it right away for those parts which are either not 
immediately needed for the main functionality or I'm still not confident 
enough that they won't change radically.

--

igor
