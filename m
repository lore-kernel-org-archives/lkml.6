Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4283C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F99621581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bSC1r7BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F99621581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeHTRnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:43:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39614 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeHTRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:43:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so6857175pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QVYdT9jQH3ImANVloEKSmq8Hg5ocricVPHa2cqn+N2E=;
        b=bSC1r7BHDkPSI2l6eIGqOm9j9+phoZgFsQznCoM4MMlDhCqBiyDoZ6OPPCoaB8TcJB
         bU94f5FQE0ruyIqHIO8mUrL1npdI5P9z339pBFPucdVKwCRRUbzXi5WVcuUEMcARn1Ue
         t/bWDoXV3OfjMBMF/vdW7U/8iEam5rDj14/A+kMGYt7Uplko1lLlL5GHPSXy8oOgOmd8
         hSuprGk5KS+II7/gghPX9Bg0rMDijSsmpgCeSl+SxgtoBKjYS/jjMkoOlfArWv7iup+O
         E+I7pkRxI+6Pl/pLFkhwwg+/vhnUT4ykC9PFc3ZThRKBdUMnqwMba9Tzq3CqSEr1DQS1
         +Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QVYdT9jQH3ImANVloEKSmq8Hg5ocricVPHa2cqn+N2E=;
        b=Kt+8GY8LstIM2aJa4cGNq05tDzzv4UKTb4bX7zv2JAIzm9aRj2hR0un7cuu7p2999N
         dad9nt8fWsy/WC4xOEwe6UOAL3VE7/pgFEAYwMXJ4d1l9En0KoISxQc6i02SUR2ygaf+
         akIscqLy5FehnIpKcu4yavkgKDV6afqB6Sm1ahr4bg7+Hf7R+O09tAKnbfOlyTXosxBq
         4dDDiWfffXZ7q4PB9KYqSspEArwdS1fhdCQNNQdzZ0gHPwsy8Qvr/xnA12j3RuuUWpkZ
         jiQyr3fvIuY5qjEGZnqvUxzqRrCqKkpals8l3pTiZnKgXjHd+p5uyv+rC3UpEh2HAO/U
         cNzw==
X-Gm-Message-State: AOUpUlGONDqCwBLlccmjG7KJsCBqHpRlUABQqMi3p3krmwqB250PQO+f
        BZe6r4YBtPBkDvEJbHFt6R3KhA==
X-Google-Smtp-Source: AA+uWPyMVLDlsR7EJfI8hTsdsvEIh6UlZM2Oc2eIKzAcnGiuOeQpPHwrIZIg1uXAOizPlWROsXotcA==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr43240563pgb.136.1534775233197;
        Mon, 20 Aug 2018 07:27:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:b4cc:81c8:3b3e:d8f? ([2601:646:c200:7429:b4cc:81c8:3b3e:d8f])
        by smtp.gmail.com with ESMTPSA id w81-v6sm19506642pfk.92.2018.08.20.07.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 07:27:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/process: Export start_thread()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1808200927550.2151@nanos.tec.linutronix.de>
Date:   Mon, 20 Aug 2018 07:27:11 -0700
Cc:     Rian Hunter <rian@alum.mit.edu>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2852E34-BC10-4161-A05D-981E3A3D4098@amacapital.net>
References: <20180819230854.7275-1-rian@alum.mit.edu> <53141AE9-7192-432B-8A27-25986CF442D4@amacapital.net> <alpine.DEB.2.21.1808200927550.2151@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2018, at 12:30 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Sun, 19 Aug 2018, Andy Lutomirski wrote:
>>> On Aug 19, 2018, at 4:08 PM, Rian Hunter <rian@alum.mit.edu> wrote:
>>>=20
>>> Commit e634d8fc792c ("x86-64: merge the standard and compat
>>> start_thread() functions") removed exporting for the start_thread()
>>> function in what seems like a typo. Add it back to
>>> arch/x86/kernel/process_64.c for parity with process_32.c and other
>>> arch.
>>=20
>> What for?  Perhaps 32-bit could remove it instead?
>=20
> No. start_thread() is called from various binfmt implementations which can=

> be built as modules.

Fair enough. I=E2=80=99m fine with the patch.

>=20
> Thanks,
>=20
>    tglx
