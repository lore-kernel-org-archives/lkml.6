Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92195C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 00:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC7A21837
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 00:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MOqHrfGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC7A21837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeHMDEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 23:04:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61087 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeHMDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 23:04:01 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180813002413epoutp032e4a555682c191c93b41678749b97dbc~KSeDkId5S1267812678epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 00:24:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180813002413epoutp032e4a555682c191c93b41678749b97dbc~KSeDkId5S1267812678epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534119853;
        bh=G9U49wfEOMz4UI73AN1f8+jEkPhJfSAJpnOsfbF82hI=;
        h=Date:From:Reply-To:To:CC:Subject:In-Reply-To:References:From;
        b=MOqHrfGh70OS2pLQGZ2iECv5UQJjQM53dmS27BZDbiNFMnzvFJnQ75UhkrSkmEgH/
         CBzePQN4YHWsu391fHjqFQzpSkQBhpDTJ4xaeZ/XWR3w/fZahp/YVBsSr6CepiR6kr
         n2Jb55jtSRYhtQaDpeE8Wj/+IxvTErF/Gu+uRbaI=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180813002410epcas1p403304535fb29f1177044c0e544ea1d59~KSeA-3hl11004310043epcas1p4X;
        Mon, 13 Aug 2018 00:24:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.CF.04176.AAFC07B5; Mon, 13 Aug 2018 09:24:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180813002409epcas1p2d0c7cf768c533de9348a994e614fc6ea~KSd-6p8Bi1658316583epcas1p2a;
        Mon, 13 Aug 2018 00:24:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180813002409epsmtrp2d2d28d7064bffed98c214fd761e7aeac~KSd-5in2M2309423094epsmtrp2G;
        Mon, 13 Aug 2018 00:24:09 +0000 (GMT)
X-AuditID: b6c32a37-6c5ff70000001050-62-5b70cfaa22a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.FE.03889.9AFC07B5; Mon, 13 Aug 2018 09:24:09 +0900 (KST)
Received: from [10.113.63.222] (unknown [10.113.63.222]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180813002409epsmtip21ea02f3cd9ea7f1fc0eb34a07c0f1225~KSd-wL5gM0605506055epsmtip2P;
        Mon, 13 Aug 2018 00:24:09 +0000 (GMT)
Date:   Mon, 13 Aug 2018 09:24:18 +0900
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-To: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
        Thunderbird/16.0.1
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: Re: Linux 3.18.111
In-Reply-To: <20180810101158.GA31002@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmvu6q8wXRBi1f5S3mrF/DZtG8eD2b
        xeffu1gtLu+aw2ax4vB0FosFGx8xWsyY/JLN4lHfW3aL83+PszpwepyY8ZvFY//cNewei/sm
        s3r0bVnF6HFmwRF2j8+b5Dw2PXnLFMAelWqTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
        aGlhrqSQl5ibaqvk4hOg65aZA3SakkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKdrQ0EjP
        0MBcz8gISBvHWhmZApUkpGbs67rCXnBcvOLnukUsDYw/hboYOTkkBEwkDt26wN7FyMUhJLCD
        UeLuwZtsEM4nRok7i/+zQDjfGCWW7FvEDNPy4EIPI0RiL6PE9PtvoFreMkrce74ayOHgYBFQ
        lbjzWRakgU1AR2L/kt+sILaQgILEha0z2EBsUYEwiRkH+xlBbF4BQYmTM5+wgNgiAsYS/Wdn
        gd3ELLCDSeLkEhCHk0NYQFriypnNYDangL7EuidbwIYyC8hLNG+dzQzSICHwn03i1NVeFoip
        ZRK9Ny+zQ5ztInFn0RZGCFtY4tXxLVBxKYnP7/ayQdjtjBIHZ9ZBDJrCKHHt7yeoImOJZwu7
        mEA+YxbQlFi/Sx9iMZ/Eu689rCBhCQFeiY42aKCqSOw8OokNIiwlMWtDMETYQ6Ltwl5mSFh9
        YZX4sX8u6wRGhVlI/p+F5J1ZCMsWMDKvYhRLLSjOTU8tNiww1itOzC0uzUvXS87P3cQITqVa
        5jsYN5zzOcQowMGoxMPbsbogWog1say4MvcQowQHs5II7wUGoBBvSmJlVWpRfnxRaU5q8SFG
        U2BMTWSWEk3OB6b5vJJ4Q1MjY2NjCxNDM1NDQyVxXiO/4GghgfTEktTs1NSC1CKYPiYOTqkG
        xowdHZ86V2y2O25tJF76/ZD2Ct8DlzamT9kmo72Lv2YH38uQE4Ii9yIEpjzVun7k/9zvsw/O
        tX3PNtdXyOyTZc3boC/iuR9etrPm1Go4TwxcZh738LOwoGDRd12fHt3jD/dMNFeeviC4MXip
        oNeqknL7SO2rRXMXHeXZO/3uc5HYjjCjbTWXipRYijMSDbWYi4oTAaomIM27AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXnfl+YJog0P3RSzmrF/DZtG8eD2b
        xeffu1gtLu+aw2ax4vB0FosFGx8xWsyY/JLN4lHfW3aL83+PszpwepyY8ZvFY//cNewei/sm
        s3r0bVnF6HFmwRF2j8+b5Dw2PXnLFMAexWWTkpqTWZZapG+XwJWxr+sKe8Fx8Yqf6xaxNDD+
        FOpi5OSQEDCReHChh7GLkYtDSGA3o8T1ea1sEAkpibnftgMlOIBsYYnDh4tBwkICrxklTk3i
        ArF5BbQk5h88ywxSwiKgKnHnsyxImE1AR2L/kt+sEOUKEhe2zgCbKCoQIvHr4xVWiFZBiZMz
        n7CA2CICxhL9Z2exg9jMAnuYJGZMygCxhQWkJa6c2cwOcdojVonZP9vABnEK6Euse7KFFWQv
        s4C6xPp5QhC98hLNW2czT2AUmoVkxSyEqllIqhYwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAiOHy2tHYwnTsQfYhTgYFTi4e1YXRAtxJpYVlyZe4hRgoNZSYT3AgNQiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA6P2nT3rS9xS0995pbq8
        K01ZaHVq4cfFz/1vCT947a51VT6l9GeqPtdeG6PDL74H/JjIc9Kt8h+HV+wn9s9zmN7dnfu+
        ef9inmPXJMtu3t2nGndpX5zlyhMlWkeZ87kE1wWEtubNdsiQX7qk+eeF3+djX7Mm/5o9a7VE
        PlvyabMwdaP+hgShPnElluKMREMt5qLiRAAx3efdmwIAAA==
Message-Id: <20180813002409epcas1p2d0c7cf768c533de9348a994e614fc6ea~KSd-6p8Bi1658316583epcas1p2a@epcas1p2.samsung.com>
X-CMS-MailID: 20180813002409epcas1p2d0c7cf768c533de9348a994e614fc6ea
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
        <20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c~I4L612J9p0428204282epcas1p1X@epcas1p1.samsung.com>
        <20180810064258epcas1p3eb68d29dbd60b705d0473b3c645496ff~Jcs48Q55D0165001650epcas1p3e@epcas1p3.samsung.com>
        <20180810101158.GA31002@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018년 08월 10일 19:11, Greg Kroah-Hartman wrote:
> On Fri, Aug 10, 2018 at 03:43:02PM +0900, Seung-Woo Kim wrote:
>> On 2018년 08월 08일 19:06, Seung-Woo Kim wrote:
>>> On 2018년 07월 05일 09:52, Al Viro wrote:
>>>> On Mon, Jul 02, 2018 at 10:01:25PM -0700, Linus Torvalds wrote:
>>>>> On Mon, Jul 2, 2018 at 9:43 PM Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
>>>>>>
>>>>>> I think the commit itself is required. Simple, but not reliable,
>>>>>> workaround fix is like below:
>>>>>>
>>>>>> diff --git a/fs/dcache.c b/fs/dcache.c
>>>>>> index a34d401..7c751f2 100644
>>>>>> --- a/fs/dcache.c
>>>>>> +++ b/fs/dcache.c
>>>>>> @@ -1879,6 +1879,8 @@ void d_instantiate_new(struct dentry *entry,
>>>>>> struct inode *inode)
>>>>>>         BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
>>>>>>         BUG_ON(!inode);
>>>>>>         lockdep_annotate_inode_mutex_key(inode);
>>>>>> +       /* WORKAROUND for calling security_d_instantiate() */
>>>>>> +       entry->d_inode = inode;
>>>>>>         security_d_instantiate(entry, inode);
>>>>>>         spin_lock(&inode->i_lock);
>>>>>>         __d_instantiate(entry, inode);
>>>>>
>>>>> Ugh. That looks horrible even if it might avoid the oops.
>>>>>
>>>>> I think a much better solution is to back-port commit b296821a7c42
>>>>> ("xattr_handler: pass dentry and inode as separate arguments of
>>>>> ->get()") to older kernels. Then the inode is passed down all the way,
>>>>> and you don't have people try to get it from the (not yet initialized)
>>>>> dentry.
>>>>>
>>>>> But there might be other parts missing too, and I didn't look at how
>>>>> easy/painful that backport would be.
>>>>>
>>>>> Al - comments? This is all because of commit 1e2e547a93a0 ("do
>>>>> d_instantiate/unlock_new_inode combinations safely") being marked for
>>>>> stable, and various cases of security_d_instantiate() calling down to
>>>>> getxattr. Which used to not get the inode at all, so those older
>>>>> kernels use d_inode(dentry), which doesn't work in this path since
>>>>> dentry->d_inode hasn't been instantiated yet..
>>>>
>>>> You also want b96809173e94 and ce23e6401334 there...
>>>
>>> For above two commits, also b296821a7c42 is required. And after
>>> backport, smack still crashed because setxattr. To fix it, 5930122683df
>>> and 3767e255b390 are also required.
>>>
>>> By the way, does no one have met this kind getxattr crash issue with
>>> selinux from 3.18.y?
>>>
>>
>> I have checked with selinux, and it is confirmed that there is no crash
>> because selinux_d_instantiate() has null check for inode. So, it is only
>> security smack issue.
> 
> So are the 5 patches you sent ok to apply to the 3.18-stable tree?  Or
> do we need to do something else?
> 

Those 5 patches are fine in my smack environment. I have not tested all
the file systems in run-time except ext2/4 and I only tested build for
those file systems.

Best Regards,
- Seung-Woo Kim

> thanks,
> 
> greg k-h
> 
> 
