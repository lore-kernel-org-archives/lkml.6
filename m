Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65FC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA892084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfASCFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 21:05:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728494AbfASCFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 21:05:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE6F7ACBC;
        Sat, 19 Jan 2019 02:05:49 +0000 (UTC)
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 check-perf-trace.py
From:   Tony Jones <tonyj@suse.de>
To:     Jiri Olsa <jolsa@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <20190117123202.GC16366@krava> <0d8a6ddc-9755-2b50-4023-26f6c84a33d1@suse.de>
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
Message-ID: <7d5e8be1-b2dc-7654-744b-5ddbe2faf5b2@suse.de>
Date:   Fri, 18 Jan 2019 18:05:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0d8a6ddc-9755-2b50-4023-26f6c84a33d1@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 4:29 PM, Tony Jones wrote:

> I'd been simultaneously working on a patch set to fix up Python3.  
> 
> It's actually already in our Factory and SLE15-SP1 releases as we had a deadline to kill Python2 usage for internal rpms. 
> 
> I was going to post once I'd fixed the last remaining issue ('import perf' is still failing [test #18]).   
> 
> I guess "you snooze you lose" :-)
> 
> https://build.opensuse.org/package/view_file/devel:tools/perf/perf.changes?expand=1

Seeteena, I'm than happy to forward my patches via email. Alternatively, as I said in another post,  the full series is in SLE15-SP1/beta2 (should apply to tip) which IBM has access to and they've been backported to v4.19 (Factory) at https://build.opensuse.org/package/show/openSUSE:Factory/perf.  Everything has been tested against python2 and python3.

Also, in this series there are patches to: 
- port tests/attr.py to Python3
- remove shebangs from the .py scripts and change to mode 644 as IMO it makes no sense to explicitly have #!/usr/bin/python since per pep-0394 this refers to version2 and the system may only have python3 installed
- remove the shebang from setup.py since it's explicitly invoked via call to ${PYTHON_WORD}

Also I found in testing that the following fix is also needed. I'm not 100% sure on it and was going to revisit before posting but _PyUnicode_FromStringAndSize() is definitely unsafe to use on attr.

----

Fixes: 66dfdff03d196e51322c6a85c0d8db8bb2bdd655

With Python3.  PyUnicode_FromStringAndSize is unsafe to call on attr and will
return NULL.  Use _PyBytes_FromStringAndSize (as with raw_buf).

$ perf script -s perf-script.py -i perf.data
in trace_begin
Segmentation fault (core dumped)
---
 tools/perf/util/scripting-engines/trace-event-python.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -733,8 +733,7 @@ static PyObject *get_perf_sample_dict(st
                Py_FatalError("couldn't create Python dictionary");

        pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
-       pydict_set_item_string_decref(dict, "attr", _PyUnicode_FromStringAndSize(
-                       (const char *)&evsel->attr, sizeof(evsel->attr)));
+       pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->attr, sizeof(evsel->attr)));

        pydict_set_item_string_decref(dict_sample, "pid",
                        _PyLong_FromLong(sample->pid));
