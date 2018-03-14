Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932958AbeCNBAz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 21:00:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932634AbeCNBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 21:00:53 -0400
References: <20180306102303.9063-1-takahiro.akashi@linaro.org> <20180306102303.9063-3-takahiro.akashi@linaro.org> <20180308011303.GB2600@dhcp-128-65.nay.redhat.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, vgoyal@redhat.com,
        bhe@redhat.com, mpe@ellerman.id.au, prudo@linux.vnet.ibm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/7] kexec_file,x86,powerpc: factor out kexec_file_ops functions
In-reply-to: <20180308011303.GB2600@dhcp-128-65.nay.redhat.com>
Date: Tue, 13 Mar 2018 22:00:39 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18031401-0020-0000-0000-00000D9659A7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008668; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002682; UDB=6.00510218; IPR=6.00782011;
 MB=3.00020017; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 01:00:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031401-0021-0000-0000-0000607BF6E9
Message-Id: <87zi3b8o94.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140008
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Young <dyoung@redhat.com> writes:

> On 03/06/18 at 07:22pm, AKASHI Takahiro wrote:
>> As arch_kexec_kernel_image_{probe,load}(),
>> arch_kimage_file_post_load_cleanup() and arch_kexec_kernel_verify_sig()
>> are almost duplicated among architectures, they can be commonalized with
>> an architecture-defined kexec_file_ops array. So let's factor them out.
>> 
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kexec.h            |  2 +-
>>  arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
>>  arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++-----------------
>>  arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
>>  arch/x86/kernel/kexec-bzimage64.c           |  2 +-
>>  arch/x86/kernel/machine_kexec_64.c          | 45 +---------------------
>>  include/linux/kexec.h                       | 13 +++----
>>  kernel/kexec_file.c                         | 60 +++++++++++++++++++++++++++--
>>  8 files changed, 71 insertions(+), 94 deletions(-)
>> 
>
> For this patch it also needs some review from powerpc people. 

FWIW:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Also, tested on a ppc64le KVM guest:

Tested-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
