Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58954C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D9A21723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUdKvhQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D9A21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeHCSwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:52:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53033 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHCSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:52:06 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so9201921itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WvGZvgDARZpI8mXGcviTmQkVEgmINSsJtf4vTyDN+kM=;
        b=uUdKvhQVGGsJuKdHh4hL4cwIg3KePgDITLNsG3H4MZIgzpyBgs0nRmWeDBNTIskAwB
         5EKL3U1C7JKZPecOIHdK5YMIYi4h28I5DWgOkpokWnxBW+eSzb3QsFtX2A0AKeJeoczz
         evaxU5o6IUmM4DqWx75WjuDG4xO+q9htTFq4TfVNQfPi2QrF+87rvyadNVW1OfPHdgzm
         1J9JNSsqzA8HGZFEFg/PDxoUem3WaL7U0dpVHfGCWNYkGw7msJbWUmvzCszYcUM4iwpX
         mKyU2Bd+DqO0GjXdIXigzrSpkWNi7UhheJCNZta3MnEQ27BVIfgNj2gL5OS9uz+Gtys6
         f3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WvGZvgDARZpI8mXGcviTmQkVEgmINSsJtf4vTyDN+kM=;
        b=CJg77ke7vxsEJZF9J95d/A+eK/OydN3DDhuDEt5Bl8RlYvs5vUnDjRZ988pNFU3Att
         XfW/0zmDzXZA79ypOOCR3ZZvVlZ/z6ceyz3+bmuhq25H5kBSjdBp0+BchKdCSgXwCPxN
         CI5NvlkU52wfF9FFsOZk48CpzT04zHueDXtdh8iYxtN7aGCCJPSxodH/HZHLXi+S3+St
         DSAeD53m6ilJRXiyqQMi9EqarogtKTjfpqjeau5+7xvJ4XLabrVwZ7IxUTBKR20iaVZ+
         TTCje0NX1Ef4mfPxcb5xCsaSTMeG4ATP0vp1bESlxz+9D0kwGQQxVJlmSjTAfE292sGs
         LK4g==
X-Gm-Message-State: AOUpUlF2DjWik/1ZySAc0kQUcrz0VLClnMMDoVEwfACPPpfAevFCZCft
        HqJ6vWlTG8rVLo6O8bHIKEjvDNrdHIgrXM33bxb6jQ==
X-Google-Smtp-Source: AAOMgpdkoZuILngtU3LsjnN6d6dD1d9SFo2jwbOgFOAUEAWXblwPXqf+goQAsk3cWmbxeo9syCZoK8RpupAD0rBXjX8=
X-Received: by 2002:a24:22cf:: with SMTP id o198-v6mr7114718ito.53.1533315298287;
 Fri, 03 Aug 2018 09:54:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 09:54:57 -0700 (PDT)
In-Reply-To: <20180803164337.GB4718@bombadil.infradead.org>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
 <20180801174256.5mbyf33eszml4nmu@armageddon.cambridge.arm.com>
 <CAAeHK+zb7vcehuX9=oxLUJVJr1ZcgmRTODQz7wsPy+rJb=3kbQ@mail.gmail.com>
 <CAAeHK+xTxPhfbVTNxcbsx7VdwQ21Bt-vo2ZU1tEM1_JX7uKnng@mail.gmail.com>
 <20180803150945.GC9297@kroah.com> <20180803164337.GB4718@bombadil.infradead.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 3 Aug 2018 18:54:57 +0200
Message-ID: <CAAeHK+zqVTOSFD5yZ0E5Z3HZPVn8KYQJMGjBvin8rEfugBdfag@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 6:43 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Aug 03, 2018 at 05:09:45PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, Aug 03, 2018 at 04:59:18PM +0200, Andrey Konovalov wrote:
>> > Started looking at this. When I run sparse with default checks enabled
>> > (make C=1) I get countless warnings. Does anybody actually use it?
>>
>> Try using a more up-to-date version of sparse.  Odds are you are using
>> an old one, there is a newer version in a different branch on kernel.org
>> somewhere...
>
> That's not true.  Building the current version of sparse from
> git://git.kernel.org/pub/scm/devel/sparse/sparse.git leaves me with a
> thousand errors just building the mm/ directory.  A sample:

I'm running the one from https://github.com/lucvoo/sparse-dev which
seems to be even more up to date. Defconfig on x86 gives me ~3000
warnings:

https://gist.github.com/xairy/8adace989f64462e18ffb5cb7d096b73
