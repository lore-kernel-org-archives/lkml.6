Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36199C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99812075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCv/7CQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99812075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeIDLA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:00:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35570 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIDLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:00:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w846YXHr020219;
        Tue, 4 Sep 2018 06:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=BRe9rjf/d2+VM2lmgO2g5vO83QmpaNjKVrdXBwaYk+E=;
 b=LCv/7CQKbo0W6N9x9mY6F1MqmmmcT5oEPpqCp9SH10qU/LPO8SzUBs0/ZT+5TXN1qilQ
 Jcc4zsoMn11QpbTIy1yKhLt7bqRdr28rqeRgH0DJ0fYf63Rp7+KDkk/hm7tygL//ACDO
 QtWr+MotjuAvxOg9IRxKdstp2wjB+hg1CvI0FGyKxRMb35tNmdrt0EWCQAhlbDdSMZMS
 P/lDTuTAKzpsZ5IMX4Mqyiag4HaXqbuz6PxVQ7oxxfDWNAv1MaUjDu94/beuiMRyQuna
 lMIUt6Qs4zrUotbR3t6Jr+NjFIxGGupwXAX4LN3/dzIMIXZ2DxpvPvcTfHKAmmm1bKw3 Tw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m7kdqatb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Sep 2018 06:37:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w846bA1B029169
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Sep 2018 06:37:10 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w846b80h010276;
        Tue, 4 Sep 2018 06:37:08 GMT
Received: from ravellos-mbp.lan (/87.214.231.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Sep 2018 23:37:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC][PATCH 1/5] [PATCH 1/5] kvm: register in task_struct
From:   Nikita Leshenko <nikita.leshchenko@oracle.com>
In-Reply-To: <20180904004621.aqhemgpefwtq3kif@wfg-t540p.sh.intel.com>
Date:   Tue, 4 Sep 2018 08:37:03 +0200
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        dongx.peng@intel.com, jingqi.liu@intel.com, eddie.dong@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, bgregg@netflix.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0A5145C-E401-43E8-9FE9-56A4470CD13E@oracle.com>
References: <D3FBF73C-3C33-4F94-8BBB-CE6C70B81A70@oracle.com>
 <0ef9ccdc-3eae-f0b9-5304-8552cb94d166@de.ibm.com>
 <20180904002818.nq2ejxlsn4o34anl@wfg-t540p.sh.intel.com>
 <20180904004621.aqhemgpefwtq3kif@wfg-t540p.sh.intel.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9005 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809040069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Sep 2018, at 2:46, Fengguang Wu <fengguang.wu@intel.com> wrote:
>=20
> Here it goes:
>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 99ce070e7dcb..27c5446f3deb 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -27,6 +27,7 @@ typedef int vm_fault_t;
> struct address_space;
> struct mem_cgroup;
> struct hmm;
> +struct kvm;
> /*
> * Each physical page in the system has a struct page associated with
> @@ -489,10 +490,19 @@ struct mm_struct {
> 	/* HMM needs to track a few things per mm */
> 	struct hmm *hmm;
> #endif
> +#if IS_ENABLED(CONFIG_KVM)
> +	struct kvm *kvm;
> +#endif
> } __randomize_layout;
> extern struct mm_struct init_mm;
> +#if IS_ENABLED(CONFIG_KVM)
> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return =
mm->kvm; }
> +#else
> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return NULL; =
}
> +#endif
> +
> static inline void mm_init_cpumask(struct mm_struct *mm)
> {
> #ifdef CONFIG_CPUMASK_OFFSTACK
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0c483720de8d..dca6156a7b35 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3892,7 +3892,7 @@ static void kvm_uevent_notify_change(unsigned =
int type, struct kvm *kvm)
> 	if (type =3D=3D KVM_EVENT_CREATE_VM) {
> 		add_uevent_var(env, "EVENT=3Dcreate");
> 		kvm->userspace_pid =3D task_pid_nr(current);
> -		current->kvm =3D kvm;
> +		current->mm->kvm =3D kvm;
I think you also need to reset kvm to NULL once the VM is
destroyed, otherwise it would point to dangling memory.

-Nikita
> 	} else if (type =3D=3D KVM_EVENT_DESTROY_VM) {
> 		add_uevent_var(env, "EVENT=3Ddestroy");
> 	}

