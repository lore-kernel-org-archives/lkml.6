Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZocSTiE56PHqYt0NQ7hBrl73BcpZU/LUeK44WkQyh1UTR8FrsvwmF4IZHnCeAl7eTOrsu/2
ARC-Seal: i=1; a=rsa-sha256; t=1524895805; cv=none;
        d=google.com; s=arc-20160816;
        b=A8djLrgfFlPV4vHKgnwuNZ/1sLbha7AvvZDAaNfBC3jgi89dOJMwOrLw2SdxEWBAtP
         5G+BIyyXoxR+TRhFveDpWBjBUoQQhVvR2SzLd5B2fB3cLwonvJihNtDyhcy7woqkdDQO
         JaGCITT/C2aEoS2zZoDEGDeB3QiDvi7U7LtDoKVGpjUML/Ai85/FF1ZXjEYZpxr7KMXw
         JVZs2UPPbqJ4O3M1ZkOFegLy7+CGhh0m6RMPvIbNwmqZ5XgtHKjLhrJCsO2bhSYZQV0L
         HX2bfRmTlgMWtXFR3RrT//vWPqR/LC6EXyer/rjkxjugOHg1+iKbDc8YVaVygj2eKLMh
         Ev4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6IZWthw7xQgnagtCbuo1r+yqPvp3h0Ylduc3iQHgzCs=;
        b=IRsU1XFEXAe7yxoSnVGFKJTF94/JBzZ11UIuw5WPxVMSQLBOM1SDqtHXcQWQ2P71zD
         l3+QDNnWSIY/nihlRI7VjWlgpDjZSktU5/iHLC+ydg8MWRB4DuWmrysGKDZctkkHtA1y
         mA+fGFX41Ax8p277KiBfBHrJB6EONfW565DlEHiogJ+nWeQWLJ+6KeUOKPSfrD9xypvv
         xxhj39h+OXkTqL3+P1Nf3fvhgBEY8qhSGNl0tHRy4rO84pyGsE27bTZ+cw8/Ja5fjL4B
         DPyO4Oo7CLt/BKlEwv3Zg++i8/4x1d+Oc7V6DR18mF8KE1xymwzmKFTf4nbFaqjjRPIH
         1aOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jIhQQtuh;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jIhQQtuh;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Teck Choon Giam <giamteckchoon@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
 <84b1d534-9b9d-ff70-ead6-3f8bb70a4d4b@infradead.org>
 <20180428050026.GA29422@kroah.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a56f585-d3c1-ee42-20a3-b47921f160c4@infradead.org>
Date: Fri, 27 Apr 2018 23:09:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428050026.GA29422@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1598370592739113214?=
X-GMAIL-MSGID: =?utf-8?q?1598969143909881549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 10:00 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 27, 2018 at 10:28:27AM -0700, Randy Dunlap wrote:
>> [adding some Cc:]
>>
>> On 04/14/2018 02:41 AM, Teck Choon Giam wrote:
>>> Hi,
>>>
>>> Compile linux-4.9.94 will have error related to KMOD_DECOMP_LEN
>>> undeclared.  Searching string related to KMOD_DECOMP_LEN in
>>> linux-4.9.94 and linux-4.15.17 sources as below:
>>>
>>> <mock-chroot>sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.15.17
>>> ./linux-4.15.17/tools/perf/tests/code-reading.c: char
>>> decomp_name[KMOD_DECOMP_LEN];
>>> ./linux-4.15.17/tools/perf/util/dso.h:#define KMOD_DECOMP_LEN
>>> sizeof(KMOD_DECOMP_NAME)
>>> ./linux-4.15.17/tools/perf/util/annotate.c: char tmp[KMOD_DECOMP_LEN];
>>> ./linux-4.15.17/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
>>> sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.9.94
>>> ./linux-4.9.94/tools/perf/tests/code-reading.c: char
>>> decomp_name[KMOD_DECOMP_LEN];
>>> ./linux-4.9.94/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
>>>
>>> So I guess for linux-4.9.94 has not define KMOD_DECOMP_LEN in
>>> tools/perf/util/dso.h?
>>
>>
>> 4.9.9[456] lack:
>> #define KMOD_DECOMP_NAME  "/tmp/perf-kmod-XXXXXX"
>> #define KMOD_DECOMP_LEN   sizeof(KMOD_DECOMP_NAME)
>>
>>
>> However, the commit that added those macros does not apply cleanly to 4.9.96.
>>
>> commit 42b3fa670825983fc8bd0ac7b80cc84ae3abb75b
>> Author: Namhyung Kim <namhyung@kernel.org>
>> Date:   Thu Jun 8 16:31:03 2017 +0900
>>
>>     perf tools: Introduce dso__decompress_kmodule_{fd,path}
> 
> This should now be fixed in the latest 4.9.y -rc release, right?
> 
> If not, please let me know as I though I resolved this problem there...

It still fails in 4.9.96. (not #defined there)

-- 
~Randy
