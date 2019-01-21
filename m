Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF9C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8142089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfAURiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:38:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:59718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfAURiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:38:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04132AF1A;
        Mon, 21 Jan 2019 17:38:16 +0000 (UTC)
Subject: Re: [PATCH v3] perf scripts python: Add Python 3 support to
 export-to-sqlite.py
To:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
References: <1548067157-10395-1-git-send-email-s1seetee@linux.vnet.ibm.com>
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
Message-ID: <a9fea5f9-752d-e069-bd17-31fabe258a20@suse.de>
Date:   Mon, 21 Jan 2019 09:38:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1548067157-10395-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 2:39 AM, Seeteena Thoufeek wrote:
> Support both Python 2 and Python 3 in export-to-sqlite.py. ``print`` is
> now a function rather than a statement. This should have no functional
> change.
> 
> Also, handles the conversion of "print >> sys.stderr".
> 
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/scripts/python/export-to-sqlite.py | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
> index 245caf2..95bfcb2 100644
> --- a/tools/perf/scripts/python/export-to-sqlite.py
> +++ b/tools/perf/scripts/python/export-to-sqlite.py
> @@ -9,6 +9,7 @@
>  # ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>  # more details.
> +from __future__ import print_function

So is the script failing for you without the above   

As I said in previous reviews you should not need this unless you are using features of the latest print function (end, sep etc). You will need this import in the other scripts (once you fix the numerous errors regarding the trailing comma usage) as some need to concatenate output onto one line but I don't think you need it here.

tony


$ python2 --version
Python 2.7.15
$ python3 --version
Python 3.6.5

$ a='print("abcd") ; print("defg")'
$ echo $a | python2
abcd
defg
$ echo $a | python3
abcd
defg

$ b='print("abcd", end="") ; print("defg")'
$ echo $b | python2
  File "<stdin>", line 1
    print("abcd", end="") ; print("defg")
                     ^
SyntaxError: invalid syntax
$ echo $b | python3
abcddefg

$ c='from __future__ import print_function ; print("abcd", end="") ; print("defg")'
$ echo $c | python2
abcddefg
$ echo $c | python3
abcddefg
