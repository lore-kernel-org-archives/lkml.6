Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C15C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20B82173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y9KRv5RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfAIRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:35:50 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42708 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAIRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:35:47 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0923510C06E4;
        Wed,  9 Jan 2019 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547055347; bh=dLQjG0CgsBH+cuIB1ifRfV93mAl9B+lEcfOWPX7DSFc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Y9KRv5RA9WoIrAO7nbUjwtxhu3+08QWCloP9E+7ds/E+b8Qwlg2fDlYcYxDkAkW8L
         u6nadTbBm+8zblKO8SfRonwHYZs0PTyyhV7EvxuKY5Yu1wkqi2GyRuKUioDv0RiaiA
         qgfKhDwPt1q8na4Pb15yrc15xwYDN317aIOzo6kkgWRz+Pg5SNADCZePb0pjxnVPAq
         XEXLCQsieOaHZBm3FP1mxRk+mlQK8xQbDO84vaqvSBtjJa7mCrACgOGlA1k3LBAlrj
         TcMQogxZIQQygFrHv1NuBVBkT9CJyM5/SZ9Q0+Qqda7UIo1F8NrEkAz0SapfQ7TAPh
         SUgmBJLJwaYhQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id EFC385F15;
        Wed,  9 Jan 2019 09:35:46 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 9 Jan 2019 09:35:46 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 9 Jan 2019 23:05:44 +0530
Received: from [10.10.161.70] (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 9 Jan 2019 23:05:46 +0530
Subject: Re: [PATCH] ARC: show detaled ActionPoint configuration in mumbojumbo
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel
References: <20181228164444.11241-1-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <105ed98c-fdd0-3cbc-825f-f8cd0c782cce@synopsys.com>
Date:   Wed, 9 Jan 2019 09:35:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228164444.11241-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 8:44 AM, Eugeniy Paltsev wrote:
> Add information about ActionPointis number and supported set
> of targets (minimum / full).
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/include/asm/arcregs.h |  8 +++++++
>  arch/arc/kernel/setup.c        | 53 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
> index 49bfbd879caa..aa673e27add5 100644
> --- a/arch/arc/include/asm/arcregs.h
> +++ b/arch/arc/include/asm/arcregs.h
> @@ -216,6 +216,14 @@ struct bcr_fp_arcv2 {
>  #endif
>  };
>  


> +
>  #include <soc/arc/timers.h>
>  
>  struct bcr_bpu_arcompact {
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index b2cae79a25d7..c8d67f9cd40d 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -115,6 +115,47 @@ static void read_decode_ccm_bcr(struct cpuinfo_arc *cpu)
>  	}
>  }
>  
> +static bool actionpoints_exists(void)
> +{
> +	struct bcr_actionpoint bcr;
> +
> +	READ_BCR(ARC_REG_AP_BCR, bcr);
> +	return !!bcr.ver;
> +}

Lets try to follow the existing coding convention of this file. I don't see much
value of this helper.

> +
> +static const char *actionpoints_configuration(void)
> +{
> +	struct bcr_actionpoint bcr;
> +
> +	READ_BCR(ARC_REG_AP_BCR, bcr);
> +	switch (bcr.type) {
> +	case 0x0:
> +		return "2, full";
> +	case 0x1:
> +		return "4, full";
> +	case 0x2:
> +		return "8, full";
> +	case 0x4:
> +		return "2, minimum";
> +	case 0x5:
> +		return "4, minimum";
> +	case 0x6:
> +		return "8, minimum";
> +
> +	default:
> +		return "unknown";
> +	}

This might sound pedantic, but this is adding 8 unique string to rodata. Again
following the convention we could fine grain the bcr into 2 bitfields: full, num
etc. And decode them just as we do for mmu/cache bcrs.

> +}
> +
> +static int actionpoints_mumbojumbo(char *buf, int len)
> +{
> +	if (!actionpoints_exists())
> +		return 0;
> +
> +	return scnprintf(buf, len, "ActionPoint (%s set)",
> +			 actionpoints_configuration());
> +}
> +
>  static void read_arc_build_cfg_regs(void)
>  {
>  	struct bcr_timer timer;
> @@ -206,8 +247,7 @@ static void read_arc_build_cfg_regs(void)
>  		}
>  	}
>  
> -	READ_BCR(ARC_REG_AP_BCR, bcr);
> -	cpu->extn.ap = bcr.ver ? 1 : 0;
> +	cpu->extn.ap = actionpoints_exists();
>  
>  	READ_BCR(ARC_REG_SMART_BCR, bcr);
>  	cpu->extn.smart = bcr.ver ? 1 : 0;
> @@ -332,12 +372,15 @@ static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
>  			       IS_AVAIL1(cpu->extn.fpu_sp, "SP "),
>  			       IS_AVAIL1(cpu->extn.fpu_dp, "DP "));
>  
> -	if (cpu->extn.debug)
> -		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s%s\n",
> -			       IS_AVAIL1(cpu->extn.ap, "ActionPoint "),
> +	if (cpu->extn.debug) {
> +		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s",
>  			       IS_AVAIL1(cpu->extn.smart, "smaRT "),
>  			       IS_AVAIL1(cpu->extn.rtt, "RTT "));
>  
> +		n += actionpoints_mumbojumbo(buf + n, len - n);
> +		n += scnprintf(buf + n, len - n, "\n");
> +	}
> +
>  	if (cpu->dccm.sz || cpu->iccm.sz)
>  		n += scnprintf(buf + n, len - n, "Extn [CCM]\t: DCCM @ %x, %d KB / ICCM: @ %x, %d KB\n",
>  			       cpu->dccm.base_addr, TO_KB(cpu->dccm.sz),
> 

How does below look like ?

------------->
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 9f10d32ee1bd..f1b86cef0905 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -216,6 +216,14 @@ struct bcr_fp_arcv2 {
 #endif
 };

+struct bcr_actionpoint {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:21, min:1, num:2, ver:8;
+#else
+	unsigned int ver:8, num:2, min:1, pad:21;
+#endif
+};
+
 #include <soc/arc/timers.h>

 struct bcr_bpu_arcompact {
@@ -302,7 +310,7 @@ struct cpuinfo_arc {
 	struct {
 		unsigned int swap:1, norm:1, minmax:1, barrel:1, crc:1, swape:1, pad1:2,
 			     fpu_sp:1, fpu_dp:1, dual:1, dual_enb:1, pad2:4,
-			     debug:1, ap:1, smart:1, rtt:1, pad3:4,
+			     ap_num:4, ap_full:1, smart:1, rtt:1, pad3:1,
 			     timer0:1, timer1:1, rtc:1, gfrc:1, pad4:4;
 	} extn;
 	struct bcr_mpy extn_mpy;
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 926e1bc1cd7f..b4c1db2811af 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -122,6 +122,7 @@ static void read_arc_build_cfg_regs(void)
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
 	const struct id_to_str *tbl;
 	struct bcr_isa_arcv2 isa;
+	struct bcr_actionpoint ap;

 	FIX_PTR(cpu);

@@ -207,8 +208,11 @@ static void read_arc_build_cfg_regs(void)
 		}
 	}

-	READ_BCR(ARC_REG_AP_BCR, bcr);
-	cpu->extn.ap = bcr.ver ? 1 : 0;
+	READ_BCR(ARC_REG_AP_BCR, ap);
+	if (ap.ver) {
+		cpu->extn.ap_num = 2 << ap.num;
+		cpu->extn.ap_full = !ap.min;
+	}

 	READ_BCR(ARC_REG_SMART_BCR, bcr);
 	cpu->extn.smart = bcr.ver ? 1 : 0;
@@ -216,8 +220,6 @@ static void read_arc_build_cfg_regs(void)
 	READ_BCR(ARC_REG_RTT_BCR, bcr);
 	cpu->extn.rtt = bcr.ver ? 1 : 0;

-	cpu->extn.debug = cpu->extn.ap | cpu->extn.smart | cpu->extn.rtt;
-
 	READ_BCR(ARC_REG_ISA_CFG_BCR, isa);

 	/* some hacks for lack of feature BCR info in old ARC700 cores */
@@ -336,11 +338,17 @@ static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
 			       IS_AVAIL1(cpu->extn.fpu_sp, "SP "),
 			       IS_AVAIL1(cpu->extn.fpu_dp, "DP "));

-	if (cpu->extn.debug)
-		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s%s\n",
-			       IS_AVAIL1(cpu->extn.ap, "ActionPoint "),
+	if (cpu->extn.ap_num | cpu->extn.smart | cpu->extn.rtt) {
+		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s",
 			       IS_AVAIL1(cpu->extn.smart, "smaRT "),
 			       IS_AVAIL1(cpu->extn.rtt, "RTT "));
+		if (cpu->extn.ap_num) {
+			n += scnprintf(buf + n, len - n, "ActionPoint %d/%s",
+				       cpu->extn.ap_num,
+				       cpu->extn.ap_full ? "full":"min");
+		}
+		n += scnprintf(buf + n, len - n, "\n");
+	}

 	if (cpu->dccm.sz || cpu->iccm.sz)
 		n += scnprintf(buf + n, len - n, "Extn [CCM]\t: DCCM @ %x, %d
