Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeCKKe3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:34:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45102 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbeCKKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:34:26 -0400
Date: Sun, 11 Mar 2018 11:34:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Worsley <amworsley@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
Message-ID: <20180311103423.GA18467@amd>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com>
 <20180303092417.GA30917@amd>
 <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
 <20180303204512.GA9259@amd>
 <CA+Y=x3k5tsf+oxTo9YQv195XQpEECfqtFcbCoYGkJVCQsbjWpA@mail.gmail.com>
 <20180310131605.GA28296@amd>
 <CA+Y=x3mwNDNJTt=n-K__wbCb8P+VhgMafRiofc0tnXqdgRk43w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <CA+Y=x3mwNDNJTt=n-K__wbCb8P+VhgMafRiofc0tnXqdgRk43w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This is 4.15 kernel with KPTI disabled:
> >> % grep PAGE_TABLE .config
> >> # CONFIG_PAGE_TABLE_ISOLATION is not set
> >>
> >> As I expected it appears no more infomative to me.
> >>
> >> What I really need is some clue as to what is supposed to be happening
> >> at this point.
> >
> > You may want to add some printks to see where it hangs.
> >
> > But maybe before that, you may want to test CPU hotplug, and make sure
> > s2ram works, etc...
> >
> > Perhaps basic-pm-debugging.txt is good place to start?
> >
> > Best regards,
> >                                                                        =
 Pavel
> > --
>=20
> Ok - all the test modes work but a full s2ram hangs (never comes back)
> and obviously the resume full save to disk fails.
>=20
> I attach the following files:
>=20
> echo reboot > /sys/power/disk
> echo disk > /sys/power/state
> Then saved dmesg to file  dmesg-reboot-disk-ok.txt

So with "reboot" mode, hibernation works as expected, you just have to
power down machine manually?

> I tried to add some debug to hibernation_restore() but saw nothing.
>  Not sure if I doing this correctly but I believe the last know dmesg
> entry is from swsusp_read() in kernel/power/swap.c
> but then I should see something in hibernation_restore() but as the
> console might not work or something I can't be sure....
>=20
> Further directions appreciated

You may want to try without thunderbolt support / talk to thunderbolt
people:

pciehp seems to have bad problems, too.

I'd suggest debugging with s2ram (as it is less tricky) and removing
all modules you don't really need.

Good luck,
								Pavel

> [  340.781428] calling  0000:04:00.0+ @ 2273, parent: 0000:00:1c.1
> [  340.781430] calling  0000:03:00.1+ @ 2292, parent: 0000:00:1c.0
> [  340.781431] calling  0000:03:00.0+ @ 2217, parent: 0000:00:1c.0
> [  340.781435] calling  0000:07:00.0+ @ 2207, parent: 0000:06:00.0
> [  340.781439] calling  0000:06:06.0+ @ 2197, parent: 0000:05:00.0
> [  340.781441] thunderbolt 0000:07:00.0: suspending...
> [  340.781446] ------------[ cut here ]------------
> [  340.781448] tb_cfg_write: -108
> [  340.781454] calling  PNP0C09:00+ @ 2337, parent: device:2c
> [  340.781456] call PNP0C09:00+ returned 0 after 0 usecs
> [  340.781486] WARNING: CPU: 3 PID: 2207 at drivers/thunderbolt/ctl.c:981=
 tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  340.781487] calling  0000:06:05.0+ @ 2202, parent: 0000:05:00.0
> [  340.781488] calling  0000:06:04.0+ @ 2291, parent: 0000:05:00.0
> [  340.781494] Modules linked in: ebtable_filter ebtables ip6table_filter=
 ip6_tables hidp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_=
ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_con=
ntrack bridge stp llc ppdev parport_pc parport dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_bufio fuse vmw_vsock_vmci_transport vsock dm_mod vmw_v=
mci iptable_filter cmac bnep intel_rapl x86_pkg_temp_thermal intel_powercla=
mp snd_hda_codec_hdmi binfmt_misc nls_ascii nls_cp437 coretemp arc4 b43 kvm=
_intel vfat fat kvm irqbypass crct10dif_pclmul crc32_pclmul mac80211 ghash_=
clmulni_intel pcbc ssb mmc_core aesni_intel rng_core aes_x86_64 crypto_simd=
 pcmcia iTCO_wdt glue_helper iTCO_vendor_support cryptd r8188eu(C) pcmcia_c=
ore uvcvideo btusb btrtl btbcm btintel videobuf2_vmalloc snd_hda_codec_cirr=
us
> [  340.781541]  snd_hda_codec_generic bluetooth videobuf2_memops intel_cs=
tate videobuf2_v4l2 drbg videobuf2_core applesmc ansi_cprng snd_hda_intel v=
ideodev cfg80211 ecdh_generic input_polldev intel_uncore joydev rfkill medi=
a intel_rapl_perf snd_hda_codec sbs sg bcma snd_hda_core thunderbolt acpi_a=
ls snd_hwdep sbshc kfifo_buf snd_pcm industrialio apple_gmux mei_me lpc_ich=
 snd_timer shpchp mei snd mfd_core evdev soundcore apple_bl pcspkr ac efi_p=
store nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivars loop efivarfs ip_=
tables x_tables autofs4 hid_apple ext4 crc16 mbcache jbd2 fscrypto btrfs zs=
td_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx xor hid_generic usbhid hid raid6_pq libcr=
c32c crc32c_generic raid1 raid0 multipath linear md_mod bcm5974
> [  340.781593]  ax88179_178a usbnet mii sd_mod nouveau ahci libahci mxm_w=
mi xhci_pci i915 libata wmi crc32c_intel ehci_pci xhci_hcd ttm i2c_algo_bit=
 ehci_hcd scsi_mod i2c_i801 drm_kms_helper usbcore drm video button
> [  340.781610] CPU: 3 PID: 2207 Comm: kworker/u16:95 Tainted: G        WC=
       4.15.0+ #9
> [  340.781612] Hardware name: Apple Inc. MacBookPro10,1/Mac-C3EC7CD222929=
81F, BIOS MBP101.88Z.00EE.B0A.1509111559 09/11/2015
> [  340.781618] Workqueue: events_unbound async_run_entry_fn
> [  340.781623] RIP: 0010:tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  340.781625] RSP: 0018:ffffb8a383a43d00 EFLAGS: 00010286
> [  340.781627] RAX: 0000000000000000 RBX: ffff964cd317da80 RCX: 000000000=
0000006
> [  340.781630] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff964ce=
f2d66b0
> [  340.781633] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000=
0001011
> [  340.781635] R10: ffffffffb726fe40 R11: ffff964cd428dc00 R12: 000000000=
0000004
> [  340.781637] R13: ffff964cdcbdc000 R14: 0000000000000004 R15: ffffffffb=
74767a4
> [  340.781640] FS:  0000000000000000(0000) GS:ffff964cef2c0000(0000) knlG=
S:0000000000000000
> [  340.781642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  340.781644] CR2: 00007f1aae263f80 CR3: 000000035dc09003 CR4: 000000000=
01606e0
> [  340.781647] Call Trace:
> [  340.781655]  tb_plug_events_active+0x8e/0x180 [thunderbolt]
> [  340.781660]  tb_switch_suspend+0x11/0x90 [thunderbolt]
> [  340.781665]  tb_suspend_noirq+0x33/0x60 [thunderbolt]
> [  340.781671]  tb_domain_suspend_noirq+0x30/0x70 [thunderbolt]
> [  340.781674]  pci_pm_suspend_noirq+0x79/0x190
> [  340.781677]  ? pci_pm_resume_noirq+0x90/0x90
> [  340.781680]  dpm_run_callback+0x4d/0x140
> [  340.781683]  __device_suspend_noirq+0x7f/0x160
> [  340.781686]  async_suspend_noirq+0x1a/0x90
> [  340.781688]  async_run_entry_fn+0x33/0x160
> [  340.781692]  process_one_work+0x184/0x380
> [  340.781695]  worker_thread+0x4d/0x3c0
> [  340.781698]  kthread+0xf5/0x130
> [  340.781701]  ? process_one_work+0x380/0x380
> [  340.781703]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  340.781706]  ret_from_fork+0x35/0x40
> [  340.781709] Code: 24 18 e8 45 fc ff ff 8b 44 24 24 48 83 c4 18 85 c0 7=
4 1e 83 f8 01 74 57 83 f8 92 74 2d 89 c6 48 c7 c7 26 db db c0 e8 31 54 8c f=
5 <0f> ff 8b 44 24 0c 48 8b 5c 24 18 65 48 33 1c 25 28 00 00 00 75=20
> [  340.781737] ---[ end trace d61e276b076455e3 ]---
> [  340.781766] thunderbolt 0000:07:00.0: suspend finished
> [  340.781772] thunderbolt 0000:07:00.0: stopping RX ring 0
> [  340.781800] thunderbolt 0000:07:00.0: stopping TX ring 0
=2E..
> [  346.427262] calling  0000:07:00.0+ @ 2217, parent: 0000:06:00.0
> [  346.427266] thunderbolt 0000:07:00.0: Refused to change power state, c=
urrently in D3
> [  346.427275] thunderbolt 0000:07:00.0: control channel starting...
> [  346.427280] thunderbolt 0000:07:00.0: resuming...
> [  346.427284] thunderbolt 0000:07:00.0: resetting switch at 0
> [  346.427291] ------------[ cut here ]------------
> [  346.427292] tb_cfg_write: -108
> [  346.427333] WARNING: CPU: 7 PID: 2217 at drivers/thunderbolt/ctl.c:981=
 tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  346.427337] Modules linked in: ebtable_filter ebtables ip6table_filter=
 ip6_tables hidp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_=
ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_con=
ntrack bridge stp llc ppdev parport_pc parport dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_bufio fuse vmw_vsock_vmci_transport vsock dm_mod vmw_v=
mci iptable_filter cmac bnep intel_rapl x86_pkg_temp_thermal intel_powercla=
mp snd_hda_codec_hdmi binfmt_misc nls_ascii nls_cp437 coretemp arc4 b43 kvm=
_intel vfat fat kvm irqbypass crct10dif_pclmul crc32_pclmul mac80211 ghash_=
clmulni_intel pcbc ssb mmc_core aesni_intel rng_core aes_x86_64 crypto_simd=
 pcmcia iTCO_wdt glue_helper iTCO_vendor_support cryptd r8188eu(C) pcmcia_c=
ore uvcvideo btusb btrtl btbcm btintel videobuf2_vmalloc snd_hda_codec_cirr=
us
> [  346.427388]  snd_hda_codec_generic bluetooth videobuf2_memops intel_cs=
tate videobuf2_v4l2 drbg videobuf2_core applesmc ansi_cprng snd_hda_intel v=
ideodev cfg80211 ecdh_generic input_polldev intel_uncore joydev rfkill medi=
a intel_rapl_perf snd_hda_codec sbs sg bcma snd_hda_core thunderbolt acpi_a=
ls snd_hwdep sbshc kfifo_buf snd_pcm industrialio apple_gmux mei_me lpc_ich=
 snd_timer shpchp mei snd mfd_core evdev soundcore apple_bl pcspkr ac efi_p=
store nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivars loop efivarfs ip_=
tables x_tables autofs4 hid_apple ext4 crc16 mbcache jbd2 fscrypto btrfs zs=
td_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx xor hid_generic usbhid hid raid6_pq libcr=
c32c crc32c_generic raid1 raid0 multipath linear md_mod bcm5974
> [  346.427440]  ax88179_178a usbnet mii sd_mod nouveau ahci libahci mxm_w=
mi xhci_pci i915 libata wmi crc32c_intel ehci_pci xhci_hcd ttm i2c_algo_bit=
 ehci_hcd scsi_mod i2c_i801 drm_kms_helper usbcore drm video button
> [  346.427459] CPU: 7 PID: 2217 Comm: kworker/u16:105 Tainted: G        W=
C       4.15.0+ #9
> [  346.427461] Hardware name: Apple Inc. MacBookPro10,1/Mac-C3EC7CD222929=
81F, BIOS MBP101.88Z.00EE.B0A.1509111559 09/11/2015
> [  346.427467] Workqueue: events_unbound async_run_entry_fn
> [  346.427473] RIP: 0010:tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  346.427475] RSP: 0000:ffffb8a383a93d18 EFLAGS: 00010286
> [  346.427478] RAX: 0000000000000000 RBX: ffff964cd317da80 RCX: 000000000=
0000006
> [  346.427480] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff964ce=
f3d66b0
> [  346.427482] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000=
00010c7
> [  346.427484] R10: ffffffffb726fe40 R11: ffff964cd428dc00 R12: 000000000=
0000002
> [  346.427487] R13: 00000050a5e920bb R14: 0000000000000010 R15: ffffffffb=
74767a4
> [  346.427489] FS:  0000000000000000(0000) GS:ffff964cef3c0000(0000) knlG=
S:0000000000000000
> [  346.427492] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  346.427494] CR2: 0000000000000000 CR3: 000000035dc09001 CR4: 000000000=
01606e0
> [  346.427496] Call Trace:
> [  346.427505]  tb_switch_reset+0xa6/0xf0 [thunderbolt]
> [  346.427510]  tb_resume_noirq+0x3c/0x100 [thunderbolt]
> [  346.427516]  tb_domain_resume_noirq+0x3f/0x60 [thunderbolt]
> [  346.427520]  ? pci_pm_freeze_noirq+0xe0/0xe0
> [  346.427522]  dpm_run_callback+0x4d/0x140
> [  346.427526]  device_resume_noirq+0x84/0x140
> [  346.427528]  async_resume_noirq+0x19/0x40
> [  346.427531]  async_run_entry_fn+0x33/0x160
> [  346.427535]  process_one_work+0x184/0x380
> [  346.427538]  worker_thread+0x4d/0x3c0
> [  346.427541]  kthread+0xf5/0x130
> [  346.427544]  ? process_one_work+0x380/0x380
> [  346.427546]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  346.427551]  ret_from_fork+0x35/0x40
> [  346.427553] Code: 24 18 e8 45 fc ff ff 8b 44 24 24 48 83 c4 18 85 c0 7=
4 1e 83 f8 01 74 57 83 f8 92 74 2d 89 c6 48 c7 c7 26 db db c0 e8 31 54 8c f=
5 <0f> ff 8b 44 24 0c 48 8b 5c 24 18 65 48 33 1c 25 28 00 00 00 75=20
> [  346.427582] ---[ end trace d61e276b076455e4 ]---
> [  346.427586] thunderbolt 0000:07:00.0: 0: resuming switch
> [  346.427589] ------------[ cut here ]------------
> [  346.427591] tb_cfg_write: -108
> [  346.427606] WARNING: CPU: 7 PID: 2217 at drivers/thunderbolt/ctl.c:981=
 tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  346.427608] Modules linked in: ebtable_filter ebtables ip6table_filter=
 ip6_tables hidp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_=
ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_con=
ntrack bridge stp llc ppdev parport_pc parport dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_bufio fuse vmw_vsock_vmci_transport vsock dm_mod vmw_v=
mci iptable_filter cmac bnep intel_rapl x86_pkg_temp_thermal intel_powercla=
mp snd_hda_codec_hdmi binfmt_misc nls_ascii nls_cp437 coretemp arc4 b43 kvm=
_intel vfat fat kvm irqbypass crct10dif_pclmul crc32_pclmul mac80211 ghash_=
clmulni_intel pcbc ssb mmc_core aesni_intel rng_core aes_x86_64 crypto_simd=
 pcmcia iTCO_wdt glue_helper iTCO_vendor_support cryptd r8188eu(C) pcmcia_c=
ore uvcvideo btusb btrtl btbcm btintel videobuf2_vmalloc snd_hda_codec_cirr=
us
> [  346.427645]  snd_hda_codec_generic bluetooth videobuf2_memops intel_cs=
tate videobuf2_v4l2 drbg videobuf2_core applesmc ansi_cprng snd_hda_intel v=
ideodev cfg80211 ecdh_generic input_polldev intel_uncore joydev rfkill medi=
a intel_rapl_perf snd_hda_codec sbs sg bcma snd_hda_core thunderbolt acpi_a=
ls snd_hwdep sbshc kfifo_buf snd_pcm industrialio apple_gmux mei_me lpc_ich=
 snd_timer shpchp mei snd mfd_core evdev soundcore apple_bl pcspkr ac efi_p=
store nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivars loop efivarfs ip_=
tables x_tables autofs4 hid_apple ext4 crc16 mbcache jbd2 fscrypto btrfs zs=
td_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx xor hid_generic usbhid hid raid6_pq libcr=
c32c crc32c_generic raid1 raid0 multipath linear md_mod bcm5974
> [  346.427686]  ax88179_178a usbnet mii sd_mod nouveau ahci libahci mxm_w=
mi xhci_pci i915 libata wmi crc32c_intel ehci_pci xhci_hcd ttm i2c_algo_bit=
 ehci_hcd scsi_mod i2c_i801 drm_kms_helper usbcore drm video button
> [  346.427699] CPU: 7 PID: 2217 Comm: kworker/u16:105 Tainted: G        W=
C       4.15.0+ #9
> [  346.427701] Hardware name: Apple Inc. MacBookPro10,1/Mac-C3EC7CD222929=
81F, BIOS MBP101.88Z.00EE.B0A.1509111559 09/11/2015
> [  346.427705] Workqueue: events_unbound async_run_entry_fn
> [  346.427710] RIP: 0010:tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  346.427712] RSP: 0000:ffffb8a383a93d28 EFLAGS: 00010286
> [  346.427714] RAX: 0000000000000000 RBX: ffff964cd317da80 RCX: 000000000=
0000006
> [  346.427716] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff964ce=
f3d66b0
> [  346.427718] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000=
00010ec
> [  346.427721] R10: ffffffffb726fe40 R11: ffff964cd428dc00 R12: 000000000=
0000001
> [  346.427723] R13: 00000050a5e920bb R14: 0000000000000010 R15: ffffffffb=
74767a4
> [  346.427725] FS:  0000000000000000(0000) GS:ffff964cef3c0000(0000) knlG=
S:0000000000000000
> [  346.427728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  346.427730] CR2: 0000000000000000 CR3: 000000035dc09001 CR4: 000000000=
01606e0
> [  346.427731] Call Trace:
> [  346.427737]  tb_switch_resume+0x139/0x290 [thunderbolt]
> [  346.427742]  tb_resume_noirq+0x49/0x100 [thunderbolt]
> [  346.427747]  tb_domain_resume_noirq+0x3f/0x60 [thunderbolt]
> [  346.427750]  ? pci_pm_freeze_noirq+0xe0/0xe0
> [  346.427752]  dpm_run_callback+0x4d/0x140
> [  346.427755]  device_resume_noirq+0x84/0x140
> [  346.427757]  async_resume_noirq+0x19/0x40
> [  346.427760]  async_run_entry_fn+0x33/0x160
> [  346.427763]  process_one_work+0x184/0x380
> [  346.427766]  worker_thread+0x4d/0x3c0
> [  346.427768]  kthread+0xf5/0x130
> [  346.427771]  ? process_one_work+0x380/0x380
> [  346.427773]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  346.427777]  ret_from_fork+0x35/0x40
> [  346.427779] Code: 24 18 e8 45 fc ff ff 8b 44 24 24 48 83 c4 18 85 c0 7=
4 1e 83 f8 01 74 57 83 f8 92 74 2d 89 c6 48 c7 c7 26 db db c0 e8 31 54 8c f=
5 <0f> ff 8b 44 24 0c 48 8b 5c 24 18 65 48 33 1c 25 28 00 00 00 75=20
> [  346.427807] ---[ end trace d61e276b076455e5 ]---
> [  346.427810] thunderbolt 0000:07:00.0: resume finished
> [  346.427813] call 0000:07:00.0+ returned 0 after 536 usecs
> [  346.427821] call 0000:06:03.0+ returned 0 after 838 usecs
> [  346.427822] call 0000:06:05.0+ returned 0 after 837 usecs
> [  346.427823] call 0000:06:06.0+ returned 0 after 834 usecs
> [  346.427824] call 0000:06:04.0+ returned 0 after 836 usecs
> [  346.446729] call 0000:00:1d.0+ returned 0 after 19516 usecs
=2E..
> [  346.470407] calling  hdaudioC0D0+ @ 2165, parent: 0000:00:1b.0
> [  346.470412] calling  hdaudioC1D0+ @ 2175, parent: 0000:01:00.1
> [  346.472524] call hdaudioC0D0+ returned 0 after 2061 usecs
> [  346.474383] pciehp 0000:06:05.0:pcie204: Timeout on hotplug command 0x=
1038 (issued 129884 msec ago)
> [  346.474387] pciehp 0000:06:06.0:pcie204: Timeout on hotplug command 0x=
1038 (issued 129884 msec ago)
> [  346.474389] pciehp 0000:06:03.0:pcie204: Timeout on hotplug command 0x=
1038 (issued 129888 msec ago)
> [  346.474392] pciehp 0000:06:06.0:pcie204: pcie_do_write_cmd: no respons=
e from device
> [  346.474393] pciehp 0000:06:03.0:pcie204: pcie_do_write_cmd: no respons=
e from device
> [  346.474400] pciehp 0000:06:04.0:pcie204: Timeout on hotplug command 0x=
1038 (issued 129884 msec ago)
> [  346.474402] pciehp 0000:06:04.0:pcie204: pcie_do_write_cmd: no respons=
e from device
> [  346.474408] pciehp 0000:06:05.0:pcie204: pcie_do_write_cmd: no respons=
e from device
> [  346.525712] call usb1+ returned 0 after 56999 usecs
> [  346.525766] calling  1-1+ @ 2278, parent: usb1
> [  346.525870] call usb3+ returned 0 after 57106 usecs
> [  346.525922] calling  3-2+ @ 2215, parent: usb3
> [  346.525925] calling  3-1+ @ 2187, parent: usb3
> [  346.526820] call 1-1+ returned 0 after 1014 usecs
> [  346.526847] calling  1-1.1+ @ 2208, parent: 1-1
> [  346.530426] call hdaudioC1D0+ returned 0 after 58591 usecs
> [  346.600377] call 1-1.1+ returned 0 after 71789 usecs
> [  346.638929] call 3-2+ returned 0 after 110327 usecs
> [  346.642430] call 2-1+ returned 0 after 170735 usecs
> [  346.642485] calling  2-1.8+ @ 2173, parent: 2-1
> [  346.722446] usb 2-1.8: reset high-speed USB device number 3 using ehci=
-pci
> [  346.780813] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  346.781322] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [  346.784817] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [  346.787041] ata1.00: configured for UDMA/133
> [  346.894759] MAC Address =3D c4:e9:84:14:1a:0e
> [  346.896225] call 3-1+ returned 0 after 361566 usecs
> [  347.046573] call 2-1.8+ returned 0 after 394549 usecs
> [  347.046615] calling  2-1.8.2+ @ 2183, parent: 2-1.8
> [  347.046637] calling  2-1.8.1+ @ 2269, parent: 2-1.8
> [  347.126563] usb 2-1.8.2: reset full-speed USB device number 5 using eh=
ci-pci
> [  347.243290] call 2-1.8.2+ returned 0 after 192029 usecs
> [  347.314579] usb 2-1.8.1: reset full-speed USB device number 4 using eh=
ci-pci
> [  347.638630] call 2-1.8.1+ returned 0 after 578022 usecs
> [  347.638698] calling  2-1.8.1.3+ @ 2123, parent: 2-1.8.1
> [  347.718642] usb 2-1.8.1.3: reset full-speed USB device number 8 using =
ehci-pci
> [  347.828460] call 2-1.8.1.3+ returned 0 after 185279 usecs
> [  347.982658] pciehp 0000:06:05.0:pcie204: link training error: status 0=
xffff
> [  347.982661] pciehp 0000:06:04.0:pcie204: link training error: status 0=
xffff
> [  347.982666] pciehp 0000:06:03.0:pcie204: link training error: status 0=
xffff
> [  347.982668] pciehp 0000:06:06.0:pcie204: link training error: status 0=
xffff
> [  347.982673] pciehp 0000:06:04.0:pcie204: Failed to check link
> status
=2E..
> [  373.710654] calling  0000:03:00.0+ @ 2223, parent: 0000:00:1c.0
> [  373.710657] calling  0000:07:00.0+ @ 2307, parent: 0000:06:00.0
> [  373.710659] calling  0000:06:06.0+ @ 2150, parent: 0000:05:00.0
> [  373.710661] thunderbolt 0000:07:00.0: suspending...
> [  373.710663] calling  0000:06:05.0+ @ 2199, parent: 0000:05:00.0
> [  373.710666] ------------[ cut here ]------------
> [  373.710670] tb_cfg_write: -108
> [  373.710684] calling  PNP0C09:00+ @ 2367, parent: device:2c
> [  373.710687] call PNP0C09:00+ returned 0 after 0 usecs
> [  373.710704] calling  0000:06:04.0+ @ 2312, parent: 0000:05:00.0
> [  373.710711] WARNING: CPU: 7 PID: 2307 at drivers/thunderbolt/ctl.c:981=
 tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  373.710713] Modules linked in: ebtable_filter ebtables ip6table_filter=
 ip6_tables hidp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_=
ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_con=
ntrack bridge stp llc ppdev parport_pc parport dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_bufio fuse vmw_vsock_vmci_transport vsock dm_mod vmw_v=
mci iptable_filter cmac bnep intel_rapl x86_pkg_temp_thermal intel_powercla=
mp snd_hda_codec_hdmi binfmt_misc nls_ascii nls_cp437 coretemp arc4 b43 kvm=
_intel vfat fat kvm irqbypass crct10dif_pclmul crc32_pclmul mac80211 ghash_=
clmulni_intel pcbc ssb mmc_core aesni_intel rng_core aes_x86_64 crypto_simd=
 pcmcia iTCO_wdt glue_helper iTCO_vendor_support cryptd r8188eu(C) pcmcia_c=
ore uvcvideo btusb btrtl btbcm btintel videobuf2_vmalloc snd_hda_codec_cirr=
us
> [  373.710760]  snd_hda_codec_generic bluetooth videobuf2_memops intel_cs=
tate videobuf2_v4l2 drbg videobuf2_core applesmc ansi_cprng snd_hda_intel v=
ideodev cfg80211 ecdh_generic input_polldev intel_uncore joydev rfkill medi=
a intel_rapl_perf snd_hda_codec sbs sg bcma snd_hda_core thunderbolt acpi_a=
ls snd_hwdep sbshc kfifo_buf snd_pcm industrialio apple_gmux mei_me lpc_ich=
 snd_timer shpchp mei snd mfd_core evdev soundcore apple_bl pcspkr ac efi_p=
store nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivars loop efivarfs ip_=
tables x_tables autofs4 hid_apple ext4 crc16 mbcache jbd2 fscrypto btrfs zs=
td_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx xor hid_generic usbhid hid raid6_pq libcr=
c32c crc32c_generic raid1 raid0 multipath linear md_mod bcm5974
> [  373.710811]  ax88179_178a usbnet mii sd_mod nouveau ahci libahci mxm_w=
mi xhci_pci i915 libata wmi crc32c_intel ehci_pci xhci_hcd ttm i2c_algo_bit=
 ehci_hcd scsi_mod i2c_i801 drm_kms_helper usbcore drm video button
> [  373.710829] CPU: 7 PID: 2307 Comm: kworker/u16:160 Tainted: G        W=
C       4.15.0+ #9
> [  373.710832] Hardware name: Apple Inc. MacBookPro10,1/Mac-C3EC7CD222929=
81F, BIOS MBP101.88Z.00EE.B0A.1509111559 09/11/2015
> [  373.710838] Workqueue: events_unbound async_run_entry_fn
> [  373.710844] RIP: 0010:tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  373.710847] RSP: 0018:ffffb8a383c6bd00 EFLAGS: 00010286
> [  373.710850] RAX: 0000000000000000 RBX: ffff964cd317da80 RCX: 000000000=
0000006
> [  373.710852] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff964ce=
f3d66b0
> [  373.710854] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000=
000136e
> [  373.710857] R10: ffffffffb726fe40 R11: ffff964cd428dc00 R12: 000000000=
0000004
> [  373.710859] R13: ffff964cdcbdc000 R14: 0000000000000004 R15: ffffffffb=
74767a4
> [  373.710861] FS:  0000000000000000(0000) GS:ffff964cef3c0000(0000) knlG=
S:0000000000000000
> [  373.710864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  373.710866] CR2: 0000000000ad3208 CR3: 000000035dc09001 CR4: 000000000=
01606e0
> [  373.710868] Call Trace:
> [  373.710876]  tb_plug_events_active+0x8e/0x180 [thunderbolt]
> [  373.710882]  tb_switch_suspend+0x11/0x90 [thunderbolt]
> [  373.710886]  tb_suspend_noirq+0x33/0x60 [thunderbolt]
> [  373.710892]  tb_domain_suspend_noirq+0x30/0x70 [thunderbolt]
> [  373.710895]  pci_pm_suspend_noirq+0x79/0x190
> [  373.710898]  ? pci_pm_resume_noirq+0x90/0x90
> [  373.710901]  dpm_run_callback+0x4d/0x140
> [  373.710903]  __device_suspend_noirq+0x7f/0x160
> [  373.710906]  async_suspend_noirq+0x1a/0x90
> [  373.710908]  async_run_entry_fn+0x33/0x160
> [  373.710912]  process_one_work+0x184/0x380
> [  373.710915]  worker_thread+0x4d/0x3c0
> [  373.710918]  kthread+0xf5/0x130
> [  373.710920]  ? process_one_work+0x380/0x380
> [  373.710923]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  373.710927]  ret_from_fork+0x35/0x40
> [  373.710930] Code: 24 18 e8 45 fc ff ff 8b 44 24 24 48 83 c4 18 85 c0 7=
4 1e 83 f8 01 74 57 83 f8 92 74 2d 89 c6 48 c7 c7 26 db db c0 e8 31 54 8c f=
5 <0f> ff 8b 44 24 0c 48 8b 5c 24 18 65 48 33 1c 25 28 00 00 00 75=20
> [  373.710956] ---[ end trace d61e276b076455e6 ]---
> [  373.710966] thunderbolt 0000:07:00.0: suspend finished
> [  373.710973] thunderbolt 0000:07:00.0: stopping RX ring 0
> [  373.710996] thunderbolt 0000:07:00.0: stopping TX ring 0
> [  373.711017] thunderbolt 0000:07:00.0: control channel stopped
> [  373.711025] call 0000:07:00.0+ returned 0 after 358 usecs
=2E..
> [  379.355848] thunderbolt 0000:07:00.0: Refused to change power state, c=
urrently in D3
> [  379.355853] thunderbolt 0000:07:00.0: control channel starting...
> [  379.355868] thunderbolt 0000:07:00.0: resuming...
> [  379.355870] thunderbolt 0000:07:00.0: resetting switch at 0
> [  379.355877] ------------[ cut here ]------------
> [  379.355880] tb_cfg_write: -108
> [  379.355921] WARNING: CPU: 7 PID: 2122 at drivers/thunderbolt/ctl.c:981=
 tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  379.355924] Modules linked in: ebtable_filter ebtables ip6table_filter=
 ip6_tables hidp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_=
ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_con=
ntrack bridge stp llc ppdev parport_pc parport dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_bufio fuse vmw_vsock_vmci_transport vsock dm_mod vmw_v=
mci iptable_filter cmac bnep intel_rapl x86_pkg_temp_thermal intel_powercla=
mp snd_hda_codec_hdmi binfmt_misc nls_ascii nls_cp437 coretemp arc4 b43 kvm=
_intel vfat fat kvm irqbypass crct10dif_pclmul crc32_pclmul mac80211 ghash_=
clmulni_intel pcbc ssb mmc_core aesni_intel rng_core aes_x86_64 crypto_simd=
 pcmcia iTCO_wdt glue_helper iTCO_vendor_support cryptd r8188eu(C) pcmcia_c=
ore uvcvideo btusb btrtl btbcm btintel videobuf2_vmalloc snd_hda_codec_cirr=
us
> [  379.355975]  snd_hda_codec_generic bluetooth videobuf2_memops intel_cs=
tate videobuf2_v4l2 drbg videobuf2_core applesmc ansi_cprng snd_hda_intel v=
ideodev cfg80211 ecdh_generic input_polldev intel_uncore joydev rfkill medi=
a intel_rapl_perf snd_hda_codec sbs sg bcma snd_hda_core thunderbolt acpi_a=
ls snd_hwdep sbshc kfifo_buf snd_pcm industrialio apple_gmux mei_me lpc_ich=
 snd_timer shpchp mei snd mfd_core evdev soundcore apple_bl pcspkr ac efi_p=
store nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivars loop efivarfs ip_=
tables x_tables autofs4 hid_apple ext4 crc16 mbcache jbd2 fscrypto btrfs zs=
td_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx xor hid_generic usbhid hid raid6_pq libcr=
c32c crc32c_generic raid1 raid0 multipath linear md_mod bcm5974
> [  379.356035]  ax88179_178a usbnet mii sd_mod nouveau ahci libahci mxm_w=
mi xhci_pci i915 libata wmi crc32c_intel ehci_pci xhci_hcd ttm i2c_algo_bit=
 ehci_hcd scsi_mod i2c_i801 drm_kms_helper usbcore drm video button
> [  379.356057] CPU: 7 PID: 2122 Comm: kworker/u16:11 Tainted: G        WC=
       4.15.0+ #9
> [  379.356060] Hardware name: Apple Inc. MacBookPro10,1/Mac-C3EC7CD222929=
81F, BIOS MBP101.88Z.00EE.B0A.1509111559 09/11/2015
> [  379.356066] Workqueue: events_unbound async_run_entry_fn
> [  379.356073] RIP: 0010:tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  379.356076] RSP: 0000:ffffb8a3837f3d18 EFLAGS: 00010286
> [  379.356079] RAX: 0000000000000000 RBX: ffff964cd317da80 RCX: 000000000=
0000006
> [  379.356081] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff964ce=
f3d66b0
> [  379.356084] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000=
0001437
> [  379.356086] R10: ffffffffb726fe40 R11: ffff964cd428dc00 R12: 000000000=
0000002
> [  379.356089] R13: 0000005728b1bf09 R14: 0000000000000010 R15: ffffffffb=
74767a4
> [  379.356092] FS:  0000000000000000(0000) GS:ffff964cef3c0000(0000) knlG=
S:0000000000000000
> [  379.356095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  379.356097] CR2: 0000000000000000 CR3: 000000035dc09001 CR4: 000000000=
01606e0
> [  379.356100] Call Trace:
> [  379.356110]  tb_switch_reset+0xa6/0xf0 [thunderbolt]
> [  379.356116]  tb_resume_noirq+0x3c/0x100 [thunderbolt]
> [  379.356122]  tb_domain_resume_noirq+0x3f/0x60 [thunderbolt]
> [  379.356127]  ? pci_pm_freeze_noirq+0xe0/0xe0
> [  379.356130]  dpm_run_callback+0x4d/0x140
> [  379.356134]  device_resume_noirq+0x84/0x140
> [  379.356137]  async_resume_noirq+0x19/0x40
> [  379.356140]  async_run_entry_fn+0x33/0x160
> [  379.356145]  process_one_work+0x184/0x380
> [  379.356149]  worker_thread+0x4d/0x3c0
> [  379.356152]  kthread+0xf5/0x130
> [  379.356155]  ? process_one_work+0x380/0x380
> [  379.356158]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  379.356163]  ret_from_fork+0x35/0x40
> [  379.356167] Code: 24 18 e8 45 fc ff ff 8b 44 24 24 48 83 c4 18 85 c0 7=
4 1e 83 f8 01 74 57 83 f8 92 74 2d 89 c6 48 c7 c7 26 db db c0 e8 31 54 8c f=
5 <0f> ff 8b 44 24 0c 48 8b 5c 24 18 65 48 33 1c 25 28 00 00 00 75=20
> [  379.356201] ---[ end trace d61e276b076455e7 ]---
> [  379.356204] thunderbolt 0000:07:00.0: 0: resuming switch
> [  379.356208] ------------[ cut here ]------------
> [  379.356210] tb_cfg_write: -108
> [  379.356227] WARNING: CPU: 7 PID: 2122 at drivers/thunderbolt/ctl.c:981=
 tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  379.356230] Modules linked in: ebtable_filter ebtables ip6table_filter=
 ip6_tables hidp xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_=
ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_con=
ntrack bridge stp llc ppdev parport_pc parport dm_thin_pool dm_persistent_d=
ata dm_bio_prison dm_bufio fuse vmw_vsock_vmci_transport vsock dm_mod vmw_v=
mci iptable_filter cmac bnep intel_rapl x86_pkg_temp_thermal intel_powercla=
mp snd_hda_codec_hdmi binfmt_misc nls_ascii nls_cp437 coretemp arc4 b43 kvm=
_intel vfat fat kvm irqbypass crct10dif_pclmul crc32_pclmul mac80211 ghash_=
clmulni_intel pcbc ssb mmc_core aesni_intel rng_core aes_x86_64 crypto_simd=
 pcmcia iTCO_wdt glue_helper iTCO_vendor_support cryptd r8188eu(C) pcmcia_c=
ore uvcvideo btusb btrtl btbcm btintel videobuf2_vmalloc snd_hda_codec_cirr=
us
> [  379.356273]  snd_hda_codec_generic bluetooth videobuf2_memops intel_cs=
tate videobuf2_v4l2 drbg videobuf2_core applesmc ansi_cprng snd_hda_intel v=
ideodev cfg80211 ecdh_generic input_polldev intel_uncore joydev rfkill medi=
a intel_rapl_perf snd_hda_codec sbs sg bcma snd_hda_core thunderbolt acpi_a=
ls snd_hwdep sbshc kfifo_buf snd_pcm industrialio apple_gmux mei_me lpc_ich=
 snd_timer shpchp mei snd mfd_core evdev soundcore apple_bl pcspkr ac efi_p=
store nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivars loop efivarfs ip_=
tables x_tables autofs4 hid_apple ext4 crc16 mbcache jbd2 fscrypto btrfs zs=
td_decompress zstd_compress xxhash raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx xor hid_generic usbhid hid raid6_pq libcr=
c32c crc32c_generic raid1 raid0 multipath linear md_mod bcm5974
> [  379.356320]  ax88179_178a usbnet mii sd_mod nouveau ahci libahci mxm_w=
mi xhci_pci i915 libata wmi crc32c_intel ehci_pci xhci_hcd ttm i2c_algo_bit=
 ehci_hcd scsi_mod i2c_i801 drm_kms_helper usbcore drm video button
> [  379.356336] CPU: 7 PID: 2122 Comm: kworker/u16:11 Tainted: G        WC=
       4.15.0+ #9
> [  379.356338] Hardware name: Apple Inc. MacBookPro10,1/Mac-C3EC7CD222929=
81F, BIOS MBP101.88Z.00EE.B0A.1509111559 09/11/2015
> [  379.356343] Workqueue: events_unbound async_run_entry_fn
> [  379.356349] RIP: 0010:tb_cfg_write+0x6f/0xd0 [thunderbolt]
> [  379.356351] RSP: 0000:ffffb8a3837f3d28 EFLAGS: 00010286
> [  379.356354] RAX: 0000000000000000 RBX: ffff964cd317da80 RCX: 000000000=
0000006
> [  379.356356] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff964ce=
f3d66b0
> [  379.356359] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000=
000145c
> [  379.356361] R10: ffffffffb726fe40 R11: ffff964cd428dc00 R12: 000000000=
0000001
> [  379.356364] R13: 0000005728b1bf09 R14: 0000000000000010 R15: ffffffffb=
74767a4
> [  379.356367] FS:  0000000000000000(0000) GS:ffff964cef3c0000(0000) knlG=
S:0000000000000000
> [  379.356369] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  379.356372] CR2: 0000000000000000 CR3: 000000035dc09001 CR4: 000000000=
01606e0
> [  379.356374] Call Trace:
> [  379.356380]  tb_switch_resume+0x139/0x290 [thunderbolt]
> [  379.356386]  tb_resume_noirq+0x49/0x100 [thunderbolt]
> [  379.356392]  tb_domain_resume_noirq+0x3f/0x60 [thunderbolt]
> [  379.356395]  ? pci_pm_freeze_noirq+0xe0/0xe0
> [  379.356398]  dpm_run_callback+0x4d/0x140
> [  379.356401]  device_resume_noirq+0x84/0x140
> [  379.356403]  async_resume_noirq+0x19/0x40
> [  379.356407]  async_run_entry_fn+0x33/0x160
> [  379.356410]  process_one_work+0x184/0x380
> [  379.356413]  worker_thread+0x4d/0x3c0
> [  379.356416]  kthread+0xf5/0x130
> [  379.356420]  ? process_one_work+0x380/0x380
> [  379.356422]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  379.356426]  ret_from_fork+0x35/0x40
> [  379.356429] Code: 24 18 e8 45 fc ff ff 8b 44 24 24 48 83 c4 18 85 c0 7=
4 1e 83 f8 01 74 57 83 f8 92 74 2d 89 c6 48 c7 c7 26 db db c0 e8 31 54 8c f=
5 <0f> ff 8b 44 24 0c 48 8b 5c 24 18 65 48 33 1c 25 28 00 00 00 75=20
> [  379.356462] ---[ end trace d61e276b076455e8 ]---
> [  379.356466] thunderbolt 0000:07:00.0: resume finished
> [  379.356468] call 0000:07:00.0+ returned 0 after 607 usecs
> [  379.356480] call 0000:06:05.0+ returned 0 after 899 usecs


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqlBi8ACgkQMOfwapXb+vL4NACgsKxG9yxCqV7Gfw42z7wRtMzv
2KsAoK7J/Gc+5ygciobAEl3SVa+q589l
=hooI
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
