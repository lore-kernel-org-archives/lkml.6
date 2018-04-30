Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AB8JxZo2/5qhsAj+glFY2CeqryVFR1Njv0Jmwhe0eYFp3PbYmYDMV8b6ag6XYQ+2oi6IZHl4GTAJ
ARC-Seal: i=1; a=rsa-sha256; t=1525081339; cv=none;
        d=google.com; s=arc-20160816;
        b=WoQ95ObZFTyo+bLNxH1VFEyvL05OBcX8C/w522KlG4YWiw8+kU18LMkcFeEik29JXt
         sqL4NipbIfImR8FE9SYhFDZ53QwEJ140vLBGr2VKJH5iZAt5H3+hjuJ/dRXqkO5xlLMy
         THQVZ9Jvwah6KMK18uveecWSHfy9HEKb0Ag+WccXGB4rbEPKH2ZaC8lHq+5Te6oG2lgO
         Dj1eyhW6KKCf+zvcn7+Md9BtEilCR6RprGDrg2FBPlVrRSl1Xp0h4DPkVBAa9xTRRWIU
         v4f2kN/iqp4xVtIqdkZRsHaquWx0QVZeRsx7Z7G9iQ9/PcjYj0wUTUnSoQ/K5lXN6IFe
         NKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=T2fcPU5UOAxB8OkbCTq+PTQ4NpBstrtYyr0nQBjwoP4=;
        b=eyKlfTGyDp61owuIkNDn53OhifCq04ZAr9IBO7fynSseJGkgU6Kzhyfz1a7MrGObP2
         Gn/rC8c1uHRGie66CfdyjYsEmGWDwNzSsj9z9x6NaUZ+z96SYx1WygJ6GF+o0qyH682H
         lDgDt1tPNo47EteYrEuXuY099SMWJhxBNHKemSUGhY4ztdYffaEiMwvTLHfao6oJD1YT
         EybKFxlmTpVgQnSRWN35uSTj1Njo0duSrEATHYMgrZoboLHbaP+5BJ7GH7UG8d0J/IuO
         QKu13XRXX5H0pkw/VLXwrb86qo71aRe0zyBrjPiQOteFsMcZhtl9tRt4UMXZYLAv+CvU
         SsGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Mon, 30 Apr 2018 11:41:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Wang <davidwang@zhaoxin.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	brucechang@via-alliance.com, cooperyan@zhaoxin.com,
	qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
	timguo@zhaoxin.com
Subject: Re: [PATCH v3 1/2] x86/mce: new Centaur CPU support MCE broadcasting
Message-ID: <20180430094144.GE6509@pd.tnic>
References: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
 <1524652420-17330-2-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524652420-17330-2-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713954943816107?=
X-GMAIL-MSGID: =?utf-8?q?1599163691000951403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:33:39PM +0800, David Wang wrote:
> Newer Centaur multi-core CPU also support MCE broadcasting to all cores. But
> no Centaur special code tell this truth to kernel.  
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

I applied this with some minor improvements:

---
From: David Wang <davidwang@zhaoxin.com>
Date: Wed, 25 Apr 2018 18:33:39 +0800
Subject: [PATCH] x86/MCA: Enable MCE broadcasting on new Centaur CPUs

Newer Centaur multi-core CPUs also support MCE broadcasting to all
cores. Add a Centaur-specific init function setting that up.

 [ bp:
   - make mce_centaur_feature_init() static
   - flip check to do the f/m/s first for better readability
   - touch up text
  ]

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Cc: Greg KH <greg@kroah.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: benjaminpan@viatech.com
Cc: brucechang@via-alliance.com
Cc: cooperyan@zhaoxin.com
Cc: lukelin@viacpu.com
Cc: qiyuanwang@zhaoxin.com
Cc: timguo@zhaoxin.com
Cc: x86-ml <x86@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1524652420-17330-2-git-send-email-davidwang@zhaoxin.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..cd76380af79f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1727,6 +1727,21 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 	}
 }
 
+static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	 /*
+	  * All newer Centaur CPUs support MCE broadcasting. Enable
+	  * synchronization with a one second timeout.
+	  */
+	if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
+	     c->x86 > 6) {
+		if (cfg->monarch_timeout < 0)
+			cfg->monarch_timeout = USEC_PER_SEC;
+	}
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1739,6 +1754,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+	case X86_VENDOR_CENTAUR:
+		mce_centaur_feature_init(c);
+		break;
 
 	default:
 		break;
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
