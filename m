Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B1ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDC420831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O0MxlZxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDC420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJYC5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:57:47 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:35606 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJYC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:57:47 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7193424E0625;
        Wed, 24 Oct 2018 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540405720; bh=XqFsf31g+q77z+VbWOPmcY5SVmrJw/NGNXxD5uwgCMw=;
        h=From:To:CC:Subject:Date:References:From;
        b=O0MxlZxrCvuyuh22BJsENH2JN+Xp5DXSY1iMhHb9Ql/4gUDD8CMwr2mHjJn21pIfK
         UVPGNt22x1a2j7rHAttXjSbGZBNVkGy1qQtuKp9NujxTUub1BtgcFd/WqJyKigmeaC
         L30KPkYz1EU5dfhugGc4CXh48HDEsWaRjqvBjcL4jXS6F1Cchfox944hjYcbOWHAmK
         PO/myf8Qm2HkW+BgVmAP6Gp4QCB5N/6tpOFlatIGJQLlkuYWcc6hYrwYXV13N/bR3g
         m7qsvtepFdXOJkk2jIWuecAqoUFJorN0hIc7vgBy1PUVkyn0+MR0LAmRnHcMddO6a7
         By2srm5MQVK0A==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3A4DA3FE3;
        Wed, 24 Oct 2018 11:28:40 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 24 Oct 2018 11:28:40 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: [RFC] ARC: ARCv2: Introduce SmaRT support
Thread-Topic: [RFC] ARC: ARCv2: Introduce SmaRT support
Thread-Index: AQHUZ7fnYyx8g5Ko2kaL4n2YApOlcw==
Date:   Wed, 24 Oct 2018 18:28:38 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0B4D20@US01WEMBX2.internal.synopsys.com>
References: <20181019142738.31085-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
On 10/19/2018 07:27 AM, Eugeniy Paltsev wrote:=0A=
> Add compile-time 'ARC_USE_SMART' option for enabling SmaRT support.=0A=
=0A=
Nice !=0A=
=0A=
> Small real time trace (SmaRT) is an optional on-chip debug hardware=0A=
> component that captures instruction-trace history. It stores the=0A=
> address of the most recent non-sequential instructions executed into=0A=
> internal buffer.=0A=
>=0A=
> Usually we use MetaWare debugger to enable SmaRT and display trace=0A=
> information.=0A=
>=0A=
> This patch allows to display the decoded content of SmaRT buffer=0A=
> without MetaWare debugger. It is done by extending ordinary exception=0A=
> message with decoded SmaRT instruction-trace history.=0A=
>=0A=
> In some cases it's really usefull as it allows to show pre-exception=0A=
> instruction-trace which was not tainted by exception handler code,=0A=
> printk code, etc...=0A=
=0A=
So the reason is not so much as lack of mdb, but to reduce the trace clutte=
r. Its=0A=
funny because mdb goes to great lengths to generate the clutter (i.e. recon=
struct=0A=
the interim disassembly from the sparse smaRT entries)=0A=
=0A=
> Nevertheless this option has negative performance impact due to=0A=
> implementation as we dump SmaRT buffer content into external memory=0A=
> buffer in the begining of every slowpath exception handler code.=0A=
> We choose this implementation as a compromise between performance=0A=
> impact and SmaRT buffer tainting.=0A=
> Although the performance impact is not really significant (according=0A=
> to lmbench) we leave this option disabled by default.=0A=
=0A=
Oh yes, this a debug feature and intrusive even if not shows in profiles, s=
o needs=0A=
to be disabled by default.=0A=
=0A=
> Here is th examples of user-space and kernel-space fault messages with=0A=
> 'ARC_USE_SMART' option enabled:=0A=
>=0A=
> User-space exception:=0A=
> ----------------------->8-------------------------=0A=
> Exception: u_hell[99]: at 0x103a2 [off 0x103a2 in /root/u_hell, VMA: 0001=
0000:00012000]=0A=
>   ECR: 0x00050200 =3D> Invalid Write @ 0x00000000 by insn @ 0x000103a2=0A=
> SmaRT (64 entries):=0A=
>  [   0]    V 0x90232358 -> 0x9022ce3c [src do_page_fault+0x2c/0x2d8] [dst=
 populate_smart+0x0/0x9c]=0A=
=0A=
So I had to dig into smart spec to understand this src, dst stuff. What it =
implies=0A=
is that @src PC, a branch to @dst was taken.=0A=
Say we have samples SRC1: DST1, SRC2:DST2. All this is implies is that thes=
e 4 PCs=0A=
were observed. So just flatten out the SRC/DST and print them in order. So =
only 1=0A=
PC entry per line. makes it easier to follow and comprehend.=0A=
=0A=
>  [   1]    V 0x9022e3f8 -> 0x9023232c [src EV_TLBProtV+0xec/0xf0] [dst do=
_page_fault+0x0/0x2d8]=0A=
>  [   2]    V 0x90233194 -> 0x9022e30c [src do_slow_path_pf+0x10/0x14] [ds=
t EV_TLBProtV+0x0/0xf0]=0A=
>  [   3]    V 0x90233120 -> 0x90233184 [src EV_TLBMissD+0x80/0xe0] [dst do=
_slow_path_pf+0x0/0x14]=0A=
>  [   4]  E V 0x000103a2 -> 0x902330a0 [off 0x103a2 in /root/u_hell, VMA: =
00010000:00012000] [dst EV_TLBMissD+0x0/0xe0]=0A=
>  [   5] U  V 0x2004f238 -> 0x00010398 [off 0x43238 in /lib/libuClibc-1.0.=
18.so, VMA: 2000c000:20072000] [off 0x10398 in /root/u_hell, VMA: 00010000:=
00012000]=0A=
>  [   6] U  V 0x20049a82 -> 0x2004f214 [off 0x3da82 in /lib/libuClibc-1.0.=
18.so, VMA: 2000c000:20072000] [off 0x43214 in /lib/libuClibc-1.0.18.so, VM=
A: 2000c000:20072000]=0A=
=0A=
Once we do above, then we can reduce the print clutter by only printing the=
 vma if=0A=
it changed - again less printing means brain has to process less informatio=
n.=0A=
=0A=
> ...[snip]...=0A=
> ----------------------->8-------------------------=0A=
>=0A=
> TODO:=0A=
>   Add runtime procfs options to configure/suspend SmaRT.=0A=
=0A=
Good.=0A=
=0A=
>   Add SmaRT BCR encoding struct.=0A=
>   Check SmaRT version number in BCR.=0A=
=0A=
Do we need to also think about how to co-exist with mdb. What if uses enabl=
es it=0A=
in mdb before hitting run etc.=0A=
=0A=
> NOTE:=0A=
> this RFC has prerequisite:=0A=
>   http://patchwork.ozlabs.org/patch/986820/=0A=
=0A=
Right I'm still not happy with our approach there and I will respond sepera=
tely=0A=
after a few trials and tribulations of my own so please be patient with tha=
t.=0A=
See below for some coding comments=0A=
=0A=
>  =0A=
> +config ARC_USE_SMART=0A=
=0A=
ARC_SMART_TRACE ? I know why you picked the _USE_, but the semantics are di=
fferent=0A=
here.=0A=
=0A=
=0A=
> +	bool "Enable real time trace on-chip debug HW"=0A=
=0A=
This might confused with RTT, so keep smaRT keyword here with hungarian cas=
e.=0A=
=0A=
> diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h=0A=
>  =0A=
> +#ifdef CONFIG_ARC_USE_SMART=0A=
> +void populate_smart(void);=0A=
> +#define POPULATE_SMART()	populate_smart()=0A=
> +#else=0A=
> +#define POPULATE_SMART()=0A=
> +#endif /* CONFIG_ARC_USE_SMART */=0A=
> +=0A=
=0A=
Lets keep all smart related stuff in files of own: smart.h and smart.c=0A=
=0A=
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c=0A=
>  =0A=
>  	arc_chk_core_config();=0A=
> +=0A=
> +#ifdef CONFIG_ARC_USE_SMART=0A=
=0A=
> +	if (cpuinfo_arc700[cpu_id].extn.smart)=0A=
=0A=
IS_ENABLED() is better here=0A=
=0A=
> +		write_aux_reg(ARC_AUX_SMART_CONTROL, SMART_CTL_EN);=0A=
> +#endif=0A=
> +=0A=
>  }=0A=
>  =0A=
> diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoo=
t.c=0A=
>  =0A=
> +#ifdef CONFIG_ARC_USE_SMART=0A=
> +#define MAX_SMART_BUFF	4096=0A=
> +=0A=
> +struct smart_buff {=0A=
> +	u32 src[MAX_SMART_BUFF];=0A=
> +	u32 dst[MAX_SMART_BUFF];=0A=
> +	u32 flags[MAX_SMART_BUFF];=0A=
> +};=0A=
=0A=
Move all of this into smart.c=0A=
=0A=
> +#ifdef CONFIG_ARC_USE_SMART=0A=
> +static inline bool smart_exist(void)=0A=
> +{=0A=
> +	struct bcr_generic bcr;=0A=
> +=0A=
> +	READ_BCR(ARC_REG_SMART_BCR, bcr);=0A=
> +	return !!bcr.ver ;=0A=
> +}=0A=
> +=0A=
> +static inline u32 smart_stack_size(void)=0A=
> +{=0A=
> +	return read_aux_reg(ARC_REG_SMART_BCR) >> SMART_CTL_IDX_POS;=0A=
> +}=0A=
> +=0A=
> +static inline void smart_enable(void)=0A=
> +{=0A=
> +	write_aux_reg(ARC_AUX_SMART_CONTROL, SMART_CTL_EN);=0A=
> +}=0A=
> +=0A=
> +static inline void smart_disable(void)=0A=
> +{=0A=
> +	write_aux_reg(ARC_AUX_SMART_CONTROL, 0);=0A=
> +}=0A=
=0A=
Good coding style.=0A=
=0A=
> +=0A=
> +static void show_smart(void)=0A=
> +{=0A=
> +	struct smart_buff *smart_buff_cpu =3D this_cpu_ptr(&smart_buff_log);=0A=
> +	int i, stack_size;=0A=
> +	char *buf;=0A=
> +=0A=
> +	if (!smart_exist())=0A=
> +		return;=0A=
> +=0A=
> +	stack_size =3D smart_stack_size();=0A=
> +	pr_info("SmaRT (%d entries):\n", stack_size);=0A=
> +=0A=
> +	buf =3D (char *)__get_free_page(GFP_NOWAIT);=0A=
> +	if (!buf)=0A=
> +		return;=0A=
> +=0A=
> +	for (i =3D 0; i < stack_size; i++) {=0A=
> +		pr_info(" [%4d] %s%s%s%s %#010x -> %#010x ", i,=0A=
> +			smart_buff_cpu->flags[i] & SMART_FLAG_U ? "U" : " ",=0A=
> +			smart_buff_cpu->flags[i] & SMART_FLAG_E ? "E" : " ",=0A=
> +			smart_buff_cpu->flags[i] & SMART_FLAG_R ? "R" : " ",=0A=
> +			smart_buff_cpu->flags[i] & SMART_FLAG_V ? "V" : " ",=0A=
> +			smart_buff_cpu->src[i], smart_buff_cpu->dst[i]);=0A=
> +=0A=
> +		if (smart_buff_cpu->src[i] < 0x80000000)=0A=
> +			show_faulting_vma(smart_buff_cpu->src[i], buf);=0A=
> +		else=0A=
> +			pr_cont("[src %pS] ", (void *)smart_buff_cpu->src[i]);=0A=
> +=0A=
> +		if (smart_buff_cpu->dst[i] < 0x80000000)=0A=
> +			show_faulting_vma(smart_buff_cpu->dst[i], buf);=0A=
> +		else=0A=
> +			pr_cont("[dst %pS]\n", (void *)smart_buff_cpu->dst[i]);=0A=
=0A=
Some of this changes, based on my comments above about flattening src/dst !=
=0A=
=0A=
> @@ -199,6 +307,10 @@ void show_exception_mesg(struct pt_regs *regs)=0A=
>  		show_exception_mesg_u(regs);=0A=
>  	else=0A=
>  		show_exception_mesg_k(regs);=0A=
> +=0A=
> +#ifdef CONFIG_ARC_USE_SMART=0A=
> +	show_smart();=0A=
> +#endif /* CONFIG_ARC_USE_SMART */=0A=
=0A=
Provide 2 variants in header to avoid #ifdef here.=0A=
=0A=
