Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDEAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E285224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E285224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeKMOaI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:30:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:43801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeKMOaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:30:08 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0McmS9-1g527l3nlp-00Hzz7; Tue, 13
 Nov 2018 05:33:05 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <trinity-0da197a3-0f6e-41a3-8ab7-a3519e158a88-1541859073829@msvc-mesg-gmx023>
Date:   Mon, 12 Nov 2018 23:33:01 -0500
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Zhong Jiang <zhongjiang@huawei.com>,
        linux kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FE1B58AA-FC0E-4E0A-8A76-F98B70548F36@gmx.us>
References: <trinity-be6414fb-25ba-4881-acc6-abe3b375d0d0-1541814329304@msvc-mesg-gmx021>
 <c7b58543-ffd2-44bb-1005-e9733782bad5@redhat.com>
 <trinity-0da197a3-0f6e-41a3-8ab7-a3519e158a88-1541859073829@msvc-mesg-gmx023>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:4t38uTvSR6GfGvn1/YS5lk7H5V9I84X4GWYk95anX1iX9HVpT82
 NZ6W8Kff/K+yF1vsLELRvFG0xLiEubX5tPvkrc7uFD1Smuc7Lz3n7T//GEHrki8QtgC07B2
 u3toOeIPyMkJiClgU/pOJUXbDGB3TLewF0tQndhSQjWRdxRvQnaZmzeUnYSoo5NYaTk1U9B
 n9zit7+McHjXMziWv3O1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KPiVI0gVOBM=:OGkMtYn+/wZzXKNqZ179V+
 tyMJPSKdwD/z+k1TTnF4lM1DFlR8yzATIuiHdbJ9aLgjfksJcNE8fcg0AQVobQqzeAzNxefHL
 k3mjYWwJyJIq/HnKHGpRTqvaMI8sYAqCwAujXOyEXwr5dDb2VlM1mIKaNEC7AG9Q/FjBEMGMm
 BQlyQ+TSXXyNCQ2W0BeD3oPwt95A+KVWlbRtyOooFnPKnRCQIcrpFrze99akjMLHMQ6SWeX93
 b3mPYh0AXH+Es73rfY9P+AT9M4gjOFZBt/gSDfDX4uL52I9Ab8kplIkOaYbdUfLEWCSXQVojn
 Xk7K6y5BWm50OV+py5Xf4H9QYNHeigTrjAnMJcrL/75k90qtOtqR33/wYdplqq3nhOJ9kY05n
 SgNjfqjl+sVFEXsxUpEedj7cbxZCrDU+ta9JTGhjvrQM6ljRSXr7ERfYx7xmZcn3YeCbT/dGR
 thlfciTQmsfQm+BT3z1v6Ker36WUkylXH/vjYh3wa+s6mz9rrJ8fL/Q6G85C9qDRa/Opy9dsR
 A2rM6ew00K65Q416eB8as2FYfSd2qENJwDCQVdjHVqdJ9bVzuJD346tP3qh96hXIldc0R1fVL
 jl56swa+Bu58tOaqLkPmQCVncc4EmpzL79JD5G/qb7bRwDEDbT5XFKg2jaB6sZXB1x8OHj1An
 5XO9+ZL7nB5UbB/9SyYLL7cvHQqer83WfnQH3TNtBVxDHns9i0wyAXeeE8EMEMpdxYyKU3pBt
 pR4Xn8X+eTKHjHLdyey8gF5DiPgkFrfHn1n8745h/Jbw8/VyZEiKLd14AEspNjXDoZGEZ8r6R
 /fVGmSGhH8ra/5R2ywhGyjVIV8yXSyoPVt0vz9oQ3DiGW9cTpaOCW9kYxQQU9EjQQ86CJ/QFR
 Vu363JJiCho887QkJ1toYj0GSWE5eTEUXjVQtXPRAOjClbw5Sjdf26IBEmMcfF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 10, 2018, at 9:11 AM, Qian Cai <cai@gmx.us> wrote:
> 
> On 11/10/18 at 8:59 AM, Waiman Long wrote:
> 
>> On 11/09/2018 08:45 PM, Qian Cai wrote:
>>>> Sent: Friday, November 09, 2018 at 5:08 PM
>>>> From: "Waiman Long" <longman@redhat.com>
>>>> To: "Qian Cai" <cai@gmx.us>, "Yang Shi" <yang.shi@linux.alibaba.com>
>>>> Cc: "open list" <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Arnd Bergmann" <arnd@arndb.de>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Zhong Jiang" <zhongjiang@huawei.com>
>>>> Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
>>>> 
>>>> On 11/09/2018 04:51 PM, Qian Cai wrote:
>>>>>> On Nov 9, 2018, at 4:42 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> On 11/9/18 1:36 PM, Qian Cai wrote:
>>>>>>> It is a bit annoying on this aarch64 server with 64 CPUs that is
>>>>>>> booting the latest mainline (3541833fd1f2) causes object debugging
>>>>>>> always running out of memory.
>>>>>> May you please paste the detail failure log?
>>>>> I assume you mean dmesg.
>>>>> 
>>>>> Here is the dmesg for 64 CPUs,
>>>>> https://paste.ubuntu.com/p/BnhvXXhn7k/
>>>>>>> I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
>>>>>>> to make it work. Is it expected that object debugging is not going
>>>>>>> to work with large machines?
>>>>>> I don't think so. I'm supposed it works well with large CPU number on x86.
>>>>> Here is the one with nr_cpus workaround,
>>>>> https://paste.ubuntu.com/p/qMpd2CCPSV/
>>>> The debugobjects code have a set of 1024 statically allocated debug
>>>> objects that can be used in early boot before the slab memory allocator
>>>> is initialized. Apparently, the system may have used up all the
>>>> statically allocated objects. Try double ODEBUG_POOL_SIZE to see if it
>>>> helps.
>>> Great, you are right. Doubling the size makes it work. Does it make sense
>>> to have a kconfig option instead?
>> 
>> First, I think you need to figure out what your system needed to use up
>> so many debug objects in early boot. If there is a legitimate reason for
>> this behavior, we can talk about having a kconfig option to increase that.
> Anybody else not getting ODEBUG OOM with more than 64-CPU? As
> mentioned, restricting to 16-CPU works fine. How can I figure out why the
> system uses so much debug objects?
On another aarch64 server with 256-CPU, even double the size of
ODEBUG_POOL_SIZE, i.e., 2048 will get "ODEBUG: Out of memory. ODEBUG
disabled”.
