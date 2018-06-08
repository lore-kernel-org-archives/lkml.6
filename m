Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U29KBhBzGlsSPwAAmS7hNA
	; Fri, 08 Jun 2018 12:14:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 09DB5607E4; Fri,  8 Jun 2018 12:14:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A99B607A4;
	Fri,  8 Jun 2018 12:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A99B607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeFHMOF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751679AbeFHMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:14:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58CDq0e071208
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 08:14:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfqxwm2gf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 08:14:03 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 8 Jun 2018 13:14:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 13:13:59 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58CDwM731326398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 12:13:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C73AE045;
        Fri,  8 Jun 2018 13:02:54 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9FDBAE053;
        Fri,  8 Jun 2018 13:02:53 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.222])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 13:02:53 +0100 (BST)
Subject: Re: regression: "95cde3c59966 debugfs: inode: debugfs_create_dir uses
 mode permission from parent" terminally annoys libvirt
To: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
References: <1528442176.4678.10.camel@gmx.de>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 8 Jun 2018 14:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1528442176.4678.10.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060812-0016-0000-0000-000001D98AB1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060812-0017-0000-0000-0000322CA6B0
Message-Id: <cba2a66b-e8f7-6bf0-d4c1-8f2ba7d89822@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=986 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 09:16 AM, Mike Galbraith wrote:
> Greetings,
> 
> $subject bisected and verified via revert.  Box is garden variety
> i4790, distro is openSUSE Leap 15.0.
> 
> Error starting domain: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 12 Cannot allocate memory
> 2018-06-08T03:18:00.453006Z qemu-system-x86_64: failed to initialize KVM: Cannot allocate memory
> 
> Traceback (most recent call last):
>   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 89, in cb_wrapper
>     callback(asyncjob, *args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 125, in tmpcb
>     callback(*args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 82, in newfn
>     ret = fn(self, *args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/domain.py", line 1508, in startup
>     self._backend.create()
>   File "/usr/lib64/python3.6/site-packages/libvirt.py", line 1069, in create
>     if ret == -1: raise libvirtError ('virDomainCreate() failed', dom=self)
> libvirt.libvirtError: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 12 Cannot allocate memory
> 2018-06-08T03:18:00.453006Z qemu-system-x86_64: failed to initialize KVM: Cannot allocate memory
> 
> 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775 is the first bad commit
> commit 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775
> Author: Thomas Richter <tmricht@linux.ibm.com>
> Date:   Fri Apr 27 14:35:47 2018 +0200
> 
>     debugfs: inode: debugfs_create_dir uses mode permission from parent
>     
...

Hi,

that patch does not allocate any memory, it just sets permission on newly
created subdirectories in /sys/kernel/debug.
I do not know what ioctl(KVM_CREATE_VM) does, but maybe requires permissions
for group and others in that directory.

Best thing is to revert this patch.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
