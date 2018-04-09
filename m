Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeDIJdJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:33:09 -0400
Received: from mx21.baidu.com ([220.181.3.85]:47414 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeDIJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:33:08 -0400
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtSRkMgUEFUQ0hdIHg4Ni9hY3BpOiBQcmV2ZW50?=
 =?utf-8?Q?_x2apic_id_-1_from_being_accounted?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUkZDIFBBVENIXSB4ODYvYWNwaTogUHJldmVudCB4MmFwaWMg?=
 =?utf-8?Q?id_-1_from_being_accounted?=
Thread-Index: AQHTz6HHVSlv5hBR20yCXr6v6u68EqP3ZGGAgACVVGD//5+LgIAAkmSQ
Date: Mon, 9 Apr 2018 09:33:02 +0000
Message-ID: <2AD939572F25A448A3AE3CAEA61328C23759089A@BC-MAIL-M28.internal.baidu.com>
References: <1523187531-29837-1-git-send-email-lirongqing@baidu.com>
 <f137d895-b8b9-d2eb-bbf9-3e5cd8089291@cn.fujitsu.com>
 <2AD939572F25A448A3AE3CAEA61328C23758FDF3@BC-MAIL-M28.internal.baidu.com>
 <148150f5-4b33-c064-a877-88c20f63e96e@cn.fujitsu.com>
In-Reply-To: <148150f5-4b33-c064-a877-88c20f63e96e@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.62.20]
x-baidu-bdmsfe-datecheck: 1_BC-MAIL-HUB04_2018-04-09 17:33:04:506
x-baidu-bdmsfe-viruscheck: BC-MAIL-HUB04_GRAY_Inside_WithoutAtta_2018-04-09
 17:33:03:538
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w399XGNE017963



> -----邮件原件-----
> 发件人: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] 代表 Dou Liyang
> 发送时间: 2018年4月9日 16:47
> 收件人: Li,Rongqing <lirongqing@baidu.com>; linux-kernel@vger.kernel.org;
> tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; jgross@suse.com;
> x86@kernel.org; peterz@infradead.org
> 主题: Re: 答复: [RFC PATCH] x86/acpi: Prevent x2apic id -1 from being
> accounted
> 
> RongQing,
> 
> At 04/09/2018 02:38 PM, Li,Rongqing wrote:
> >
> >
> >> -----邮件原件-----
> >> 发件人: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
> >> 发送时间: 2018年4月9日 13:38
> >> 收件人: Li,Rongqing <lirongqing@baidu.com>;
> >> linux-kernel@vger.kernel.org; tglx@linutronix.de; mingo@redhat.com;
> >> hpa@zytor.com; jgross@suse.com; x86@kernel.org;
> peterz@infradead.org
> >> 主题: Re: [RFC PATCH] x86/acpi: Prevent x2apic id -1 from being
> >> accounted
> >>
> >> Hi RongQing,
> >>
> >> Is there an local x2apic whose ID is  in your machine?
> >>
> >
> > I think no
> 
> [...]
> 
> > [    0.000000] ACPI: X2APIC (apic_id[0xffffffff] uid[0x00] disabled)
> > [    0.000000] ACPI: X2APIC (apic_id[0xffffffff] uid[0x01] disabled)
> > [    0.000000] ACPI: X2APIC (apic_id[0xffffffff] uid[0x02] disabled)
> 
> Ah, sure enough!
> 
> [...]
> >
> >
> >> At 04/08/2018 07:38 PM, Li RongQing wrote:
> >>> local_apic_id of acpi_madt_local_x2apic is u32, it is converted to
> >>> int when checked by default_apic_id_valid() and return true if it is
> >>> larger than 0x7fffffff, this is wrong
> >>>
> >>
> >> For x2apic enabled systems,
> >>
> >>     - the byte length of X2APIC ID is 4, and it can be larger than
> >>       0x7fffffff in theory
> >>
> >
> > Yes
> >
> >>     - the ->apic_id_valid points to x2apic_apic_id_valid(), which always
> >>       return _ture_ , not default_apic_id_valid().
> >>
> >
> > To this machine, the apic is apic_flat
> 
> I see, I am sorry the title and changelog make me misunderstand.
> 
>    Here, actually, we prevent all the X2APIC Id from being parsed in
>    non-x2apic mode, not just 0xFFFFFFFF. because the values of x2APIC ID
>    must be 255 and greater in ACPI MADT.
> 

Thanks. How about the below modification:

commit 96ba42cf87ce0e62d500004c01bfa9a9479b2e87
Author: Li RongQing <lirongqing@baidu.com>
Date:   Sun Apr 8 18:54:10 2018 +0800

    x86/acpi: Prevent all the X2APIC Id from being parsed in non-x2apic mode
    
    the values of x2APIC ID is greater than 0xff in ACPI MADT, if acpi
    is apic_flat, default_apic_id_valid() is called to check id which
    is converted from u32 to int, will return true if id is larger than
    0x7fffffff, this is wrong
    
    and if local_apic_id is invalid, we should prevent it from being
    accounted
    
    This fixes a bug that Purley platform displays too many possible cpu
    
    Signed-off-by: Li RongQing <lirongqing@baidu.com>
    Suggested-by:: Dou Liyang <douly.fnst@cn.fujitsu.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 40a3d3642f3a..08acd954f00e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -313,7 +313,7 @@ struct apic {
        /* Probe, setup and smpboot functions */
        int     (*probe)(void);
        int     (*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-       int     (*apic_id_valid)(int apicid);
+       int     (*apic_id_valid)(u32 apicid);
        int     (*apic_id_registered)(void);
 
        bool    (*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -486,7 +486,7 @@ static inline unsigned int read_apic_id(void)
        return apic->get_apic_id(reg);
 }
 
-extern int default_apic_id_valid(int apicid);
+extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7a37d9357bc4..4ba949de1ca9 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -200,7 +200,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 {
        struct acpi_madt_local_x2apic *processor = NULL;
 #ifdef CONFIG_X86_X2APIC
-       int apic_id;
+       u32 apic_id;
        u8 enabled;
 #endif
 
@@ -222,10 +222,13 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
         * to not preallocating memory for all NR_CPUS
         * when we use CPU hotplug.
         */
-       if (!apic->apic_id_valid(apic_id) && enabled)
-               printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
-       else
-               acpi_register_lapic(apic_id, processor->uid, enabled);
+       if (!apic->apic_id_valid(apic_id)) {
+               if (enabled)
+                       printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
+               return 0;
+       }
+
+       acpi_register_lapic(apic_id, processor->uid, enabled);
 #else
        printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
 #endif
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index a360801779ae..02b4839478b1 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -40,7 +40,7 @@ int default_check_phys_apicid_present(int phys_apicid)
        return physid_isset(phys_apicid, phys_cpu_present_map);
 }
 
-int default_apic_id_valid(int apicid)
+int default_apic_id_valid(u32 apicid)
 {
        return (apicid < 255);
 }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 134e04506ab4..78778b54f904 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigned int id)
        return id << 24;
 }
 
-static int numachip_apic_id_valid(int apicid)
+static int numachip_apic_id_valid(u32 apicid)
 {
        /* Trust what bootloader passes in MADT */
        return 1;
diff --git a/arch/x86/kernel/apic/x2apic.h b/arch/x86/kernel/apic/x2apic.h
index b107de381cb5..a49b3604027f 100644
--- a/arch/x86/kernel/apic/x2apic.h
+++ b/arch/x86/kernel/apic/x2apic.h
@@ -1,6 +1,6 @@
 /* Common bits for X2APIC cluster/physical modes. */
 
-int x2apic_apic_id_valid(int apicid);
+int x2apic_apic_id_valid(u32 apicid);
 int x2apic_apic_id_registered(void);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e2829bf40e4a..b5cf9e7b3830 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -101,7 +101,7 @@ static int x2apic_phys_probe(void)
 }
 
 /* Common x2apic functions, also used by x2apic_cluster */
-int x2apic_apic_id_valid(int apicid)
+int x2apic_apic_id_valid(u32 apicid)
 {
        return 1;
 }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f11910b44638..efaf2d4f9c3c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -557,7 +557,7 @@ static void uv_send_IPI_all(int vector)
        uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static int uv_apic_id_valid(int apicid)
+static int uv_apic_id_valid(u32 apicid)
 {
        return 1;
 }
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 2163888497d3..5e53bfbe5823 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -112,7 +112,7 @@ static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
        return xen_pv_domain();
 }
 
-static int xen_id_always_valid(int apicid)
+static int xen_id_always_valid(u32 apicid)
 {
        return 1;
 }
