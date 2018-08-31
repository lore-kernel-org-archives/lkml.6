Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17A52083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="QiMwputa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17A52083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHaF2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:28:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38919 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHaF2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:28:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id g20-v6so4684191pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1F2bt/QS4kUTSdQXENMmlBXZ8A8HW7T9eMb02IEllCQ=;
        b=QiMwputaxxOXP3OzLmmGf+q8Fkx2Oig9kYN9AyUndmS5Nd1Oiz00ciExwtXcfWEOWH
         kaCrlpZtezeN6wxEwm31gGdThaY5IfX7xDrS6ypGvhRBW4uYvWOt9PcgabZbkdXvxmx4
         3KTp+dOZXMDNUr5HcMJvaluiDlx/9KynGTrgvMcVurIwpJ+1eFhhWMlg/hMrY9f8tHKw
         f3ASRSv+s0wy+fna8zs1dE29CQ5Cu5Eu5f11PJSrDfbUCtkXnoTFuY8dhlVWD0Cr1uQS
         oYR55HAwKEAxSMV1CDJf4CLrRnNBF+bf+2TXI24fQmuMR+/0Lf+hM20ipQtCTyf0o6zs
         tAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1F2bt/QS4kUTSdQXENMmlBXZ8A8HW7T9eMb02IEllCQ=;
        b=rcDB7uPZ2LYPJuwC7RDG4fv/U623wD3PLefOTF2N7PTKr+knpI/DiYWzy5+dchl/yU
         u5F4X7UTFzmlWQ+0MwdvY6hC25ROEpHH0qcggsE45Ic57gJM2aPndqdOqfwaRapQi9Az
         uPk/YJ2gheggJjo7pgFuwDDM2WMGU8X/cHfdMANJp1A2Oqh+HLW1eqarWxbC/4W3qbOr
         3/pS3f9XyPNw+QTpvEP5MsI/jtqoCwA6Sv0GoDqEvc85CLO1SfIXMu9B+lidcmOIft33
         JMUJz44xrJlwocF+5To0cm1Fd6NPUHZcN+2JPv88P6mi019lSaMDpyuYT3GogDOgYdkz
         lYyg==
X-Gm-Message-State: APzg51DdRId7zgFCgEDN31WArfVAs8z5g3rxpC0shv+eXEuFTiCfF11t
        GjqGSBeCe/F+Qdnj5iMmjg8oEA==
X-Google-Smtp-Source: ANB0VdZXf3nwRYcJA8jotm8G5HRdky8SEzYTTJHb+dE2Y4CvfuVuXGv9PiMQ3HhPsvC6pb+qOCfzyw==
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr13201129pff.199.1535678598106;
        Thu, 30 Aug 2018 18:23:18 -0700 (PDT)
Received: from ?IPv6:2601:647:5803:15b9:5944:9b2e:c060:74c3? ([2601:647:5803:15b9:5944:9b2e:c060:74c3])
        by smtp.gmail.com with ESMTPSA id t21-v6sm13621663pfi.73.2018.08.30.18.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:23:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAG48ez3ixWROuQc6WZze6qPL6q0e_gCnMU4XF11JUWziePsBJg@mail.gmail.com>
Date:   Thu, 30 Aug 2018 18:23:15 -0700
Cc:     yu-cheng.yu@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <337F9DA7-ED07-4CD0-B41C-22D570527362@amacapital.net>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com> <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com> <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com> <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com> <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com> <1535649960.26689.15.camel@intel.com> <33d45a12-513c-eba2-a2de-3d6b630e928e@linux.intel.com> <1535651666.27823.6.camel@intel.com> <CAG48ez3ixWROuQc6WZze6qPL6q0e_gCnMU4XF11JUWziePsBJg@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2018, at 10:59 AM, Jann Horn <jannh@google.com> wrote:
>=20
>> On Thu, Aug 30, 2018 at 7:58 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote=
:
>>=20
>>> On Thu, 2018-08-30 at 10:33 -0700, Dave Hansen wrote:
>>>> On 08/30/2018 10:26 AM, Yu-cheng Yu wrote:
>>>>=20
>>>> We don't have the guard page now, but there is a shadow stack
>>>> token
>>>> there, which cannot be used as a return address.
>>> The overall concern is that we could overflow into a page that we
>>> did
>>> not intend.  Either another actual shadow stack or something that a
>>> page
>>> that the attacker constructed, like the transient scenario Jann
>>> described.
>>>=20
>>=20
>> A task could go beyond the bottom of its shadow stack by doing either
>> 'ret' or 'incssp'.  If it is the 'ret' case, the token prevents it.
>> If it is the 'incssp' case, a guard page cannot prevent it entirely,
>> right?
>=20
> I mean the other direction, on "call".

I still think that shadow stacks should work just like mmap and that mmap sh=
ould learn to add guard pages for all non-MAP_FIXED allocations.=
