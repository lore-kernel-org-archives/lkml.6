Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66520C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64A02077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fr0KT5eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64A02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeIGO16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:27:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36633 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeIGO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:27:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180907094742euoutp011daf1a1678a6ab67be8bc256bff50ecd~SFSLpBIR72206622066euoutp01y
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 09:47:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180907094742euoutp011daf1a1678a6ab67be8bc256bff50ecd~SFSLpBIR72206622066euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536313662;
        bh=wAOWE2x7k7FLF6acw7Ub90DRce9Ebzpy5wLdn7hlf+8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fr0KT5eKbZzvqLzt3OUYmgPqinqhJrXQ8sssXyF1DvaG02AKZRJAN8+CpYq/cpGNR
         8ZH3QpRPOs8cwIYFPUdirvwkKAVPGp/xrszlO2LZEKEXgpWxiyCVWA7PzzLZcEveH4
         JXfjeWUC2KXjeJ5RqppOjXelKNg40+oXsKxHmgIo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180907094741eucas1p2bbfae4b86efbe2e67ba581860fa554d2~SFSK54SNP1603816038eucas1p2z;
        Fri,  7 Sep 2018 09:47:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.F1.04294.D39429B5; Fri,  7
        Sep 2018 10:47:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180907094740eucas1p10389694601d4d8f62bee71bb489922b2~SFSKD3ZrN0052200522eucas1p19;
        Fri,  7 Sep 2018 09:47:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180907094740eusmtrp21d48a94b408e7e58b5573c217e0166f2~SFSJzPpdW0719107191eusmtrp2a;
        Fri,  7 Sep 2018 09:47:40 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-43-5b92493dca91
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.17.04128.C39429B5; Fri,  7
        Sep 2018 10:47:40 +0100 (BST)
Received: from amdc2143 (unknown [106.120.53.33]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20180907094740eusmtip2949fb30c3605ac7de591ffd5fe6016cb~SFSJhp9Xd1684016840eusmtip2C;
        Fri,  7 Sep 2018 09:47:40 +0000 (GMT)
Subject: Re: Fwd: Smack: wrong-looking capable() check in
 smk_ptrace_rule_check()
From:   Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Sep 2018 11:47:39 +0200
In-Reply-To: <2fafaca2-73c4-d344-98be-089e17e95055@schaufler-ca.com>
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7q2npOiDa5NlLK4t+0Xm8XlXXPY
        LD70PGJzYPY4un8Rm8fnTXIBTFFcNimpOZllqUX6dglcGRduv2Qt2ChQsW5GO2sD42aeLkZO
        DgkBE4mHj9tZuhi5OIQEVjBKbH80iw3C+cIo8f3PAWYI5zOjxJJL99lhWqZv7IFKLGeUmHfv
        GpTzjFFi6qWNrF2MHBzCAsESr54ZgTSwCRhIfL+wlxnEFhHQkdi35znYIGaBfImp914ygZSz
        CKhKPH9qARLmFHCR+H71IBPELm2Jffc/soCU8AoISvzdIQzRKS+x/e0csK0SAq/ZJFavvws2
        nlegTOL036VsEL0uEpv/3WSBsIUlXh3fAnW/jMT/nfPB1koIVEu0nSiEmNPBKHFucjNUr7XE
        50lbmEFqmAU0Jdbv0ocIO0rcOXKJDaKVT+LGW0GIc/gkJm2bzgwR5pXoaBOCqFaVeL1nNiOE
        LS3x8c9eqAM8JOYuuss2gVFxFsJfs5D8NQth7QJG5lWM4qmlxbnpqcVGeanlesWJucWleel6
        yfm5mxiByeH0v+NfdjDu+pN0iFGAg1GJh/eB0cRoIdbEsuLK3EOMEhzMSiK8/MaTooV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInz8mmlRQsJpCeWpGanphakFsFkmTg4pRoY2+RCZ7gt/bJTb/6t
        HatOq68Vnl/37X2I6aJDwff+WxxnfLT5mFeqz4G7bUtu8MdFdbNN9LbcsGvfsqbU42Z2sWmX
        i2crVfxwmXIoYNafOZYOmoYLa07tnfhqxzQlo5P86Z8ZG/3EgkPe3Cv7OFPodeRpIZts3m0b
        eV4/O6EV/myl5aZHJznuJSuxFGckGmoxFxUnAgBiIWqlCgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t/xe7o2npOiDZouylnc2/aLzeLyrjls
        Fh96HrE5MHsc3b+IzePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jAu3X7IWbBSoWDejnbWBcTNPFyMnh4SAicT0jT3MXYxcHEICSxkl
        dp/8zAiRkJY4fmAhK4QtLPHnWhcbRNETRon+FQ+AEhwcvAIeEutfhICYwgLBEq+eGYGUswkY
        SHy/sJcZxBYR0JHYt+c5O4jNLJAvMfXeSyaQchYBVYnnTy1AwpwCLhLfrx5kgpj+mFHifvMB
        Roh6TYnW7b/ZIU7Qlth3/yMLxFZBib87hCFK5CW2v53DPIFRcBaSjlkIVbOQVC1gZF7FKJJa
        WpybnltspFecmFtcmpeul5yfu4kRGPbbjv3csoOx613wIUYBDkYlHl4L04nRQqyJZcWVuYcY
        JTiYlUR4+Y0nRQvxpiRWVqUW5ccXleakFh9iNAV6ZyKzlGhyPjAm80riDU0NzS0sDc2NzY3N
        LJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MG4TjYzV/HV3F8sKQ3NZ1riminW3tK+oTKtL
        1gtcIdhv7WzMY8aUl/3vDcesb+7zFqt0fYuzjCuRvubftLm2jcd158n6E27rF3nNPbHShOnw
        7cWOu3Iuz1pQsIu/3trr8MbOFVU2dcpiNpKFr0WZ6qTfdc6pcNXg27HVqH3TvvzjzvrRauus
        lFiKMxINtZiLihMBqldFPZECAAA=
Message-Id: <20180907094740eucas1p10389694601d4d8f62bee71bb489922b2~SFSKD3ZrN0052200522eucas1p19@eucas1p1.samsung.com>
X-CMS-MailID: 20180907094740eucas1p10389694601d4d8f62bee71bb489922b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180906185359epcas4p249c16d651266a1cb8ee8273a6daff3a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180906185359epcas4p249c16d651266a1cb8ee8273a6daff3a5
References: <CAG48ez0nCC0_on95q7x_8cwSyJ8ATReA0ysDnEr=CW2tkqE=7w@mail.gmail.com>
        <CGME20180906185359epcas4p249c16d651266a1cb8ee8273a6daff3a5@epcas4p2.samsung.com>
        <2fafaca2-73c4-d344-98be-089e17e95055@schaufler-ca.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2018-09-06 at 11:53 -0700, Casey Schaufler wrote:
> Lukasz, does this analysis seem correct to you? This is code you
> wrote in 2014.

It seems correct.
Moreover I've sent a patch that fixes this bug long time ago with the
namespace series.

https://lists.linux-foundation.org/pipermail/containers/2015-October/036318.html

Not sure this is the latest version. The latest I ever wrote can be
found here:
https://github.com/Havner/smack-namespace/commit/52d6e4be2db51e9aca53e0e112a7ff9625000994

Without namespaces, parts of this patch are probably irrelevant, but it
does fix this bug and one or two similar elsewhere.

Best regards,
Lukasz



> 
> -------- Forwarded Message --------
> Subject:	Smack: wrong-looking capable() check in
> smk_ptrace_rule_check()
> Date:	Thu, 6 Sep 2018 20:22:35 +0200
> From:	Jann Horn <jannh@google.com>
> To:	Casey Schaufler <casey@schaufler-ca.com>
> CC:	linux-security-module <linux-security-module@vger.kernel.org>,
> kernel list <linux-kernel@vger.kernel.org>
> 
> Hi!
> 
> I noticed the following check in smk_ptrace_rule_check():
> 
>                 if (tracer_known->smk_known == tracee_known-
> >smk_known)
>                         rc = 0;
>                 else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
>                         rc = -EACCES;
>                 else if (capable(CAP_SYS_PTRACE))
>                         rc = 0;
>                 else
>                         rc = -EACCES;
> 
> Note that smk_ptrace_rule_check() can be called from not just
> smack_ptrace_access_check() and smack_ptrace_traceme(), but also
> smack_bprm_set_creds(). AFAICS this means that if a task executes
> with
> a smack privilege transition and smack_ptrace_rule is
> SMACK_PTRACE_EXACT, whether the execution is permitted depends on
> whether _the debugged task_ has CAP_SYS_PTRACE (and not on whether
> the
> debugger has that capability).
> This seems like it's probably unintentional?
> 
> 


-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics



