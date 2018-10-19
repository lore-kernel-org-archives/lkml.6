Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FCECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FAA21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GugzP/kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FAA21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJTBoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:44:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39053 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeJTBoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:44:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so16061128pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mQ93xoQgGaUs5YqI+Yy/gl2b7/gQyAobUsJ0F33FxTs=;
        b=GugzP/kMjjrRB4A6cN21WhWC6ORGNfA5FEi8ZlGEU39/vMDm1iUwojFMSMmGMTWmOi
         d3X9vM3bU6TIknGOt4pFAvCckM5X6uZJ6oJXU4qSePYQpXpQ13PEqWTs8hpyk/sWGTbL
         UR13DRFzR3+ofixm+4e6VZMQSFi0kQwgUmDxl6BqZlgKhtqjQ07vmjsQtIzID9DWLDJ9
         I29gwmcM5/dUYBtmItSSn+WkzUOljSzKjhSkDPfxnVI1Xm7jbSJ9AB3I4nOIJe8JhfTK
         H42LbsOq+RrHmxgLCqULZBmiwz02HlAnJjsbW7X1DlX1kX4HDcZCq1PrBt5uCk0KivQM
         8YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mQ93xoQgGaUs5YqI+Yy/gl2b7/gQyAobUsJ0F33FxTs=;
        b=dj24CNK/TF+Am4FHXFGrKc+DdUku4OU9GVsUSnCnmqcOKPT7HP9Gf3vgcrO9zqdgb0
         OAKj1nsRVcKSgV2NdhHNwnGBOofcvLJYANQJuqV8D6hFt7GqSCWmCLfzUsgwWrc7GRAj
         Qyod9bnpiVbShA6bqxj914vAVIyv6m9ZNq2BodhBf389NLnztOL5+SJ+fZs9+HIOmeyq
         cuZsEmJV6UMAEgH++dDp0VRDIYxE+Efgus41LXnMXWdeN8+oXCwdEM7fUC7gMNzEygng
         Eq3+9NIEn983zmd40wBYx89hqklditwZwFaocUIt3DQsU3IOhmp3I8rT0g8NTqKm2uXl
         sXDg==
X-Gm-Message-State: ABuFfohE79hC8ONHhIUZB35Ku/ilI92T8K8kzx3i9oSJI17/do0UfMrj
        3aBJ8VoQg9JQvFYc4V15VFg+Lw==
X-Google-Smtp-Source: ACcGV63YIijsdIT4GlMOO5KOLwB6rmUwNKCY4Y/X8Q0oFHZycntJtA0XQ2thiW31rWSj3iB9O/LjAw==
X-Received: by 2002:a62:2fc1:: with SMTP id v184-v6mr35516118pfv.115.1539970638896;
        Fri, 19 Oct 2018 10:37:18 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01f:cba8:c05f:3a2c:209d:43f4? ([2600:1010:b01f:cba8:c05f:3a2c:209d:43f4])
        by smtp.gmail.com with ESMTPSA id i186-v6sm28168484pge.80.2018.10.19.10.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:37:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <9c5ed364-4282-7dd3-f614-4e62632d81aa@linux.intel.com>
Date:   Fri, 19 Oct 2018 10:37:16 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CCD6641-4CCC-485A-BDD9-50751C4139B0@amacapital.net>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-6-bigeasy@linutronix.de> <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com> <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com> <20181018162644.qqjkzoqn2fleyi2b@linutronix.de> <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net> <20181018182538.vgotfpsdy7qxl2tg@linutronix.de> <CALCETrVjEOkNhdyAF10PaYi_rnFUWKRqPhLRCq3ZV=gxQFETxg@mail.gmail.com> <2fe82232-4e80-8317-757c-d2235c4633d8@redhat.com> <9BAD5065-AA1B-4DEF-A9D4-D7FD9B46667E@amacapital.net> <9c5ed364-4282-7dd3-f614-4e62632d81aa@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2018, at 10:01 AM, Dave Hansen <dave.hansen@linux.intel.com> wr=
ote:
>=20
> On 10/19/2018 09:59 AM, Andy Lutomirski wrote:
>>> That looks like a good API in general.  The ffs_user_copy_worker that
>>> Sebastian mentioned seems to be used by AIO, in which case of course it
>>> has to happen in a kernel thread.
>>>=20
>>> But while the API is good, deciding on the desired semantics is
>>> "interesting".  The submitting thread might be changing PKRU between the=

>>> time the I/O operation is submitted and the time it is completed, for
>>> example.
>> I think there=E2=80=99s only one sensible answer: capture PKRU at the tim=
e of submission.
>=20
> I think it's much more straightforward to just not enforce pkeys.
> Having this "phantom" value could cause a very odd, nearly undebuggable
> I/O failure.

But now we have the reverse. The IO can work if it=E2=80=99s truly async but=
, if the kernel decides to synchronously complete IO (with GUP or copy_to_us=
er), it=E2=80=99ll fail, right. This isn=E2=80=99t exactly friendly either.=
