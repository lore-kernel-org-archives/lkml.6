Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2252NTchNAYRyz2dYvs6+aa7dcrO0XdutRlSIzj90MCXf9CDxhq1GcuofK/GNr8a5NFCpPOa
ARC-Seal: i=1; a=rsa-sha256; t=1518406002; cv=none;
        d=google.com; s=arc-20160816;
        b=IsXo+kBEFa+r2WDPM0HS9wWSxWF9RLCGdV3hVQtrr29oTONAoouJ0NEhcJvHVc6BWN
         cReeVyTYe+B24L0DxsCGnCC5LB35MaEEaj+COL/QhKdnIR6EHip7y5c6VrHcUSrRk+ca
         JFX7naMhMq5ymCIMOqAtuJz8F5/ys1NJLS+MCu6CXqT/GDiXrerVSLXfPhw43yKdiZZa
         w+hWwWJebHEWrKZ9ZqpWsa01Xv1bSNzxttgCj4gdaD8co8vJqFJ9Ijg8YWALjWkoJ+X1
         JcHrykVEz1h18mwL7lKHf5h9cRL8/xj/HDklFeqmNrL8w9UjRS47De0hKbEGbToRWkbW
         Tytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=82LghxXPCEecEEK3i3jaUCxrNaRT8MlwVnnY+9ngXYc=;
        b=0IqheMM5GLhCCRPBdb59ezUw9Y4p4Z4+w39/N1oRIq+S6CYZ4XwZKGeBQzk072lxs3
         /mwNkLNmQA5+oe9mXRLBdEW6z1FJdKsij5miwT4llJQx0fqhR+aMwrLpNrqPgtA7Dewu
         ++EsPkChADoXC+pmFeVFMYGiff+VZrAEhlgp7Nv9N73z3kYWsVnKYFfx66RsGYrJeeQY
         YuJXgU8w5sQcZlyJHQR9yGSsbQFo37QNgpqdjq3UOR4lve5yfdhu9WkElx1dzYagZ/Gv
         mT/pBU9dGydoL6MjJl/hslu05nQ0EEY8guS79B9tNfonzBpBnhI/RJivFcGeVYZOlYzm
         JC3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeBLD0m (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 22:26:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:60807 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932512AbeBLD0l (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 22:26:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,499,1511856000";
   d="scan'208";a="26567405"
Subject: Re: [kselftests] compaction_test is blocked
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Dan Rue <dan.rue@linaro.org>
Cc: linux-kselftest@vger.kernel.org,
        "Li, Philip" <philip.li@intel.com>, linux-kernel@vger.kernel.org
References: <700acd92-2b0b-d2da-615e-1f228708d216@cn.fujitsu.com>
 <20180209211119.xbch2eok6holyvel@xps>
 <7c95e7cc-1955-ba99-9aa5-4bf5d994bd58@cn.fujitsu.com>
From: Li Zhijian <zhijianx.li@intel.com>
Message-ID: <30e882ea-1e79-44bf-9a85-c0be105ec218@intel.com>
Date: Mon, 12 Feb 2018 11:26:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <7c95e7cc-1955-ba99-9aa5-4bf5d994bd58@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591909123815142975?=
X-GMAIL-MSGID: =?utf-8?q?1592164092900293787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018年02月11日 13:44, Li Zhijian wrote:
>
>
> On 02/10/2018 05:11 AM, Dan Rue wrote:
>> On Fri, Feb 09, 2018 at 03:53:59PM +0800, Li Zhijian wrote:
>>> Hi
>>>
>>> kselftests is integrated Intel 0Day project.
>>> Sometimes we found compaction_test is blocked for more than 1 hours 
>>> until i kill it.
>>>
>>> Try to figure out where it is running, i added some log to this case.
>>>
>>> the test log is like:
>>> -------------------
>>>   [  111.750543] main: 248
>>>   [  111.750544]-
>>>   [ 111.750821] check_compaction: 98
>>>   [  111.750822]-
>>>   [  111.751102] check_compaction: 105
>>>   [  111.751103]-
>>>   [  111.751362] check_compaction: 111
>>>   [  111.751363]-
>>>   [  111.751621] check_compaction: 118
>>>   [  111.751622]-
>>>   [  111.751879] check_compaction: 123
>>>   [  111.751880]-
>>> -------------------
>>> 118         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
>>> 119         lseek(fd, 0, SEEK_SET);
>>> 120
>>> 121         /* Request a large number of huge pages. The Kernel will 
>>> allocate
>>> 122            as much as it can */
>>> 123         fprintf(stderr, "%s: %d\n", __func__, __LINE__);         
>>> <<<======== the last line we can catch.
>>> 124         if (write(fd, "100000", (6*sizeof(char))) != 
>>> (6*sizeof(char))) {        <<<<============ blocking position
>>> 125                 perror("Failed to write 100000 to 
>>> /proc/sys/vm/nr_hugepages\n");
>>> 126                 goto close_fd;
>>> 127         }
>>> 128
>>> 129         lseek(fd, 0, SEEK_SET);
>>> 130
>>> 131         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
>>> 132         if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
>>> 133                 perror("Failed to re-read from 
>>> /proc/sys/vm/nr_hugepages\n");
>>> 134                 goto close_fd;
>>> 135         }
>>> -------------------
>>>
>>> According to above log and code, it most likely it is blocking at 
>>> the writing operation.
>>>
>>> my environment is like:
>>> OS: debian
>>> kernel: v4.15
>>> model: Ivytown Ivy Bridge-EP
>>> nr_cpu: 48
>>> memory: 64G
>> Hi Zhijian,
>>
>> Please try this patch in mainline:
>>
>>      4c1baad22390 kselftest: fix OOM in memory compaction test
>
> Hi Dan
>
> Thanks for your replies.
>
> I run this case on v4.15, looks this patch is already merged to v4.15.
> lizhijian@inn:~/linux$ git describe 4c1baad
> v4.15-rc2-2-g4c1baad223906

My mistake, this path is not contained by v4.15 yet.
i will have a try.

Thanks



>
> Thanks
>
>> Dan
>>
>>>
>>> NOTE: 0Day can reproduce this issue in 20% on 0Day.
>>>
>>> Anybody can help have a look?
>>>
>>> Thanks
>>> Zhjian
>>>
>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-kselftest" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> .
>>
>

