Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224HH+25CKMNGSet2m80Gikv/5CnXZMjOA1JSXImQBnqmIE3/g7GCiIR7wcBxl6gQlS2WEuo
ARC-Seal: i=1; a=rsa-sha256; t=1518162845; cv=none;
        d=google.com; s=arc-20160816;
        b=j49dHp3ELbTWuZjFiSPgHZX9ruvHUTJ+RV5NLq9VT9dhGSsjiMloK9nKlBU/GsbP+x
         3qY8d0DFgFwaIdvJMI866ULxwzMwuWks+Muz/Wr86qDJb6w8OyhUGs3msBmPmuO7fOLy
         TUkGs5A80tLMCnPK9/+T8ZEH1T06K3ENP1v2Y0spu6Qlbi1K7LNC1w045iJtoQsaO/Rp
         26i8dUhDJkUUwqoIVLQA0b+6r89mIHxSyDgE5amtc8dOV81F63dMPbqricW+FJ0yjEBI
         C/YaZT4Q8iE7XmOTcXtVNOSi0Vw1/LoorClsy0YX6KbbXNOzTC24CKf/68bdndBv/2yw
         QLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language
         :content-transfer-encoding:mime-version:user-agent:date:message-id
         :cc:to:organization:subject:from:arc-authentication-results;
        bh=4cbtOhbOyjom2sAlR1gInm60BuBrvpeNHz8RVzQ7WXA=;
        b=fieBeS4TCDDXVtKIguDAh7oGDWvgLSj5bjiNyeMYrnQU9D/RTdC2AI8CYKwS7b+Z6T
         5tMGJfXm8qJavTsSQqJFYb5rRTZWXxF2toyFevGk8tLiWDqsefFwjJpxRPshCwBzRpd4
         sSfSwFzbhdSwgiYl4UlTNjGZjUowYTB27uiOq1xBVMaroGOV8uPwagM1gJBIsz7f0Ygq
         aQEYe8AVNzZIdNqtM5QAk9m44S6BhKikriOzRa7O9gxXBBsvZOe0ZcS7/W0vMW/ujSdY
         zxjuQIaHEgC2e+4w1hGJnpMTHY5KiZUIqfvOcHOeSS6e0qrWt2zJPlqiL15rD3ui7mQw
         KvXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbeBIHyE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 9 Feb 2018 02:54:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60218 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750778AbeBIHyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Feb 2018 02:54:04 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36952545"
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [kselftests] compaction_test is blocked
Organization: fnst-ulinux
To: <linux-kselftest@vger.kernel.org>
CC: "Li, Philip" <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        "Li Zhijian(intel)" <zhijianx.li@intel.com>
Message-ID: <700acd92-2b0b-d2da-615e-1f228708d216@cn.fujitsu.com>
Date: Fri, 9 Feb 2018 15:53:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: F364348AE761.AB2B7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591909123815142975?=
X-GMAIL-MSGID: =?utf-8?q?1591909123815142975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

kselftests is integrated Intel 0Day project.
Sometimes we found compaction_test is blocked for more than 1 hours until i kill it.

Try to figure out where it is running, i added some log to this case.

the test log is like:
-------------------
  [  111.750543] main: 248
  [  111.750544]-
  [ 111.750821] check_compaction: 98
  [  111.750822]-
  [  111.751102] check_compaction: 105
  [  111.751103]-
  [  111.751362] check_compaction: 111
  [  111.751363]-
  [  111.751621] check_compaction: 118
  [  111.751622]-
  [  111.751879] check_compaction: 123
  [  111.751880]-
-------------------
118         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
119         lseek(fd, 0, SEEK_SET);
120
121         /* Request a large number of huge pages. The Kernel will allocate
122            as much as it can */
123         fprintf(stderr, "%s: %d\n", __func__, __LINE__);         <<<======== the last line we can catch.
124         if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {        <<<<============ blocking position
125                 perror("Failed to write 100000 to /proc/sys/vm/nr_hugepages\n");
126                 goto close_fd;
127         }
128
129         lseek(fd, 0, SEEK_SET);
130
131         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
132         if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
133                 perror("Failed to re-read from /proc/sys/vm/nr_hugepages\n");
134                 goto close_fd;
135         }
-------------------

According to above log and code, it most likely it is blocking at the writing operation.

my environment is like:
OS: debian
kernel: v4.15
model: Ivytown Ivy Bridge-EP
nr_cpu: 48
memory: 64G


NOTE: 0Day can reproduce this issue in 20% on 0Day.

Anybody can help have a look?

Thanks
Zhjian



