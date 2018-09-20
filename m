Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493ACC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECFA2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vIM8XUue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECFA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeITNBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:01:09 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33812 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeITNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:01:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id m10-v6so2654702vsk.1;
        Thu, 20 Sep 2018 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ip7ztdLQEbhkH4RVaBNDwLNN0T5jYSwsrNVa1j8iKI=;
        b=vIM8XUue4f50wqVyHlrkCmB77mTL+wXIavcLkpO6veStK4Z8aGlpC1U9j9LCMfeyD2
         qRUPi3G9y27Alfv2Eh36tNFOABfYk5S5bwfbbS+GWfmsXG/fF/7KGDEfI01ZlFhuFMTn
         pMYpBjEk/LvgPNlyH8bqisPjk9vC1BgBVZ9j0HYPTpLMVz73VJewbmkRefTM/NS2UcGy
         SS52XSwvoPK8mtwR4rDmTC/IdhSHin1VEyBlhC1RWLd2PtzU3QpsrjT4DGY2eottUpKf
         nLt5TOxeLv7wif5QNZpL3Qej9sO4qAt3+f5OcSm2j+ipD/Da1tDvG5gB+ZzW2ycB1lPS
         2Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ip7ztdLQEbhkH4RVaBNDwLNN0T5jYSwsrNVa1j8iKI=;
        b=JUwcbVERA1CfV+UJ99z4lO/dZIW372c+cN/HO8j8yW7koSwKMTa9w5bzIP+OBgYp6S
         WvFOj7fhkR6HdSWYcYSD4NJHsO3UUpUP+dgf+X+ldAlYk0DXtBWQoLI0Jew6m+pjf/df
         2YAEZQBKiXCkgYECg+NKaNzJY75bnGusy1wReb3qVaRn/yRFGR5O4IEcSGv73jJ+RwrK
         25XMAYvqllDywx0gKJcCI2llYqheTaaLp1XhDgCewtlnci9lkgxlee9NEP/y8v5G0mGd
         4KivVQxaJzF4sn/u8oa94SFJsHYiqH7gfntnJNaBhfdsX5yc+yTkxFs+vNbgYEApxdKU
         GaAQ==
X-Gm-Message-State: APzg51D9QWeDiwLkiAEs+/FFep3yf19lvbc1u93DEsZRDPP4PvRgKFRX
        o9GuyAQwIid0XFgsiNIDOkeWFBrYOw7cUTdr/HhVNyPmVUk=
X-Google-Smtp-Source: ANB0VdZocW/RyDhROM0eiJaMrDU1iMM6VlMY6pHSvVNbV/zSCLa9/eBlQZDxaDIJPBMb8unA9mMZeAv5/sPvlbyzREc=
X-Received: by 2002:a67:1644:: with SMTP id 65-v6mr11684362vsw.103.1537427947663;
 Thu, 20 Sep 2018 00:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180919231402.4482-1-cgzones@googlemail.com> <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
In-Reply-To: <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 20 Sep 2018 09:18:56 +0200
Message-ID: <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
To:     casey@schaufler-ca.com
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
        serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've only had a cursory look at your patch, but how is it
> different from what's in xt_SECMARK.c ?

xt_SEXMARK.c is for xtables, use-able in iptables; this is for nftables (nft)
