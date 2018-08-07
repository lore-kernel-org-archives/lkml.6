Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EC9215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8ABZ0r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EC9215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbeHGMEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:04:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39259 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHGMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:04:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so17465871wmq.4;
        Tue, 07 Aug 2018 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t9p4dSe0q0IuPiRy8z5xwkp4yh58XbAfB1p7MAgAdR0=;
        b=E8ABZ0r1g+qRzyLVy9Xf/A6253K0ss6nhoAXxM+FO/tBzStW34fjl427zfoWBLyiXw
         Xqr+1+KgGa49Q7dzjAkY0++mC+I/7b7NY0e50l62yd1m1s18eKi2MGWEBP471VuEjlfR
         Ow9XTPR+iOz/Xj4JqP8GPT1QJ+/j8/tTeX7ki5EyncYjoqMqdqZJdyW7yhSp4O35prpD
         P67NkUpHxcQ7Gk5pUcQbY5d3vEkI1BNCB5kPwdFcMbGXQ1Dc6s7XEKTNTE57PkJqkSk7
         YhQeLuPsNiljNSMjN3EGgW4BqbhJu0Yu2kkWjC36FnofrywBQOvXv4nCijKm1AD9YD2G
         PFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9p4dSe0q0IuPiRy8z5xwkp4yh58XbAfB1p7MAgAdR0=;
        b=ej2CXBntQ2IfwH+NNWxb/8ob7xsaJ5ITTuSYz6piqyJ1czCdKeKFZPpDdlORdFzHTK
         XI+NI2+BwyKKriXw4N3ju993G4u3A78gVOA+ghocjk8C4Qx82oZhjrs1EpiQ0T2gYMU4
         zZCOcypOTWTcV/1l3CBjTpbSyRe2ygBP8MwgsNsQeysOTXUihLWJFrQr/vt8ssiLCKQs
         xY9FG4ewwDnhmZSrokwrM/XiLSz5va0bfxOk2nLoathgjwFsVSBaQgz/Dc2bugcBhzYC
         9dXYWk4WK69VAyA2EwI4lz8OtN5X5vhKD/FN10ujkkxBMRjEuR2iTc/Hqp6mtYqEL5su
         PnlA==
X-Gm-Message-State: AOUpUlGSd/Uy61bxPHxZ9dBuibPH9o1jzTOO79HRJOcAjbRdm4eq1zrB
        J9lVP20i4EPbtfOplrSVi+O4FEKQ
X-Google-Smtp-Source: AA+uWPxB+RMlh+D3alEkZBtEwBJDlx7GI8Ttz3Mk6OQhNZaIQ6bOyBUm7/pE0grX0OdbIY8OZFerCw==
X-Received: by 2002:a1c:96c8:: with SMTP id y191-v6mr1149732wmd.37.1533635432935;
        Tue, 07 Aug 2018 02:50:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f23-v6sm825487wmc.42.2018.08.07.02.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 02:50:32 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:50:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] xen/pv: Call get_cpu_address_sizes to set
 x86_virt/phys_bits
Message-ID: <20180807095029.GA4921@gmail.com>
References: <20180721194909.23903-2-m.v.b@runbox.com>
 <20180724124547.32562-1-m.v.b@runbox.com>
 <7c07bb2f-e825-66bf-f517-86f893cd9e8b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c07bb2f-e825-66bf-f517-86f893cd9e8b@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:

> x86 maintainers, this needs your ack please.

LGTM:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
