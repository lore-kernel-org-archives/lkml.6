Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83865ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256B020BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQbwvO6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256B020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeGQEVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:21:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46796 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeGQEVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:21:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so27320614pfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 20:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h+rZ08gn0fwrmXszgm9NXTmIcbui/CPLOQv/DhC02po=;
        b=oQbwvO6nQX59vJi13PlmFqPs5h0UaUA15ucYUbnwV7dRp4vCHWNIGsvrpuizyPqIiW
         Pm8IiQ4JWkhi4VTWsmN3aHgPOgQ9gCr+n3HoN8wz93LM4Ik4RKnfCx4k6XNSZQweq8ae
         IsiAa0aQOjp5o9XLShU+aGyA11eE+XLQ9LR7FO+FgN8sZm52MvX/O2AV/EOgh9eIjlLz
         py1ea8q37KX3/IuTjdLpjpXbKBZiGHz4+UNARpa4TxLzbeEQhleLuIyOZWyiJ04jJJr8
         HKSKfpwK52anciDCQAWnTYsWoV4CFNj/7ozOe1mgCH29vQjZD26s/nOGbPLujuGTBPVz
         aoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h+rZ08gn0fwrmXszgm9NXTmIcbui/CPLOQv/DhC02po=;
        b=eG2eWaSTgwSJNHCybGqYmYWVMGd1m/EI+RC2ya8q2RFhMrBkWVKeX2G7ZcRfxB/kpM
         uUutDd50mj4iM02rsf4m7bL9/eeLkVAUbXke7NO2aFxkKBdz+gZldPBhGABDXpps0Xb5
         taE/v0ouYJsWt5ZsUWpoRX36x52/NgI3f23LPe4VlHX5KxSGnmi3Hyhzw/HKIaMG1UFT
         t/i1bg907d4Kzoabpe8+lMnFZrf9JKolASkpcAnfbc0jGZeJ0+7xrxnWHf5sOGEz2dU8
         BGOz8iCWLGSeqqKzwStYUN9q2125ydeC2sgn81lBwU89QBIO+3p+SkDor3vUgRWiyqd2
         N7qA==
X-Gm-Message-State: AOUpUlHRTN2VCZXyKp/CPM1Fxf5Q/dtmw6mehsbvQRzs/gWAoBLUgH34
        utrfhXDcJ3acILMScED/fjS+Ow==
X-Google-Smtp-Source: AAOMgpeemlg08HatTB4nuJx1+Wq2ybVujhupAghLNAlAzdXTCsgSKq8FLaKNiTuKGpqAlrbk8AfZJA==
X-Received: by 2002:a62:c8c2:: with SMTP id i63-v6mr20837851pfk.73.1531799475483;
        Mon, 16 Jul 2018 20:51:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p7-v6sm35580887pfp.168.2018.07.16.20.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 20:51:14 -0700 (PDT)
Date:   Mon, 16 Jul 2018 20:51:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
cc:     akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v13 2/2] Add oom victim's memcg to the oom context
 information
In-Reply-To: <CAHCio2je-k-vTejPO=hv2DDHD6XQ5Q4JeKDkMoDscoyjiZAeFw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807162051080.157949@chino.kir.corp.google.com>
References: <1531482952-4595-1-git-send-email-ufo19890607@gmail.com> <alpine.DEB.2.21.1807131521030.202408@chino.kir.corp.google.com> <CAHCio2je-k-vTejPO=hv2DDHD6XQ5Q4JeKDkMoDscoyjiZAeFw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1113858990-1551172007-1531799474=:157949"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1113858990-1551172007-1531799474=:157949
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 15 Jul 2018, 禹舟键 wrote:

> Hi David
> Could I use use plain old %d? Just like this,
> pr_cont(",task=%s,pid=%d,uid=%d\n", p->comm, p->pid,
> from_kuid(&init_user_ns, task_uid(p)));
> 

Yes please!
--1113858990-1551172007-1531799474=:157949--
