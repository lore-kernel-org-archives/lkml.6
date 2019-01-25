Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D47C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130C3218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfAYSJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:09:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:56590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbfAYSJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:09:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04F49ADC2;
        Fri, 25 Jan 2019 18:09:48 +0000 (UTC)
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org
References: <20190124005229.16146-1-tonyj@suse.de>
 <20190125123119.GD12077@kernel.org> <20190125135730.GE12077@kernel.org>
From:   Tony Jones <tonyj@suse.de>
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
Message-ID: <f1547448-7e1a-c322-5b71-a37f4ddb2910@suse.de>
Date:   Fri, 25 Jan 2019 10:09:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190125135730.GE12077@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/19 5:57 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 25, 2019 at 01:31:19PM +0100, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones escreveu:
>>> Seeteena posted, earlier this week, some patches to add Python3 support
>>> to scripts/python/*.py.  Unfortunately there were some issues with these
>>> patches (such as: https://lkml.org/lkml/2019/1/17/351)
>>>
>>> Since I already had a tested set of patches in openSUSE:Factory and 
>>> SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
>>> should post my patches not involving scripts/python/*.py and Seeteena 
>>> will later resubmit the patches for scripts/python/*.py incorporating 
>>> my review feedback under a joint signed-off-by.
>>>
>>> It should be noted that the use of "from __future__ import print_function" 
>>> (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
>>> tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
>>> been backported to prior versions.  I am not sure if it's worth detecting 
>>> <2.6 at build time or whether it's sufficiently old as to be a non-issue?
>>>
>>> The shebang changes were driven mostly by our build process as it scans
>>> all files within an rpm and the shebangs would result in a rpm requires
>>> on the python2 binary when BuildRequires was python3-devel. I think they 
>>> make sense to apply upstream but understand totally if it's prefered we 
>>> keep them local.
>>>
>>> These changes have been tested with PYTHON=python2 (v2.7) and 
>>> PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
>>> test #18 "'import perf' in python" is failing on my system without these 
>>> changes. I'll look at it further but didn't want to hold up Seeteena's 
>>> resubmit.
>>
>> So it fails on AmazonLinux 1, that has python 2.6, please check if this
>> is something we can workaround, if its difficult, I'll just use
>> NO_PYTHON=1 there to disable it.

Sorry about this.  I'll be sure to test more broadly next time.

>>
>>   CC       /tmp/build/perf/util/parse-branch-options.o
>> util/scripting-engines/trace-event-python.c: In function 'python_start_script':
>> util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
>>   PyImport_AppendInittab("perf_trace_context", initfunc);
>>   ^
>> In file included from /usr/include/python2.6/Python.h:130:0,
>>                  from util/scripting-engines/trace-event-python.c:22:
>> /usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
>>  PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
>>                  ^
>> cc1: all warnings being treated as errors
>> mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
>> make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1
> 
> I did a quick hack to init an auto variable with that const string and
> then pass it, is passing everything so far:

I see that you already amended in cc4376422552

Thanks!
