Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8926CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F3A208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cHGLUudU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F3A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeKND6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:58:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44445 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeKND6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:58:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so20999293qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9DhjwRNoXjEAyQemgjipji/GQ3gr6vjKNMVUrxvbfE=;
        b=cHGLUudUf3fxuGsPSbUluKpVG26X3xXwdqwNEGkqYvbCMaxxlJuFDG/D7v0QTKf1O+
         2WW8Tb8JhRNIa1WhtxI164zFrFo5MD/tNu/HRwWIBVbwzU4hmq8XThLk+zAev56k7cfy
         tNm5dD15b6nwi4DdnXPz7ftEOY0a29/bAxJyzsTdmsUbUkKuZ/HBwPTCuzJdcbrkhWYI
         CKH/hRFeW89ymeWiQG6iVfMPpQu15d92689lskQx2f06BaN5ECiVEXpXuEBt/Fi8fgtI
         K69bWt02RUOPOV7wl/8/nAXeeu8Yl7ux4ODBO7BPMovzKCHeEVWTOR65fpHEvpforWga
         b6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9DhjwRNoXjEAyQemgjipji/GQ3gr6vjKNMVUrxvbfE=;
        b=AybWW2mKeGlabvI8idNuLm/sAFmbct11csXm2H2gWMyzvsZmkXsHJnXry74gZW5MQG
         Pb9wTsCbxbRx2pp5x84ZA+EyMNM9FjzVNfl7wSK/YR7b+mNYI7nGY8wkTXZwNfGD9XAs
         dSIhIuiUCYGU+/78cZRuj59DshA487FqVPg8104dWeFqnas87UIyKa5bfY2CHDEq4FVy
         Ao1N/IKG4rw4dULfvzS/jZ+RjeYw0dEPw/2/PjgrIVfuzhYn5qWxoVy6U1KiGv8HF12k
         mgVPivy11ie1MvfbKCXNr/RZnK5SoXggVN3RD7kM4RhI5kcazfhqHpLZy4GtT8xMtNpC
         I2DA==
X-Gm-Message-State: AGRZ1gJRXGFWmuTekOjEdi6jvY08SQ8CAujC6guSYHviwXQCULzEqHW1
        BQi3yGn/pFwGqj8iYbI/oMtInQ==
X-Google-Smtp-Source: AJdET5d5/8b0cPYhGAH/2uQ41Yrr1IDMnYVhiDpgCT/Dbx6nLJm1B5aP4qZKKue4XAs82Z3ncPbUwg==
X-Received: by 2002:a0c:b786:: with SMTP id l6mr6417096qve.244.1542131973659;
        Tue, 13 Nov 2018 09:59:33 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id b8sm12820692qka.79.2018.11.13.09.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:59:32 -0800 (PST)
Date:   Tue, 13 Nov 2018 17:59:30 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     jannh@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        timofey.titovets@synesis.ru, willy@infradead.org
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
Message-ID: <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-13 15:23:50, Oleksandr Natalenko wrote:
> Hi.
> 
> > Yep. However, so far, it requires an application to explicitly opt in
> > to this behavior, so it's not all that bad. Your patch would remove
> > the requirement for application opt-in, which, in my opinion, makes
> > this way worse and reduces the number of applications for which this
> > is acceptable.
> 
> The default is to maintain the old behaviour, so unless the explicit
> decision is made by the administrator, no extra risk is imposed.

The new interface would be more tolerable if it honored MADV_UNMERGEABLE:

KSM default on: merge everything except when MADV_UNMERGEABLE is
excplicitly set.

KSM default off: merge only when MADV_MERGEABLE is set.

The proposed change won't honor MADV_UNMERGEABLE, meaning that
application programmers won't have a way to prevent sensitive data to be
every merged. So, I think, we should keep allow an explicit opt-out
option for applications.

> 
> > As far as I know, basically nobody is using KSM at this point. There
> > are blog posts from several cloud providers about these security risks
> > that explicitly state that they're not using memory deduplication.
> 
> I tend to disagree here. Based on both what my company does and what UKSM
> users do, memory dedup is a desired option (note "option" word here, not the
> default choice).

Lightweight containers is a use case for KSM: when many VMs share the
same small kernel. KSM is used in production by large cloud vendors.

Thank you,
Pasha
