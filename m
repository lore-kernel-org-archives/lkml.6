Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C478C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCF02087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfAaGmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:42:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727623AbfAaGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:42:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V6cYaZ097421
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:42:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbuc59qcw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:42:00 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 31 Jan 2019 06:41:57 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 06:41:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V6filb25034870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 06:41:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DDB0A4054;
        Thu, 31 Jan 2019 06:41:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E948A405C;
        Thu, 31 Jan 2019 06:41:41 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 31 Jan 2019 06:41:41 +0000 (GMT)
Date:   Thu, 31 Jan 2019 08:41:39 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Salter <msalter@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
        linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        openrisc@lists.librecores.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013106-0028-0000-0000-00000341269A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013106-0029-0000-0000-000023FF2799
Message-Id: <20190131064139.GB28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 07:07:46AM +0100, Christophe Leroy wrote:
> 
> 
> Le 21/01/2019 à 09:04, Mike Rapoport a écrit :
> >Add check for the return value of memblock_alloc*() functions and call
> >panic() in case of error.
> >The panic message repeats the one used by panicing memblock allocators with
> >adjustment of parameters to include only relevant ones.
> >
> >The replacement was mostly automated with semantic patches like the one
> >below with manual massaging of format strings.
> >
> >@@
> >expression ptr, size, align;
> >@@
> >ptr = memblock_alloc(size, align);
> >+ if (!ptr)
> >+ 	panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> >size, align);
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> >Acked-by: Paul Burton <paul.burton@mips.com>	     # MIPS
> >Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> >Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> >---
> 
> [...]
> 
> >diff --git a/mm/sparse.c b/mm/sparse.c
> >index 7ea5dc6..ad94242 100644
> >--- a/mm/sparse.c
> >+++ b/mm/sparse.c
> 
> [...]
> 
> >@@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> >  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> >  						__pa(MAX_DMA_ADDRESS),
> >  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >+	if (!sparsemap_buf)
> >+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
> >+		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
> >+
> 
> memblock_alloc_try_nid_raw() does not panic (help explicitly says: Does not
> zero allocated memory, does not panic if request cannot be satisfied.).

"Does not panic" does not mean it always succeeds.
 
> Stephen Rothwell reports a boot failure due to this change.

Please see my reply on that thread.

> Christophe
> 
> >  	sparsemap_buf_end = sparsemap_buf + size;
> >  }
> >
> 

-- 
Sincerely yours,
Mike.

