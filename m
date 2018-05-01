Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756037AbeEAAj4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:39:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbeEAAjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:39:16 -0400
From: Al Stone <ahs3@redhat.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Al Stone <ahs3@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v3 1/3] ACPI: improve function documentation for acpi_parse_entries_array()
Date: Mon, 30 Apr 2018 18:39:05 -0600
Message-Id: <20180501003907.4322-2-ahs3@redhat.com>
In-Reply-To: <20180501003907.4322-1-ahs3@redhat.com>
References: <20180501003907.4322-1-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found the description of the table_size argument to the function
acpi_parse_entries_array() unclear and ambiguous.  This is a minor
documentation change to improve that description so I don't misuse
the argument again in the future, and it is hopefully clearer to
other future users.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 849c4fb19b03..4a3410aa6540 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -222,7 +222,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * acpi_parse_entries_array - for each proc_num find a suitable subtable
  *
  * @id: table id (for debugging purposes)
- * @table_size: single entry size
+ * @table_size: size of the root table
  * @table_header: where does the table start?
  * @proc: array of acpi_subtable_proc struct containing entry id
  *        and associated handler with it
@@ -233,6 +233,11 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * on it. Assumption is that there's only single handler for particular
  * entry id.
  *
+ * The table_size is not the size of the complete ACPI table (the length
+ * field in the header struct), but only the size of the root table; i.e.,
+ * the offset from the very first byte of the complete ACPI table, to the
+ * first byte of the very first subtable.
+ *
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
@@ -400,7 +405,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		return -ENODEV;
 }
 
-/* 
+/*
  * The BIOS is supposed to supply a single APIC/MADT,
  * but some report two.  Provide a knob to use either.
  * (don't you wish instance 0 and 1 were not the same?)
-- 
2.14.3
