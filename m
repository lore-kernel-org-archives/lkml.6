Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D872FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DBB24593
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nBfT0f5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DBB24593
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeFVQLr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:11:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33046 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeFVQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:11:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so3719011plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YM+46ucOheg72dPwAbaFVyWZdaRIS1pmxjCf3rce6Mo=;
        b=nBfT0f5HfeIQziYT13pH3xUKGwcdZbavBZmcl3cVGc0Hjr74+4duEwcVGgTSPOvgNB
         BKtbOPTa/GtjsKXRq4ITZCVgtNSTmpcxyghMYFZVGEjDmooAdfTjnrhwl6TTQ6tU4I3H
         X0EA7sjjfFyZ74rNDHdmy9Px/Z0+XGram/5hosT6+6dPBQ4l4X1sStntXZJDYeIZIBP1
         y2GhdZIywNyagYruGrmgRwbvdX7MNPC22ky+TCCyyE/6JvSKBOUFbAbrD6ywBeRmljPN
         sLo/JDg4L2xxct8/tfRIpEb0vt9HgIhpqg36y2AnyK4JBOYrz5oglBzToCThsaws8236
         NMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YM+46ucOheg72dPwAbaFVyWZdaRIS1pmxjCf3rce6Mo=;
        b=bLRLRy7xOOOZLZ9LNRD5v3gjVXhkzmtZ9JAPBrAKGwhk2YUZ3T0LlEmfCe5CT9cZ0C
         ivlvUqcmmVF+hgyksrWZGwVQxCpwzaRXxsdQh9lJUHl+6eMLfB60G1v0AWH8lEAAAchM
         OilYrpp1sda6804Y+RpJ3rcGNJ71mG9a3ZbzcqZhJs7+uoZKUaWMqxsasS68TIpS/VG8
         Xr36qosK02x9hKYbUZka/7AQj+qffnOJHfXj/I+XqynHmJ0+BF4WJJBAppTD62X82lSE
         piDmfDHO0Ha+a1iTBPorQw976AFKtreKX56HN6AO4SknqEyx9tWqU2yjg9sTtL/SGa13
         LSrg==
X-Gm-Message-State: APt69E3HmNitr4neBdpSD+w9BYJv9RzAfcT9fxXjIEj0FFhvmLlDnHc3
        Y72m9NkhTEvSlAvj86NjqZWScQ==
X-Google-Smtp-Source: ADUXVKI9OmtaGnKkMUYwQJ18dMIDpt7sW7M067dGH6QpUHoLaOncKh6gjM9bmhr7hallE09UpvkNqw==
X-Received: by 2002:a17:902:a24:: with SMTP id 33-v6mr2355376plo.88.1529683906014;
        Fri, 22 Jun 2018 09:11:46 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:2cd9:e530:8535:a508:f820? ([2600:1010:b065:2cd9:e530:8535:a508:f820])
        by smtp.gmail.com with ESMTPSA id r79-v6sm429904pfk.153.2018.06.22.09.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 09:11:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de>
Date:   Fri, 22 Jun 2018 09:11:42 -0700
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 22, 2018, at 8:18 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Wed, 20 Jun 2018, Chang S. Bae wrote:
>>=20
>> +#ifdef CONFIG_X86_64
>> +static void setup_cpu_number(int cpu)
>=20
> This function name is really misleading. vdso_setup_cpu_and_node() or
> something like that clearly tells what this is about.
>=20

Ah. The big secret is that it=E2=80=99s not just vDSO, or at lease hpa wants=
 to start using it in the entry code.

> Thanks,
>=20
>    tglx
