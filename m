Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OsIAEeb0GltWUgAAmS7hNA
	; Fri, 08 Jun 2018 21:28:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57B5C607E4; Fri,  8 Jun 2018 21:28:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpiXF+OC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 79211601B4;
	Fri,  8 Jun 2018 21:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79211601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeFHV2d (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:28:33 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52511 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeFHV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:28:31 -0400
Received: by mail-wm0-f43.google.com with SMTP id p126-v6so5540412wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=kiwPWH9HYDS9Iy1jgyWE/r7rufBNcRGJzYy7nnriVog=;
        b=YpiXF+OCiNik3BNSHJIEekAWj93L1NMh1ejA0RIqz3YGHpD5IqtlMfT7y0bBko7MpU
         qrJ+AE6k06lHSgIHWFf2PaNcf9qC/Lk8sQ6hm1EaGGWHdZQsYsZrRPyGAg+XNPvbIXd1
         BUGfTna8CbhyaugeQJQc0CNnK4DSZUEira6Ge5jeKea2O2Mde30SXfHsc4o5ZZ39Mtrg
         lPxN07J5QxF37mOMXaOK5redm+ooMQgIqL4LD+J63Uv1bgFyLJsQ1yEsDDcsXgj6FBAn
         xiqjqg5SStI3zIxtKb6lEYoRdM8rCEIjOh/TFykWBlC/7J4jAYAeR+hzLgMq5J4TKy2N
         o4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=kiwPWH9HYDS9Iy1jgyWE/r7rufBNcRGJzYy7nnriVog=;
        b=cHTQiRUuPcp9rLfKzahAPb6TUqopdejbfExb+wsJgXn9SFmO2vCkZUFdcl+jbA/3/y
         pIligTTFH+CzfkL7f/xJOiMZ9SK+Wzf1EcQl77TV3s4izX498/+9D6sak9cgW8kuDieo
         wy6f6DB0wQum/WqETcstU5hdMXJ7qw6VPFOHZpN5BBA+iBWi3Lil0mlDyCP1omqAJyCN
         GBfXx81opK/irvDh222b7rE1VNnCSctzrqyZE7yumhk5znTaOfcIQuNN140reqwTZyy2
         1iSMj3pvuJFhOI74RxbFFMDLq1Y7rcy3bwa94sKx+bUTHdW8EB5NfEdRxfqGVBuCJ0X9
         k8Uw==
X-Gm-Message-State: APt69E2JwWveqDIjr7EvaCfVijV6wRm+od57yxp7JCIUlZh7uXKJ5n0f
        X44atwgcv9+yhv4jaGy3qYoaEGM7
X-Google-Smtp-Source: ADUXVKKSUcqxJG6gJ1El8AJ3QVgKin3O8juAT+DAP/nhnvXX8uiDqTsJWCYit0YHQsco+3NW/Gy8KA==
X-Received: by 2002:a1c:7507:: with SMTP id o7-v6mr2574337wmc.139.1528493309656;
        Fri, 08 Jun 2018 14:28:29 -0700 (PDT)
Received: from [192.168.1.18] ([5.29.26.210])
        by smtp.gmail.com with ESMTPSA id 82-v6sm948222wmm.39.2018.06.08.14.28.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 14:28:28 -0700 (PDT)
To: linux-kernel@vger.kernel.org
From: raz <raziebe@gmail.com>
Subject: RFC : Hyplets - User Space Interrupts for ARM
Message-ID: <9a47c1c4-f7e7-b64a-4f5b-3492ffd282c9@gmail.com>
Date: Sat, 9 Jun 2018 00:28:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to present ARM hyplets. Hyplets are a novel way to code 
interrupt service routines under ARM.
Hyplets provide high performance, security, running time predictability 
,an RPC mechanism and a possible solution for
the priority inversion problem. Hyplets uses special features of ARM 
hypervisor memory architecture.
We demonstrate Hyplets implementation in the C programming language on 
ARMv8 platform and under the Linux kernel.
We provide performance measurements, use cases and security scenarios.

Hyplets are based on the concept of a delicate separation within a 
running process. Instead of running multiple operating
systems kernels in order to segment and divide the system resources, the 
hyplet divides the Linux process into two execution
modes. One part of the process would execute in an isolated, 
non-interrupted privileged safe execution environment while other
parts of the process would execute in a regular user mode. However, both 
execution modes run in the same Application processors.

Background
ARMv8 has unique approach to privilege level that is crucial to the 
implementation of hyplets. The ARM platform normally has 4 exceptions 
(permission) levels:
EL0 refers to user space code. This is analogues to “ring 3” in x86 
platform.
EL1 refers to operating system code. This is analogues to “ring 0” in 
x86  platform.
EL2 refers to HYP mode. This is analogues to “ring -1” or “real mode” on 
the x86 platform.
EL3 refers to TrustZone as a special security mode that can monitor the 
ARM processor and may run a security real time OS. There is no
direct analogues modes but related concepts in x86 are intel’s ME or SMM.

Each of the exception levels provides its own state of registers and can 
access the registers of the lower levels but not higher levels.
This architecture dictates that the translation tables of the different 
exception levels are distinct.
This means, that EL2 (hypervisor mode) may point to any memory 
translation table while the generic operating system,
running in EL1 uses another translation table. This way, we can map an 
executing process (program) or part of it to the hypervisor,
and we automatically gain access to the program address space, without 
any need to perform context switches or relocations.

The trivial approach of migrating code to kernel space to improve 
performance requires a high level of kernel programming skills.
Alternatively, if we try to access a user space code from the ISR, it 
would probably require a context
switch because there is no guarantee that the current process in the 
processor is the one with hyplet code. We needed to make sure
that the hyplet code is always accessible and this could be achieved 
only by disabling evacuation of the hyplet
code and data from the current translation table. So, we we chose to use 
TTBR0_EL2 ( the translation table register) to constantly hold the 
hyplet code.  In order to map user space tasks we modified the Linux 
ARM-KVM mappings infrastructure to map a user space code in tandem with 
some kernel space data.

Restrictions
It is not possible to access any memory which is not mapped prematurely 
to the hypervisor. Also, it is not possible to perform
any system calls.

Some Figures
All benchmarks were conducted on a RASPBERRY PI 3.

Interrupt lantency
Hardware Interrupt Latency -> user hyplet: 2.5us
hyplet timer: Avg: <1us

A nother variant of the hyplet are hyplets RPCs (or in short HypRPC) are 
Remote Procedure calls that are executed
in hyplet context.

Scope of code change

The hyplet patch does not intervene with the hardcore of the kernel code 
nor require any modification to any hardware. The
modification are in the generic ISR routine, in sys_exit and introduces 
a new system called sys_hyplet. For this reason it easy to apply it as 
it does not change the operating system heuristics.

Evaluate

The Kernel code and the full paper are available at github at: 
https://git.scipio.org/raziebe/pi3-public.git

Installtation instructions:
1. Get a raspberry PI3.
2. Download & Install 
openSUSE-Leap42.2-ARM-E20-raspberrypi3.aarch64-2017.02.02-Build1.165.raw. 
This a 64 bit distro.
    see 
http://ftp.yz.yamagata-u.ac.jp/pub/Linux/openSUSE/ports/aarch64/distribution/leap/42.2/appliances/

3. compile the kernel (aarch64) and install it on the PI.
4. compile the examples in arch/arm64/kvm/hyplet/tests/
     see the compile shell script.
     Start the "simple_hyplet" example. Use it as follows:
     check /proc/interrupts for an irq that generates enough interrupts.
     run: taskset <cpu id> simple_hyplet <irq number>
          wait for 20 seconds. if some_global output a number bigger 
than zero then it worked.
      A typical output on the serial console looks like this:

linux:/opt/hyplet # ./simple_hyplet 2
Waiting [  284.158547] hyplet [3]:  address 7f7e472000 already mapped
for irq [  284.158593] hyplet [3]:  address 400820 already mapped
2 for 20 seconds
some global 75
