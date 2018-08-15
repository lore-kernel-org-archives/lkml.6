Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F74EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1590214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YxAibw+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1590214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeHOSNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:13:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36935 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbeHOSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:13:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so656240pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdFO8HrtTvVVRvzhqsKkBbc6IONvEHdXtfHyxm1hcMk=;
        b=YxAibw+eVX5SRm9JmL5WEF+gWXQp+wL66wEkh8nzKDBxIoQ5dhGU/aueLtbl/JKE/O
         MtGGmbH6rbQnYVaqd+Y+VBnaUs6atwxFrxh/SvgiYa/UzBSGs7LfvhICLqMfdyjPqbnn
         TukPKMxDJ3TCydQrwm2X4y9/wJpPRSLlexDvnuxOc1L9E2LccZN5q5y/VN3YZKfXwgaw
         npod/O9zdZiu0zPqQUAdW/t4qqHidVN6K0d/HzFK1oW/X5me+3HNHZcW3ck5EvbM3D5c
         X/e1oycYkDCvtr7VXBfyckEK55OtN5RoTTDF41CyxIM1xXCM1ccz5loha5H2Y/uU1L8G
         aRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdFO8HrtTvVVRvzhqsKkBbc6IONvEHdXtfHyxm1hcMk=;
        b=BWi3LLO3FClxCScgRsXj9jJ0lexRjgBOhNHdGmb0Zxgsz6hLgrkmA6QZtgY3lBHBip
         0l1r6dpH5CayBqnRUqTCoTXLTSt4Ydr6s+qdCgITIWdU4swYeehxaJPNANjIuB3aOvIX
         gnq03NDmvfBiWdVATPdFeG5DJXPW10XEl7HtyqZwOz3yca24hIuNxoqfEB5gc5wAfKUZ
         rm7ubBGGn6HsU0Qkm0U1JAfzb0/sTmVvdal/flN5Og4wpkxOfdTYyeAYhfKCpT1VNz8X
         SScWTQW8gqX2quLPYUh8axR7BJgDlaLDQgB1HT6F3m2858laMN6yuWyozKdhu/EhKeYF
         dhvA==
X-Gm-Message-State: AOUpUlHQdM0yLjoY/1aD9JvtSTsBe+mTxMXuJ4/2z16lyUxRIUYAV1MC
        4wy45miZTrxzJNffhD9+XIxFLA==
X-Google-Smtp-Source: AA+uWPzC+W9HlHMHgxMYUAsxZ6Tu0l4ztXV7gPlOI7vcZVEkFGK9SXvr7WJoQ93WMcXwVXwTJi0+Eg==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr26391504pgc.119.1534346477722;
        Wed, 15 Aug 2018 08:21:17 -0700 (PDT)
Received: from ?IPv6:2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f? ([2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f])
        by smtp.gmail.com with ESMTPSA id l71-v6sm37759339pgd.70.2018.08.15.08.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 08:21:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL 00/35] perf/core improvements and fixes
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Date:   Wed, 15 Aug 2018 08:21:15 -0700
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        Benno Evers <bevers@mesosphere.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        linux-trace-devel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>, stable@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Wang Nan <wangnan0@huawei.com>, x86@kernel.org,
        Yordan Karadzhov <y.karadz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA2DD2BE-2EBB-415A-9171-8CC90F3E7F31@amacapital.net>
References: <20180815150611.32080-1-acme@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 15, 2018, at 8:05 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Hi Ingo,
>=20
>    Please consider pulling, this is on top of
> perf-core-for-mingo-4.19-20180809, that is not yet in tip.
>=20
> Thanks,
>=20
> - Arnaldo
>=20
> Test results at the end of this message, as usual.
>=20
> The following changes since commit 6a9405b56c274024564f9014bba97b92c91b34d=
6:
>=20
>  perf map: Optimize maps__fixup_overlappings() (2018-08-08 15:56:00 -0300)=

>=20
> are available in the Git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-co=
re-for-mingo-4.19-20180815
>=20
> for you to fetch changes up to 6855dc41b24619c3d1de3dbd27dd0546b0e45272:
>=20
>  x86: Add entry trampolines to kcore

I don=E2=80=99t object per se, but once I finish rebasing and testing my ent=
ry trampoline removal code, this will probably have to go.=
