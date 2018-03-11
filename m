Date: Sun, 11 Mar 2018 17:44:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.121
Message-ID: <20180311164453.GA21716@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.121 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                   |    2 -
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 ++++
 arch/arm/mach-mvebu/Kconfig                |    4 +-
 arch/x86/entry/entry_64.S                  |   16 ++++++---
 arch/x86/include/asm/nospec-branch.h       |   37 ++++++++++++++++++++++
 arch/x86/kernel/apic/vector.c              |   14 ++++----
 arch/x86/kernel/cpu/bugs.c                 |    3 -
 arch/x86/net/bpf_jit_comp.c                |    9 +++--
 drivers/char/tpm/st33zp24/st33zp24.c       |    4 +-
 drivers/char/tpm/tpm_i2c_infineon.c        |    5 +--
 drivers/char/tpm/tpm_i2c_nuvoton.c         |    8 +++-
 drivers/cpufreq/s3c24xx-cpufreq.c          |    8 ++++
 drivers/leds/led-core.c                    |    2 -
 drivers/leds/led-triggers.c                |   12 ++++---
 drivers/md/dm-io.c                         |    1=20
 drivers/media/dvb-frontends/m88ds3103.c    |    7 +++-
 drivers/net/ppp/ppp_generic.c              |    9 +++++
 drivers/net/wan/hdlc_ppp.c                 |    5 ++-
 drivers/s390/net/qeth_core.h               |    5 +++
 drivers/s390/net/qeth_core_main.c          |   33 +++++++++++---------
 fs/btrfs/acl.c                             |   19 +++++++----
 include/linux/nospec.h                     |    3 -
 include/net/udplite.h                      |    1=20
 net/bridge/br_sysfs_if.c                   |    3 +
 net/core/dev.c                             |   11 +++++-
 net/ipv4/fib_semantics.c                   |    5 +++
 net/ipv4/route.c                           |    8 +++-
 net/ipv4/udp.c                             |    5 +++
 net/ipv6/ip6_checksum.c                    |    5 +++
 net/ipv6/sit.c                             |    2 -
 net/mpls/af_mpls.c                         |   36 ++++++++++++----------
 net/netlink/genetlink.c                    |   12 ++++++-
 net/sctp/ipv6.c                            |   10 ++++--
 net/sctp/protocol.c                        |   10 ++----
 net/sctp/sm_make_chunk.c                   |    8 +++-
 sound/pci/hda/hda_intel.c                  |   38 ++++++++++++++++++++++-
 sound/usb/quirks-table.h                   |   47 ++++++++++++++++++++++++=
+++++
 virt/kvm/kvm_main.c                        |    3 -
 38 files changed, 319 insertions(+), 99 deletions(-)

Adam Ford (1):
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Alexey Kodanev (3):
      udplite: fix partial checksum initialization
      sctp: fix dst refcnt leak in sctp_v6_get_dst()
      sctp: verify size of a new chunk in _sctp_make_chunk()

Arnd Bergmann (1):
      ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Ben Hutchings (1):
      Revert "led: core: Fix brightness setting when setting delay_off=3D0"

Dan Carpenter (1):
      x86/spectre: Fix an error message

Dan Williams (1):
      mpls, nospec: Sanitize array index in mpls_label_ok()

Daniel Borkmann (1):
      bpf, x64: implement retpoline for tail call

David Ahern (1):
      net: mpls: Pull common label check into helper

Denis Du (1):
      hdlc_ppp: carrier detect ok, don't turn off negotiation

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones

Ernesto A. Fern=E1ndez (1):
      btrfs: preserve i_mode if __btrfs_set_acl() fails

Greg Kroah-Hartman (1):
      Linux 4.4.121

Guillaume Nault (1):
      ppp: prevent unregistered channels from connecting to PPP units

Hans de Goede (1):
      ALSA: hda: Add a power_save blacklist

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

Jan Kara (1):
      btrfs: Don't clear SGID when inheriting ACLs

Jeremy Boone (3):
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches o=
n the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitche=
s on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches=
 on the bus

Jiri Slaby (1):
      x86/syscall: Sanitize syscall table de-references under speculation f=
ix

Julian Wiedmann (2):
      s390/qeth: fix SETIP command handling
      s390/qeth: fix IPA command submission race

Mauro Carvalho Chehab (1):
      media: m88ds3103: don't call a non-initalized function

Mike Snitzer (1):
      dm io: fix duplicate bio completion due to missing ref count

Nathan Sullivan (1):
      leds: do not overflow sysfs buffer in led_trigger_show

Nicolas Dichtel (1):
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type

Sabrina Dubroca (1):
      net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Stefano Brivio (1):
      fib_semantics: Don't match route with mismatching tclassid

Thomas Gleixner (1):
      x86/apic/vector: Handle legacy irq data correctly

Tommi Rantala (1):
      sctp: fix dst refcnt leak in sctp_v4_get_dst

Ulf Magnusson (1):
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Viresh Kumar (1):
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Wanpeng Li (1):
      KVM: mmu: Fix overlap between public and private memslots

Xin Long (1):
      bridge: check brport attr show in brport_show


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqlXQQACgkQONu9yGCS
aT7DXg//QVBwSbu14slLp6BaZkNrHJiyu+glFIGQZT0ekgqfJeI0qUGxiK19sMVA
OFxWMDVEuWQ/UM1zG+DvQ4nL0jie3zzRKKsyI0BEG9G4pX/REpxsK78ewSTbPs4a
s2yLveQlEnFmz/alHlZfDwsehpr2wSNvXFik8bY3we17Cpi7RlkpkZCYDG6yRvT5
abBKNVAv6vsBGV5BawDJTlgTqSPsySnsGFyEryQ+QXd2V0fcnkxr3PFJ+1MJrSBP
KUYEnyG1efGU5gsasOPjHi8QAWqa0h4QPH/3Lxy2OTdMVWfUYUYIA5dIz6ffyauD
7D2OO2hTneplzIKHTJpC3JQH4NM+MAYiQ5E5FTJ6VyaTMooEZRCkK3Il/QmvoYRa
qk8q7KvhPeOpbHEn9aQjKoVJ7cP5h6Fs6vscQs9Es1lzodjTAtd8QrdJz9KIzuZT
PdzufHcK3IRTsfbfPLdY1OhEohvzjFWi96OCKuLM0EP+H9q8+RE6e4ROJa+kWInh
8aPJ5hkv2bS1Zbjj9xgQUQGfmVXdJuHfBOCAp8DGBzz9pwjGthAEL6fI4Ah7Igzq
FLQ+5nWHaFktFzaR253jo6WVde0jEOmnpFFp+w7CdQdRiF6mX73SwpldqLYDyEbc
rUv1qEUJFwZ/FudtEam8kZKmmxhAoR3Fst81DVB28arymCb9skg=
=5U7T
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
