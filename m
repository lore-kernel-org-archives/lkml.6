Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED2120859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUnKh8UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfBTSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:45:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48572 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBTSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:45:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KIYINx006799;
        Wed, 20 Feb 2019 18:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6QdK9boB/GprqfvOOeLbljG89BjD1NPQ8GkF2zwBFnw=;
 b=DUnKh8UH2y8hARzAXu7lVsNV6Zh3/QVkPUwULHEDg0xrLUWgDGVXRVFrNm0ZaYgTlIzp
 C7Db1sPEROEe1yNLa7DZMIdiTBKZkONPjoAph59Q12GQYjNuIsWcotJQJPou7x+UFI0X
 jUr40p6Z96AWLxv22Pfu8wwBuWKBLJHUJEcm6tedln7B8fRugHXVMMV0TExrI6C1nfeF
 sPfVhHdpO4r954lFVD6OIti4NiP9IJ/Tznhw0ZG6pIsEJYe9h29Y+RQFd0wZp9M8j2ur
 wsakQNqU/NpuJTh0nx9CrKV4w46L3F/r+OLVphQtJd3GDdOzgColNcP+S2ZU711EW5Mc IQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81ebky1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 18:45:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KIjH9R013633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 18:45:18 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KIjHEB023687;
        Wed, 20 Feb 2019 18:45:17 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 10:45:17 -0800
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kerr <kerrnel@google.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, Paul Turner <pjt@google.com>,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org
References: <20190218165620.383905466@infradead.org>
 <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
 <20190220094255.GE32494@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <c1aedc4d-0821-95d0-8f50-cee6526e7779@oracle.com>
Date:   Wed, 20 Feb 2019 10:43:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220094255.GE32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/20/19 1:42 AM, Peter Zijlstra wrote:
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> On Tue, Feb 19, 2019 at 02:07:01PM -0800, Greg Kerr wrote:
>> Thanks for posting this patchset Peter. Based on the patch titled, "sched: A
>> quick and dirty cgroup tagging interface," I believe cgroups are used to
>> define co-scheduling groups in this implementation.
>>
>> Chrome OS engineers (kerrnel@google.com, mpdenton@google.com, and
>> palmer@google.com) are considering an interface that is usable by unprivileged
>> userspace apps. cgroups are a global resource that require privileged access.
>> Have you considered an interface that is akin to namespaces? Consider the
>> following strawperson API proposal (I understand prctl() is generally
>> used for process
>> specific actions, so we aren't married to using prctl()):
> I don't think we're anywhere near the point where I care about
> interfaces with this stuff.
>
> Interfaces are a trivial but tedious matter once the rest works to
> satisfaction.
>
> As it happens; there is actually a bug in that very cgroup patch that
> can cause undesired scheduling. Try spotting and fixing that.
>
> Another question is if we want to be L1TF complete (and how strict) or
> not, and if so, build the missing pieces (for instance we currently
> don't kick siblings on IRQ/trap/exception entry -- and yes that's nasty
> and horrible code and missing for that reason).
I remember asking Paul about this and he mentioned he has a Address Space
Isolation proposal to cover this. So it seems this is out of scope of
core scheduling?
>
> So first; does this provide what we need? If that's sorted we can
> bike-shed on uapi/abi.
