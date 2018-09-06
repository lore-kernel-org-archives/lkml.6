Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F297C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A3B20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgLl2OV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A3B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeIGArN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:47:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40383 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbeIGArN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:47:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so12698206wrw.7;
        Thu, 06 Sep 2018 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=azRF1WvAQn/lvao9BXqVwgS0phzVglVTMRxN6ICDDVo=;
        b=QgLl2OV8BJYRksZ4XbiXKSF3MSN1pOo8EfHkUhRxYuUAuFy4ccb5lSzEQY7/msp8WM
         oobbrzDh/7hgHdJicjaHM/Esc5VLS4RsAbvmfECByJsPYiwHMzwMilRuCqJe2cuKaUM8
         mfffJS+79f2esrh+zUNezhNXmCZAOZ1uyRZgI1rfNnIqIfU1HK5kFKI4cmP0fdJLiTUL
         9nNIL5nep7jFUPmimYxOJn+Ypr0ZGEgVL4jODNHz39+P3u0VFTICzcGkyq3oDsbnlNUd
         A40dvwSb5GjVkGa2MrCeEJ0NSHdMpdHLhOVzwjr4uHP69axSLAxh+69E48yRTPm4+1rp
         BDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=azRF1WvAQn/lvao9BXqVwgS0phzVglVTMRxN6ICDDVo=;
        b=QcvUtSqQLNPuX2o6EDGWO21765/NOcrrDKc0EG59YHUtckzbA4IeEZAYcIgw4dDKNU
         UxFEEq9d7MS/91fmluoZWXjUflU/FyJcfVFh1+SvrMZWRMKHTozZeeLfP9CPAPtGm3Pm
         iHZvVDmsVJ0j3Gyp0OS98ALw67EN25zlrsedWidmskY0+Cf9N4lfo11eoZ1PXO+X6C+G
         vfwHFd78GoYowiMKA6195wSV3Yh0JYU+ZXCfvj++Dz0YsgoNVbmOfFdTXeiik3Bf9ppW
         9zqbd7G2EPqcGBi1BuPXTEDZmDiCfYtVJCEpU1jYxbZr41/nbug8H6T1R/qRBnuamKk7
         XcOQ==
X-Gm-Message-State: APzg51Av6O9tbf+Yec7DdY+CYMo6OFJXYCpjY95784bhvXC4BCEb0JIB
        m+5swUi2YNUq/S3rOUmtAWA=
X-Google-Smtp-Source: ANB0VdY6IchvSUoqOF1vIASQQmQW+yBbCZUcq+EOZWzJPoehNOQRE1JXhV6qG7mH48xaRRVeSXDb8A==
X-Received: by 2002:adf:e211:: with SMTP id j17-v6mr3951445wri.205.1536264607064;
        Thu, 06 Sep 2018 13:10:07 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:f830:4b56:d713:5075])
        by smtp.gmail.com with ESMTPSA id b144-v6sm7294198wmd.23.2018.09.06.13.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:10:06 -0700 (PDT)
Date:   Thu, 6 Sep 2018 22:10:04 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Message-ID: <20180906201003.54bqs7sacynt5uyq@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local>
 <20180831134244.GB19965@ZenIV.linux.org.uk>
 <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
 <01cadefd-c929-cb45-500d-7043cf3943f6@arm.com>
 <20180903151026.n2jak3e4yqusnogt@ltop.local>
 <a31d3400-4523-2bda-a429-f2a221e69ee8@arm.com>
 <20180905190316.a34yycthgbamx2t3@ltop.local>
 <5074b9b6-2b8d-c410-f908-b4c17dacbb2c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5074b9b6-2b8d-c410-f908-b4c17dacbb2c@arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:13:16PM +0100, Vincenzo Frascino wrote:
> On 05/09/18 20:03, Luc Van Oostenryck wrote:
> > I think that at this point, it would be nice to have a clear description
> > of the problem and what sort of checks are wanted.
> >
> 
> 
> The problem we are trying to address here is to identify when the user pointers
> are cast to integer types and to sanitize (when required) the kernel, when this
> happens.
> 
> The way on which we are trying to address this problem based on what Andrey
> proposed in his patch-set is to use the Top Byte Ignore feature (which is a 64 bit
> specific feature).
> 
> Based on what I said I think that we require 2 'modifiers':
> - __compat (or __compat_ptr) used when the kernel is dealing with user compat 
> pointers (32 bit, they can not be tagged). It should behave like force
> (silence warnings), but having something separate IMO makes more clear the
> intention of what we are trying to do.
> - __tagged (or __tagged_ptr) used when the kernel is dealing with user normal
> pointers (which can be tagged). In this case sparse should still be able to trigger
> a warning (that can be disabled by default as I was proposing in my previous email).
> When we put a tagged identifier we declare that we analyzed the code impacted by
> the conversion and eventually sanitized it. Having the warning still there allows us
> or whoever is looking at the code to always go back to the identified issue.  

OK. Thanks for the explanation.

So, the way I see things from a type checking perspective, is that
'being (potentially) tagged' is a new property of values, othogonal
the the concept of address space. Leaving the other address spaces
(__iomem, __percpu & __rcu) aside, it should be possible to have
__user & __kernel tagged pointers as well as tagged ulongs:
	__user __tagged *
	__kernel __tagged *
	ulong __tagged
in addition of the usuals:
	__user *
	__kernel *
	ulong
But some of them are banished or meaningless:
	__user *            (all __user pointers are potentially tagged)
	__kernel __tagged * (tags are only for user space)
	ulong __tagged      (pointers need to be untagged during conversion)
So, only the followings remain:
	__user __tagged *
	__kernel *
	ulong
and the property '__tagged' becomes equivalent to '__user'.
Thus '__tagged' can be implicit and this would have the advantage
of not needing to change any annotations.

Since the conversion '__user *' to '__kernel *' is already covered
by the default sparse warnings, only the conversion '__user' to
'ulong' need to be covered (and this is already covered by the new
option -Wcast-from-as) but that is only fine for detection. After
detection and auditing, several solution are possible:
1) simply add '__force' in the cast (this is very bad)
2) moving this '__force' inside a macro '__untag_ptr(x)' would already
   more acceptable but is fundamentaly the same as 1)
3) a weaker form of '__force', '__force_as', will do the trick nicely
   as long as __user is equated to __tagged (and could be useful on
   its own but could also hide real AS conversion problems).
4) a more specific solution would be to effectively add a new attribute,
   '__tagged', to define '__user' like:
	#define __user attribute((noderef,address_space(1),tagged))
   and have something like '__untag', a weaker form of __force meaning:
   "I know what I'm doing regarding conversion from 'tagged'". 

Neither 3) nor 4) should be much work but while I firmly think that
4) is the most correct solution, I'm not sure it's worth the added
complexity, certainly if KHWASAN is not meant to be upstreamed.

For the compat pointers, I'm less sure to understand the situation:
even if they can't be tagged, treating them as the other __user
pointers will still be OK (but I understand that it could be
interesting to be able to track them, it's just that it's independent
from the __tagged property).


-- Luc
