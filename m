Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FE62147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rz/rV4hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FE62147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJQHGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:06:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJQHGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:06:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GN8fJb032730;
        Tue, 16 Oct 2018 23:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=gv/y8dToplbRvPfHS/sW1iB01Tc15hwyMkc6bXTSz0M=;
 b=rz/rV4hYxt3usAmbwd24daX0Eg/YgU8nG+iq85vcAR0uGfZlCcf4Vxm/j+S7Iz1+tGYv
 MtKmkazpGKMQpiLpsTBgedlaCr3Eap1iTLsjoW8hBjD29HZp14khgSVHclQDrk/Lbal+
 rB87TjIkAhyGvfrTRv/wa8daI8mUTAS6u4hf8NgKooymljvWjxTtzG02Xfy2VUdJiMAS
 sJnqVAqvGR8fZ+1fkhTZ0hQeDhwr0R45iv5HtNFek0EYNgjR5/uIxClbE+D3pY5hQLaQ
 wKHuMAjwOUwtfFdiqCE+nUQb/l4N1cXu97G5eniodMZergeu20pSScNlazoAItYKRo6G qg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brbm7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 23:13:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9GNDIOB014522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 23:13:19 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9GNDIwH007222;
        Tue, 16 Oct 2018 23:13:18 GMT
Received: from [192.168.14.112] (/79.181.251.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 16:13:18 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: VMX: enable nested virtualization by default
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20181016225522.13077-1-pbonzini@redhat.com>
Date:   Wed, 17 Oct 2018 02:13:15 +0300
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CB58AE6-8057-4D76-8EA5-C219326F3432@oracle.com>
References: <20181016225522.13077-1-pbonzini@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 17 Oct 2018, at 1:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> With live migration support and finally a good solution for CR2/DR6
> exception payloads, nested VMX should finally be ready for having a =
stable

And good solution for setting/getting vCPU events from userspace with =
correct pending/injected state.

> userspace ABI.  The results of syzkaller fuzzing are not perfect but =
not
> horrible either (and might be partially due to running on GCE, so that
> effectively we're testing three-level nesting on a fork of upstream =
KVM!).
> Enabling it by default seems like a nice way to conclude the 4.20
> pull request. :)
>=20
> Unfortunately, enabling nested SVM in 2009 was a bit premature.  =
However,

Don=E2=80=99t you wish to mention commit which enabled it?

> until live migration support is in place we can reasonably expect that
> it does not offer much in terms of ABI guarantees.  Therefore we are
> still in time to break things and conform as much as possible to the
> interface used for VMX.
>=20
> Suggested-by: Jim Mattson <jmattson@google.com>
> Suggested-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> arch/x86/kvm/vmx.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index e665aa7167cf..89fc2a744d7f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -107,7 +107,7 @@ module_param_named(enable_shadow_vmcs, =
enable_shadow_vmcs, bool, S_IRUGO);
>  * VMX and be a hypervisor for its own guests. If nested=3D0, guests =
may not
>  * use VMX instructions.
>  */
> -static bool __read_mostly nested =3D 0;
> +static bool __read_mostly nested =3D 1;
> module_param(nested, bool, S_IRUGO);
>=20
> static u64 __read_mostly host_xss;
> --=20
> 2.17.1
>=20

Woohoo! :)
Reviewed-by: Liran Alon <liran.alon@oracle.com>


