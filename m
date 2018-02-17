Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBQHUQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 02:20:16 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41971 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQHUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 02:20:14 -0500
X-Google-Smtp-Source: AH8x227ymkN3FukY3TcCL1VPlwuhfyDKbf+pw9nTuLNiJOx22F0fHwvqa4hq9Jdej5r2/tqqHOSe0w==
Date: Sat, 17 Feb 2018 10:20:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] proc: use set_puts() at /proc/*/wchan
Message-ID: <20180217072011.GB16074@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -396,7 +396,7 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 
 	wchan = get_wchan(task);
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
-		seq_printf(m, "%s", symname);
+		seq_puts(m, symname);
 		return 0;
 	}
 
