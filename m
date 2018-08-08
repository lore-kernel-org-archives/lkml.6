Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3FCC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EEC21729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DJpJlicn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EEC21729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHHMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:25:33 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41337 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbeHHMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:25:33 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180808100630epoutp03f820106a930e67dbc1ce0c55770aa595~I4MB6uLYN3145531455epoutp03E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Aug 2018 10:06:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180808100630epoutp03f820106a930e67dbc1ce0c55770aa595~I4MB6uLYN3145531455epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533722790;
        bh=EXV4VXfcpi30i6MoXtt3tigPMy12vR/lHajsqgZz0qA=;
        h=Date:From:Reply-To:To:CC:Subject:In-Reply-To:References:From;
        b=DJpJlicnbXLm3PDKDmmvxROBoPZ8ou+ZllG/kJ3mm111EiCHc6jXIhulXVTghfhXT
         R2geDlMgW+DdNneFhnVE82asyZ2tynFzofY7gjjEMLcDq73efda5gEPD6k6xnvykxu
         09gkhTXgVyDM7v0Bs62XQpi80YBe1xbyzpp3nXcI=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180808100625epcas1p31dfb8f3f61f2d002a32efe062b20806b~I4L9DtcAL2915229152epcas1p3d;
        Wed,  8 Aug 2018 10:06:25 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.D6.04176.F90CA6B5; Wed,  8 Aug 2018 19:06:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c~I4L612J9p0428204282epcas1p1X;
        Wed,  8 Aug 2018 10:06:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180808100622epsmtrp257a94e9d0482d9754bdc5fe1c94179d8~I4L60tX6I0072600726epsmtrp2W;
        Wed,  8 Aug 2018 10:06:22 +0000 (GMT)
X-AuditID: b6c32a37-6c5ff70000001050-01-5b6ac09fd572
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.6F.03889.E90CA6B5; Wed,  8 Aug 2018 19:06:22 +0900 (KST)
Received: from [10.113.63.222] (unknown [10.113.63.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180808100622epsmtip1a0eb1da9453c07f34c1d3d3b7ba29cb6~I4L6aQYoW1005410054epsmtip15;
        Wed,  8 Aug 2018 10:06:22 +0000 (GMT)
Date:   Wed, 08 Aug 2018 19:06:26 +0900
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-To: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
        Thunderbird/16.0.1
MIME-Version: 1.0
To:     Al Viro <viro@ZenIV.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: Re: Linux 3.18.111
In-Reply-To: <20180705005205.GC30522@ZenIV.linux.org.uk>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmru78A1nRBs93s1vMWb+GzaJ58Xo2
        i8+/d7FaXN41h81ixeHpLBYLNj5itJgx+SWbxaO+t+wW5/8eZ3Xg9Dgx4zeLx/65a9g9FvdN
        ZvXo27KK0ePMgiPsHp83yXlsevKWKYA9KtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+g0JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrShoZGe
        oYG5npERkDaOtTIyBSpJSM3YvLOXraBXsGLKf7EGxlu8XYycHBICJhK3FneydzFycQgJ7GCU
        uH3/BpTziVHi4LInLBDON0aJjx+XssO0vN29jgkisZdRYt2KPkYI5y2jxKcTa1lAqlgEVCVu
        rVwF1sEmoCOxf8lvVhBbSEBB4sLWGWwgtqhAmMSMg/2MIDavgKDEyZlPwHpFgHrvnDoDtoFZ
        4BiTxLGtE8ASwgLSElfObAYaysHBKWAhceuDOUiYWUBeonnrbGaQegmB32wSP5ctYocYWiax
        /dxZFoizXSROb5/LCGELS7w6vgXqHSmJz+/2skHY7UBPz6yDGDSFUeLa309QRcYSzxZ2MYEs
        ZhbQlFi/Sx9iMZ/Eu689rCBhCQFeiY42IYhqFYmdRyexQYSlJGZtCIYIe0i0XdjLDAmrr8wS
        M3feZZrAqDALyfuzkLwzC2HZAkbmVYxiqQXFuempxYYFxnrFibnFpXnpesn5uZsYwYlUy3wH
        44ZzPocYBTgYlXh4OU5mRguxJpYVV+YeYpTgYFYS4U2uAwrxpiRWVqUW5ccXleakFh9iNAXG
        1ERmKdHkfGCSzyuJNzQ1MjY2tjAxNDM1NFQS5zXyC44WEkhPLEnNTk0tSC2C6WPi4JRqYKzJ
        azg6s3d+/LIEpUNJDf0NchEvD/A0SKyb+7Jgs1WoetCDnPfV6g+2rF/jOX/FwyTFKJ9LfYfa
        9Sx5LonMrt95eNKL+TN2zDkgmvDfIGSv1ofWhwbaE0NcLjTOO3TL+fTt+etfioYXeE1ae+rA
        2uXPpFxenpNUa1I4fOXbQ60DUSomEQKHdkYqsRRnJBpqMRcVJwIA0cWM57oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTnfegaxog7+9+hZz1q9hs2hevJ7N
        4vPvXawWl3fNYbNYcXg6i8WCjY8YLWZMfslm8ajvLbvF+b/HWR04PU7M+M3isX/uGnaPxX2T
        WT36tqxi9Diz4Ai7x+dNch6bnrxlCmCP4rJJSc3JLEst0rdL4MrYvLOXraBXsGLKf7EGxlu8
        XYycHBICJhJvd69j6mLk4hAS2M0oMfv2DDaIhJTE3G/bGbsYOYBsYYnDh4shal4zSlxqWssK
        UsMroCVx4dxkdhCbRUBV4tbKVWA2m4COxP4lv8FqhAQUJC5shZgpKhAi8evjFaheQYmTM5+w
        gNgiQL13Tp0BO4JZ4BSTxIuOHWCDhAWkJa6c2cwOsfkls8SMVz/ZQS7iFLCQuPXBHMRkFlCX
        WD9PCKScWUBeonnrbOYJjEKzkKyYhVA1C0nVAkbmVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYwRGkpbWD8cSJ+EOMAhyMSjy8HCczo4VYE8uKK3MPMUpwMCuJ8CbXAYV4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwlsxkahWxUktI09Zc6ZvQ
        uHbaxKqPqdlb5VhuPNLIm1ih1H7xvIZwULVlUFKSwNN/f25Hb3v1m91IyXjnnA1Pv33e8Usq
        X1fKdteLgmmPbm5TfPLg+lY3h9v22V1mcmKJJle+VPlPE/ry8PEzb00Vf4tHeY+9T8Vm3Q52
        0fR5vKHcVt0qr/OgEktxRqKhFnNRcSIAV3HPyZwCAAA=
Message-Id: <20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c~I4L612J9p0428204282epcas1p1X@epcas1p1.samsung.com>
X-CMS-MailID: 20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180530073304epcas3p4967df82d2d086fd08fd354781df61861
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
        <20180530073211.GA22422@kroah.com>
        <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
        <20180703043655.GA9793@kroah.com>
        <20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p@epcas1p4.samsung.com>
        <CA+55aFz-K8s-Sh86PqxRaXTD5pG=YsVUCxf9ue8XOSaGmg-brw@mail.gmail.com>
        <20180705005205.GC30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 07월 05일 09:52, Al Viro wrote:
> On Mon, Jul 02, 2018 at 10:01:25PM -0700, Linus Torvalds wrote:
>> On Mon, Jul 2, 2018 at 9:43 PM Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
>>>
>>> I think the commit itself is required. Simple, but not reliable,
>>> workaround fix is like below:
>>>
>>> diff --git a/fs/dcache.c b/fs/dcache.c
>>> index a34d401..7c751f2 100644
>>> --- a/fs/dcache.c
>>> +++ b/fs/dcache.c
>>> @@ -1879,6 +1879,8 @@ void d_instantiate_new(struct dentry *entry,
>>> struct inode *inode)
>>>         BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
>>>         BUG_ON(!inode);
>>>         lockdep_annotate_inode_mutex_key(inode);
>>> +       /* WORKAROUND for calling security_d_instantiate() */
>>> +       entry->d_inode = inode;
>>>         security_d_instantiate(entry, inode);
>>>         spin_lock(&inode->i_lock);
>>>         __d_instantiate(entry, inode);
>>
>> Ugh. That looks horrible even if it might avoid the oops.
>>
>> I think a much better solution is to back-port commit b296821a7c42
>> ("xattr_handler: pass dentry and inode as separate arguments of
>> ->get()") to older kernels. Then the inode is passed down all the way,
>> and you don't have people try to get it from the (not yet initialized)
>> dentry.
>>
>> But there might be other parts missing too, and I didn't look at how
>> easy/painful that backport would be.
>>
>> Al - comments? This is all because of commit 1e2e547a93a0 ("do
>> d_instantiate/unlock_new_inode combinations safely") being marked for
>> stable, and various cases of security_d_instantiate() calling down to
>> getxattr. Which used to not get the inode at all, so those older
>> kernels use d_inode(dentry), which doesn't work in this path since
>> dentry->d_inode hasn't been instantiated yet..
> 
> You also want b96809173e94 and ce23e6401334 there...

For above two commits, also b296821a7c42 is required. And after
backport, smack still crashed because setxattr. To fix it, 5930122683df
and 3767e255b390 are also required.

By the way, does no one have met this kind getxattr crash issue with
selinux from 3.18.y?

-- 
Seung-Woo Kim
Samsung Research
--

