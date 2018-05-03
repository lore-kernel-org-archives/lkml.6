Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZodUmGzpg6v8hcnfoOylbfOCSXuK4fnjFIBUozOKMicKis/vgzSkc5g5bVOObg9D6KLlKdF
ARC-Seal: i=1; a=rsa-sha256; t=1525314774; cv=none;
        d=google.com; s=arc-20160816;
        b=IDPtbl3KVFu2ViaND5DrtdzUVdUSnvcfXRpqZyGIxZjTcr6ghg2uL8SjwWhBIblTJz
         H7qw3b41HBqoMchXgnjCWfnmKsBgTvVXo49VD0VwpDT4VX1g5Ddsm1hTh75reBL5fCbd
         98BfsOQGzvyVVJIvjeMB2ajOeBdunBQQ5JHQPCGQZ/66makOowBFob/71MIYmNj+YfVG
         dWEYP+SiN5kqyaWzbh6iJBSZrcAO9J7rdzbheXNXagX8KObaX09i+0eo2bKnYOspOiX5
         9nFznRZfRZDDP6jkFxy1NWBfbNtqQ8f20HAxbmQtRKZgi/KQctncxyhZN6FjSR5H2Z96
         7S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JJGz/WanSHlZVqqIj7QGuJmYyqN6qbYB3GF5CEzctvI=;
        b=sggZ3rnIEhXDBm8ffP83X/Wrvj55SgWBO3NQTptUpTzWXYjJGaJj5JTtYIDryIxWbk
         vpEFEEJIRQHuXCW3t8vx4rXugMt5TZqXp2SerJiydr1BSsUA1S74QMoKcytekhLsMMz5
         GJ4sjvsSjUh30sNVNgQ5W9ghUgQG9oa536Azwd4wBQq0SOQ/y5IwTqZaqPOFh3e+Bz2S
         ayNhCrtJAUP9Z8BijIypFhuXDtPWLZPzCQHPEhxB3BjOjkPXLMUR1CinDCz19/e8Alfm
         m5aCEM/SDbX76IGQ63ofJLlvGMKbgWl8BLrSrgupJw3go4gKUX/tJkQWQz2w8RsqRHnr
         GPfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 0/3] x86/CPU: Report correct cpu/cache topo for Centaur CPUs and some minor changes 
Date: Thu, 3 May 2018 10:32:43 +0800
Message-ID: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599408464675182512?=
X-GMAIL-MSGID: =?utf-8?q?1599408464675182512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are three patches:

The first patch define detect_num_cpu_cores() in common.c to replace the
original intel_num_cpu_cores() which is defined in intel.c; 

The second patch is used to include the legacy cpu_detect_cache_sizes()
into the init_intel_cacheinfo() function;

The third patch is used to report correct CPU/Cache topology by using the
functions defined in the first and the second patch;

David Wang (3):
  x86/CPU: Replace intel_num_cpu_cores with detect_num_cpu_cores
  x86/cpu/intel_cacheinfo: include cpu_detect_cache_size in
    init_intel_cacheinfo
  x86/Centaur: Report correct CPU/cache topology

 arch/x86/include/asm/processor.h      |  1 +
 arch/x86/kernel/cpu/centaur.c         |  5 +++++
 arch/x86/kernel/cpu/common.c          | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c           | 28 ++--------------------------
 arch/x86/kernel/cpu/intel_cacheinfo.c |  6 ++++++
 5 files changed, 28 insertions(+), 26 deletions(-)

-- 
1.9.1
