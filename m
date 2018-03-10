Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641444-2-17708554943374910340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641443; b=lLixkE+xh+VPT9a1jmCA883yGgBU5i1hfOgHP30V0Cnql/r
    z7Zosr4tR6EGd/QdqlkOjvwnl9EZFHhoJlUHv14MEBat0unwNtgTNodE5qjbsiFt
    pI/S0EzHiqRriwerWVjppvtJr5gxuXWT7hMw+NwiUT/1WIH6Mqwxt79q5lwphn5v
    ImiMXAXh5itX+B0U46SomsE2bQFse9wtsG1gT9Syrthm72UOAZOPrXZK/H4MQ4Ya
    7fW5rZHOZpt9+sG9ibw0Vbj7TtjCKAUOTxiMyoL4CnP0Nuxj/aRsYZk2hrz335Z5
    zDSc6XolUZsVJDQ/9/+XyaO2kSRnZKPeJme/7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520641443; bh=CjcwtUnZVw6XVlGkCwMiouew8B
    i9Hc/ZtgfzwTQUOJc=; b=IjvfnR+pmbuxy0E5kz3MTZlJkxBzWBFSmkJDBPj1Op
    mINZ36RyW76Qjk9qRgZHtdDf6bb+qJjhDj0fXwErg1k309oj/Fk9ZwtkJHb6EsMF
    FiUyvO5MjQz/GEojM96ajmEhXR32QxsbbOXRI8pfu6R4NyVcFzXRukGCFls3og16
    VK5yO3Hq6zssxGixR33JN8vXk8f4YBYRIJZbr693ALvWaXC6H7pwmxwbapVlG+n5
    DtE8fRNG4iPQ5shhVDZ03v0J85Cnk1eX1YszHJaA4SYMMcqwSJM5oNSiiNiKCocU
    BF5fDOwPbyHNyFOTE+WiCBnOVb0PxXXEZXg4FffkFrzg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933762AbeCJAX7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934213AbeCJAX6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 00/11] 4.15.9-stable review
Date: Fri,  9 Mar 2018 16:19:14 -0800
Message-Id: <20180310001834.560857664@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.9-rc1
X-KernelTest-Deadline: 2018-03-12T00:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.9 release.
There are 11 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Mar 12 00:18:21 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.9-rc1

Radim Krčmář <rkrcmar@redhat.com>
    KVM: x86: fix backward migration with async_PF

Sreekanth Reddy <sreekanth.reddy@broadcom.com>
    scsi: mpt3sas: wait for and flush running commands on shutdown/unload

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    scsi: mpt3sas: fix oops in error handlers after shutdown/unload

Daniel Borkmann <daniel@iogearbox.net>
    bpf, ppc64: fix out of bounds access in tail call

Daniel Borkmann <daniel@iogearbox.net>
    bpf: allow xadd only on aligned memory

Eric Dumazet <edumazet@google.com>
    bpf: add schedule points in percpu arrays management

Daniel Borkmann <daniel@iogearbox.net>
    bpf, arm64: fix out of bounds access in tail call

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: implement retpoline for tail call

Yonghong Song <yhs@fb.com>
    bpf: fix rcu lockdep warning for lpm_trie map_free callback

Yonghong Song <yhs@fb.com>
    bpf: fix memory leak in lpm_trie map_free callback function

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix mlock precharge on arraymaps


-------------

Diffstat:

 Documentation/virtual/kvm/cpuid.txt         |  4 ++
 Documentation/virtual/kvm/msr.txt           |  3 +-
 Makefile                                    |  4 +-
 arch/arm64/net/bpf_jit_comp.c               |  5 +-
 arch/powerpc/net/bpf_jit_comp64.c           |  1 +
 arch/x86/include/asm/nospec-branch.h        | 37 +++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h        |  1 +
 arch/x86/kernel/kvm.c                       |  8 +--
 arch/x86/kvm/cpuid.c                        |  3 +-
 arch/x86/net/bpf_jit_comp.c                 |  9 ++--
 drivers/scsi/mpt3sas/mpt3sas_base.c         |  8 +--
 drivers/scsi/mpt3sas/mpt3sas_base.h         |  3 ++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 21 ++++++--
 kernel/bpf/arraymap.c                       | 33 +++++++-----
 kernel/bpf/lpm_trie.c                       | 14 ++---
 kernel/bpf/verifier.c                       | 42 +++++++++------
 tools/testing/selftests/bpf/test_verifier.c | 84 +++++++++++++++++++++++++++++
 17 files changed, 222 insertions(+), 58 deletions(-)
