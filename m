Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97765C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3F820823
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfASA3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:29:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:33564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730168AbfASA3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:29:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C30A4AC95;
        Sat, 19 Jan 2019 00:29:21 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 check-perf-trace.py
To:     Jiri Olsa <jolsa@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <20190117123202.GC16366@krava>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <0d8a6ddc-9755-2b50-4023-26f6c84a33d1@suse.de>
Date:   Fri, 18 Jan 2019 16:29:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190117123202.GC16366@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 4:32 AM, Jiri Olsa wrote:
> On Thu, Jan 17, 2019 at 03:15:28PM +0530, Seeteena Thoufeek wrote:
>> Support both Python 2 and Python 3 in check-perf-trace.py.
>> ``print`` is now a function rather than a statement. This should have
>> no functional change.
>>
>> Fix indentation issue, replace spaces with tab
>>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> hum, could you please add some info about testing those changes?
> (or even some global into 0/.. patch)
> 
> this is working for me on python2:
> 
> 	[root@krava perf]# perf script rec check-perf-trace
> 	^C
> 	[root@krava perf]# perf script   -s scripts/python/check-perf-trace.py
> 	trace_begin
> 
> 	unhandled events:
> 
> 
> 	event                                          count
> 
> 	----------------------------------------  -----------
> 
> 	raw_syscalls__sys_enter                      3509879
> 
> 
> but fails for python3:
> 
> 	[root@ibm-x3650m4-01-vm-04 perf]# perf script rec check-perf-trace
> 	^C[ perf record: Woken up 0 times to write data ]
> 	Warning:
> 	1 out of order events recorded.
> 	[ perf record: Captured and wrote 43.132 MB perf.data (490171 samples) ]
> 
> 	[root@ibm-x3650m4-01-vm-04 perf]# perf script   -s scripts/python/check-perf-trace.py
> 	Traceback (most recent call last):
> 	  File "scripts/python/check-perf-trace.py", line 18, in <module>
> 	    from perf_trace_context import *
> 	ModuleNotFoundError: No module named 'perf_trace_context'
> 	Error running python script scripts/python/check-perf-trace.py
> 
> I did not test with rpm, just did 'make install' for perf
> 
> thanks,
> jirka
> 

I'd been simultaneously working on a patch set to fix up Python3.  

It's actually already in our Factory and SLE15-SP1 releases as we had a deadline to kill Python2 usage for internal rpms. 

I was going to post once I'd fixed the last remaining issue ('import perf' is still failing [test #18]).   

I guess "you snooze you lose" :-)

https://build.opensuse.org/package/view_file/devel:tools/perf/perf.changes?expand=1

Anyhow,  the fix for the above is: 'add-trace_context-extension-module-to-sys-modules.patch' from above.

Attached below.  Verified with PYTHON=python2 and PYTHON=python3

Tony

---------------------------------

In Python3,  the result of PyModule_Create (called from
scripts/python/Perf-Trace-Util/Context.c) is not automatically added to 
sys.modules.  See: https://bugs.python.org/issue4592

Below is the observed behavior without the fix.

# ldd /usr/bin/perf | grep -i python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f8e1dfb2000)

# perf record -a -e raw_syscalls:sys_enter sleep 5
[ perf record: Woken up 0 times to write data ]
[ perf record: Captured and wrote 187.177 MB perf.data (1581501 samples) ]

# perf script -g python | cat
generated Python script: perf-script.py

# perf script -s ./perf-script.py
Traceback (most recent call last):
  File "./perf-script.py", line 18, in <module>
    from perf_trace_context import *
ModuleNotFoundError: No module named 'perf_trace_context'
Error running python script ./perf-script.py

Signed-off-by: Tony Jones <tonyj@suse.de>
---
 tools/perf/util/scripting-engines/trace-event-python.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1494,6 +1494,7 @@ static void _free_command_line(wchar_t *
 static int python_start_script(const char *script, int argc, const char **argv)
 {
 	struct tables *tables = &tables_global;
+	PyMODINIT_FUNC (*initfunc)(void);
 #if PY_MAJOR_VERSION < 3
 	const char **command_line;
 #else
@@ -1504,24 +1505,25 @@ static int python_start_script(const cha
 	FILE *fp;
 
 #if PY_MAJOR_VERSION < 3
+	initfunc = initperf_trace_context;
 	command_line = malloc((argc + 1) * sizeof(const char *));
 	command_line[0] = script;
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = argv[i - 1];
 #else
+	initfunc = PyInit_perf_trace_context;
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
 #endif
 
+	PyImport_AppendInittab("perf_trace_context", initfunc);
 	Py_Initialize();
 
 #if PY_MAJOR_VERSION < 3
-	initperf_trace_context();
 	PySys_SetArgv(argc + 1, (char **)command_line);
 #else
-	PyInit_perf_trace_context();
 	PySys_SetArgv(argc + 1, command_line);
 #endif
 




