Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeDIQRc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:17:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752957AbeDIQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:17:30 -0400
Subject: Re: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <17b19aac-fed7-23a2-013c-43ca867152e9@synopsys.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 18:17:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <17b19aac-fed7-23a2-013c-43ca867152e9@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040916-0044-0000-0000-000005452C35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040916-0045-0000-0000-000028855870
Message-Id: <21c34965-ec30-4d7f-aeaf-cb3da9758a0e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 18:03, Vineet Gupta wrote:
> On 04/09/2018 06:57 AM, Laurent Dufour wrote:
>> The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
>> per architecture header files. This doesn't allow to make other
>> configuration dependent on it.
> 
> So I understand this series has more "readability" value and I'm fine with this
> change but I wonder if you really would want to make something depend on it or
> make this de-configurable. PTE special is really a fundamental construct - e.g.
> it is used for anon mapped pages where zero page has been wired up etc...

I don't want it to be de-configurable. This is almost like
ARCH_SUPPORTS_MEMORY_FAILURE, ARCH_USES_HIGH_VMA_FLAGS, ARCH_HAS_HMM...

These values are selected by per architecture Kconfig files and are not exposed
through the configuration menu.

Concerning making something depend on it, I will probably make
CONFIG_SPECULATIVE_PAGE_FAULT introduced by the SPF series dependent on it.
For details, please see https://lkml.org/lkml/2018/3/13/1143

Thanks,
Laurent.
