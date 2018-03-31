Return-Path: <wasim.nazir@pathpartnertech.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522503267; cv=none;
        d=google.com; s=arc-20160816;
        b=PTrxKBKbsKOM8/p/KWEN96RsSAU4Sot7C9Ag4F8uTMGFr3+xLPvIhaT8T/zsypEAnH
         6WA5MVGzeyY/YvL8chy6+yFK1jAUvRH3cBOEV4nFAFmz5lpaEgDoTwSE2kMTP6HCB4iO
         D7aI+NVON5fHZFWoa6bnfKuPDuiMxZr8mHydMbnB9bJjicV+unWGDcoXfWlGRr2zOB4b
         eIAq8b1Fcl59B5+WW7G7FuTHZ3E/c9FAhCmGJeUN7l8Sd7YP+O6W7OKxf4foRIrx8DKh
         4B8ZomMkmtgHSt4RT4M326tYeT0JCHvWEI3h0Ink+JXuQxDe6yNdjTjXvnB+9FQaq2ZT
         uq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=2ixqh+ciaeqfNAuOvYOA8C8LI8PLl3nhhFLWdWouFPA=;
        b=zLRg8R1DcMZAliuKqkMPSrQ7W2HPRj1zO3gk+GIYrtKWEvOv08QRoHB+PFcQ2OoMM9
         vOjSTDKwyPAsfyy/iU2fK8YV9irFKbfgVD4msZVd1hlMG3PZPWnR6Wn7BDMh1yq/qsjg
         xm4fFUbsjLuyUMbNaPaCTcKQeQoTs1kLuZ4b5a7WG+B9ANBJQ/9dgtA+PTaIMjxtF4si
         Najot18Wc1avOYzBG/BnB7ES1sCnAQ7k9tTRG9Tyv5HEEpuI7+yAJYxlHIZ8ynaI21du
         1ERs8SdlZY4PR5Qel96pYb08DSHBulFc7ZXZHm0ZPKHuXVp/2FGUJW7mMPb69l8oHjU+
         Iw0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@pathpartnertech.com header.s=google header.b=GFG5pU47;
       spf=pass (google.com: domain of wasim.nazir@pathpartnertech.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wasim.nazir@pathpartnertech.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@pathpartnertech.com header.s=google header.b=GFG5pU47;
       spf=pass (google.com: domain of wasim.nazir@pathpartnertech.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wasim.nazir@pathpartnertech.com
X-Google-Smtp-Source: AIpwx4/F5V/kdBnVmiI6S2+smh937722Xwr5BT1lyc5w12iCk5lPZfMbpEBQ7lE875+vuI9VFjKwB6WNgGnInlehan4=
MIME-Version: 1.0
From: Wasim Nazir <wasim.nazir@pathpartnertech.com>
Date: Sat, 31 Mar 2018 19:04:24 +0530
Message-ID: <CAAYn-egv0c7DAf3T4mprG7wzWtaP9SOSYQu6V25EV6G5wAYTgA@mail.gmail.com>
Subject: [PATCH] Patch to replace DEFINE_SEMAPHORE with DEFINE_BINARY_SEMAPHORE
To: jhogan@kernel.org, kys@microsoft.com, linuxdrivers@attotech.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	linux-arm-kernel@lists.infradead.org
Cc: Wasim Nazir <wasim.nazir@pathpartnertech.com>, Ralf Baechle <ralf@linux-mips.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	David Daney <david.daney@cavium.com>, Mihaela Muraru <mihaela.muraru21@gmail.com>,
	Kishore KP <kishore.p@techveda.org>, Sidong Yang <realwakka@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Phil Elwell <phil@raspberrypi.org>,
	Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>, linux-mips@linux-mips.org,
	linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Content-Type: multipart/mixed; boundary="089e08e578414ffff00568b56a7e"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596460385840802808?=
X-GMAIL-MSGID: =?utf-8?q?1596460385840802808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--089e08e578414ffff00568b56a7e
Content-Type: multipart/alternative; boundary="089e08e578414fffec0568b56a7c"

--089e08e578414fffec0568b56a7c
Content-Type: text/plain; charset="UTF-8"

This patch replaces the macro DEFINE_SEMAPHORE with DEFINE_BINARY_SEMAPHORE.
This is necessary because otherwise it makes confusion with counting
semaphore.

To apply the patch, in the root of a kernel tree use:
patch -p1 < 0001-Replace-DEFINE_SEMAPHORE-with-DEFINE_BINARY_SEMAPHOR.patch

Please let me know any feedback you have on this patch.

Thank You,
Wasim Nazir,
Software Engineer,
Pathpartner Tech

Signed-off-by: Wasim Nazir <wasim.nazir@pathpartnertech.com>
---
 arch/mips/cavium-octeon/setup.c
               | 2 +-
 drivers/firmware/efi/runtime-wrappers.c
              | 2 +-
 drivers/firmware/efi/vars.c
                       | 2 +-
 drivers/hv/vmbus_drv.c
                       | 2 +-
 drivers/macintosh/adb.c
                      | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
    | 2 +-
 drivers/scsi/esas2r/esas2r_ioctl.c
                   | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c  | 2 +-
 include/linux/semaphore.h
                    | 2 +-
 kernel/printk/printk.c
                            | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c
b/arch/mips/cavium-octeon/setup.c
index a8034d0..983b464 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -68,7 +68,7 @@
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;

-DEFINE_SEMAPHORE(octeon_bootbus_sem);
+DEFINE_BINARY_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);

 struct octeon_boot_descriptor *octeon_boot_desc_ptr;
diff --git a/drivers/firmware/efi/runtime-wrappers.c
b/drivers/firmware/efi/runtime-wrappers.c
index ae54870b..5706f8c 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -88,7 +88,7 @@ void efi_call_virt_check_flags(unsigned long flags, const
char *call)
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+static DEFINE_BINARY_SEMAPHORE(efi_runtime_lock);

 static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 9336ffd..e8aab38 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -43,7 +43,7 @@
  * 2) ->ops calls
  * 3) (un)registration of __efivars
  */
-static DEFINE_SEMAPHORE(efivars_lock);
+static DEFINE_BINARY_SEMAPHORE(efivars_lock);

 static bool efivar_wq_enabled = true;
 DECLARE_WORK(efivar_work, NULL);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc65c4d..a75ad8a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -88,7 +88,7 @@ static int hyperv_die_event(struct notifier_block *nb,
unsigned long val,
 static const char *fb_mmio_name = "fb_range";
 static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
-static DEFINE_SEMAPHORE(hyperv_mmio_lock);
+static DEFINE_BINARY_SEMAPHORE(hyperv_mmio_lock);

 static int vmbus_exists(void)
 {
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 4c8097e..55725e0 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static DEFINE_SEMAPHORE(adb_probe_mutex);
+static DEFINE_BINARY_SEMAPHORE(adb_probe_mutex);
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index b8388e9..eac1bf9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -283,7 +283,7 @@ enum bnx2x_board_type {

 /* Global resources for unloading a previously loaded device */
 #define BNX2X_PREV_WAIT_NEEDED 1
-static DEFINE_SEMAPHORE(bnx2x_prev_sem);
+static DEFINE_BINARY_SEMAPHORE(bnx2x_prev_sem);
 static LIST_HEAD(bnx2x_prev_list);

 /* Forward declaration */
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c
b/drivers/scsi/esas2r/esas2r_ioctl.c
index 9762300..55a9488 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -56,7 +56,7 @@
 u32 esas2r_buffered_ioctl_size;
 struct pci_dev *esas2r_buffered_ioctl_pcid;

-static DEFINE_SEMAPHORE(buffered_ioctl_semaphore);
+static DEFINE_BINARY_SEMAPHORE(buffered_ioctl_semaphore);
 typedef int (*BUFFERED_IOCTL_CALLBACK)(struct esas2r_adapter *,
         struct esas2r_request *,
         struct esas2r_sg_context *,
diff --git
a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index b59ef14..727ec59 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -84,7 +84,7 @@ struct vchiq_pagelist_info {
 static struct semaphore g_free_fragments_sema;
 static struct device *g_dev;

-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+static DEFINE_BINARY_SEMAPHORE(g_free_fragments_mutex);

 static irqreturn_t
 vchiq_doorbell_irq(int irq, void *dev_id);
diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 11c86fb..b74522a 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -26,7 +26,7 @@ struct semaphore {
  .wait_list = LIST_HEAD_INIT((name).wait_list), \
 }

-#define DEFINE_SEMAPHORE(name) \
+#define DEFINE_BINARY_SEMAPHORE(name) \
  struct semaphore name = __SEMAPHORE_INITIALIZER(name, 1)

 static inline void sema_init(struct semaphore *sem, int val)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbe..8cb2f27 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -78,7 +78,7 @@
  * provides serialisation for access to the entire console
  * driver system.
  */
-static DEFINE_SEMAPHORE(console_sem);
+static DEFINE_BINARY_SEMAPHORE(console_sem);
 struct console *console_drivers;
 EXPORT_SYMBOL_GPL(console_drivers);

-- 
1.9.1

-- 
 

This message contains confidential information and is intended only for the 
individual(s) named. If you are not the intended recipient, you are 
notified that disclosing, copying, distributing or taking any action in 
reliance on the contents of this mail and attached file/s is strictly 
prohibited. Please notify the sender immediately and delete this e-mail 
from your system. E-mail transmission cannot be guaranteed to be secured or 
error-free as information could be intercepted, corrupted, lost, destroyed, 
arrive late or incomplete, or contain viruses. The sender therefore does 
not accept liability for any errors or omissions in the contents of this 
message, which arise as a result of e-mail transmission.

--089e08e578414fffec0568b56a7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This patch replaces the macro DEFINE_SEMAPHORE with D=
EFINE_BINARY_SEMAPHORE.</div><div>This is necessary because otherwise it ma=
kes confusion with counting semaphore.</div><div><span style=3D"white-space=
:pre">									</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>To apply the pa=
tch, in the root of a kernel tree use:</div><div>patch -p1 &lt; 0001-Replac=
e-DEFINE_SEMAPHORE-with-DEFINE_BINARY_SEMAPHOR.patch</div><div><br></div><d=
iv>Please let me know any feedback you have on this patch.</div><div><br></=
div><div>Thank You,</div><div>Wasim Nazir,</div><div>Software Engineer,</di=
v><div>Pathpartner Tech</div><div><br></div><div><div>Signed-off-by: Wasim =
Nazir &lt;<a href=3D"mailto:wasim.nazir@pathpartnertech.com">wasim.nazir@pa=
thpartnertech.com</a>&gt;</div><div>---</div></div>=C2=A0arch/mips/cavium-o=
cteon/setup.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
2 +-<br>=C2=A0drivers/firmware/efi/runtime-wrappers.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2 +-<br>=C2=A0drivers/firmware/efi/vars.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 2 +-<br>=C2=A0drivers/hv/vmbus_drv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 2 +-<br>=C2=A0drivers/macintosh/adb.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>=C2=A0drivers/net/ethernet/broadcom/bnx2x/bnx2x=
_main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>=C2=A0drivers/scsi/esas2r/=
esas2r_ioctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2 +-<br>=C2=A0drivers/staging/vc04_services/interface/vchiq_arm/vchiq_=
2835_arm.c=C2=A0 | 2 +-<br>=C2=A0include/linux/semaphore.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2 +-<br><div><div style=3D"text-align:left">=C2=A0kernel/printk/pr=
intk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-</div>=
</div><div><div>=C2=A010 files changed, 10 insertions(+), 10 deletions(-)</=
div><div><br></div><div>diff --git a/arch/mips/cavium-octeon/setup.c b/arch=
/mips/cavium-octeon/setup.c</div><div>index a8034d0..983b464 100644</div><d=
iv>--- a/arch/mips/cavium-octeon/setup.c</div><div>+++ b/arch/mips/cavium-o=
cteon/setup.c</div><div>@@ -68,7 +68,7 @@</div><div>=C2=A0static unsigned l=
ong long max_memory =3D ULLONG_MAX;</div><div>=C2=A0static unsigned long lo=
ng reserve_low_mem;</div><div>=C2=A0</div><div>-DEFINE_SEMAPHORE(octeon_boo=
tbus_sem);</div><div>+DEFINE_BINARY_SEMAPHORE(octeon_bootbus_sem);</div><di=
v>=C2=A0EXPORT_SYMBOL(octeon_bootbus_sem);</div><div>=C2=A0</div><div>=C2=
=A0struct octeon_boot_descriptor *octeon_boot_desc_ptr;</div><div>diff --gi=
t a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-=
wrappers.c</div><div>index ae54870b..5706f8c 100644</div><div>--- a/drivers=
/firmware/efi/runtime-wrappers.c</div><div>+++ b/drivers/firmware/efi/runti=
me-wrappers.c</div><div>@@ -88,7 +88,7 @@ void efi_call_virt_check_flags(un=
signed long flags, const char *call)</div><div>=C2=A0 * none of the remaini=
ng functions are actually ever called at runtime.</div><div>=C2=A0 * So let=
&#39;s just use a single lock to serialize all Runtime Services calls.</div=
><div>=C2=A0 */</div><div>-static DEFINE_SEMAPHORE(efi_runtime_lock);</div>=
<div>+static DEFINE_BINARY_SEMAPHORE(efi_runtime_lock);</div><div>=C2=A0</d=
iv><div>=C2=A0static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_tim=
e_cap_t *tc)</div><div>=C2=A0{</div><div>diff --git a/drivers/firmware/efi/=
vars.c b/drivers/firmware/efi/vars.c</div><div>index 9336ffd..e8aab38 10064=
4</div><div>--- a/drivers/firmware/efi/vars.c</div><div>+++ b/drivers/firmw=
are/efi/vars.c</div><div>@@ -43,7 +43,7 @@</div><div>=C2=A0 * 2) -&gt;ops c=
alls</div><div>=C2=A0 * 3) (un)registration of __efivars</div><div>=C2=A0 *=
/</div><div>-static DEFINE_SEMAPHORE(efivars_lock);</div><div>+static DEFIN=
E_BINARY_SEMAPHORE(efivars_lock);</div><div>=C2=A0</div><div>=C2=A0static b=
ool efivar_wq_enabled =3D true;</div><div>=C2=A0DECLARE_WORK(efivar_work, N=
ULL);</div><div>diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.=
c</div><div>index bc65c4d..a75ad8a 100644</div><div>--- a/drivers/hv/vmbus_=
drv.c</div><div>+++ b/drivers/hv/vmbus_drv.c</div><div>@@ -88,7 +88,7 @@ st=
atic int hyperv_die_event(struct notifier_block *nb, unsigned long val,</di=
v><div>=C2=A0static const char *fb_mmio_name =3D &quot;fb_range&quot;;</div=
><div>=C2=A0static struct resource *fb_mmio;</div><div>=C2=A0static struct =
resource *hyperv_mmio;</div><div>-static DEFINE_SEMAPHORE(hyperv_mmio_lock)=
;</div><div>+static DEFINE_BINARY_SEMAPHORE(hyperv_mmio_lock);</div><div>=
=C2=A0</div><div>=C2=A0static int vmbus_exists(void)</div><div>=C2=A0{</div=
><div>diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c</div><=
div>index 4c8097e..55725e0 100644</div><div>--- a/drivers/macintosh/adb.c</=
div><div>+++ b/drivers/macintosh/adb.c</div><div>@@ -80,7 +80,7 @@</div><di=
v>=C2=A0BLOCKING_NOTIFIER_HEAD(adb_client_list);</div><div>=C2=A0static int=
 adb_got_sleep;</div><div>=C2=A0static int adb_inited;</div><div>-static DE=
FINE_SEMAPHORE(adb_probe_mutex);</div><div>+static DEFINE_BINARY_SEMAPHORE(=
adb_probe_mutex);</div><div>=C2=A0static int sleepy_trackpad;</div><div>=C2=
=A0static int autopoll_devs;</div><div>=C2=A0int __adb_probe_sync;</div><di=
v>diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/n=
et/ethernet/broadcom/bnx2x/bnx2x_main.c</div><div>index b8388e9..eac1bf9 10=
0644</div><div>--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c</div>=
<div>+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c</div><div>@@ -2=
83,7 +283,7 @@ enum bnx2x_board_type {</div><div>=C2=A0</div><div>=C2=A0/* =
Global resources for unloading a previously loaded device */</div><div>=C2=
=A0#define BNX2X_PREV_WAIT_NEEDED 1</div><div>-static DEFINE_SEMAPHORE(bnx2=
x_prev_sem);</div><div>+static DEFINE_BINARY_SEMAPHORE(bnx2x_prev_sem);</di=
v><div>=C2=A0static LIST_HEAD(bnx2x_prev_list);</div><div>=C2=A0</div><div>=
=C2=A0/* Forward declaration */</div><div>diff --git a/drivers/scsi/esas2r/=
esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c</div><div>index 9762300=
..55a9488 100644</div><div>--- a/drivers/scsi/esas2r/esas2r_ioctl.c</div><d=
iv>+++ b/drivers/scsi/esas2r/esas2r_ioctl.c</div><div>@@ -56,7 +56,7 @@</di=
v><div>=C2=A0u32 esas2r_buffered_ioctl_size;</div><div>=C2=A0struct pci_dev=
 *esas2r_buffered_ioctl_pcid;</div><div>=C2=A0</div><div>-static DEFINE_SEM=
APHORE(buffered_ioctl_semaphore);</div><div>+static DEFINE_BINARY_SEMAPHORE=
(buffered_ioctl_semaphore);</div><div>=C2=A0typedef int (*BUFFERED_IOCTL_CA=
LLBACK)(struct esas2r_adapter *,</div><div>=C2=A0<span style=3D"white-space=
:pre">				</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0struct esas2r_request *,</div><=
div>=C2=A0<span style=3D"white-space:pre">				</span>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct esas2r_sg_context *,</div><div>diff --git a/drivers/staging/vc=
04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_ser=
vices/interface/vchiq_arm/vchiq_2835_arm.c</div><div>index b59ef14..727ec59=
 100644</div><div>--- a/drivers/staging/vc04_services/interface/vchiq_arm/v=
chiq_2835_arm.c</div><div>+++ b/drivers/staging/vc04_services/interface/vch=
iq_arm/vchiq_2835_arm.c</div><div>@@ -84,7 +84,7 @@ struct vchiq_pagelist_i=
nfo {</div><div>=C2=A0static struct semaphore g_free_fragments_sema;</div><=
div>=C2=A0static struct device *g_dev;</div><div>=C2=A0</div><div>-static D=
EFINE_SEMAPHORE(g_free_fragments_mutex);</div><div>+static DEFINE_BINARY_SE=
MAPHORE(g_free_fragments_mutex);</div><div>=C2=A0</div><div>=C2=A0static ir=
qreturn_t</div><div>=C2=A0vchiq_doorbell_irq(int irq, void *dev_id);</div><=
div>diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h</div=
><div>index 11c86fb..b74522a 100644</div><div>--- a/include/linux/semaphore=
.h</div><div>+++ b/include/linux/semaphore.h</div><div>@@ -26,7 +26,7 @@ st=
ruct semaphore {</div><div>=C2=A0<span style=3D"white-space:pre">	</span>.w=
ait_list<span style=3D"white-space:pre">	</span>=3D LIST_HEAD_INIT((name).w=
ait_list),<span style=3D"white-space:pre">		</span>\</div><div>=C2=A0}</div=
><div>=C2=A0</div><div>-#define DEFINE_SEMAPHORE(name)<span style=3D"white-=
space:pre">	</span>\</div><div>+#define DEFINE_BINARY_SEMAPHORE(name)<span =
style=3D"white-space:pre">	</span>\</div><div>=C2=A0<span style=3D"white-sp=
ace:pre">	</span>struct semaphore name =3D __SEMAPHORE_INITIALIZER(name, 1)=
</div><div>=C2=A0</div><div>=C2=A0static inline void sema_init(struct semap=
hore *sem, int val)</div><div>diff --git a/kernel/printk/printk.c b/kernel/=
printk/printk.c</div><div>index f274fbe..8cb2f27 100644</div><div>--- a/ker=
nel/printk/printk.c</div><div>+++ b/kernel/printk/printk.c</div><div>@@ -78=
,7 +78,7 @@</div><div>=C2=A0 * provides serialisation for access to the ent=
ire console</div><div>=C2=A0 * driver system.</div><div>=C2=A0 */</div><div=
>-static DEFINE_SEMAPHORE(console_sem);</div><div>+static DEFINE_BINARY_SEM=
APHORE(console_sem);</div><div>=C2=A0struct console *console_drivers;</div>=
<div>=C2=A0EXPORT_SYMBOL_GPL(console_drivers);</div><div>=C2=A0</div><div>-=
-=C2=A0</div><div>1.9.1</div></div><div><br></div></div>

<br>




<p><span lang=3D"EN-IN">This
message contains confidential information and is intended only for the
individual(s) named.</span><span lang=3D"EN-IN"> </span>If you are not the =
intended
recipient, you are notified that disclosing, copying, distributing or takin=
g any
action in reliance on the contents of this mail and attached file/s is stri=
ctly
prohibited<span lang=3D"EN-IN">. Please notify the
sender immediately and delete this e-mail from your system. E-mail transmis=
sion
cannot be guaranteed to be secured or error-free as information could be
intercepted, corrupted, lost, destroyed, arrive late or incomplete, or cont=
ain
viruses. The sender therefore does not accept liability for any errors or
omissions in the contents of this message, which arise as a result of e-mai=
l
transmission.</span></p>
--089e08e578414fffec0568b56a7c--

--089e08e578414ffff00568b56a7e
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-Replace-DEFINE_SEMAPHORE-with-DEFINE_BINARY_SEMAPHOR.patch"
Content-Disposition: attachment;
	filename="0001-Replace-DEFINE_SEMAPHORE-with-DEFINE_BINARY_SEMAPHOR.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfff4mhi0

RnJvbSA1Y2Q3ZmM4ZGIxYzIzYzNkMmRkNjYxNTJkNzYyMGVkNGZkMTA4MWUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYXNpbSBOYXppciA8d2FzaW0ubmF6aXJAcGF0aHBhcnRuZXJ0
ZWNoLmNvbT4KRGF0ZTogU2F0LCAzMSBNYXIgMjAxOCAxODowNDowNiArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIFJlcGxhY2UgREVGSU5FX1NFTUFQSE9SRSB3aXRoIERFRklORV9CSU5BUllfU0VNQVBI
T1JFCgpTaWduZWQtb2ZmLWJ5OiBXYXNpbSBOYXppciA8d2FzaW0ubmF6aXJAcGF0aHBhcnRuZXJ0
ZWNoLmNvbT4KLS0tCiBhcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9zZXR1cC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstCiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9ydW50
aW1lLXdyYXBwZXJzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstCiBkcml2ZXJz
L2Zpcm13YXJlL2VmaS92YXJzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAyICstCiBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAyICstCiBkcml2ZXJzL21hY2ludG9zaC9hZGIuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstCiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9icm9hZGNvbS9ibngyeC9ibngyeF9tYWluLmMgICAgICAgICAgICAgICAgICAg
fCAyICstCiBkcml2ZXJzL3Njc2kvZXNhczJyL2VzYXMycl9pb2N0bC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyICstCiBkcml2ZXJzL3N0YWdpbmcvdmMwNF9zZXJ2aWNlcy9p
bnRlcmZhY2UvdmNoaXFfYXJtL3ZjaGlxXzI4MzVfYXJtLmMgfCAyICstCiBpbmNsdWRlL2xpbnV4
L3NlbWFwaG9yZS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAy
ICstCiBrZXJuZWwvcHJpbnRrL3ByaW50ay5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAyICstCiAxMCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9z
ZXR1cC5jIGIvYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vc2V0dXAuYwppbmRleCBhODAzNGQwLi45
ODNiNDY0IDEwMDY0NAotLS0gYS9hcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9zZXR1cC5jCisrKyBi
L2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL3NldHVwLmMKQEAgLTY4LDcgKzY4LDcgQEAKIHN0YXRp
YyB1bnNpZ25lZCBsb25nIGxvbmcgbWF4X21lbW9yeSA9IFVMTE9OR19NQVg7CiBzdGF0aWMgdW5z
aWduZWQgbG9uZyBsb25nIHJlc2VydmVfbG93X21lbTsKIAotREVGSU5FX1NFTUFQSE9SRShvY3Rl
b25fYm9vdGJ1c19zZW0pOworREVGSU5FX0JJTkFSWV9TRU1BUEhPUkUob2N0ZW9uX2Jvb3RidXNf
c2VtKTsKIEVYUE9SVF9TWU1CT0wob2N0ZW9uX2Jvb3RidXNfc2VtKTsKIAogc3RydWN0IG9jdGVv
bl9ib290X2Rlc2NyaXB0b3IgKm9jdGVvbl9ib290X2Rlc2NfcHRyOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9maXJtd2FyZS9lZmkvcnVudGltZS13cmFwcGVycy5jIGIvZHJpdmVycy9maXJtd2FyZS9l
ZmkvcnVudGltZS13cmFwcGVycy5jCmluZGV4IGFlNTQ4NzBiLi41NzA2ZjhjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9ydW50aW1lLXdyYXBwZXJzLmMKKysrIGIvZHJpdmVycy9m
aXJtd2FyZS9lZmkvcnVudGltZS13cmFwcGVycy5jCkBAIC04OCw3ICs4OCw3IEBAIHZvaWQgZWZp
X2NhbGxfdmlydF9jaGVja19mbGFncyh1bnNpZ25lZCBsb25nIGZsYWdzLCBjb25zdCBjaGFyICpj
YWxsKQogICogbm9uZSBvZiB0aGUgcmVtYWluaW5nIGZ1bmN0aW9ucyBhcmUgYWN0dWFsbHkgZXZl
ciBjYWxsZWQgYXQgcnVudGltZS4KICAqIFNvIGxldCdzIGp1c3QgdXNlIGEgc2luZ2xlIGxvY2sg
dG8gc2VyaWFsaXplIGFsbCBSdW50aW1lIFNlcnZpY2VzIGNhbGxzLgogICovCi1zdGF0aWMgREVG
SU5FX1NFTUFQSE9SRShlZmlfcnVudGltZV9sb2NrKTsKK3N0YXRpYyBERUZJTkVfQklOQVJZX1NF
TUFQSE9SRShlZmlfcnVudGltZV9sb2NrKTsKIAogc3RhdGljIGVmaV9zdGF0dXNfdCB2aXJ0X2Vm
aV9nZXRfdGltZShlZmlfdGltZV90ICp0bSwgZWZpX3RpbWVfY2FwX3QgKnRjKQogewpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvdmFycy5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkv
dmFycy5jCmluZGV4IDkzMzZmZmQuLmU4YWFiMzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZmlybXdh
cmUvZWZpL3ZhcnMuYworKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS92YXJzLmMKQEAgLTQzLDcg
KzQzLDcgQEAKICAqIDIpIC0+b3BzIGNhbGxzCiAgKiAzKSAodW4pcmVnaXN0cmF0aW9uIG9mIF9f
ZWZpdmFycwogICovCi1zdGF0aWMgREVGSU5FX1NFTUFQSE9SRShlZml2YXJzX2xvY2spOworc3Rh
dGljIERFRklORV9CSU5BUllfU0VNQVBIT1JFKGVmaXZhcnNfbG9jayk7CiAKIHN0YXRpYyBib29s
IGVmaXZhcl93cV9lbmFibGVkID0gdHJ1ZTsKIERFQ0xBUkVfV09SSyhlZml2YXJfd29yaywgTlVM
TCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIGIvZHJpdmVycy9odi92bWJ1
c19kcnYuYwppbmRleCBiYzY1YzRkLi5hNzVhZDhhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2h2L3Zt
YnVzX2Rydi5jCisrKyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMKQEAgLTg4LDcgKzg4LDcgQEAg
c3RhdGljIGludCBoeXBlcnZfZGllX2V2ZW50KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVu
c2lnbmVkIGxvbmcgdmFsLAogc3RhdGljIGNvbnN0IGNoYXIgKmZiX21taW9fbmFtZSA9ICJmYl9y
YW5nZSI7CiBzdGF0aWMgc3RydWN0IHJlc291cmNlICpmYl9tbWlvOwogc3RhdGljIHN0cnVjdCBy
ZXNvdXJjZSAqaHlwZXJ2X21taW87Ci1zdGF0aWMgREVGSU5FX1NFTUFQSE9SRShoeXBlcnZfbW1p
b19sb2NrKTsKK3N0YXRpYyBERUZJTkVfQklOQVJZX1NFTUFQSE9SRShoeXBlcnZfbW1pb19sb2Nr
KTsKIAogc3RhdGljIGludCB2bWJ1c19leGlzdHModm9pZCkKIHsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWFjaW50b3NoL2FkYi5jIGIvZHJpdmVycy9tYWNpbnRvc2gvYWRiLmMKaW5kZXggNGM4MDk3
ZS4uNTU3MjVlMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tYWNpbnRvc2gvYWRiLmMKKysrIGIvZHJp
dmVycy9tYWNpbnRvc2gvYWRiLmMKQEAgLTgwLDcgKzgwLDcgQEAKIEJMT0NLSU5HX05PVElGSUVS
X0hFQUQoYWRiX2NsaWVudF9saXN0KTsKIHN0YXRpYyBpbnQgYWRiX2dvdF9zbGVlcDsKIHN0YXRp
YyBpbnQgYWRiX2luaXRlZDsKLXN0YXRpYyBERUZJTkVfU0VNQVBIT1JFKGFkYl9wcm9iZV9tdXRl
eCk7CitzdGF0aWMgREVGSU5FX0JJTkFSWV9TRU1BUEhPUkUoYWRiX3Byb2JlX211dGV4KTsKIHN0
YXRpYyBpbnQgc2xlZXB5X3RyYWNrcGFkOwogc3RhdGljIGludCBhdXRvcG9sbF9kZXZzOwogaW50
IF9fYWRiX3Byb2JlX3N5bmM7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9h
ZGNvbS9ibngyeC9ibngyeF9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9i
bngyeC9ibngyeF9tYWluLmMKaW5kZXggYjgzODhlOS4uZWFjMWJmOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54MngvYm54MnhfbWFpbi5jCisrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2JueDJ4L2JueDJ4X21haW4uYwpAQCAtMjgzLDcgKzI4
Myw3IEBAIGVudW0gYm54MnhfYm9hcmRfdHlwZSB7CiAKIC8qIEdsb2JhbCByZXNvdXJjZXMgZm9y
IHVubG9hZGluZyBhIHByZXZpb3VzbHkgbG9hZGVkIGRldmljZSAqLwogI2RlZmluZSBCTlgyWF9Q
UkVWX1dBSVRfTkVFREVEIDEKLXN0YXRpYyBERUZJTkVfU0VNQVBIT1JFKGJueDJ4X3ByZXZfc2Vt
KTsKK3N0YXRpYyBERUZJTkVfQklOQVJZX1NFTUFQSE9SRShibngyeF9wcmV2X3NlbSk7CiBzdGF0
aWMgTElTVF9IRUFEKGJueDJ4X3ByZXZfbGlzdCk7CiAKIC8qIEZvcndhcmQgZGVjbGFyYXRpb24g
Ki8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9lc2FzMnIvZXNhczJyX2lvY3RsLmMgYi9kcml2
ZXJzL3Njc2kvZXNhczJyL2VzYXMycl9pb2N0bC5jCmluZGV4IDk3NjIzMDAuLjU1YTk0ODggMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9lc2FzMnIvZXNhczJyX2lvY3RsLmMKKysrIGIvZHJpdmVy
cy9zY3NpL2VzYXMyci9lc2FzMnJfaW9jdGwuYwpAQCAtNTYsNyArNTYsNyBAQAogdTMyIGVzYXMy
cl9idWZmZXJlZF9pb2N0bF9zaXplOwogc3RydWN0IHBjaV9kZXYgKmVzYXMycl9idWZmZXJlZF9p
b2N0bF9wY2lkOwogCi1zdGF0aWMgREVGSU5FX1NFTUFQSE9SRShidWZmZXJlZF9pb2N0bF9zZW1h
cGhvcmUpOworc3RhdGljIERFRklORV9CSU5BUllfU0VNQVBIT1JFKGJ1ZmZlcmVkX2lvY3RsX3Nl
bWFwaG9yZSk7CiB0eXBlZGVmIGludCAoKkJVRkZFUkVEX0lPQ1RMX0NBTExCQUNLKShzdHJ1Y3Qg
ZXNhczJyX2FkYXB0ZXIgKiwKIAkJCQkgICAgICAgc3RydWN0IGVzYXMycl9yZXF1ZXN0ICosCiAJ
CQkJICAgICAgIHN0cnVjdCBlc2FzMnJfc2dfY29udGV4dCAqLApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGFnaW5nL3ZjMDRfc2VydmljZXMvaW50ZXJmYWNlL3ZjaGlxX2FybS92Y2hpcV8yODM1X2Fy
bS5jIGIvZHJpdmVycy9zdGFnaW5nL3ZjMDRfc2VydmljZXMvaW50ZXJmYWNlL3ZjaGlxX2FybS92
Y2hpcV8yODM1X2FybS5jCmluZGV4IGI1OWVmMTQuLjcyN2VjNTkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvc3RhZ2luZy92YzA0X3NlcnZpY2VzL2ludGVyZmFjZS92Y2hpcV9hcm0vdmNoaXFfMjgzNV9h
cm0uYworKysgYi9kcml2ZXJzL3N0YWdpbmcvdmMwNF9zZXJ2aWNlcy9pbnRlcmZhY2UvdmNoaXFf
YXJtL3ZjaGlxXzI4MzVfYXJtLmMKQEAgLTg0LDcgKzg0LDcgQEAgc3RydWN0IHZjaGlxX3BhZ2Vs
aXN0X2luZm8gewogc3RhdGljIHN0cnVjdCBzZW1hcGhvcmUgZ19mcmVlX2ZyYWdtZW50c19zZW1h
Owogc3RhdGljIHN0cnVjdCBkZXZpY2UgKmdfZGV2OwogCi1zdGF0aWMgREVGSU5FX1NFTUFQSE9S
RShnX2ZyZWVfZnJhZ21lbnRzX211dGV4KTsKK3N0YXRpYyBERUZJTkVfQklOQVJZX1NFTUFQSE9S
RShnX2ZyZWVfZnJhZ21lbnRzX211dGV4KTsKIAogc3RhdGljIGlycXJldHVybl90CiB2Y2hpcV9k
b29yYmVsbF9pcnEoaW50IGlycSwgdm9pZCAqZGV2X2lkKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc2VtYXBob3JlLmggYi9pbmNsdWRlL2xpbnV4L3NlbWFwaG9yZS5oCmluZGV4IDExYzg2
ZmIuLmI3NDUyMmEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2VtYXBob3JlLmgKKysrIGIv
aW5jbHVkZS9saW51eC9zZW1hcGhvcmUuaApAQCAtMjYsNyArMjYsNyBAQCBzdHJ1Y3Qgc2VtYXBo
b3JlIHsKIAkud2FpdF9saXN0CT0gTElTVF9IRUFEX0lOSVQoKG5hbWUpLndhaXRfbGlzdCksCQlc
CiB9CiAKLSNkZWZpbmUgREVGSU5FX1NFTUFQSE9SRShuYW1lKQlcCisjZGVmaW5lIERFRklORV9C
SU5BUllfU0VNQVBIT1JFKG5hbWUpCVwKIAlzdHJ1Y3Qgc2VtYXBob3JlIG5hbWUgPSBfX1NFTUFQ
SE9SRV9JTklUSUFMSVpFUihuYW1lLCAxKQogCiBzdGF0aWMgaW5saW5lIHZvaWQgc2VtYV9pbml0
KHN0cnVjdCBzZW1hcGhvcmUgKnNlbSwgaW50IHZhbCkKZGlmZiAtLWdpdCBhL2tlcm5lbC9wcmlu
dGsvcHJpbnRrLmMgYi9rZXJuZWwvcHJpbnRrL3ByaW50ay5jCmluZGV4IGYyNzRmYmUuLjhjYjJm
MjcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9wcmludGsvcHJpbnRrLmMKKysrIGIva2VybmVsL3ByaW50
ay9wcmludGsuYwpAQCAtNzgsNyArNzgsNyBAQAogICogcHJvdmlkZXMgc2VyaWFsaXNhdGlvbiBm
b3IgYWNjZXNzIHRvIHRoZSBlbnRpcmUgY29uc29sZQogICogZHJpdmVyIHN5c3RlbS4KICAqLwot
c3RhdGljIERFRklORV9TRU1BUEhPUkUoY29uc29sZV9zZW0pOworc3RhdGljIERFRklORV9CSU5B
UllfU0VNQVBIT1JFKGNvbnNvbGVfc2VtKTsKIHN0cnVjdCBjb25zb2xlICpjb25zb2xlX2RyaXZl
cnM7CiBFWFBPUlRfU1lNQk9MX0dQTChjb25zb2xlX2RyaXZlcnMpOwogCi0tIAoxLjkuMQoK
--089e08e578414ffff00568b56a7e--
