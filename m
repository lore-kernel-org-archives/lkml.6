Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225pxuqd+U8cx36X+SLRTZloSdVYjn7f+7/LLy+jYk4NNR7/DOvOdbMpVULoIIqwNr3++jlz
ARC-Seal: i=1; a=rsa-sha256; t=1518327890; cv=none;
        d=google.com; s=arc-20160816;
        b=yPxs7KtlUWx6vjDBMO7tdsoSCCIGKLt7QpPItkmLyPUlwbvISw5ZJezmuMPZjvSpGF
         mmzSzNF0OcjFPqPmnP/R6Q3JUdU5Cw16+ScoAS9MUbT8u1Uy3Jem/YAlKbvns1a/Oyp1
         01fiXAfGuCLn3RqKTQqSk20PkhvVZ3qmZgZFMQUHGvC/fqpwrcUZfn8QLFlUw524DGJM
         Q++A2WOAEpy34QXLRRvyIsrFhAjQ2LC4i+mSFMKAiwrYYrU24E/H7CzhasRvg8/T7ZNL
         zZ6gef5tiq7fZ0dHQaI3E00Z3dojIl6CRRI8ClHufDfm+YhCBQ+6UYHc+6w/qkkkflvi
         RBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:organization:from:references:cc:to:subject
         :arc-authentication-results;
        bh=C2B9Xj8CgWuW+kveiqEJbEGfm0V0U7g7nNGZWeUfRE0=;
        b=n8P6oI/mAeSFcnPRWkXCsb21mnVuT+h78ZhqHorloSY9zq6PNgf86gWxNwHw0o6iVe
         l+fo/ke8rWa/dve2QVbp5NqiSJ2FYJ+L6cIJXf/08/BFcvVVfEhi33ttVerg5aV5PoRc
         JAxFsW4GP7bPLknrrjXfj8uWEsykTzPRDg1NPW/ZC3OJo0e9FZypaSkLMgcUD4D8Kdd6
         m0PhkSl5sV248UqgfazOeZvPaN0B5nfqD9FwI5x6UkvEe7K6mXPs7PUsbw9cj8uc4iA1
         AaQg729J4Q4nGryWwX17iBo67fKeo6CDq2Jh2xWX/ux/OPv1wAUpocSrhVln1yKRgVsU
         aSMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbeBKFot (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 00:44:49 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41056 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750739AbeBKFos (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 00:44:48 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36981209"
Subject: Re: [kselftests] compaction_test is blocked
To: Dan Rue <dan.rue@linaro.org>
CC: <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        "Li Zhijian(intel)" <zhijianx.li@intel.com>
References: <700acd92-2b0b-d2da-615e-1f228708d216@cn.fujitsu.com>
 <20180209211119.xbch2eok6holyvel@xps>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <7c95e7cc-1955-ba99-9aa5-4bf5d994bd58@cn.fujitsu.com>
Date: Sun, 11 Feb 2018 13:44:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209211119.xbch2eok6holyvel@xps>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: DD39948AE761.AD3F4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591909123815142975?=
X-GMAIL-MSGID: =?utf-8?q?1592082186504112837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/10/2018 05:11 AM, Dan Rue wrote:
> On Fri, Feb 09, 2018 at 03:53:59PM +0800, Li Zhijian wrote:
>> Hi
>>
>> kselftests is integrated Intel 0Day project.
>> Sometimes we found compaction_test is blocked for more than 1 hours until i kill it.
>>
>> Try to figure out where it is running, i added some log to this case.
>>
>> the test log is like:
>> -------------------
>>   [  111.750543] main: 248
>>   [  111.750544]-
>>   [ 111.750821] check_compaction: 98
>>   [  111.750822]-
>>   [  111.751102] check_compaction: 105
>>   [  111.751103]-
>>   [  111.751362] check_compaction: 111
>>   [  111.751363]-
>>   [  111.751621] check_compaction: 118
>>   [  111.751622]-
>>   [  111.751879] check_compaction: 123
>>   [  111.751880]-
>> -------------------
>> 118         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
>> 119         lseek(fd, 0, SEEK_SET);
>> 120
>> 121         /* Request a large number of huge pages. The Kernel will allocate
>> 122            as much as it can */
>> 123         fprintf(stderr, "%s: %d\n", __func__, __LINE__);         <<<======== the last line we can catch.
>> 124         if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {        <<<<============ blocking position
>> 125                 perror("Failed to write 100000 to /proc/sys/vm/nr_hugepages\n");
>> 126                 goto close_fd;
>> 127         }
>> 128
>> 129         lseek(fd, 0, SEEK_SET);
>> 130
>> 131         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
>> 132         if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
>> 133                 perror("Failed to re-read from /proc/sys/vm/nr_hugepages\n");
>> 134                 goto close_fd;
>> 135         }
>> -------------------
>>
>> According to above log and code, it most likely it is blocking at the writing operation.
>>
>> my environment is like:
>> OS: debian
>> kernel: v4.15
>> model: Ivytown Ivy Bridge-EP
>> nr_cpu: 48
>> memory: 64G
> Hi Zhijian,
>
> Please try this patch in mainline:
>
>      4c1baad22390 kselftest: fix OOM in memory compaction test

Hi Dan

Thanks for your replies.

I run this case on v4.15, looks this patch is already merged to v4.15.
lizhijian@inn:~/linux$ git describe 4c1baad
v4.15-rc2-2-g4c1baad223906

Thanks

> Dan
>
>>
>> NOTE: 0Day can reproduce this issue in 20% on 0Day.
>>
>> Anybody can help have a look?
>>
>> Thanks
>> Zhjian
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kselftest" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>

-- 
Best regards.
Li Zhijian (8528)



