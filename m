Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A638520870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZLlUyM6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfBBNLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:11:22 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43303 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfBBNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:11:22 -0500
Received: by mail-pf1-f175.google.com with SMTP id w73so4653145pfk.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SoZuevrux212qO2SaiWf9+Eg9xNsFOf+wy8mcx69Gi8=;
        b=ZLlUyM6w1sx8v699bWBankBRpvtwiYx+EJ3iFFk6SU/soGZ1f9/h9cBZj3N8HJqukG
         ieuc+1hKM7KuIYV4CSAMGm0Yu/nm9YNZcDXzXnJrL5J3XFbbn67ChiF41jrtvnDOMjU7
         oGjjFtzfjHxE442svNkAYV0LrUbUKipvZKnfmBOZrdYkaf/dIZdPkn03aNlGNXoMk8FG
         FzIV/RDDPmcQCNvmALp5id2cnqVb7wIE0RFrwQmlfSKq2n12VtG+Ncew417nzYxcwL+H
         FnrsUEzSRkTFOxQw9ugWSAMnWj0rurzDpLWHOunrmVM/bmsddY0o014PDKwb7VZzzEJp
         9xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoZuevrux212qO2SaiWf9+Eg9xNsFOf+wy8mcx69Gi8=;
        b=H22Gg64cEC0oR7+GU91e8ePKSvIK4JxpAhZq3MAxP+xowXaPWLoQPss/sni+FUpNGY
         d8ARSUd4tx9+K48zFu/DaG5vIe5Tma7WGmjNBp4G/cI/8EQPvF3ePGGYpYJzpzgysACn
         daxpptRHLpqPsHrNyTKAeHQGfX4/sQDzLHPG2Id3YOriWoX0TQ2VcTiMjxdsXiRB1Qk+
         ufXvblASN+q5rD64TiMZHmx5oGMHV2TbI6XuvWCVPqs4NpGG7C1mqxV8p9TyslHk9w3D
         2R0QVnIpmYshOsgEsUhKUMMnZ7NHfnhRxZUgYfvPlOv4z91EPPYgVJFLkATt+b6aYitQ
         n4XQ==
X-Gm-Message-State: AJcUukeEycPiADrP5mpz6b+YPvS5l/m6wYk5UJWbiP04zX8KoyyPCU2Q
        6b+QBUNeYKzfpMV/s73kmgYJ9xjQzTLXb1KCOaASqoQhf3E=
X-Google-Smtp-Source: ALg8bN5eWYwg99oXKtDRLv/Om1TCLpb3WuIM/9EbQTDDFi8d/ix1Ixkw2sJVHyLCWL+uUg0uxy8wBnC8ica0OhbJR4c=
X-Received: by 2002:a62:d448:: with SMTP id u8mr43369684pfl.105.1549113081561;
 Sat, 02 Feb 2019 05:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com> <20190202061129.GB8158@shao2-debian>
In-Reply-To: <20190202061129.GB8158@shao2-debian>
From:   Florian La Roche <florian.laroche@googlemail.com>
Date:   Sat, 2 Feb 2019 14:10:45 +0100
Message-ID: <CANZrA2Y8oFaEkwGXPbD8uBTyROOqdQw9=+_fJz3XXA=kK4z9Tg@mail.gmail.com>
Subject: Re: [LKP] 32bd07585d: kernel_selftests.lib.prime_numbers.sh.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this test-result. That patch was only sent in on
linux-kernel@, but got never applied to
the kernel. Indeed the first half of the patch was wrong.

best regards,

Florian La Roche
