Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELsxdQ1afj9kn9X2A28PqYCUL2So7n4rwdmAqfcR4Gz8FHR0bfqfSv6jLDGayXA5pVtYnIL+
ARC-Seal: i=1; a=rsa-sha256; t=1520285463; cv=none;
        d=google.com; s=arc-20160816;
        b=PG4c6II2q1nY8cQcm1yot1IJHFr5pODUMonWEpnlbidE8cM/FJVrstkszHqNdvsayK
         wGoYa95B6Nbrqe+M1yfeVd4tGrBP+9VG1FUio6OkTjFIWtHcdEnDP6fS2hEj1pGNjUu3
         z7VkGDD6p/Q5+OP4MWo5Iz3Nuai1KfuZuzeJvCMEPlNfbtz1K4WzMIciwqm3cMlWuuRK
         eErVHL+VC5genhJog0coYo+/LrtawtczW1I79IIskmhKdezshNZ56evfbyU9Logfim1+
         ZcoCembt20/wonCTvNoYblcOcYadAGAtmxld8ItezATG8kPbvAf45mLxCo3NY8bo9U33
         TFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=WF0yB/iDA9p0TCgYvbpHxVkX27ySg1JizYPGjnyNq9Q=;
        b=KcyhmF0t/WPBDn3Q3iyuA6Uapyqho7LUmSD9ukHWQ212t3vVOMKKpUuXqhGVozpoZN
         2QM3rx9E80qZWImXz34/LfVq691ycFCWYH2sN3wrKiuR2tJY/vyKBNcy6kl41i7VdZe3
         WUpMP2WD0Q0SzK3UHkIll4QBFz5yOdE2ZJgQmpZxWsqqXJo3xHVQAv11ydCcWg2m0MVd
         InQ26xJaHFV2zpEmbLqoISFYcLdU24Gqz3LQMnK/1/13x/FLmzatfapXMmLZq8L4I8wm
         TY4qqUbGs4WNBhlyqMX+SW118Ei3DNR/Sa3HEMUKVGvWBShdPZvHp6il6ueYF1TdtXde
         f3Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="180110191"
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net,
 akpm@linux-foundation.org
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
 <84931753-9a84-8624-adb8-95bd05d87d56@oracle.com>
Cc: corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com,
 pasha.tatashin@oracle.com, mike.kravetz@oracle.com, rob.gardner@oracle.com,
 mingo@kernel.org, nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com,
 kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com,
 allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com,
 vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz,
 punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com,
 ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org,
 minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com,
 linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com,
 jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8b0edd2e-3e9b-1148-6309-38b61307a523@linux.intel.com>
Date: Mon, 5 Mar 2018 13:31:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <84931753-9a84-8624-adb8-95bd05d87d56@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594134850299576013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 01:14 PM, Khalid Aziz wrote:
> Are you suggesting that vma returned by find_vma() could be split or
> merged underneath me if I do not hold mmap_sem and thus make the flag
> check invalid? If so, that is a good point.

This part does make me think that this code hasn't been tested very
thoroughly.  Could you describe the testing that you have done?  For MPX
and protection keys, I added something to tools/testing/selftests/x86,
for instance.
