Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9807C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742272075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eK3TWxz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeICSbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:31:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeICSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:31:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w83E3wtv072106;
        Mon, 3 Sep 2018 14:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2018-07-02;
 bh=b9yhlihTsqyYWIMz49zxeW+EL9uySE/8TV4PLiDrRwk=;
 b=eK3TWxz3XL4tqd/WJYfc3dFTyzIZa1U0kkBY3sj22YiK2rUtpOysqJWWc5XtCqddFYcQ
 +iUQhaX/o7yekRG+UAXt+F4Xo2GurTRwPQ3IwRRco2H5KUyuyvHAAFk6FlmuXsC4IBZc
 2fbKWX16DTsio3AgQW62EsNmbZYPovAIM+ze7DBCSR3tRTy90gOoCe3aNHFyryYooJum
 e2P4q/H41INzoTAKdSNqV+UXB2ueGubuIxitzPUovPdnj1lP78fZzWNPuDvrRD59om9n
 5pShQ1SWHhKjRcUmti/O+t4phq9m47L9aYO4N3C0XCBrr19IdjDCt3HeFcumZyJrcdHo TA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m7j6t87ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Sep 2018 14:10:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w83EAiEj019882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Sep 2018 14:10:44 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w83EAigt027841;
        Mon, 3 Sep 2018 14:10:44 GMT
Received: from [10.30.3.6] (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Sep 2018 07:10:44 -0700
From:   Nikita Leshenko <nikita.leshchenko@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC][PATCH 1/5] [PATCH 1/5] kvm: register in task_struct
Message-Id: <D3FBF73C-3C33-4F94-8BBB-CE6C70B81A70@oracle.com>
Date:   Mon, 3 Sep 2018 16:10:22 +0200
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        fengguang.wu@intel.com, dongx.peng@intel.com, jingqi.liu@intel.com,
        eddie.dong@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        bgregg@netflix.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     fengguang.wu@intel.com
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9004 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=961
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809030149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2018 5:21:15 AM, fengguang.wu@intel.com wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8b47507faab5..0c483720de8d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3892,6 +3892,7 @@ static void kvm_uevent_notify_change(unsigned =
int type, struct kvm *kvm)
>  	if (type =3D=3D KVM_EVENT_CREATE_VM) {
>  		add_uevent_var(env, "EVENT=3Dcreate");
>  		kvm->userspace_pid =3D task_pid_nr(current);
> +		current->kvm =3D kvm;

Is it OK to store `kvm` on the task_struct? What if the thread that
originally created the VM exits? =46rom the documentation it seems
like a VM is associated with an address space and not a specific
thread, so maybe it should be stored on mm_struct?

=46rom Documentation/virtual/kvm/api.txt:
   Only run VM ioctls from the same process (address space) that was =
used
   to create the VM.

-Nikita
>  	} else if (type =3D=3D KVM_EVENT_DESTROY_VM) {
>  		add_uevent_var(env, "EVENT=3Ddestroy");
>  	}
> --=20
> 2.15.0
>=20
>=20
>=20
