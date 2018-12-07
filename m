Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22068C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49692082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtFga5hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49692082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLGSBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:01:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLGSBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:01:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so2030654pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HTtmn1EzID3LQoWQ+qje1zRbS/n0UPCm2ohnShczpM=;
        b=BtFga5hjczahE/ZC1zetTngd3ip3/P/zHfJYmimgZsfFn5rRRgGNsYRSgbeaRfFvgS
         yQD497ANy/YNfVlnqMtKqpsW6IqjYI4SuGSUHW1jArxp0Bj/OzxpyCo+el2otnAd8EOA
         tBiCvzgQQ0d0xMxAWy9Qk3A0O6GUT3pOvq8wZ9/qdw1++FzDR00BwE1wXSfVPbi8WttQ
         3UXJ30VVLnCN2Htv2FRaIB97Ng8cIy2RTaKvkPwCMdn4RmS7iWdYGTc0aFubw+DTuTbb
         pBtGJTVapD3EQJNSPGaH5VM8KqhMqzait3VKuejl39+Y7wzEpr2IdgS9HZethG7Idhru
         0wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HTtmn1EzID3LQoWQ+qje1zRbS/n0UPCm2ohnShczpM=;
        b=ZK7rBxM2awyhVlz+qMpuPkSzoDXfFP0PJmk94RMenYjb9OaYsnQQ8nVAT0I9UraP7b
         IW+h9ZuljEZoNbjfhoCRtnr9nmqkuT/UIIpEkt9t8DIgFbZj9b4/DqE+0vL26oXKnlna
         5jB+ohc954YXkc3+vUhmyzOpdlVMKpiM/qTqoaMugudx/lRqOb4+bhbQfJUz6RPOCHlL
         CBMX10cpf8J/FhSH9SJGNfCHSKSqPJspTQ6IFr/c4gVdeZKZaMLCZLwT4ZhlczpfNtkI
         1waOsoZFNp+ps9TQCRZbkNgrcs5sDCbaBTzw6l+x9KZ6HA4WN3LQJW1fYUqcU3OzAYKO
         K/YQ==
X-Gm-Message-State: AA+aEWaEdZ9prUI13ssZ+lGCCqWGPBDOmDKvGYtwhPkD575MezRGK6+d
        m4qaUChXou7hcRtVOE7OYYG/oNVKhL1A9fVBqk+XnA==
X-Google-Smtp-Source: AFSGD/VYETWXbFVn+SblVE43/YFDLEpEImphJ8L4YH38CtXUfYwTvLNpPzjeTet7EfXbcizGMgWBJjDqk+5zVovyEK8=
X-Received: by 2002:a65:4683:: with SMTP id h3mr2675549pgr.225.1544205663756;
 Fri, 07 Dec 2018 10:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <20181207101814.GA9385@zn.tnic> <CAKwvOd=75MRjaDbEjHRaMTm1MSC1wkLxPKhH_S3KXreP8yU9Uw@mail.gmail.com>
 <20181207175253.GE9385@zn.tnic>
In-Reply-To: <20181207175253.GE9385@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Dec 2018 10:00:52 -0800
Message-ID: <CAKwvOd=g_eQwCdtO7bwCx4ykOjCBhw637X=TVc+hqatS+XbNjg@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: drop implicit common-page-size linker flag
To:     bp@alien8.de
Cc:     luto@kernel.org, Fangrui Song <maskray@google.com>,
        Andi Kleen <ak@linux.intel.com>, andi@firstfloor.org,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Rui Ueyama <ruiu@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rafael@espindo.la, Stephen Hines <srhines@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 9:53 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 07, 2018 at 09:45:42AM -0800, Nick Desaulniers wrote:
> > Google's Native Client, a technology for running native code in a web
> > browser.  It's since been superseded by Portable Native Client (pNaCl)
> > and to an extent Web Assembly.  It seems that BFD still contains code
> > for NaCl.
>
> Yeah, found the wikipedia page. :)
>
> > How does this sound:
> > TL;DR
> > -z common-page-size's default value is based on the target
> > architecture.  arch/x86/entry/vdso/Makefile sets it to the
> > architecture default, which is implicit and redundant.  Drop it.
>
> Sure. Although the longer explanation gives more insight into the whole
> deal but that's fine too - the longer explanation is on the ML and we
> have the Link: tags.
>
> So no need to resend - I'll simply take the three-liner above.

Thanks, it's being set to the default value again for x86 usermode
linux, arm, and for sparc.  I'll send additional clean ups for those
three.
-- 
Thanks,
~Nick Desaulniers
