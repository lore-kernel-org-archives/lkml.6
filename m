Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EFEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C64214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JHI9YU5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C64214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeKUHd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:33:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52933 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeKUHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:33:57 -0500
Received: by mail-it1-f195.google.com with SMTP id i7so5583310iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vp6Z0D7r3DXpm/Nwbk3fBmqUeJLYAO2UFvzCZCOObKo=;
        b=JHI9YU5GhvfPIbVXI4VjY7u7qUvIMeg1MEu42P/NTDvupazXF+I5UWhyTsknuUsGVj
         ACqbnPGDnjAqdzonrrUgu7yEOx8uFUEPwjWSwG3DlMaMXbgqrRPKrK8dA1nfIlaWUuxo
         NZcfiBYjrX6gwEkquLyyzzUVfbh77AhiWIcsCSUMto156HERmZZ4Q1IMS7lQgMx3/Lbj
         XawDJpkdPeEu0rAH+eJPZMSLu6E6J/JCIt4vzfqPHW18TD4yAsvWHG2Lna+YSgPxgCfL
         ZV5UQjXlMqDDczlXPTP+9J60tcQtXHPi2aQrI/mUkFYvRxWKFq8jUkiD9WK2R/6rU4BL
         GRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vp6Z0D7r3DXpm/Nwbk3fBmqUeJLYAO2UFvzCZCOObKo=;
        b=fx5MAEl0w/QKrmfw/+A8EwIjEueBxa24trKzMdNRfudCLHvruL1ZgYnh/LJmBCW/7G
         wgTKIHfglZNsSeEb5ELjZ81tPIlynR1rIEfx+KaoEgNDjtnJmsPlRNWnjKqq2k/0C0TE
         CBGLKxgKzFBr/+pC3h07Uz90b7rVlSQ1jIRgXHQWNTvZjx4gGVR5KWRDJNzHTUMspHMs
         84iHVnC9GGBkdgbMEKbAjclql+87chibs4A/bbrmowqHXQV5J8iqX6cZo322lVDqQ8DD
         cobCrws16uy4AZ1BsVFwl+15y/bcTcIz2nCRWDgUyxbtbM3AoufOusk1P6xM5vyCR1Jw
         TzGQ==
X-Gm-Message-State: AGRZ1gJ1LvFQ+moSaXxdTzyYi13wg2TXxlA1dQ8VmW/kIUdD86PJbjRg
        doxSq2cNsZxVdOvjzSk9FlgJsA==
X-Google-Smtp-Source: AJdET5cSJgIwPeWUmsdRDYtAPxmlPfzj26dqKDJ3eya3zIXBVO0CwwflbcA0fpXQu+O3Kwc4lnAYVQ==
X-Received: by 2002:a24:c187:: with SMTP id e129mr3975357itg.68.1542747771629;
        Tue, 20 Nov 2018 13:02:51 -0800 (PST)
Received: from ?IPv6:2600:100e:b040:b126:ec78:48dd:44e2:e165? ([2600:100e:b040:b126:ec78:48dd:44e2:e165])
        by smtp.gmail.com with ESMTPSA id p10-v6sm14075913ioh.20.2018.11.20.13.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 13:02:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more robust
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181120204710.GB22801@google.com>
Date:   Tue, 20 Nov 2018 14:02:49 -0700
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8E28229-C99E-4711-982B-5B5DE0F70F16@amacapital.net>
References: <20181120052137.74317-1-joel@joelfernandes.org> <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com> <20181120183926.GA124387@google.com> <20181121070658.011d576d@canb.auug.org.au> <469B80CB-D982-4802-A81D-95AC493D7E87@amacapital.net> <20181120204710.GB22801@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 20, 2018, at 1:47 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
>> On Tue, Nov 20, 2018 at 01:33:18PM -0700, Andy Lutomirski wrote:
>>=20
>>> On Nov 20, 2018, at 1:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>>>=20
>>> Hi Joel,
>>>=20
>>>>> On Tue, 20 Nov 2018 10:39:26 -0800 Joel Fernandes <joel@joelfernandes.=
org> wrote:
>>>>>=20
>>>>> On Tue, Nov 20, 2018 at 07:13:17AM -0800, Andy Lutomirski wrote:
>>>>> On Mon, Nov 19, 2018 at 9:21 PM Joel Fernandes (Google)
>>>>> <joel@joelfernandes.org> wrote: =20
>>>>>>=20
>>>>>> A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last we=
ek
>>>>>> where we don't need to modify core VFS structures to get the same
>>>>>> behavior of the seal. This solves several side-effects pointed out by=

>>>>>> Andy [2].
>>>>>>=20
>>>>>> [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
>>>>>> [2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74=
@amacapital.net/
>>>>>>=20
>>>>>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>>>>>> Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd") =
=20
>>>>>=20
>>>>> What tree is that commit in?  Can we not just fold this in? =20
>>>>=20
>>>> It is in linux-next. Could we keep both commits so we have the history?=

>>>=20
>>> Well, its in Andrew's mmotm, so its up to him.
>>>=20
>>>=20
>>=20
>> Unless mmotm is more magical than I think, the commit hash in your fixed
>> tag is already nonsense. mmotm gets rebased all the time, and is only
>> barely a git tree.
>=20
> I wouldn't go so far to call it nonsense. It was a working patch, it just d=
id
> things differently. Your help with improving the patch is much appreciated=
.

I=E2=80=99m not saying the patch is nonsense =E2=80=94 I=E2=80=99m saying th=
e *hash* may be nonsense. akpm uses a bunch of .patch files and all kinds of=
 crazy scripts, and the mmotm.git tree is not stable at all.

>=20
> I am Ok with whatever Andrew wants to do, if it is better to squash it wit=
h
> the original, then I can do that and send another patch.
>=20
>=20

=46rom experience, Andrew will food in fixups on request :)=
