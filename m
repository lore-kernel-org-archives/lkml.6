Return-Path: <darren.kenny@oracle.com>
X-Google-Smtp-Source: AH8x226Chjt5C2XQPoibfuqPBaOkrnH1l36siT/QoPlCNuMJOUJVTi9zsdKsTcQgG4gIAE1/m8KE
ARC-Seal: i=1; a=rsa-sha256; t=1518185492; cv=none;
        d=google.com; s=arc-20160816;
        b=t3XPqbp+JGYdxzRV+NzrbWiJOV6U3hNu0qeR3CPbOZ56OWTpGTySXsgHpmPpKjaxSs
         XNrP91W4vRfM9sCPijh7YETKrwLEIzPGsB1GVnVeD1ty+VmXYnr5G0NxPjc5pmOAgud1
         pTZPze/eT2iJ6cOIzM2gRwNmcJeAbkLkvPptUNx+dNcS0+jcD8ORlgtSHJeVMFr63yi1
         tS7Sr7y5j3nstbtrwr4sS3n28kyFJ58/ukP0zmBFm8oRcaUzH1raQ9F/6ALV2non6RBt
         LnJHs727pBZJI7KXHdfY3LvK/eu/Ud06Mz3W7efsFnq2PJDJyzOj9Go7camZ4mBRRY/S
         UkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=rj4y74AqlPP0fhtlYuEoQnU8MhgJynbS/eSSJIhBpyc=;
        b=vVdMGVdfDSXzt9pTjUvrnZ/qSPDWxbxmwDS1Jj8RYOAOpyuBruAIkF6w273daNLT+c
         iC9x+HdtNjSL/ZAhynnwWbfayuDncUxveKtJEkoop9df5SnL6+7NUrTBpLbAJRP64p3d
         BJydW9C5wfj7uDaxx0aGmBzNiuiFB9k6BxXDNUB9/p689pj8OlTmcSomL5K1LAguCBnT
         fPdKQOfluIcuk9kpfABBaxeh/5nsjdFEYN013aMDcuLCSx7J8zSB+FamcyDe1uWqrS/n
         mYFCOzttppk2P4xco9q3dp5a6GBIdqjXQh5c74jowFkWh5jL3U+vUiUFqVU4ZBtT+cA6
         8K+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s1GA3F0k;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s1GA3F0k;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 9 Feb 2018 14:10:54 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>, Kyle Huey <me@kylehuey.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Subject: [PATCH] x86/spectre_v2: Remove 0xc2 from spectre_bad_microcodes
Message-ID: <20180209141054.gfzioctavbpnjckl@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=816
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090182
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591932870470343348?=
X-GMAIL-MSGID: =?utf-8?q?1591932870470343348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

According to the latest microcode update from Intel (on Feb 8, 2018) on
Skylake we should be using the microcode revisions 0xC2***, so we need
to remove that from the blacklist now.

Signed-off-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/cpu/intel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 319bf98..276bfe2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -123,8 +123,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
-- 
2.9.5
