Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68558C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A872083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L3qWie6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A872083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeLGSW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:22:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48402 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeLGSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:22:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7IIt0e094541;
        Fri, 7 Dec 2018 18:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=EkCBNpuvnpgco/EMBRVEe1wJsm6NKP1TdViUP7/SHsI=;
 b=L3qWie6JztwgeUahRH8h32sfs7r3eaXXOHfP7FxfiYeaWhJ1jJRj4CwnSzAU85FuEtNo
 usgKR2zLkpQhn4w16fc/t8xbq9BQDaWMBiMAGMhHVE6+THeauffpshqjTLvLqJBvpFgb
 tiQCJ8XR2CWcFAlUQQmi0C+gwLqlM6S6EmxDEAzcLoY1POOqdsrIY7igtLqdKGztv1gI
 yCxAr9oQXb4ROPKHrCuafKYdXha1+pPvRPzLUEgsCllOuAe03JGGxJmJ6JBVZoJvF9Dr
 8E6QoZLtsjjsx5YCjYqYCfI+RXZfzX2tKK72Tx0oaWmoWA36/6/0NDRexQKJPvlvbjW9 jg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p3ftfk87p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 18:22:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB7IM8MD024118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 18:22:08 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB7IM7YP023272;
        Fri, 7 Dec 2018 18:22:07 GMT
Received: from [10.159.246.233] (/10.159.246.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 10:22:07 -0800
Subject: Re: [PATCH v8 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and
 CONFIG_XEN_PVH
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de,
        thomas.lendacky@amd.com, luto@kernel.org,
        dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, rdunlap@infradead.org
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
 <1544076257-21792-1-git-send-email-maran.wilson@oracle.com>
 <d532f023-85f9-62b9-ca56-53a619fdcd1e@redhat.com>
 <2c289956-0e6a-700c-605d-83685fbb08f9@suse.com>
 <0a2f692a-f7df-8ad1-9d34-96f5e36926db@redhat.com>
 <3f95d053-87aa-ad45-03e6-1e1977283eb4@suse.com>
 <d0fd8799-35ea-fba5-9d0d-94feead85943@redhat.com>
 <5d1d0071-1db4-ea03-027f-2a12812b78d0@suse.com>
 <d18b961a-d115-8d12-8ee4-eb1a3466959c@redhat.com>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <6f71c714-1a72-1619-fd1f-f5d1044ce217@oracle.com>
Date:   Fri, 7 Dec 2018 10:21:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <d18b961a-d115-8d12-8ee4-eb1a3466959c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2018 7:14 AM, Paolo Bonzini wrote:
> On 07/12/18 14:58, Juergen Gross wrote:
>> On 07/12/2018 14:52, Paolo Bonzini wrote:
>>> On 07/12/18 14:50, Juergen Gross wrote:
>>>> The PVH boot entry is in the same bzImage binary as the normal one.
>>>> Its just another entry, similar to the Xen PV boot entry. So the binary
>>>> arch/x86/boot/bzimage can be booted either on bare metal via grub2 or
>>>> other boot-loaders, as Xen PV-guest, as Xen PVH-guest, or as KVM
>>>> PVH-guest. So one build and one binary. The non-standard boot entries
>>>> (PV- or PVH-node) are found via ELF-notes by the boot loader (qemu in
>>>> case of KVM).
>>> But the bzImage is not an ELF binary, and it is compressed, isn't it?
>>> /me is confused. :)
>> grub2 (and qemu, too) can decompress it. And the decompressed result
>> "vmlinux" is an ELF-binary.
> Aha - for KVM, the main advantage of PVH would be to skip the cost of
> decompression, and that is what confused me (also we probably prefer not
> having any decompression code running in QEMU, since that increases the
> attack surface; there's no real disadvantage to using the existing
> linuxboot code if we're given a bzImage).  So, at least for now, KVM
> would go with the two-binaries/one-config approach.

Yeah, the way we have been testing with the Qemu/qboot changes that Liam 
has out for review, if you provide the bzImage binary in the -kernel 
argument, legacy behavior is followed. However if you provide the 
vmlinux binary (from the same kernel build), Qemu recognizes it as an 
ELF binary, looks for the presence of the PVH ELFNOTE, and (if the 
ELFNOTE in question is found) uses that entry point instead.

So at this point, the only feedback/comment still outstanding from you 
is the one about removing KVM_GUEST_PVH right?

I'll hold off on sending a v9 until next week to see if there is any 
additional feedback or test results.

Thanks,
-Maran

> Sorry for having you lecture me, it's much clearer now.  Thanks,
>
> Paolo

