Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvUFpJlrxt3QqxJvGSa9ya1vZ4QnquDtdq6rZi7DlOQrobKzgvRzrCpaQ5q83CsFXYiQhyG
ARC-Seal: i=1; a=rsa-sha256; t=1520641228; cv=none;
        d=google.com; s=arc-20160816;
        b=SEpW71fMWo/ti1xo1Izk+p7pnnELS0lfdJdEES+53I7xXFL+IZxifpQ/cSWBa0qE/a
         TVlFarz8Gfz9GxoIXLhkCe2aHruQqZqs+j8fGPmyKyvcTzXbfd25CqVYXmeJoJ9xqrYD
         wk2mzQFEob+t7gueGs0M+efr/Mkm/3f2mWhg/myIOS3dJRP/dFwmmcH4CGWugK5HMEEU
         pRAAujI4rPrjxyzPXhL3Z+22j8OD9efq3OG4yhud3/CplfghqPmL4VYyXQKxqJ1UwNze
         JaV9AkEC2wcAPAU3dmclaodS+BV7WIVRY9nOprnf660pHtSA0ZlMnSRAXOgmStKadHtJ
         Sz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JVryOrPXjOtlWQzBkGA5x+V3aU0IVy6K6sYl4AIX2u4=;
        b=VfK3dRSsYxYKJBC0ytegDC97QyL9twt1aWYx3dAcm4LfJ3iYCS+C3vsmPN7E7bXEQ+
         l8VLiyIsXuliuFYGh3K2HTFaWNxIulIvN3UUl1fdBVR6jQbyNASrhd7bXDuRn+2pOVEX
         ylEdQPkux4suJ9CZBu0uDL1imC4gOJ+N5MnJWY/fz0zHxliyO2W2bLa0kU5Z9cM7rWGr
         aI3H4H3ErsNKVPCsTrgpBgANQrKXHGvGU9OxerHu3CBG1ul35z+wXv4RwpOSqbFQcw2d
         i5USpvzFl6RYYIOJ7JqKaSMJfPqaGvkO32owvRweVs/H0cHa58QRzhmJT4Rek9WtSQID
         KSaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.4 00/36] 4.4.121-stable review
Date: Fri,  9 Mar 2018 16:18:16 -0800
Message-Id: <20180310001807.213987241@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.121-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.121-rc1
X-KernelTest-Deadline: 2018-03-12T00:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507896678991964?=
X-GMAIL-MSGID: =?utf-8?q?1594507896678991964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.121 release.
There are 36 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Mar 12 00:17:54 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.121-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.121-rc1

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    btrfs: preserve i_mode if __btrfs_set_acl() fails

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: implement retpoline for tail call

Mike Snitzer <snitzer@redhat.com>
    dm io: fix duplicate bio completion due to missing ref count

Dan Williams <dan.j.williams@intel.com>
    mpls, nospec: Sanitize array index in mpls_label_ok()

David Ahern <dsahern@gmail.com>
    net: mpls: Pull common label check into helper

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: verify size of a new chunk in _sctp_make_chunk()

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IPA command submission race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix SETIP command handling

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: fix dst refcnt leak in sctp_v6_get_dst()

Tommi Rantala <tommi.t.rantala@nokia.com>
    sctp: fix dst refcnt leak in sctp_v4_get_dst

Alexey Kodanev <alexey.kodanev@oracle.com>
    udplite: fix partial checksum initialization

Guillaume Nault <g.nault@alphalink.fr>
    ppp: prevent unregistered channels from connecting to PPP units

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: fix race on decreasing number of TX queues

Arnd Bergmann <arnd@arndb.de>
    ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Denis Du <dudenis2000@yahoo.ca>
    hdlc_ppp: carrier detect ok, don't turn off negotiation

Stefano Brivio <sbrivio@redhat.com>
    fib_semantics: Don't match route with mismatching tclassid

Xin Long <lucien.xin@gmail.com>
    bridge: check brport attr show in brport_show

Ben Hutchings <ben.hutchings@codethink.co.uk>
    Revert "led: core: Fix brightness setting when setting delay_off=0"

Dan Carpenter <dan.carpenter@oracle.com>
    x86/spectre: Fix an error message

Nathan Sullivan <nathan.sullivan@ni.com>
    leds: do not overflow sysfs buffer in led_trigger_show

Thomas Gleixner <tglx@linutronix.de>
    x86/apic/vector: Handle legacy irq data correctly

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Jan Kara <jack@suse.cz>
    btrfs: Don't clear SGID when inheriting ACLs

Jiri Slaby <jslaby@suse.cz>
    x86/syscall: Sanitize syscall table de-references under speculation fix

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: mmu: Fix overlap between public and private memslots

Ulf Magnusson <ulfalizer@gmail.com>
    ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    nospec: Allow index argument to have const-qualified type

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: m88ds3103: don't call a non-initalized function

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Add a power_save blacklist

Erik Veijola <erik.veijola@gmail.com>
    ALSA: usb-audio: Add a quirck for B&W PX headphones

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus


-------------

Diffstat:

 Makefile                                   |  4 +--
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |  8 +++++
 arch/arm/mach-mvebu/Kconfig                |  4 +--
 arch/x86/entry/entry_64.S                  | 16 ++++++----
 arch/x86/include/asm/nospec-branch.h       | 37 +++++++++++++++++++++++
 arch/x86/kernel/apic/vector.c              | 14 ++++-----
 arch/x86/kernel/cpu/bugs.c                 |  3 +-
 arch/x86/net/bpf_jit_comp.c                |  9 +++---
 drivers/char/tpm/st33zp24/st33zp24.c       |  4 +--
 drivers/char/tpm/tpm_i2c_infineon.c        |  5 ++--
 drivers/char/tpm/tpm_i2c_nuvoton.c         |  8 +++--
 drivers/cpufreq/s3c24xx-cpufreq.c          |  8 ++++-
 drivers/leds/led-core.c                    |  2 +-
 drivers/leds/led-triggers.c                | 12 ++++----
 drivers/md/dm-io.c                         |  1 +
 drivers/media/dvb-frontends/m88ds3103.c    |  7 +++--
 drivers/net/ppp/ppp_generic.c              |  9 ++++++
 drivers/net/wan/hdlc_ppp.c                 |  5 +++-
 drivers/s390/net/qeth_core.h               |  5 ++++
 drivers/s390/net/qeth_core_main.c          | 33 +++++++++++----------
 fs/btrfs/acl.c                             | 19 +++++++-----
 include/linux/nospec.h                     |  3 +-
 include/net/udplite.h                      |  1 +
 net/bridge/br_sysfs_if.c                   |  3 ++
 net/core/dev.c                             | 11 +++++--
 net/ipv4/fib_semantics.c                   |  5 ++++
 net/ipv4/route.c                           |  8 +++--
 net/ipv4/udp.c                             |  5 ++++
 net/ipv6/ip6_checksum.c                    |  5 ++++
 net/ipv6/sit.c                             |  2 +-
 net/mpls/af_mpls.c                         | 36 +++++++++++++----------
 net/netlink/genetlink.c                    | 12 ++++++--
 net/sctp/ipv6.c                            | 10 +++++--
 net/sctp/protocol.c                        | 10 +++----
 net/sctp/sm_make_chunk.c                   |  8 +++--
 sound/pci/hda/hda_intel.c                  | 38 ++++++++++++++++++++++--
 sound/usb/quirks-table.h                   | 47 ++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c                        |  3 +-
 38 files changed, 320 insertions(+), 100 deletions(-)
