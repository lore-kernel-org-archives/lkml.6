Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C99C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3199420835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJLVLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:11:35 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33583 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbeJLVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:11:35 -0400
Received: by mail-wr1-f49.google.com with SMTP id e4-v6so13498404wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 06:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7tYwUebON2kh6dHhqnnL7wbi9A2GOZXTlEa/g+AAmDc=;
        b=P7du6PHI6aQiMvJ6hf0+eydF+L8a1GwI5kDCuGod2tpMcRBCXV8xz1RXPkgyFa0XO/
         XzCp+4H2U13ztLnXIpk1B/9RFwBKgC26ymHnWEkqhA8jCFQFZr1U2//9x3NSESNiQoCi
         jCmg4V+7oU2UNV+ltfbYidonfWNlkM+O/8ZFToXabTNIO1x5+3nvZNyhCsXKrt1jJHri
         DoD0UEDaWqwhKax+TYubyEkGBiHuAkBJoLD3MVXPGhZA42bzd3t8UxqqLVRRyR6QLApZ
         SupNj2KIJ8U8Kvtj1LvA/OqxfUIaUtBR9lPd8AwlDdBO24a4mZ+o3/wgmeL6+zb4CA4S
         zwdw==
X-Gm-Message-State: ABuFfoi/CYPbcUyl/hJdY6x6ZvOex4HZhI15wLwe9EPaamkvbI685zhE
        NKvtZTMRFl3YiQg2qiAx1qQ8TA==
X-Google-Smtp-Source: ACcGV63HRnENpYZ2bNtE+pYK8QPH9to0grk9fmZWqtTxydapWa9cq1C2UHDLrci43umtNnC66bjuRA==
X-Received: by 2002:a5d:618f:: with SMTP id j15-v6mr5836263wru.198.1539351541536;
        Fri, 12 Oct 2018 06:39:01 -0700 (PDT)
Received: from sokar.ausil.us ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1065593wmt.16.2018.10.12.06.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 06:39:00 -0700 (PDT)
Message-ID: <a59c9c9868193fb5a518118cd0872da84370a2c8.camel@redhat.com>
Subject: Re: issues with suspend on Dell XPS 13 2-in-1
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>
Date:   Fri, 12 Oct 2018 08:38:59 -0500
In-Reply-To: <1524755327.13783.1.camel@intel.com>
References: <6ce634cb82617c2a9a060ba6e2accef2a15dcc15.camel@redhat.com>
         <b7c4434319bf4ff8877f882d219a60ba@ausx13mpc120.AMER.DELL.COM>
         <1524005977.31134.15.camel@intel.com>
         <CAJesf3MUUGo_MVpr9+8zy-Nm5OAuYu1uwo2z50T2KcN-G5B5ew@mail.gmail.com>
         <1524708778.7505.1.camel@intel.com>
         <9f3043be59108e5c7f75786ce11cf1018aa15880.camel@redhat.com>
         <1524720852.10001.1.camel@intel.com>
         <e24a766b1a475eab0e8f3fda131758dc8d1ca219.camel@redhat.com>
         <1524755327.13783.1.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 26-04-2018 a las 15:09 +0000, Pandruvada, Srinivas escribió:
> On Thu, 2018-04-26 at 07:42 -0500, Dennis Gilmore wrote:
> > Hi Srinivas,
> > 
> > El jue, 26-04-2018 a las 05:34 +0000, Pandruvada, Srinivas
> > escribió:
> > > Hi Dennis,
> > > 
> > > On Wed, 2018-04-25 at 22:06 -0500, Dennis Gilmore wrote:
> > > > Hi Srinivas,
> > > > 
> > > > Yes I have latest bios, I have version 1.3.1 that was released
> > > > on
> > > > 18th
> > > > of  Feb.
> > > 
> > > Can you try these commands and repeat the test?
> > > 
> > > # cd /sys/kernel/debug/pmc_core/
> > > # for i in {0..32}; do echo $i > ltr_ignore; done
> > 
> > # for i in {0..32}; do echo $i > ltr_ignore; done
> > -bash: ltr_ignore: Operación no permitida

After some digging i figured out that the patches fedora has for
secureboot caused the access to ltr_ignore to not work. 

# turbostat 
turbostat version 18.07.27 - Len Brown <lenb@kernel.org>
CPUID(0): GenuineIntel 22 CPUID levels; family:model:stepping 0x6:8e:9
(6:142:9)
CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM HT TM
CPUID(6): APERF, TURBO, DTS, PTM, HWP, HWPnotify, HWPwindow, HWPepp,
No-HWPpkg, EPB
cpu1: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
CPUID(7): SGX
cpu1: MSR_IA32_FEATURE_CONTROL: 0x0000ff07 (Locked )
CPUID(0x15): eax_crystal: 2 ebx_tsc: 134 ecx_crystal_hz: 0
TSC: 1608 MHz (24000000 Hz * 134 / 2 / 1000000)
CPUID(0x16): base_mhz: 1600 max_mhz: 3600 bus_mhz: 100
cpu1: MSR_MISC_PWR_MGMT: 0x00401cc0 (ENable-EIST_Coordination DISable-
EPB DISable-OOB)
RAPL: 58254 sec. Joule Counter Range, at 4 Watts
cpu1: MSR_PLATFORM_INFO: 0x804043df1011000
4 * 100.0 = 400.0 MHz max efficiency frequency
16 * 100.0 = 1600.0 MHz base frequency
cpu1: MSR_IA32_POWER_CTL: 0x0024005d (C1E auto-promotion: DISabled)
cpu1: MSR_TURBO_RATIO_LIMIT: 0x22222224
34 * 100.0 = 3400.0 MHz max turbo 4 active cores
34 * 100.0 = 3400.0 MHz max turbo 3 active cores
34 * 100.0 = 3400.0 MHz max turbo 2 active cores
36 * 100.0 = 3600.0 MHz max turbo 1 active cores
cpu1: MSR_CONFIG_TDP_NOMINAL: 0x0000000d (base_ratio=13)
cpu1: MSR_CONFIG_TDP_LEVEL_1: 0x0006001c (PKG_MIN_PWR_LVL1=0
PKG_MAX_PWR_LVL1=0 LVL1_RATIO=6 PKG_TDP_LVL1=28)
cpu1: MSR_CONFIG_TDP_LEVEL_2: 0x00100038 (PKG_MIN_PWR_LVL2=0
PKG_MAX_PWR_LVL2=0 LVL2_RATIO=16 PKG_TDP_LVL2=56)
cpu1: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
cpu1: MSR_TURBO_ACTIVATION_RATIO: 0x0000000c (MAX_NON_TURBO_RATIO=12
lock=0)
cpu1: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3, UNdemote-C1, 
demote-C3, demote-C1, locked, pkg-cstate-limit=8 (unlimited))
cpu1: POLL: CPUIDLE CORE POLL IDLE
cpu1: C1: MWAIT 0x00
cpu1: C1E: MWAIT 0x01
cpu1: C3: MWAIT 0x10
cpu1: C6: MWAIT 0x20
cpu1: C7s: MWAIT 0x33
cpu1: C8: MWAIT 0x40
cpu1: C9: MWAIT 0x50
cpu1: C10: MWAIT 0x60
cpu1: cpufreq driver: intel_pstate
cpu1: cpufreq governor: powersave
cpufreq intel_pstate no_turbo: 0
cpu1: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-
pair L1-Prefetch L1-IP-Prefetch)
cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
cpu0: MSR_HWP_CAPABILITIES: 0x01070d24 (high 36 guar 13 eff 7 low 1)
cpu0: MSR_HWP_REQUEST: 0x80002404 (min 4 max 36 des 0 epp 0x80 window
0x0 pkg 0x0)
cpu0: MSR_HWP_INTERRUPT: 0x00000000 (Dis_Guaranteed_Perf_Change,
Dis_Excursion_Min)
cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-
Excursion_Min)
cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061 Joules,
0.000977 sec.)
cpu0: MSR_PKG_POWER_INFO: 0x00000024 (4 W TDP, RAPL 0 - 0 W, 0.000000
sec.)
cpu0: MSR_PKG_POWER_LIMIT: 0x420078009c8048 (UNlocked)
cpu0: PKG Limit #1: ENabled (9.000000 Watts, 24.000000 sec, clamp
DISabled)
cpu0: PKG Limit #2: DISabled (15.000000 Watts, 0.002441* sec, clamp
DISabled)
cpu0: MSR_DRAM_POWER_LIMIT: 0x5400de00000000 (UNlocked)
cpu0: DRAM Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
DISabled)
cpu0: MSR_PP0_POLICY: 0
cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
DISabled)
cpu0: MSR_PP1_POLICY: 0
cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
DISabled)
cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0a640080 (100 C)
cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x882e0808 (54 C)
cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
cpu1: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
cpu1: MSR_PKGC6_IRTL: 0x00008876 (valid, 120832 ns)
cpu1: MSR_PKGC7_IRTL: 0x00008894 (valid, 151552 ns)
cpu1: MSR_PKGC8_IRTL: 0x000088fa (valid, 256000 ns)
cpu1: MSR_PKGC9_IRTL: 0x0000894c (valid, 339968 ns)
cpu1: MSR_PKGC10_IRTL: 0x00008bf2 (valid, 1034240 ns)
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	SMI	POLL	
C1	C1E	C3	C6	C7s	C8	C9	C10	POLL%	
C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	CPU%c1	
CPU%c3	CPU%c6	CPU%c7	CoreTmp	PkgTmp	GFX%rc6	GFXMHz	Totl%C0	Any%C0	
GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8	Pkg%pc9	Pk%pc10
	CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt	PKG_%	RAM_%
-	-	238	14.13	1682	1607	7665	0	5	
191	226	243	1561	0	1603	199	2418	0.00	
0.24	0.27	0.12	4.510.00	7.03	3.45	70.17	14.11	
0.08	5.96	65.71	51	51	94.67	300	52.99	44.18	
5.13	3.41	12.05	40.26	0.00	0.00	0.00	0.000.00	
0.00	0.00	3.37	1.73	0.02	0.47	0.00	0.00
0	0	215	14.00	1534	1607	2766	0	3	
120	68	87	549	0	423	116	732	0.00	
0.35	0.25	0.17	6.170.00	7.39	9.48	62.09	10.17	
0.10	7.33	68.40	49	51	94.67	300	53.01	44.19	
5.13	3.41	12.05	40.27	0.00	0.00	0.00	0.000.00	
0.00	0.00	3.37	1.73	0.02	0.47	0.00	0.00
0	2	117	9.06	1297	1607	1600	0	1	
16	76	73	394	0	512	34	693	0.00	
0.08	0.47	0.14	4.500.00	8.65	1.55	75.54	15.12
1	1	168	10.72	1569	1608	1459	0	1	
30	48	40	342	0	306	42	581	0.00	
0.32	0.28	0.08	3.680.00	5.47	2.63	76.75	21.58	
0.06	4.60	63.04	51
1	3	450	22.74	1979	1608	1840	0	0	
25	34	43	276	0	362	7	412	0.00	
0.21	0.07	0.09	3.680.00	6.60	0.14	66.29	9.57
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	SMI	POLL	
C1	C1E	C3	C6	C7s	C8	C9	C10	POLL%	
C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	CPU%c1	
CPU%c3	CPU%c6	CPU%c7	CoreTmp	PkgTmp	GFX%rc6	GFXMHz	Totl%C0	Any%C0	
GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8	Pkg%pc9	Pk%pc10
	CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt	PKG_%	RAM_%
-	-	292	19.04	1535	1608	10249	12	18	
455	702	509	2538	1	1737	190	2748	0.00	
0.37	0.47	0.31	6.330.00	7.04	2.37	64.05	14.51	
0.19	6.56	59.70	49	50	90.05	300	63.43	45.18	
9.83	4.95	11.88	36.32	0.00	0.00	0.00	0.000.00	
0.00	0.00	3.33	1.63	0.04	0.56	0.00	0.00
0	0	304	20.87	1459	1608	3771	3	7	
106	156	119	824	0	527	79	714	0.01	
0.32	0.48	0.29	9.520.00	8.61	5.20	54.69	18.23	
0.16	6.46	54.29	49	50	90.05	300	63.43	45.18	
9.83	4.95	11.88	36.32	0.00	0.00	0.00	0.000.00	
0.00	0.00	3.33	1.63	0.04	0.56	0.00	0.00
0	2	464	23.30	1992	1608	2368	3	3	
79	188	98	426	0	436	20	588	0.00	
0.28	0.30	0.29	3.870.00	6.92	0.88	64.04	15.79
1	1	175	13.61	1283	1608	2103	3	6	
169	154	147	644	0	455	67	760	0.00	
0.49	0.64	0.31	6.030.00	7.60	2.95	68.42	14.40	
0.22	6.66	65.11	49
1	3	226	18.39	1227	1608	2007	3	2	
101	204	145	644	1	319	24	686	0.00	
0.38	0.47	0.35	5.920.01	5.02	0.45	69.04	9.62
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	     IRQ	SMI	
    POLL	      C1	     C1E	      C3	      C
6	     C7s	      C8	      C9	     C10	
POLL%	C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	
CPU%c1	CPU%c3	CPU%c6	CPU%c7	CoreTmp	PkgTmp	GFX%rc6	GFXMHz	Totl%C0
	Any%C0	GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8
	Pkg%pc9	Pk%pc10	CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt
	PKG_%	RAM_%
-	-	38	1.97	1913	1623	 -191291	16	
     320	    5687	    2001	     711	    324
8	       2	    2630	     232	    2606	
0.00	0.08	0.06	0.03	0.46	0.00	0.65	0.12	5.58	
1.69	0.02	0.35	95.98	56	56	100.70	300	6.45	
3.88	0.20	0.16	0.32	5.20	0.00	0.00	0.03	0.00	
89.94	90.31	0.00	0.91	0.22	0.00	0.28	0.00	0.00
0	0	42	2.18	1929	1623	  -51859	4	
      93	    1696	     611	     179	     74
6	       0	     721	      86	     792	
0.00	0.09	0.07	0.03	0.39	0.00	0.70	0.14	5.46	
1.58	0.02	0.32	95.91	56	56	100.70	300	6.45	
3.88	0.20	0.16	0.32	5.20	0.00	0.00	0.03	0.00	
89.94	90.31	0.00	0.91	0.22	0.00	0.28	0.00	0.00
0	2	39	1.95	1974	1623	  -44474	4	
     134	    2280	     672	     214	     89
3	       2	     902	      40	     430	
0.00	0.13	0.08	0.04	0.52	0.00	0.90	0.14	5.31	
1.81
1	1	42	2.20	1891	1623	  -45616	4	
       6	     369	     234	     105	     63
0	       0	     310	      33	     622	
0.00	0.02	0.04	0.02	0.41	0.00	0.31	0.04	6.02	
1.36	0.01	0.37	96.06	55
1	3	29	1.56	1841	1623	  -49342	4	
      87	    1342	     484	     213	     97
9	       0	     697	      73	     762	
0.00	0.08	0.06	0.04	0.53	0.00	0.68	0.17	5.52	
2.00
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	     IRQ	SMI	
    POLL	      C1	     C1E	      C3	      C
6	     C7s	      C8	      C9	     C10	
POLL%	C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	
CPU%c1	CPU%c3	CPU%c6	CPU%c7	CoreTmp	PkgTmp	GFX%rc6	GFXMHz	Totl%C0
	Any%C0	GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8
	Pkg%pc9	Pk%pc10	CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt
	PKG_%	RAM_%
-	-	810	43.00	1883	1608	   25029	0	
      57	    3373	    1585	     864	    512
1	       1	    4401	     559	    2347	
0.01	1.25	1.20	0.62	13.02	0.00	17.74	4.14	18.47	
30.05	0.49	10.40	16.06	51	51	95.64	300	137.62	
98.15	4.11	4.02	0.00	0.00	0.00	0.00	0.00	0.00	
0.00	0.00	0.00	6.44	4.66	0.02	0.66	0.00	0.00
0	0	719	40.39	1779	1608	    6804	0	
      12	     817	     383	     225	    149
5	       0	    1207	     196	     545	
0.01	1.19	1.12	0.66	16.23	0.00	19.77	6.33	13.80	
23.34	0.67	13.51	22.09	51	51	95.64	300	137.62	
98.16	4.11	4.02	0.00	0.00	0.00	0.00	0.00	0.00	
0.00	0.00	0.00	6.44	4.66	0.02	0.66	0.00	0.00
0	2	670	34.80	1924	1608	    6507	0	
      11	     683	     442	     253	    149
6	       0	    1458	     147	     697	
0.01	1.27	1.54	0.66	13.80	0.00	22.91	4.37	20.27	
28.93
1	1	1013	52.58	1927	1608	    5901	0	
      11	     604	     263	     176	     94
5	       1	     799	     132	     577	
0.01	0.97	0.75	0.53	9.60	0.00	13.11	4.06	17.59	
29.79	0.31	7.30	10.02	50
1	3	838	44.23	1894	1608	    5817	0	
      23	    1269	     497	     210	    118
5	       0	     937	      84	     528	
0.02	1.56	1.38	0.61	12.45	0.00	15.15	1.79	22.21	
38.14
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	     IRQ	SMI	
    POLL	      C1	     C1E	      C3	      C
6	     C7s	      C8	      C9	     C10	
POLL%	C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	
CPU%c1	CPU%c3	CPU%c6	CPU%c7	CoreTmp	PkgTmp	GFX%rc6	GFXMHz	Totl%C0
	Any%C0	GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8
	Pkg%pc9	Pk%pc10	CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt
	PKG_%	RAM_%
-	-	801	44.72	1893	1522	   28623	0	
     168	    8252	    2500	    1022	    437
3	       0	    2917	     544	    3699	
0.04	2.25	1.60	0.70	9.11	0.00	10.08	4.22	23.80	
33.40	1.29	6.49	14.10	54	54	89.74	300	144.45	
95.89	5.02	4.67	0.00	0.00	0.00	0.00	0.00	0.00	
0.00	0.00	0.00	6.29	4.59	0.03	0.65	0.00	0.00
0	0	733	40.67	1904	1522	    6879	0	
      57	    1930	     691	     307	    133
3	       0	     752	     212	     948	
0.05	2.20	1.64	0.87	11.01	0.00	10.18	7.81	21.97	
41.31	0.55	6.84	10.63	52	54	89.74	300	144.45	
95.89	5.02	4.67	0.00	0.00	0.00	0.00	0.00	0.00	
0.00	0.00	0.00	6.29	4.59	0.03	0.65	0.00	0.00
0	2	937	50.69	1952	1522	    6332	0	
      38	    1968	     641	     226	     96
4	       0	     736	     128	     710	
0.04	2.25	1.46	0.66	7.81	0.00	10.51	3.86	19.43	
31.29
1	1	851	48.25	1864	1522	    5826	0	
      35	    1648	     589	     194	     87
2	       0	     482	     118	     969	
0.03	2.02	1.62	0.45	7.01	0.00	6.57	3.78	26.97	
26.01	2.03	6.13	17.58	54
1	3	685	39.28	1843	1522	    9586	0	
      38	    2706	     579	     295	    120
4	       0	     947	      86	    1072	
0.04	2.55	1.68	0.82	10.59	0.00	13.05	1.41	26.84	
34.98
^CCore	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	     IRQ	SMI	
    POLL	      C1	     C1E	      C3	      C
6	     C7s	      C8	      C9	     C10	
POLL%	C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	
CPU%c1	CPU%c3	CPU%c6	CPU%c7	CoreTmp	PkgTmp	GFX%rc6	GFXMHz	Totl%C0
	Any%C0	GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8
	Pkg%pc9	Pk%pc10	CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt
	PKG_%	RAM_%
-	-	1318	58.01	2462	1484	    5393	0	
      37	    2229	     593	     199	     94
4	       0	     422	      61	     261	
0.05	4.19	2.80	1.23	14.53	0.00	9.50	1.50	4.15	
36.81	0.24	2.94	2.00	58	58	33.73	300	178.58	
99.15	63.65	62.57	0.00	0.00	0.00	0.00	0.00	0.00	
0.00	0.00	0.00	10.04	8.11	0.18	0.83	0.00	0.00
0	0	1943	78.79	2674	1483	    1233	0	
       3	     192	      28	      22	     10
8	       0	      55	       6	      20	
0.01	2.22	0.36	0.38	9.15	0.00	5.46	0.18	0.77	
21.19	0.00	0.01	0.00	57	58	33.73	300	178.66	
99.20	63.68	62.59	0.00	0.00	0.00	0.00	0.00	0.00	
0.00	0.00	0.00	10.04	8.11	0.18	0.83	0.00	0.00
0	2	1139	52.89	2334	1484	    1436	0	
       8	     546	     137	      54	     28
0	       0	     176	       3	      54	
0.06	3.37	3.12	1.49	14.02	0.00	15.09	0.37	5.08	
47.10
1	1	1113	49.66	2428	1484	    1553	0	
      13	     853	     208	      65	     28
5	       0	     117	      19	     111	
0.06	6.25	3.63	1.72	16.95	0.00	10.30	1.44	5.64	
39.99	0.47	5.87	4.01	58
1	3	1076	50.71	2299	1485	    1171	0	
      13	     638	     220	      58	     27
1	       0	      74	      33	      76	
0.05	4.89	4.10	1.33	18.02	0.00	7.17	4.01	5.09	
38.95

