Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Gp41K5/fg8bQdAWQxbY4Wqb7lKudXTqt70HTOsQAf5sMZ8b9FX4yXMXe+aUP1QaJ1yr5d
ARC-Seal: i=1; a=rsa-sha256; t=1519218424; cv=none;
        d=google.com; s=arc-20160816;
        b=YP5/AKZE+WnTluDBFUjesfwNisyTwMIvtfx54zhlFXJoeht7YPOw05IvkwFMf0u1vs
         Nd45/QdFOybq/6MzIYwxnGQYvtztnpeOE2PQDZlLDYPhaV0Ax9B3aF/4UPRFC/Y2mjMQ
         /YGAnL4nDMgVQQRiWckVOH6qiJ2AcJk+KKXcYmz6N7Mkr8gbtp369eUmv7I9XHl4Jdwc
         t2PkVrmISzs8DUAtqP8/PmvLez2YqtdPqIR7fzZa5q1iv5BDkZBFmdYPps3NSOsCi8uY
         xpALz6mjQrMLYn8w0GBJEHWn475WSmCdlwNMjkLJ2n0qxLOSt/XZRiTr4/N44Fg8ifJZ
         Ruvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vMT/THJCmOP7fBWPJ5TxEI1BpWrBmLLBqacCY165OMY=;
        b=CPx8OqiM4FL4Pv1lHmEn/SWoz17LMou1iluWObDBKIVSG7JeYy1lyKbyUy0slxf/fb
         On2TZ2f32GmHPDZ+7GZGzLy9BMzZxfNs0cje3pWeRZxStIaM64MMjZmPLSB/NBcKa1T4
         Xy/JervrGTsLa2M7gA/6ILfJkiegWGzkZITQrzzmpoUu8EWUzfqU5pPiywZMhjFmqaqS
         qqozqEF+aGewrMisEGzRXjXC+iBKAZ8j57DR8wHFCo9Ppx3mvDsvvH1osbRI/JFFQP2g
         0X6J2p140SJbdrXeXIBQY4hpgwmHFiifMeC0E/Ib8CcdCXrbjFUoUfk5LoxLGDAw5uUg
         Xgag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Anusha Srivatsa <anusha.srivatsa@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Airlie <airlied@linux.ie>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.15 035/163] x86/gpu: add CFL to early quirks
Date: Wed, 21 Feb 2018 13:47:44 +0100
Message-Id: <20180221124532.202910761@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015607863918761?=
X-GMAIL-MSGID: =?utf-8?q?1593015978899399865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit 33aa69ed8aacd92dea12671e52eb3ca6ac2d7a49 upstream.

CFL was missing from intel_early_ids[]. The PCI ID needs to be there to
allow the memory region to be stolen, otherwise we could have RAM being
arbitrarily overwritten if for example we keep using the UEFI framebuffer,
depending on how BIOS has set up the e820 map.

Fixes: b056f8f3d6b9 ("drm/i915/cfl: Add Coffee Lake PCI IDs for S Skus.")
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Anusha Srivatsa <anusha.srivatsa@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: <stable@vger.kernel.org> # v4.13+ 0890540e21cf drm/i915: add GT number to intel_device_info
Cc: <stable@vger.kernel.org> # v4.13+ 41693fd52373 drm/i915/kbl: Change a KBL pci id to GT2 from GT1.5
Cc: <stable@vger.kernel.org> # v4.13+
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171213200425.2954-1-lucas.demarchi@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/early-quirks.c |    1 +
 include/drm/i915_pciids.h      |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -527,6 +527,7 @@ static const struct pci_device_id intel_
 	INTEL_SKL_IDS(&gen9_early_ops),
 	INTEL_BXT_IDS(&gen9_early_ops),
 	INTEL_KBL_IDS(&gen9_early_ops),
+	INTEL_CFL_IDS(&gen9_early_ops),
 	INTEL_GLK_IDS(&gen9_early_ops),
 	INTEL_CNL_IDS(&gen9_early_ops),
 };
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -392,6 +392,12 @@
 	INTEL_VGA_DEVICE(0x3EA8, info), /* ULT GT3 */ \
 	INTEL_VGA_DEVICE(0x3EA5, info)  /* ULT GT3 */
 
+#define INTEL_CFL_IDS(info) \
+	INTEL_CFL_S_GT1_IDS(info), \
+	INTEL_CFL_S_GT2_IDS(info), \
+	INTEL_CFL_H_GT2_IDS(info), \
+	INTEL_CFL_U_GT3_IDS(info)
+
 /* CNL U 2+2 */
 #define INTEL_CNL_U_GT2_IDS(info) \
 	INTEL_VGA_DEVICE(0x5A52, info), \
