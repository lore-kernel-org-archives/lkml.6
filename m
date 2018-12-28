Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F198208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeL1H52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:57:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbeL1H50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:57:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBS7nJAM005530
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:57:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pnfjw0s7k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:57:24 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 28 Dec 2018 07:57:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Dec 2018 07:57:17 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBS7vHV856098876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Dec 2018 07:57:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E366152050;
        Fri, 28 Dec 2018 07:57:16 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.141])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5B6605204E;
        Fri, 28 Dec 2018 07:57:16 +0000 (GMT)
Subject: Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
To:     Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     pbonzini@redhat.com, dgilbert@redhat.com,
        Halil Pasic <pasic@linux.ibm.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 xsFNBE6cPPgBEAC2VpALY0UJjGmgAmavkL/iAdqul2/F9ONz42K6NrwmT+SI9CylKHIX+fdf
 J34pLNJDmDVEdeb+brtpwC9JEZOLVE0nb+SR83CsAINJYKG3V1b3Kfs0hydseYKsBYqJTN2j
 CmUXDYq9J7uOyQQ7TNVoQejmpp5ifR4EzwIFfmYDekxRVZDJygD0wL/EzUr8Je3/j548NLyL
 4Uhv6CIPf3TY3/aLVKXdxz/ntbLgMcfZsDoHgDk3lY3r1iwbWwEM2+eYRdSZaR4VD+JRD7p8
 0FBadNwWnBce1fmQp3EklodGi5y7TNZ/CKdJ+jRPAAnw7SINhSd7PhJMruDAJaUlbYaIm23A
 +82g+IGe4z9tRGQ9TAflezVMhT5J3ccu6cpIjjvwDlbxucSmtVi5VtPAMTLmfjYp7VY2Tgr+
 T92v7+V96jAfE3Zy2nq52e8RDdUo/F6faxcumdl+aLhhKLXgrozpoe2nL0Nyc2uqFjkjwXXI
 OBQiaqGeWtxeKJP+O8MIpjyGuHUGzvjNx5S/592TQO3phpT5IFWfMgbu4OreZ9yekDhf7Cvn
 /fkYsiLDz9W6Clihd/xlpm79+jlhm4E3xBPiQOPCZowmHjx57mXVAypOP2Eu+i2nyQrkapaY
 IdisDQfWPdNeHNOiPnPS3+GhVlPcqSJAIWnuO7Ofw1ZVOyg/jwARAQABzTRDaHJpc3RpYW4g
 Qm9ybnRyYWVnZXIgKElCTSkgPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+wsF4BBMBAgAiBQJO
 nDz4AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRARe7yAtaYcfOYVD/9sqc6ZdYKD
 bmDIvc2/1LL0g7OgiA8pHJlYN2WHvIhUoZUIqy8Sw2EFny/nlpPVWfG290JizNS2LZ0mCeGZ
 80yt0EpQNR8tLVzLSSr0GgoY0lwsKhAnx3p3AOrA8WXsPL6prLAu3yJI5D0ym4MJ6KlYVIjU
 ppi4NLWz7ncA2nDwiIqk8PBGxsjdc/W767zOOv7117rwhaGHgrJ2tLxoGWj0uoH3ZVhITP1z
 gqHXYaehPEELDV36WrSKidTarfThCWW0T3y4bH/mjvqi4ji9emp1/pOWs5/fmd4HpKW+44tD
 Yt4rSJRSa8lsXnZaEPaeY3nkbWPcy3vX6qafIey5d8dc8Uyaan39WslnJFNEx8cCqJrC77kI
 vcnl65HaW3y48DezrMDH34t3FsNrSVv5fRQ0mbEed8hbn4jguFAjPt4az1xawSp0YvhzwATJ
 YmZWRMa3LPx/fAxoolq9cNa0UB3D3jmikWktm+Jnp6aPeQ2Db3C0cDyxcOQY/GASYHY3KNra
 z8iwS7vULyq1lVhOXg1EeSm+lXQ1Ciz3ub3AhzE4c0ASqRrIHloVHBmh4favY4DEFN19Xw1p
 76vBu6QjlsJGjvROW3GRKpLGogQTLslbjCdIYyp3AJq2KkoKxqdeQYm0LZXjtAwtRDbDo71C
 FxS7i/qfvWJv8ie7bE9A6Wsjn87BTQROnDz4ARAAmPI1e8xB0k23TsEg8O1sBCTXkV8HSEq7
 JlWz7SWyM8oFkJqYAB7E1GTXV5UZcr9iurCMKGSTrSu3ermLja4+k0w71pLxws859V+3z1jr
 nhB3dGzVZEUhCr3EuN0t8eHSLSMyrlPL5qJ11JelnuhToT6535cLOzeTlECc51bp5Xf6/XSx
 SMQaIU1nDM31R13o98oRPQnvSqOeljc25aflKnVkSfqWSrZmb4b0bcWUFFUKVPfQ5Z6JEcJg
 Hp7qPXHW7+tJTgmI1iM/BIkDwQ8qe3Wz8R6rfupde+T70NiId1M9w5rdo0JJsjKAPePKOSDo
 RX1kseJsTZH88wyJ30WuqEqH9zBxif0WtPQUTjz/YgFbmZ8OkB1i+lrBCVHPdcmvathknAxS
 bXL7j37VmYNyVoXez11zPYm+7LA2rvzP9WxR8bPhJvHLhKGk2kZESiNFzP/E4r4Wo24GT4eh
 YrDo7GBHN82V4O9JxWZtjpxBBl8bH9PvGWBmOXky7/bP6h96jFu9ZYzVgIkBP3UYW+Pb1a+b
 w4A83/5ImPwtBrN324bNUxPPqUWNW0ftiR5b81ms/rOcDC/k/VoN1B+IHkXrcBf742VOLID4
 YP+CB9GXrwuF5KyQ5zEPCAjlOqZoq1fX/xGSsumfM7d6/OR8lvUPmqHfAzW3s9n4lZOW5Jfx
 bbkAEQEAAcLBXwQYAQIACQUCTpw8+AIbDAAKCRARe7yAtaYcfPzbD/9WNGVf60oXezNzSVCL
 hfS36l/zy4iy9H9rUZFmmmlBufWOATjiGAXnn0rr/Jh6Zy9NHuvpe3tyNYZLjB9pHT6mRZX7
 Z1vDxeLgMjTv983TQ2hUSlhRSc6e6kGDJyG1WnGQaqymUllCmeC/p9q5m3IRxQrd0skfdN1V
 AMttRwvipmnMduy5SdNayY2YbhWLQ2wS3XHJ39a7D7SQz+gUQfXgE3pf3FlwbwZhRtVR3z5u
 aKjxqjybS3Ojimx4NkWjidwOaUVZTqEecBV+QCzi2oDr9+XtEs0m5YGI4v+Y/kHocNBP0myd
 pF3OoXvcWdTb5atk+OKcc8t4TviKy1WCNujC+yBSq3OM8gbmk6NwCwqhHQzXCibMlVF9hq5a
 FiJb8p4QKSVyLhM8EM3HtiFqFJSV7F+h+2W0kDyzBGyE0D8z3T+L3MOj3JJJkfCwbEbTpk4f
 n8zMboekuNruDw1OADRMPlhoWb+g6exBWx/YN4AY9LbE2KuaScONqph5/HvJDsUldcRN3a5V
 RGIN40QWFVlZvkKIEkzlzqpAyGaRLhXJPv/6tpoQaCQQoSAc5Z9kM/wEd9e2zMeojcWjUXgg
 oWj8A/wY4UXExGBu+UCzzP/6sQRpBiPFgmqPTytrDo/gsUGqjOudLiHQcMU+uunULYQxVghC
 syiRa+UVlsKmx1hsEg==
Date:   Fri, 28 Dec 2018 08:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18122807-4275-0000-0000-000002F647CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122807-4276-0000-0000-000038046A6C
Message-Id: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=614 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812280072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.12.2018 03:26, Wei Wang wrote:
> Some vqs don't need to be allocated when the related feature bits are
> disabled. Callers notice the vq allocation layer by setting the related
> names[i] to be NULL.
> 
> This patch series fixes the find_vqs implementations to handle this case.

So the random crashes during boot are gone.
What still does not work is actually using the balloon.

So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
Seems to be a deadlock in the virtio-ccw code.  We seem to call the
config code in the interrupt handler.

crash> bt
PID: 0      TASK: d9a400            CPU: 0   COMMAND: "swapper/0"
 LOWCORE INFO:
  -psw      : 0x0404c00180000000 0x0000000000116472
  -function : smp_yield_cpu at 116472
  -prefix   : 0x7fffc000
  -cpu timer: 0x7fffffcc8c0af5be
  -clock cmp: 0x720a4e4002831000
  -general registers:
     000000000000000000 000000000000000000
     0x000000000000009c 0x0000000000fac2b0
     0x0000000000000015 0xffffffffffffffe2
     0x000003e000100000 0x0000000000000001
     000000000000000000 0x0000000000000001
     0x00000000000003e8 0x000000000f85c020
     000000000000000000 0x0000000000000001
     0x0000000000116464 0x000003e00035fad0
  -access registers:
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
  -control registers:
     0x0080000014866a10 0x0000000000fbc007
     0x0000000000100140 000000000000000000
     0x000000000000ffff 0x0000000000100140
     0x0000000031000000 0x000000000f9281c3
     000000000000000000 000000000000000000
     000000000000000000 000000000000000000
     000000000000000000 0x0000000000fbc007
     0x00000000db000000 0x0000000000100280
  -floating point registers:
     000000000000000000 0x000002aa374b0298
     0x0000000000000001 0x0000000000000010
     0x00000000000001ae 0x000000000000000f
     0x000002aa46056010 0x000002aa460681c0
     0x000003ffd867d590 0x000003ffdca7c818
     0x000003ffd867d58f 0x000003fff6ffdc60
     0x000003ffd867dad8 0x000003ffdca7c5e8
     0x000003ffd867dadc 0x000003ffdca7c818

 #0 [3e00035faf8] arch_spin_lock_wait at a7bd52
 #1 [3e00035fb50] ccw_io_helper at 9130ea
 #2 [3e00035fbd0] virtio_ccw_get_config at 914a28
 #3 [3e00035fc30] virtballoon_changed at 76e776
 #4 [3e00035fc70] virtio_config_changed at 76aabc
 #5 [3e00035fca8] virtio_ccw_int_handler at 914ede
 #6 [3e00035fd18] ccw_device_irq at 8941d4
 #7 [3e00035fd48] do_cio_interrupt at 885906
 #8 [3e00035fd80] __handle_irq_event_percpu at 1b3c22
 #9 [3e00035fdf0] handle_irq_event_percpu at 1b3e1e
#10 [3e00035fe28] handle_percpu_irq at 1b87d8
#11 [3e00035fe58] generic_handle_irq at 1b2ce6
#12 [3e00035fe70] do_IRQ at 10c3b2
#13 [3e00035fea8] io_int_handler at a86b3c
 PSW:  0404c00180000000 00000000001034f6 (enabled_wait+70)
 GPRS: ffffffffffffffff 0000000000000000 000000007ff70200 0706c00180000000 
       000000000000000c 000001bf6f331c58 ffffffffffffffff 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000001 
       000000007ff70200 0000000000a8b2f0 00000000001034f6 000003e000317e00 
 #0 [3e000317e28] arch_cpu_idle at 103842
 #1 [3e000317e48] do_idle at 17ad18
 #2 [3e000317e80] cpu_startup_entry at 17af16
 #3 [3e000317ea8] arch_call_rest_init at eac934


> 
> Wei Wang (2):
>   virtio_pci: use queue idx instead of array idx to set up the vq
>   virtio: don't allocate vqs when names[i] = NULL
> 
>  drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
>  drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
>  drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
>  drivers/virtio/virtio_mmio.c           |  9 +++++++--
>  drivers/virtio/virtio_pci_common.c     |  8 ++++----
>  5 files changed, 34 insertions(+), 13 deletions(-)
> 

