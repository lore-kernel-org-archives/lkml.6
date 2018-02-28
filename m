Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227CexjaN3LRMhNysfDSnARiSHjfAPu4X8r3fkDBRCsKXab9Q1jxnL4sdqbaEndYKtr0LCei
ARC-Seal: i=1; a=rsa-sha256; t=1519831344; cv=none;
        d=google.com; s=arc-20160816;
        b=QwCLtr67z4XwCjo2Q8R++Z81HOgNBF8SNohrBQg8VBhnCHiXPUiAUej8IXHqhrlqzP
         6gLl+8HW5FdkVEanrgChLmrpHyVeWSFM+GxGzWyLLcXbiZX6NVYnhBmDrPHbpg0iZcBA
         b7E+wgyFDtaB+ifGtcZ/wrt1NsSXE/PHXMMgz8/1QsUYit+gQwRJO9pRGcpMIPtGCyGO
         yWgfHKNW4cTshD7tfXrEn2Jz6QhNF3dFt5iEolj6jZ1Ze4PVB/PmVpUus73gqHzG8KOK
         iPnlPgj5jPouxD2WZok7g/V5tSFBEA+675+OIFlV3cm+237MX8qNXLZePs/bxdmoC7cy
         aqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=k3dEO0R8AN+oiztzBcJCo9ShVPK0L/x70ZgZXxlR0oc=;
        b=ls0WI/qzyVhTy8V1rSBipdEdOwBBiUPcMltBXE2VdpgvPw0dfAGFcF0VfM3JNVM0en
         M+BXPQiQxvlXl6EudpIIkBjRphgEI6X/f2xiDcNHp9BGJq0qegYfOTOTWZZOnSkV/INk
         4+NC6f5MBdi/kze7vMNQcirfM9BEpkXhaeD4S/ALs9cCSB3facD96PamVbau6k6IMjen
         WrLqQI/X4Lf8Tjr9U3hM8E714dltdikAwoTJb0jjaE8szHV2N4BDHcMZIc22TbmoT+RU
         rwzSLYPmxw1z7CJw8+Wuupv37et71GmWNkBq1fffXDVpD6xYslIgh/1TbgfRoKhCVic2
         tDfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
 "Matt Fleming" <matt@codeblueprint.co.uk>,
 "Dave Young" <dyoung@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 linux-efi@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.738032988@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 061/254] efi: Move some sysfs files to be read-only
 by root
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658671653555925?=
X-GMAIL-MSGID: =?utf-8?q?1593658671653555925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit af97a77bc01ce49a466f9d4c0125479e2e2230b6 upstream.

Thanks to the scripts/leaking_addresses.pl script, it was found that
some EFI values should not be readable by non-root users.

So make them root-only, and to do that, add a __ATTR_RO_MODE() macro to
make this easier, and use it in other places at the same time.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20171206095010.24170-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: drop changes in esrt.c]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -72,8 +72,7 @@ static ssize_t systab_show(struct kobjec
 	return str - buf;
 }
 
-static struct kobj_attribute efi_attr_systab =
-			__ATTR(systab, 0400, systab_show, NULL);
+static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
 
 #define EFI_FIELD(var) efi.var
 
--- a/drivers/firmware/efi/runtime-map.c
+++ b/drivers/firmware/efi/runtime-map.c
@@ -67,11 +67,11 @@ static ssize_t map_attr_show(struct kobj
 	return map_attr->show(entry, buf);
 }
 
-static struct map_attribute map_type_attr = __ATTR_RO(type);
-static struct map_attribute map_phys_addr_attr   = __ATTR_RO(phys_addr);
-static struct map_attribute map_virt_addr_attr  = __ATTR_RO(virt_addr);
-static struct map_attribute map_num_pages_attr  = __ATTR_RO(num_pages);
-static struct map_attribute map_attribute_attr  = __ATTR_RO(attribute);
+static struct map_attribute map_type_attr = __ATTR_RO_MODE(type, 0400);
+static struct map_attribute map_phys_addr_attr = __ATTR_RO_MODE(phys_addr, 0400);
+static struct map_attribute map_virt_addr_attr = __ATTR_RO_MODE(virt_addr, 0400);
+static struct map_attribute map_num_pages_attr = __ATTR_RO_MODE(num_pages, 0400);
+static struct map_attribute map_attribute_attr = __ATTR_RO_MODE(attribute, 0400);
 
 /*
  * These are default attributes that are added for every memmap entry.
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -82,6 +82,12 @@ struct attribute_group {
 	.show	= _name##_show,						\
 }
 
+#define __ATTR_RO_MODE(_name, _mode) {					\
+	.attr	= { .name = __stringify(_name),				\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+	.show	= _name##_show,						\
+}
+
 #define __ATTR_WO(_name) {						\
 	.attr	= { .name = __stringify(_name), .mode = S_IWUSR },	\
 	.store	= _name##_store,					\
