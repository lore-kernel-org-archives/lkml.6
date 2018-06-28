Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6326F9E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh7maeiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB6326F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeF1GSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:18:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36041 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeF1GSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:18:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id t3-v6so4437205eds.3;
        Wed, 27 Jun 2018 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUtMrg8N0KzkoFGndvfU+Uh3gV6eJJBxlHd2ncQ5Mh8=;
        b=eh7maeiFQWnT4zPf8keKMuse4+qjQW5cadgn+b4VFUjD5UrLHnvan0aYt/eBct90o7
         eTl9fYEfwFDlqIBalI7S6NUmYhwxLW81+rCx73BHaygrlQLINrhK+FTytUwEyxfiw9ou
         Dzh9ZKx1PdS9RZ6tZs0qVCbqLnUJ3Gje1zZ7vGPG3wZit2bdk0ZVxerCTNvMyIN8FF+P
         nJJD+5+0FVndagUXzcynWHRQFlajbOikFID7l6q8qMSeVuNciOfR4lpjmYEbjrGLk2Dz
         DHtndMLBkQI0nXNQGRffbOdxkFf65J3QAKoCcfaq5nQJa87kJmVKC3zKdqwt2WSKIdeT
         0BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUtMrg8N0KzkoFGndvfU+Uh3gV6eJJBxlHd2ncQ5Mh8=;
        b=nIO5JvzBSpn1xClSVQAVJTpozoE23Bkc3rhEVKqJ9w2wIIQs3Rx7+4l8zet2QhD4G+
         oXG4gEJBmazojk6mCqlTjl3tcXw0k091iBk3PPg9JCMw6b3U1fjv4Th/D18KFF7qAdom
         +iitBEfSwRBJWMQq/psiMlr+XSiZw+/eZwGeg1EfZUJoKNbcmWEdEFIMIrXLAl8tSGgo
         UV4dlRHyLQbOqE3iOx3rDIRZKZZ9jmi5p5YWLrCu0B1p8WX0JP2Otg9qfwWirNs2Au3m
         wH2ygO0WRHCINf7S42ukRlIUWD916Fh6MJ1Juj6mJXJFT3z9ghbzn3dbkZGS4+tnglGL
         3VgA==
X-Gm-Message-State: APt69E2fCSBRKFhW2cmiOus02PighkDbVlJgoB0mj/qvdVN8J1rgWnc+
        QxQqG6ekoen6duQ9pQRsMN4=
X-Google-Smtp-Source: AAOMgpc+TXYAF2+7RMkYqLA7j0IYXbHQYPjnJVKaYHu6IrMoF8NsL3xbO/E4+HvJWaOiYw5yRQQvOQ==
X-Received: by 2002:a50:8d88:: with SMTP id r8-v6mr7486297edh.86.1530166681681;
        Wed, 27 Jun 2018 23:18:01 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40dc:3d00:cdc6:6da5:5120:7634])
        by smtp.gmail.com with ESMTPSA id t3-v6sm2564361edq.50.2018.06.27.23.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 23:18:00 -0700 (PDT)
Date:   Thu, 28 Jun 2018 08:17:59 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180628061758.j6bytsaj5jk4aocg@ltop.local>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> 
> sparse is indeed an option. The current implementation doesn't warn on
> an explicit cast from (void __user *) to (unsigned long) since that's a
> valid thing in the kernel. I couldn't figure out if there's any other
> __attribute__ that could be used to warn of such conversion.

Hi,

sparse doesn't have such attribute but would an new option that would warn
on such cast be a solution for your case?

-- Luc
