Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeCNVTq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:19:46 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:39772 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:19:45 -0400
X-Google-Smtp-Source: AG47ELtkBS6OlCn5+nr2AuTAQg+oIk8NLD4TB9ChdIqg0YPQo9lJFHxQ1fD39thQ3CCn+r1sh23I1A==
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: New -Werror=restrict error with incremental gcc
Message-ID: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
Date: Wed, 14 Mar 2018 14:19:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora picked up a new gcc (8.0.1-0.18.fc29) and it seems to have introduced a new error:

   gcc -Wp,-MD,/home/labbott/linux/tools/objtool/.str_error_r.o.d -Wp,-MT,/home/labbott/linux/tools/objtool/str_error_r.o -Wall -Werror -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wshadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3 -Wno-switch-default -Wno-switch-enum -Wno-packed -fomit-frame-pointer -O2 -g -I/home/labbott/linux/tools/include -I/home/labbott/linux/tools/arch/x86/include/uapi -I/home/labbott/linux/tools/objtool/arch/x86/include -I/home/labbott/linux/tools/lib -D"BUILD_STR(s)=#s" -c -o /home/labbott/linux/tools/objtool/str_error_r.o ../lib/str_error_r.c
../lib/str_error_r.c: In function ‘str_error_r’:
../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
    ^~

This looks like gcc is now warning about the aliasing from printing out buf
while printing to the buffer. I can work around this pretty easily but I
know people have strong opinions about gcc warnings. Any thoughts?

Thanks,
Laura
