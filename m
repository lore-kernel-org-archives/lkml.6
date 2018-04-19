Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx4+zDEaPQAa+DNSO/TQNRIzSqyJ8r8yYshKD2mOVoi4nYnNVScr10JIOI2qqgbRoGw21xeZI
ARC-Seal: i=1; a=rsa-sha256; t=1524145733; cv=none;
        d=google.com; s=arc-20160816;
        b=K8Vfk19we5Wrb0tNQt0wGA6ruv/VWHSFndGJZzy5291mLzMoenG3kg29bgUHfaRYp0
         0UBDAZBEAsnv2lk+kXpPnO0ZgdlVtiaNcmKm1vtuSEWCYzJT8dpBZmO1iLKthCOIeZtt
         q2I0hZp75PbirpSEKgenHC6eD07OAHCuOjgMAKwM1D3poveXuiOkSrOxqymck6IP4NVq
         HZUs93Yn77A8iKtFdvBrb4Ds5qZjvrK0pbgIG+z1rVqlFJ3CpNLmQSplA5tLmNSFhJ3B
         HmykDYemSaC/LoSQrq4dlgeyn+wDRU6U2UtO7MWKB9kkY2xwV8S505z3kdJY4DZz1mz0
         n9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=Wvs6ujw5yoho4vSTczTy42ime2Mf45fsIsEgJFfyfpg=;
        b=hPE4WpRxIivHxwRic1R9kXyEXRFr6u7bLps+AyQyEsrne06gjUIdf6zm+TKmamWYlj
         WoU8vgzlaKpNka7Qt+K45VOwoA3qwjMHjoP9vY/FuQKwghMFti4+XyFZabJ6xp7AqhRm
         S+p/14P/6guRhz5vm409qJRW6qzxAwyP2/A0RkE/uKak2QBeveMQvKcdXmE5qqD1J86d
         k8kyRGu3RnKtOIOg54AarwgG+PsA2V3mu9tyzcRtPsu11jjUN7hHpl7104S+OMhOCqVn
         ZXb1eAE3KpNoSPWZUiJK9lFVyw8+jczkNfl7PhijWZ6Q16Myimqq27ZxBNJcZ9zLkoy+
         mbQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Thu, 19 Apr 2018 15:48:53 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419134853.GB2387@pc11.op.pod.cz>
Mail-Followup-To: "Raj, Ashok" <ashok.raj@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419123217.GA19746@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419123217.GA19746@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598182636814640199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 05:32:18AM -0700, Raj, Ashok wrote:
> Thanks.. also can you remove the ret below, and send the output
> of /proc/cpuinfo before and after?
> 
> On Thu, Apr 19, 2018 at 02:18:41PM +0200, Borislav Petkov wrote:
> >  	} else {
> > +		pr_info("%s: CPU%d returning 0x%x\n", __func__, cpu, err);
> >  		return ret;
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  	}
> >  
> 
> This should not panic, but curious what the microcode versions reported...

  Yes, this time it didn't panic:

--------------------------------------------------------------
microcode: __reload_late: CPU1
microcode: __reload_late: CPU3
microcode: __reload_late: CPU0
microcode: __reload_late: CPU2
microcode: __reload_late: CPU1 reloading
microcode: __reload_late: CPU2 reloading
microcode: __reload_late: CPU0 reloading
microcode: __reload_late: CPU3 reloading
microcode: find_patch: CPU2, NADA
microcode: apply_microcode_intel: CPU2, NFOUND
microcode: __reload_late: CPU2 returning 0x3
microcode: find_patch: CPU0, NADA
microcode: __reload_late: CPU2 waiting to exit
microcode: updated to revision 0x24, date = 2018-01-21
microcode: __reload_late: CPU0 waiting to exit
microcode: find_patch: CPU3, NADA
microcode: apply_microcode_intel: CPU3, NFOUND
microcode: __reload_late: CPU3 returning 0x3
microcode: find_patch: CPU1, NADA
microcode: apply_microcode_intel: CPU1, NFOUND
microcode: __reload_late: CPU3 waiting to exit
microcode: __reload_late: CPU1 returning 0x3
microcode: __reload_late: CPU1 waiting to exit
x86/CPU: CPU features have changed after loading microcode, but might not take effect.
x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
--------------------------------------------------------------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 3052.578
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 3070.964
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 3094.770
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 2895.857
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:
--------------------------------------------------------------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x24
cpu MHz		: 1915.336
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 3076.997
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 2589.773
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
stepping	: 3
microcode	: 0x1c
cpu MHz		: 2865.152
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs		: cpu_meltdown spectre_v1 spectre_v2
bogomips	: 6200.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:
--------------------------------------------------------------

	Cheers,

		Vita
