Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x226Toq+21pEsMCVVyFjRL4QZd61jkgGheY1yu7xZcqIcklw68aFZ7s5rVqB0QxK4YK2CQ2UT
ARC-Seal: i=1; a=rsa-sha256; t=1519127944; cv=none;
        d=google.com; s=arc-20160816;
        b=qiudROPO/NYCnnmXIkX83JNKJaIP7b59/gDK8kemR/g2SAfO5ZQQk+ooEMGSql4OfX
         BcCLYcHnXzgq896XYskagAUI4Ywglip7Z3xnrs1E99MiM2ii1URwJJd5w/b/JpPNmWOg
         sFcYCNfek1PK4L9GPlwbIX0FW0OeuiUu8FLKMAO598dVi21o/yBMnCmONZvuGQuyEstW
         hyYrQgHSGU8CR58QrM8FCEdteV+oLCCi2+CJwx4MFdY2JwCLwzdI2dvnmrBJJTNfcUiB
         fhSm79t66wazJbQUYrkiguXf7STLHOt2XVh3u+4tzO/7U5+18DuxnUmXwNmDFNWKM7Lb
         dDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0Yp9wLbDFpr71FOE0lz24WGMmXSOsBN7UdooN2sLTAE=;
        b=QZvk6sgMYqsWivpNh0xGQNVLQpITidkakrXakwlxO/PHjdT8h2Y1ywWU1yhPqogaI3
         mQhewFJICerV9ygZMXGtGvdXi4q4Uw+gX+DGAnDo/OL92tdWs6xKKaPmMMrU99DbL31O
         EEw3A+cL2JnKCye9RdUjZPLIdRoR/bq8rkiWfhDn0WSqTn+xxMKaOieNtdXEZGZIutS7
         mMWyez7refhvicICjrfpMrv/3gSYmBgG6nlsvcZeS0Dk1jKVSHSNyFG7GJbpylVQxihk
         Jg0++e7kspsvYRQzN2n+G5aJuujiFemfcdfSBUQr2ZVfrSj2NFnGFeFLDb5De+hYE6F8
         SKZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org
Subject: [4.4-stable 10/22] ASoC: Intel: Kconfig: fix build when ACPI is not enabled
Date: Tue, 20 Feb 2018 12:54:57 +0100
Message-Id: <20180220115527.1806578-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:+OGUARZvbYaC61ThZMhc0pohW4ZOlbZQTsUpwbQCZDBN3j5JN1R
 eOzhxO/zIGB6b7+jiiySKXXBWhx1b0w9ryWyAzr8tk1277zvDvU2Y/nBt6SSCSzuOR2ciGz
 WHDJl5yl+HP0Z/nfFhcEffUNd2u5wklV0u+K2d16a1IqP1iowYbuwjxCZEaEQP2z9zzj745
 0CMAnc7Um2L/7FO1fedDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+XuUA9Rv3+0=:4D1gNETQp8DqiKbRqWW4/p
 /Uo/UnxipSUi7IqzIm+LlUYSamP+RghEifOUetC0dWyjS++RmoTccMG38Ieffzk3is2RM2QNQ
 zzhu1h39hhf4Zu/4r1rNMw2cKzZM28GpjuwB9oZm6GcDmf90MGRi+D2km1SLNM3guEAZg0Jkc
 OlaSw+4o+DCB2Dg8JIH+Nvzj56wlb7vgNX8srvoWc6YrTmLo65NljwUdjTGnEY+3vyB230C84
 1y0v57YRVJ0pYPlJfAAh1gU1wKm10q+BOh3n6EsR3fYBPlVk1Pe3DIK64de/SoZTIbrRhzVtr
 oWAWMSrc5VH2K/rW5/UTamh0fbz1IurPqTVTOkk7jWiUnoi6LnHgCexHiO/59figsf9nIq1c5
 Nq6PIyZg0Lx6K5SFJQo3YOvkxNQFGzBuqB22X8AOOSWqWevtK6LRjNOJfe6MRZBI576hFkrI0
 M7AjNjdPoKSz/F/CfUUJ/QAJO2ed0MEQpMcXxekZA+AuWZRK1d+H8bx7wn9NQY60X2XXMJCA/
 vt70OEWtxozDprrfIPNc9JjBG6GNS6O+r+yTWt6vKuhybq/dhjozXGpecjs/X7BXHPhUZXDlF
 gChDSS0xUVYeEyw6+9l/kj2joSxX6RB7tSxMG3dHT6ompsxU6ssmWIqia/flSZvzU9GEZx3yR
 ExGdWE4HiW7S2x0DVl7pgRVUQaeRB49tCnROwhsonuzevnkgW4HlzZm1s/uHCI++dO/X0pbCf
 8/sXgAqG8vnUBW3rC4RNCAJkjRbOoRrg/h7nVg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921103427176636?=
X-GMAIL-MSGID: =?utf-8?q?1592921103427176636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vinod Koul <vinod.koul@intel.com>

commit 3493d4a86457c7de9f1e602b4267c9b0f9ec1c9f upstream.

Randy reported following error when ACPI is not enabled:

warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH
&& SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH &&
SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI
+which has unmet direct dependencies (SOUND && !M68K && !UML && SND &&
SND_SOC && ACPI)

causing these build errors:

In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:40:0:
../include/acpi/acpi_bus.h:65:20: error: conflicting types for
'acpi_evaluate_dsm'
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:31:0:
../include/linux/acpi.h:676:34: note: previous definition of
'acpi_evaluate_dsm' was here
 static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,

CONFIG_SND_SST_IPC_ACPI was already dependent upon ACPI, but that was not
solving it. So move the depends up to machine drivers and remove from
CONFIG_SND_SST_IPC_ACPI.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[arnd: rebased to 4.4-stable kernel]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index d430ef5a4f38..79c29330c56a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -24,7 +24,6 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
-	depends on ACPI
 
 config SND_SOC_INTEL_SST
 	tristate
@@ -91,7 +90,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	tristate "ASoC Audio DSP Support for MID BYT Platform"
-	depends on X86 && I2C
+	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
@@ -103,7 +102,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
-        depends on X86_INTEL_LPSS && I2C
+        depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
         select SND_SST_MFLD_PLATFORM
         select SND_SST_IPC_ACPI
@@ -115,7 +114,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
-	depends on X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
-- 
2.9.0
