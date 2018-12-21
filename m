Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E720C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAE121906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc7xLSRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeLUHLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:11:06 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39561 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:11:05 -0500
Received: by mail-wr1-f54.google.com with SMTP id t27so4094303wra.6;
        Thu, 20 Dec 2018 23:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3vXWmnchlkAz3GDBqPrYNx42BTVxmeWoTMk3iVdteCQ=;
        b=Qc7xLSRjMo1/tUrhv+Kho2/Bl7EI60tYwKrDCEKIucEnHhEyNAOSyJQ2UWsp+cqj4j
         aRMShfJTOlX+fdlWjiYK5BIrxvTSQl7yTsNLAQCUyIX/CAONzSNAD5SOYAb1HbQUoodb
         27pl74XV2saSidTc3Fs7ZhBtWORi4NDBngB8MODgPqmCBjz5hNmI3ZN4eDJNO4aybx9Y
         ryVeKq70LhSysE+ZXGluZoU/pT65qKKWe7ophsUEbGcC+aY8yf2iLMzlbHhxmOgQYPUN
         iEFEfLjXNRV+aKIC4XVYwz5eMOEdWeeK6sdPqv0N5PWtQzGDKK3HbOFq9QZPxR/Y1KJa
         VEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3vXWmnchlkAz3GDBqPrYNx42BTVxmeWoTMk3iVdteCQ=;
        b=myiWupxTL23m/UBnVv3a3+Ahf+PByS+D5Terqsp6YvP8hm8BBw60uNDrAV/aJF+H7H
         ZrYO7MF8Gmv+Q+8pfkB8FbYucbZz4MeEICLMfBC1bXvC3cnkJ1CWbY6LUvwJXBvpViW8
         1ji6QmDhQs+yH9Ra9ykVBN9vt5b+eFWYomOqkekkVr1J7GrAw6RsG7hRxAPAQ5Ejs0l8
         1P27xcKnrbROqYxV7m/Qg4dob5V8Cok/rrZyO9JrDkw75OrfEPY1of/BsEtGeOZzqhE/
         v+dnpLCyXhgZiM2bYlSYJEzLrgWWJ6lmf9rKVEJsPwrxYu4e3Ceb+DptEcHZKzNVxu5E
         aKRA==
X-Gm-Message-State: AJcUukdmFDXYth7wwDuzYd+5zeHYVL2VkSNq+31t+8HmJ7kPBDdClXq0
        NTZ9Fi+OyKK4rKv8fCUW/2k=
X-Google-Smtp-Source: ALg8bN77mUihUKiPhUs+/2SkSXRLL0b0Y+9EqbABJUo+PQV8aUFp5EO/9QChcqIqXNSR7qDRcvDJwg==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr1299057wrt.141.1545376262954;
        Thu, 20 Dec 2018 23:11:02 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y34sm28456256wrd.68.2018.12.20.23.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:11:02 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:11:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Clang build error in drivers/scsi/smartpqi/smartpqi_init.c
Message-ID: <20181221071100.GA20515@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After commit 4fd22c13ad44 ("scsi: smartpqi: add ofa support"), an arm
allyesconfig build with Clang fails with the following warning/error:

drivers/scsi/smartpqi/smartpqi_init.c:7473:2: warning: comparison of distinct pointer types ('typeof ((sg_count)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
        do_div(sg_count, chunk_size);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
        (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
               ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
drivers/scsi/smartpqi/smartpqi_init.c:7473:2: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
        do_div(sg_count, chunk_size);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/div64.h:239:22: note: expanded from macro 'do_div'
                __rem = __div64_32(&(n), __base);       \
                                   ^~~~
./arch/arm/include/asm/div64.h:33:45: note: passing argument to parameter 'n' here
static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                                            ^
drivers/scsi/smartpqi/smartpqi_init.c:7473:2: warning: shift count >= width of type [-Wshift-count-overflow]
        do_div(sg_count, chunk_size);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/div64.h:235:25: note: expanded from macro 'do_div'
        } else if (likely(((n) >> 32) == 0)) {          \
                               ^  ~~
./include/linux/compiler.h:76:40: note: expanded from macro 'likely'
# define likely(x)      __builtin_expect(!!(x), 1)
                                            ^

According to include/asm-generic/div64.h, the first parameter of do_div
must be a 64-bit number, meaning the below diff would properly fix it.

However, I am not sure if there are any unintended consequences of this
change, hence reaching out before sending it in. If you have a more
preferred way of fixing it, please do so.

Thank you,
Nathan

==========================================================================================

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index e57fbff08f03..6a185a6172c4 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7460,7 +7460,7 @@ static void pqi_ofa_ctrl_unquiesce(struct pqi_ctrl_info *ctrl_info)
 static int pqi_ofa_alloc_mem(struct pqi_ctrl_info *ctrl_info,
        u32 total_size, u32 chunk_size)
 {
-       u32 sg_count;
+       u64 sg_count;
        u32 size;
        int i;
        struct pqi_sg_descriptor *mem_descriptor = NULL;
