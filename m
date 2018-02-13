Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934978AbeBMMGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:06:03 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:52569 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934661AbeBMMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:05:58 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180213120556epoutp0251d20faa87a51277f6b08286d97f9eba~S4SD4Mu8j0805708057epoutp02M
X-AuditID: b6c32a47-19fff7000000100c-b3-5a82d4a3b8b7
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Fix loading of module radeonfb on PowerMac
Date: Tue, 13 Feb 2018 13:05:51 +0100
Message-id: <1518527140.UJSeJceWAP@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CA+7wUswgwCHON083+RLz926+CfWAWJ0ODcHyLcTfki0uambO+Q@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdljTTHfxlaYogwvzOC0+NLUyW1z5+p7N
        4kTfB1aLy7vmsFm8+LaGyeLsprcsFuvn32JzYPf4umo2u8evtrnMHj1vWlg97ncfZ/I4fmM7
        k8fnTXIBbFFcNimpOZllqUX6dglcGWsmzGEuOHCasWLf7w72BsaZ8xi7GDk5JARMJL4/n8jW
        xcjFISSwg1Hi2rGrTBDOd0aJR5MPM8FU9S7azAiR2MAo8eFPK1TVV0aJvy1HmUGq2ASsJCa2
        rwKbKyKgIXHrynOguRwczAJzmST+WoKEhQWcJL5O2wpWwiKgKvH7YAeYzSugI7Hu/nR2EFtU
        wEtiy752sMWcAsESDTevs0HUCEr8mHyPBcRmFpCX2Ld/KiuErSNx9tg6sOMkBE6wSbxf0MoG
        cbWLxILpW9khbGGJV8e3QNnSEs9WbYRqWMUo8fPqXyhnM6PE5+tfWSGqrCUOH78ItYJPouPw
        X3aQbyQEeCU62oQgSjwkVnXfhBrqKHHjxx12SKj8YZRYeWky6wRG2VlILp+F5PJZSC5fwMi8
        ilEstaA4Nz212KjAWK84Mbe4NC9dLzk/dxMjOG1oue9g3HbO5xCjAAejEg9vx+zGKCHWxLLi
        ytxDjBIczEoivBwLm6KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ87YGuEQJCaQnlqRmp6YWpBbB
        ZJk4OKUaGJfyrG5UL5jw2am1K1MvpMrf6aEgy0KGqx2rV4m7i1q/35r1TrDNqZNr65+l782/
        itr8vvTticYV8YkeCs+j6hur3KbKTvJeqvRq/5OGj1MW5i2qMrm0cObG+AVrmr9oqLIe8fk3
        pUIgxey51rXtk9oYXobsao/TP+x/k7vvrha3y7+rdnL9FkosxRmJhlrMRcWJAEe7i5IXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t9jQd1FV5qiDI59kLD40NTKbHHl63s2
        ixN9H1gtLu+aw2bx4tsaJouzm96yWKyff4vNgd3j66rZ7B6/2uYye/S8aWH1uN99nMnj+I3t
        TB6fN8kFsEVx2aSk5mSWpRbp2yVwZayZMIe54MBpxop9vzvYGxhnzmPsYuTkkBAwkehdtBnI
        5uIQEljHKPFo42pmCOcro8TWLW/ZQarYBKwkJravAusQEdCQuHXlORtIEbPAXCaJaY3fmUES
        wgJOEl+nbQUrYhFQlfh9sAPM5hXQkVh3fzrYIFEBL4kt+9qZQGxOgWCJvc9XQq1ewSjRdOY/
        G0SDoMSPyfdYQGxmAXmJffunskLYWhLrdx5nmsDIPwtJ2SwkZbOQlC1gZF7FKJlaUJybnlts
        VGCUl1quV5yYW1yal66XnJ+7iREY6NsOa/XvYHy8JP4QowAHoxIPb8fsxigh1sSy4srcQ4wS
        HMxKIrwcC5uihHhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBK
        NTD270thX6SwzOZiYwsrb9O0i8u1bTsv7ct+x9svMuHoz6czV/qv8+46v33DxOqXlc8mfup+
        39BcVHvTXzQpz2HRWu5ZyYun54tJpbZsXb8sTOGFtXK1ku3lT/EJ53TWKWvLyW/1lple/EVj
        bvcskyff3p6NSpzvF8x/fZFPcNXn/WaL2Jw+7NmpxFKckWioxVxUnAgAr6rjlHACAAA=
X-CMS-MailID: 20180213120554epcas2p170cf3165c38d02fe081903c347e84b1e
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180213120554epcas2p170cf3165c38d02fe081903c347e84b1e
X-RootMTR: 20180213120554epcas2p170cf3165c38d02fe081903c347e84b1e
References: <1479153557-20849-1-git-send-email-malat@debian.org>
        <22661745.JSDcq4C6er@amdc3058>
        <CA+7wUswgwCHON083+RLz926+CfWAWJ0ODcHyLcTfki0uambO+Q@mail.gmail.com>
        <CGME20180213120554epcas2p170cf3165c38d02fe081903c347e84b1e@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 10, 2018 01:48:55 PM Mathieu Malaterre wrote:
>  Hi,
> 
> On Thu, Feb 8, 2018 at 2:28 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Wednesday, January 31, 2018 08:51:23 PM Mathieu Malaterre wrote:
> >> Bartlomiej,
> >>
> >> On Wed, Jan 31, 2018 at 12:57 PM, Bartlomiej Zolnierkiewicz
> >> <b.zolnierkie@samsung.com> wrote:
> >> > On Tuesday, January 30, 2018 02:14:10 PM Mathieu Malaterre wrote:
> >> >> Bartlomiej,
> >> >>
> >> >> On Wed, Jan 3, 2018 at 3:47 PM, Bartlomiej Zolnierkiewicz
> >> >> <b.zolnierkie@samsung.com> wrote:
> >> >> >
> >> >> > On Thursday, December 21, 2017 11:07:56 PM Mathieu Malaterre wrote:
> >> >> >> When the linux kernel is build with (typical kernel ship with Debian
> >> >> >> installer):
> >> >> >>
> >> >> >> CONFIG_FB_OF=y
> >> >> >> CONFIG_VT_HW_CONSOLE_BINDING=y
> >> >> >> CONFIG_FB_RADEON=m
> >> >> >>
> >> >> >> The offb driver takes precedence over module radeonfb. It is then
> >> >> >> impossible to load the module, error reported is:
> >> >> >>
> >> >> >> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> >> >> >> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> >> >> >> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> >> >> >> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> >> >> >>
> >> >> >> This patch reproduce the behavior of the module radeon, so as to make it
> >> >> >> possible to load radeonfb when offb is first loaded.
> >> >> >>
> >> >> >> It should be noticed that `offb_destroy` is never called which explain the
> >> >> >> need to skip error detection on the radeon side.
> >> >> >
> >> >> > This still needs to be explained more, from my last mail:
> >> >> >
> >> >> > "The last put_fb_info() on fb_info should call ->fb_destroy
> >> >> > (offb_destroy in our case) and remove_conflicting_framebuffers()
> >> >> > is calling put_fb_info() so there is some extra reference on
> >> >> > fb_info somewhere preventing it from going away.
> >> >> >
> >> >> > Please look into fixing this."
> >> >>
> >> >> I am not familiar with the fb stuff internals but here is what I see:
> >> >>
> >> >> # modprobe radeonfb
> >> >>
> >> >> leads to:
> >> >>
> >> >> [   52.058546] bus: 'pci': add driver radeonfb
> >> >> [   52.058588] bus: 'pci': driver_probe_device: matched device
> >> >> 0000:00:10.0 with driver radeonfb
> >> >> [   52.058595] bus: 'pci': really_probe: probing driver radeonfb with
> >> >> device 0000:00:10.0
> >> >> [   52.058608] devices_kset: Moving 0000:00:10.0 to end of list
> >> >> [   52.058613] radeonfb_pci_register BEGIN
> >> >> [   52.058634] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> >> >> <at this point radeon_kick_out_firmware_fb is called>
> >> >> [   52.058666] checking generic (9c008000 96000) vs hw (98000000 8000000)
> >> >> [   52.058667] fb: switching to radeonfb from OFfb ATY,RockHo
> >> >> [   52.058844] Console: switching to colour dummy device 80x25
> >> >> [   52.058860] device: 'fb0': device_unregister
> >> >> [   52.058956] PM: Removing info for No Bus:fb0
> >> >> [   52.059014] device: 'fb0': device_create_release
> >> >> <a call to do_unregister_framebuffer is done>
> >> >> <put_fb_info is done with a count=2 and dev=NULL>
> >> >> [   52.059048] device: 'vtcon1': device_unregister
> >> >> [   52.059076] PM: Removing info for No Bus:vtcon1
> >> >> [   52.059091] device: 'vtcon1': device_create_release
> >> >> [   52.059107] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem
> >> >> 0x98000000-0x9fffffff pref]
> >> >> [   52.256151] aper_base: 98000000 MC_FB_LOC to: 9bff9800, MC_AGP_LOC
> >> >> to: ffffa000
> >> >> [   52.256157] radeonfb (0000:00:10.0): Found 32768k of DDR 64 bits
> >> >> wide videoram
> >> >>
> >> >> I can confirm that offb_destroy is never called (not sure exactly
> >> >> why), but in any case the call to radeon_kick_out_firmware_fb happen
> >> >> much earlier, at least before the put_fb_info.
> >> >
> >> > It is okay, put_fb_info() is called indirectly by radeon_kick_out_firmware_fb()
> >> >
> >> > radeon_kick_out_firmware_fb()
> >> >         remove_conflicting_framebuffers()
> >> >                 do_remove_conflicting_framebuffers()
> >> >                         do_unregister_framebuffer()
> >> >                                 put_fb_info()
> >> >
> >> > offb_destroy() is not called because there is an extra reference on old
> >> > fb_info (->count == 2):
> >> >
> >> > static void put_fb_info(struct fb_info *fb_info)
> >> > {
> >> >         if (!atomic_dec_and_test(&fb_info->count))
> >> >                 return;
> >> >         if (fb_info->fbops->fb_destroy)
> >> >                 fb_info->fbops->fb_destroy(fb_info);
> >> > }
> >> >
> >> > The question is why there is an extra reference, probably user-space
> >> > is still holding the fb_info reference obtained in fb_open() call and
> >> > fb_release() is never called. Besides not calling fbops->fb_destroy()
> >> > this also causes missing call of fbops->fb_release() (in fb_release())
> >> > which some fb drivers are implementing (but not offb.c).
> >> >
> >> >> Could you describe a bit more the chain of calls you were thinking of ?
> >> >
> >> > Please add WARN_ON(1) to get_fb_info() and put_fb_info() so we can check
> >> > from the stacktrace if it is actually fb_open() that holds the extra
> >> > old fb_info reference.
> >> >
> >> > drivers/video/fbdev/core/fbmem.c:
> >> >
> >> > static struct fb_info *get_fb_info(unsigned int idx)
> >> > {
> >> >         struct fb_info *fb_info;
> >> >
> >> >         if (idx >= FB_MAX)
> >> >                 return ERR_PTR(-ENODEV);
> >> >
> >> >         mutex_lock(&registration_lock);
> >> >         fb_info = registered_fb[idx];
> >> >         if (fb_info)
> >> >                 atomic_inc(&fb_info->count);
> >> >
> >> > if (fb_info)
> >> >         WARN_ON(1);
> >> >
> >> >         mutex_unlock(&registration_lock);
> >> >
> >> >         return fb_info;
> >> > }
> >> >
> >> > static void put_fb_info(struct fb_info *fb_info)
> >> > {
> >> > WARN_ON(1);
> >> >
> >> >         if (!atomic_dec_and_test(&fb_info->count))
> >> >                 return;
> >> >         if (fb_info->fbops->fb_destroy)
> >> >                 fb_info->fbops->fb_destroy(fb_info);
> >> > }
> >>
> >>
> >> Alright, here is what I see:
> >>
> >> [   18.961639] PM: Adding info for No Bus:vcs7
> >> [   18.966448] device: 'vcsa7': device_add
> >> [   18.966496] PM: Adding info for No Bus:vcsa7
> >> [   19.001701] WARNING: CPU: 0 PID: 405 at
> >> drivers/video/fbdev/core/fbmem.c:68 get_fb_info.part.3+0x58/0x7c
> >> [   19.001715] Modules linked in: uinput snd_aoa_codec_toonie
> >> snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm
> >> snd_timer snd soundcore rack_meter evdev i2c_dev sg usb_storage
> >> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto
> >> hid_generic usbhid hid ohci_pci ehci_pci ohci_hcd ehci_hcd sungem
> >> firewire_ohci sungem_phy sr_mod firewire_core crc_itu_t cdrom sd_mod
> >> usbcore
> >> [   19.001773] CPU: 0 PID: 405 Comm: Xorg Not tainted 4.15.0+ #321
> >> [   19.001778] NIP:  c039ef20 LR: c039eefc CTR: c039ef44
> >> [   19.001781] REGS: decc7c80 TRAP: 0700   Not tainted  (4.15.0+)
> >> [   19.001784] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 28222828  XER: 00000000
> >> [   19.001795]
> >>                GPR00: c039eefc decc7d30 c147ab00 00000000 dc3ed8c0
> >> df568a6c 00000001 c147ab00
> >>                GPR08: df568a6c 00000002 00000000 dc280c50 28222822
> >> 006f9ff4 006fff50 80000000
> >>                GPR16: 88000228 00000008 bfcb5b08 00000002 decc7e60
> >> 80000000 ffffffea 00000041
> >>                GPR24: 00000000 00000006 df568a6c dc3ed8c0 df5ef1e8
> >> df568a40 c08f7c18 dc198800
> >> [   19.001835] NIP [c039ef20] get_fb_info.part.3+0x58/0x7c
> >> [   19.001840] LR [c039eefc] get_fb_info.part.3+0x34/0x7c
> >> [   19.001842] Call Trace:
> >> [   19.001848] [decc7d30] [c039eefc] get_fb_info.part.3+0x34/0x7c (unreliable)
> >> [   19.001854] [decc7d40] [c039efa0] fb_open+0x5c/0x18c
> >> [   19.001866] [decc7d60] [c01e0e90] chrdev_open+0xb8/0x19c
> >> [   19.001872] [decc7d90] [c01d7994] do_dentry_open+0x24c/0x398
> >> [   19.001881] [decc7dc0] [c01ec378] path_openat+0x4c4/0x11b8
> >> [   19.001888] [decc7e50] [c01ee0d8] do_filp_open+0xbc/0x10c
> >> [   19.001893] [decc7f00] [c01d93b0] do_sys_open+0x158/0x228
> >> [   19.001901] [decc7f40] [c00181cc] ret_from_syscall+0x0/0x40
> >> [   19.001908] --- interrupt: c01 at 0xb751b940
> >>                    LR = 0xb751b8dc
> >> [   19.001912] Instruction dump:
> >> [   19.001917] 7fc3f378 57ff103a 482cc171 3d20c093 39291a84 7fe9f82e
> >> 2f9f0000 419e0018
> >> [   19.001927] 7d20f828 31290001 7d20f92d 40a2fff4 <0fe00000> 7fc3f378
> >> 482cca69 7fe3fb78
> >> [   19.001938] ---[ end trace e0bf4192eb1c4f60 ]---
> >> [   19.001985] WARNING: CPU: 0 PID: 405 at
> >> drivers/video/fbdev/core/fbmem.c:77 put_fb_info+0x18/0x68
> >> [   19.001988] Modules linked in: uinput snd_aoa_codec_toonie
> >> snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm
> >> snd_timer snd soundcore rack_meter evdev i2c_dev sg usb_storage
> >> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto
> >> hid_generic usbhid hid ohci_pci ehci_pci ohci_hcd ehci_hcd sungem
> >> firewire_ohci sungem_phy sr_mod firewire_core crc_itu_t cdrom sd_mod
> >> usbcore
> >> [   19.002028] CPU: 0 PID: 405 Comm: Xorg Tainted: G        W
> >> 4.15.0+ #321
> >> [   19.002031] NIP:  c039e6ec LR: c039eeb0 CTR: c039ee48
> >> [   19.002035] REGS: decc7e10 TRAP: 0700   Tainted: G        W         (4.15.0+)
> >> [   19.002037] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 28000222  XER: 20000000
> >> [   19.002047]
> >>                GPR00: c039eeb0 decc7ec0 c147ab00 dc198800 dc3ed8c0
> >> dc3ed8c8 00000001 c147ab00
> >>                GPR08: 00000000 c08fa6f8 00000000 dc280c50 28000228
> >> 006f9ff4 006fff50 00000000
> >>                GPR16: 007001a8 00000008 bfcb5b08 007001a4 00000000
> >> 0070d0c4 00000002 00000000
> >>                GPR24: b6ad8b1c dc3ed8c8 df5ef1e8 df3e4ee0 dc280c50
> >> df5ef1e8 dc19880c dc198800
> >> [   19.002086] NIP [c039e6ec] put_fb_info+0x18/0x68
> >> [   19.002091] LR [c039eeb0] fb_release+0x68/0x80
> >> [   19.002093] Call Trace:
> >> [   19.002096] [decc7ec0] [df5ef1e8] 0xdf5ef1e8 (unreliable)
> >> [   19.002102] [decc7ed0] [c039eeb0] fb_release+0x68/0x80
> >> [   19.002108] [decc7ee0] [c01dd2e8] __fput+0xb4/0x260
> >> [   19.002118] [decc7f10] [c006e088] task_work_run+0xc0/0xe8
> >> [   19.002129] [decc7f30] [c000aa90] do_notify_resume+0xb4/0xb8
> >> [   19.002135] [decc7f40] [c0018b4c] do_user_signal+0x7c/0xcc
> >> [   19.002140] --- interrupt: c00 at 0xb751a7d8
> >>                    LR = 0xb751a7ac
> >> [   19.002144] Instruction dump:
> >> [   19.002147] 80010014 38210010 7c0803a6 4e800020 38600000 4e800020
> >> 7c0802a6 90010004
> >> [   19.002157] 60000000 9421fff0 7c0802a6 90010014 <0fe00000> 7d401828
> >> 314affff 7d40192d
> >> [   19.002168] ---[ end trace e0bf4192eb1c4f61 ]---
> >> [   19.002595] WARNING: CPU: 0 PID: 405 at
> >> drivers/video/fbdev/core/fbmem.c:68 get_fb_info.part.3+0x58/0x7c
> >> [   19.002601] Modules linked in: uinput snd_aoa_codec_toonie
> >> snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm
> >> snd_timer snd soundcore rack_meter evdev i2c_dev sg usb_storage
> >> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto
> >> hid_generic usbhid hid ohci_pci ehci_pci ohci_hcd ehci_hcd sungem
> >> firewire_ohci sungem_phy sr_mod firewire_core crc_itu_t cdrom sd_mod
> >> usbcore
> >> [   19.002645] CPU: 0 PID: 405 Comm: Xorg Tainted: G        W
> >> 4.15.0+ #321
> >> [   19.002649] NIP:  c039ef20 LR: c039eefc CTR: c039ef44
> >> [   19.002652] REGS: decc7c80 TRAP: 0700   Tainted: G        W         (4.15.0+)
> >> [   19.002655] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 28222248  XER: 00000000
> >> [   19.002664]
> >>                GPR00: c039eefc decc7d30 c147ab00 00000000 deca0340
> >> deca0348 00000001 00000000
> >>                GPR08: 00000000 00000002 00000000 dc280c50 28222842
> >> 006f9ff4 006fff50 80000000
> >>                GPR16: 88000448 00000001 00000000 00000002 decc7e60
> >> 80000000 ffffffea 00000041
> >>                GPR24: 00000000 00000006 c01e0dd8 deca0340 df5ef1e8
> >> df568a40 c08f7c18 dc198800
> >> [   19.002704] NIP [c039ef20] get_fb_info.part.3+0x58/0x7c
> >> [   19.002708] LR [c039eefc] get_fb_info.part.3+0x34/0x7c
> >> [   19.002711] Call Trace:
> >> [   19.002716] [decc7d30] [c039eefc] get_fb_info.part.3+0x34/0x7c (unreliable)
> >> [   19.002722] [decc7d40] [c039efa0] fb_open+0x5c/0x18c
> >> [   19.002730] [decc7d60] [c01e0e90] chrdev_open+0xb8/0x19c
> >> [   19.002735] [decc7d90] [c01d7994] do_dentry_open+0x24c/0x398
> >> [   19.002743] [decc7dc0] [c01ec378] path_openat+0x4c4/0x11b8
> >> [   19.002748] [decc7e50] [c01ee0d8] do_filp_open+0xbc/0x10c
> >> [   19.002754] [decc7f00] [c01d93b0] do_sys_open+0x158/0x228
> >> [   19.002760] [decc7f40] [c00181cc] ret_from_syscall+0x0/0x40
> >> [   19.002766] --- interrupt: c01 at 0xb751b940
> >>                    LR = 0xb751b8dc
> >> [   19.002770] Instruction dump:
> >> [   19.002774] 7fc3f378 57ff103a 482cc171 3d20c093 39291a84 7fe9f82e
> >> 2f9f0000 419e0018
> >> [   19.002784] 7d20f828 31290001 7d20f92d 40a2fff4 <0fe00000> 7fc3f378
> >> 482cca69 7fe3fb78
> >> [   19.002795] ---[ end trace e0bf4192eb1c4f62 ]---
> >> [   19.011629] gem 0002:20:0f.0 eth0: Link is up at 100 Mbps, full-duplex
> >> [   19.011746] gem 0002:20:0f.0 eth0: Pause is disabled
> >> [   19.011846] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> >> [   19.018954] device: 'input3': device_add
> >> [   19.019031] PM: Adding info for No Bus:input3
> >>
> >>
> >> Then later on (after modprobe radeonfb):
> >>
> >> [  657.135105] PM: Removing info for No Bus:fb0
> >> [  657.135164] device: 'fb0': device_create_release
> >> [  657.135279] WARNING: CPU: 0 PID: 475 at
> >> drivers/video/fbdev/core/fbmem.c:77 put_fb_info+0x18/0x68
> >> [  657.135284] Modules linked in: radeonfb(+) uinput
> >> snd_aoa_codec_toonie snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus
> >> snd_aoa_soundbus snd_pcm snd_timer snd soundcore rack_meter evdev
> >> i2c_dev sg usb_storage ip_tables x_tables autofs4 ext4 crc16 mbcache
> >> jbd2 fscrypto hid_generic usbhid hid ohci_pci ehci_pci ohci_hcd
> >> ehci_hcd sungem firewire_ohci sungem_phy sr_mod firewire_core
> >> crc_itu_t cdrom sd_mod usbcore
> >> [  657.135344] CPU: 0 PID: 475 Comm: modprobe Tainted: G        W
> >>   4.15.0+ #321
> >> [  657.135348] NIP:  c039e6ec LR: c039e834 CTR: 00000000
> >> [  657.135352] REGS: dec93af0 TRAP: 0700   Tainted: G        W         (4.15.0+)
> >> [  657.135355] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24228822  XER: 20000000
> >> [  657.135365]
> >>                GPR00: c039e834 dec93ba0 dc28eaa0 dc198800 00000000
> >> 000005c0 00000002 00000000
> >>                GPR08: 00001032 c08c2c2c 00000000 c08c1ab0 28228424
> >> 0049ce6c e2287b5c 00000000
> >>                GPR16: c06974dc 00000007 e2284384 00000001 dec9852c
> >> e2282610 00000000 000a0000
> >>                GPR24: c07c9d60 c07c9d2c dc19880c 00000000 dec93bb8
> >> 00000000 c0931a84 dc198800
> >> [  657.135405] NIP [c039e6ec] put_fb_info+0x18/0x68
> >> [  657.135411] LR [c039e834] do_unregister_framebuffer+0xf8/0x148
> >> [  657.135413] Call Trace:
> >> [  657.135419] [dec93bb0] [c039e834] do_unregister_framebuffer+0xf8/0x148
> >> [  657.135425] [dec93be0] [c039ea1c]
> >> do_remove_conflicting_framebuffers+0x198/0x1b8
> >> [  657.135431] [dec93c30] [c039ea84] remove_conflicting_framebuffers+0x48/0x6c
> >> [  657.135474] [dec93c50] [e2274d6c]
> >> radeonfb_pci_register+0x184/0x1838 [radeonfb]
> >> [  657.135481] [dec93cb0] [c037e9fc] pci_device_probe+0x110/0x180
> >> [  657.135492] [dec93ce0] [c045be70] driver_probe_device+0x378/0x4a0
> >> [  657.135497] [dec93d10] [c045c0ac] __driver_attach+0x114/0x118
> >> [  657.135503] [dec93d30] [c04593dc] bus_for_each_dev+0x74/0xc0
> >> [  657.135508] [dec93d60] [c045acd4] bus_add_driver+0x18c/0x2a0
> >> [  657.135515] [dec93d80] [c045ce3c] driver_register+0x94/0x13c
> >> [  657.135524] [dec93d90] [c0004af4] do_one_initcall+0x4c/0x178
> >> [  657.135536] [dec93df0] [c00ced18] do_init_module+0x70/0x1ec
> >> [  657.135542] [dec93e10] [c00cdcb0] load_module+0x20d8/0x26b8
> >> [  657.135548] [dec93ec0] [c00ce500] SyS_finit_module+0xc4/0x120
> >> [  657.135555] [dec93f40] [c00181cc] ret_from_syscall+0x0/0x40
> >> [  657.135562] --- interrupt: c01 at 0x34d450
> >>                    LR = 0x476108
> >> [  657.135566] Instruction dump:
> >> [  657.135572] 80010014 38210010 7c0803a6 4e800020 38600000 4e800020
> >> 7c0802a6 90010004
> >> [  657.135582] 60000000 9421fff0 7c0802a6 90010014 <0fe00000> 7d401828
> >> 314affff 7d40192d
> >> [  657.135593] ---[ end trace e0bf4192eb1c4f63 ]---
> >> [  657.135613] device: 'vtcon1': device_unregister
> >> [  657.135644] PM: Removing info for No Bus:vtcon1
> >>
> >>
> >> Full dmesg:
> >> https://people.debian.org/~malat/dmesg_radeonfb.txt
> >>
> >> Does that help at all? the call stack does not make much sense to me.
> >> I am accessing the Mac Mini over ssh.
> >
> > Thank you, it helps.
> >
> > User-space is holding reference on the /dev/fb0 and old fb_info
> > (from offb) while offb is being replaced by radeonfb (this is
> > why ->fb_destroy is never called). You may try checking with
> > lsof command to see what is holding /dev/fb0 open..
> 
> Right, I totally missed that X was running:
> 
> $ sudo lsof /dev/fb0
> COMMAND PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> Xorg    469 root  mem    CHR   29,0          6500 /dev/fb0
> Xorg    469 root   12u   CHR   29,0      0t0 6500 /dev/fb0
> 
> so I simply:
> 
> $ dmesg > before_xdm_stop
> $ sudo service xdm stop
> $ dmesg > after_xdm_stop
> $ sudo lsof /dev/fb0
> -> nothing
> 
> And I can verify in dmesg the call to put_fb_info:
> 
> $ diff -u before_xdm_stop after_xdm_stop
> @@ -1589,3 +1589,31 @@
>  [   19.650088] gem 0002:20:0f.0 eth0: Link is up at 100 Mbps, full-duplex
>  [   19.650211] gem 0002:20:0f.0 eth0: Pause is disabled
>  [   19.650245] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> +[   38.545478] WARNING: CPU: 0 PID: 468 at
> drivers/video/fbdev/core/fbmem.c:77 put_fb_info+0x18/0x68
> +[   38.545772] Modules linked in: uinput arc4 b43 bcma mac80211
> snd_aoa_codec_toonie snd_aoa_fabric_layout snd_aoa sha256_generic
> cfg80211 evdev sg snd_aoa_i2sbus snd_aoa_soundbus snd_pcm snd_timer
> snd soundcore ssb usb_storage autofs4 ext4 crc16 mbcache jbd2 fscrypto
> usbhid ohci_pci ehci_pci ohci_hcd ehci_hcd sungem firewire_ohci
> sungem_phy firewire_core crc_itu_t sr_mod usbcore cdrom sd_mod
> nls_base usb_common
> +[   38.546894] CPU: 0 PID: 468 Comm: Xorg Tainted: G        W
> 4.15.0+ #31
> +[   38.547103] NIP:  c03083ec LR: c0308bb0 CTR: c0308b48
> +[   38.547252] REGS: de661dc0 TRAP: 0700   Tainted: G        W
>  (4.15.0+)
> +[   38.547459] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22002222  XER: 20000000
> +[   38.547661]
> +               GPR00: c0308bb0 de661e70 ddd108c0 dee02c00 de0febe0
> de0febe8 00000001 ddd108c0
> +               GPR08: 00000000 c07b0a40 00000000 df501e10 22002428
> 007e0ff4 00000000 00000000
> +               GPR16: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> +               GPR24: ddd108c0 de0febe8 dede1c10 df30bbb0 df501e10
> dede1c10 dee02c10 dee02c00
> +[   38.548684] NIP [c03083ec] put_fb_info+0x18/0x68
> +[   38.548821] LR [c0308bb0] fb_release+0x68/0x80
> +[   38.548951] Call Trace:
> +[   38.549026] [de661e70] [dede1c10] 0xdede1c10 (unreliable)
> +[   38.549186] [de661e80] [c0308bb0] fb_release+0x68/0x80
> +[   38.549344] [de661e90] [c01c1198] __fput+0xac/0x20c
> +[   38.553889] [de661ec0] [c0062140] task_work_run+0xc0/0xe8
> +[   38.558437] [de661ee0] [c0048918] do_exit+0x268/0x964
> +[   38.562960] [de661f20] [c00490b4] do_group_exit+0x4c/0xb0
> +[   38.567400] [de661f30] [c0049138] __wake_up_parent+0x0/0x3c
> +[   38.571740] [de661f40] [c00151bc] ret_from_syscall+0x0/0x38
> +[   38.575965] --- interrupt: c01 at 0xb794a778
> +                   LR = 0xb794a748
> +[   38.584039] Instruction dump:
> +[   38.587878] 80010014 38210010 7c0803a6 4e800020 38600000 4e800020
> 7c0802a6 90010004
> +[   38.595537] 60000000 9421fff0 7c0802a6 90010014 <0fe00000>
> 7d401828 314affff 7d40192d
> +[   38.603316] ---[ end trace ee2e036160cab00c ]---
> 
> 
> Now with your WARN_ON patch and xdm service stopped, here is what I get:
> 
> https://people.debian.org/~malat/full_xdm_stop_offb_without.log
> 
> You'll see that modprobe to radeonfb still fails.
> 
> If you now compare with the patch (v4) applied (+ WARN_ON and xdm
> service stopped):
> 
> https://people.debian.org/~malat/full_xdm_stop_offb_with.log
> 
> You'll see a printk INFO for the call to offb_destroy:
> 
> ...
> [   48.025983]  MM calling offb_destroy
> ...
> 
> offb_destroy is called too late, which explains the failure for
> loading radeonfb without the patch.

offb_destroy() seems to be called in the right place but we still
need to kick out offb.  IOW your patch is needed but with xdm stop
sequence it should be possible to drop ifdef hacks.

PS switch to drm_fb_helper_remove_conflicting_framebuffers() in v4
should be reverted to just use remove_conflicting_framebuffers() as
the former one is for DRM subsystem only.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> -M
> 
> >> For reference, the patch I used is:
> >> https://github.com/malaterre/linux/commit/89fd7d4438c5200a1a4fcba1d60dd701fda4f40e.patch
> >>
> >>
> >> >> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >> >> >> Link: https://bugs.debian.org/826629#57
> >> >> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
> >> >> >> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> >> >> >> ---
> >> >> >> v2: Only fails when CONFIG_PCC is not set
> >> >> >> v3: Only fails when CONFIG_FB_OF is not set, CONFIG_PCC was too broad. Since the conflicts in region is due to OFfb explicitly refers to it.
> >> >> >
> >> >> > It seems that there may still be configurations when this is
> >> >> > incorrect -> when offb drives primary (non-radeon) card and radeonfb
> >> >> > drives secondary (radeon) card..
> >> >> >
> >> >> >>  drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
> >> >> >>  1 file changed, 26 insertions(+)
> >> >> >>
> >> >> >> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> >> >> >> index 4d77daeecf99..221879196531 100644
> >> >> >> --- a/drivers/video/fbdev/aty/radeon_base.c
> >> >> >> +++ b/drivers/video/fbdev/aty/radeon_base.c
> >> >> >> @@ -2259,6 +2259,22 @@ static const struct bin_attribute edid2_attr = {
> >> >> >>       .read   = radeon_show_edid2,
> >> >> >>  };
> >> >> >>
> >> >> >> +static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
> >> >> >> +{
> >> >> >> +     struct apertures_struct *ap;
> >> >> >> +
> >> >> >> +     ap = alloc_apertures(1);
> >> >> >> +     if (!ap)
> >> >> >> +             return -ENOMEM;
> >> >> >> +
> >> >> >> +     ap->ranges[0].base = pci_resource_start(pdev, 0);
> >> >> >> +     ap->ranges[0].size = pci_resource_len(pdev, 0);
> >> >> >> +
> >> >> >> +     remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
> >> >> >> +     kfree(ap);
> >> >> >> +
> >> >> >> +     return 0;
> >> >> >> +}
> >> >> >>
> >> >> >>  static int radeonfb_pci_register(struct pci_dev *pdev,
> >> >> >>                                const struct pci_device_id *ent)
> >> >> >> @@ -2312,19 +2328,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
> >> >> >>       rinfo->fb_base_phys = pci_resource_start (pdev, 0);
> >> >> >>       rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
> >> >> >>
> >> >> >> +     ret = radeon_kick_out_firmware_fb(pdev);
> >> >> >> +     if (ret)
> >> >> >> +             return ret;
> >> >> >> +
> >> >> >>       /* request the mem regions */
> >> >> >>       ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
> >> >> >>       if (ret < 0) {
> >> >> >> +#ifndef CONFIG_FB_OF
> >> >> >>               printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
> >> >> >>                       pci_name(rinfo->pdev));
> >> >> >>               goto err_release_fb;
> >> >> >> +#endif
> >> >> >>       }
> >> >> >>
> >> >> >>       ret = pci_request_region(pdev, 2, "radeonfb mmio");
> >> >> >>       if (ret < 0) {
> >> >> >> +#ifndef CONFIG_FB_OF
> >> >> >>               printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
> >> >> >>                       pci_name(rinfo->pdev));
> >> >> >>               goto err_release_pci0;
> >> >> >> +#endif
> >> >> >>       }
> >> >> >>
> >> >> >>       /* map the regions */
> >> >> >> @@ -2509,10 +2533,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
> >> >> >>       iounmap(rinfo->mmio_base);
> >> >> >>  err_release_pci2:
> >> >> >>       pci_release_region(pdev, 2);
> >> >> >> +#ifndef CONFIG_FB_OF
> >> >> >>  err_release_pci0:
> >> >> >>       pci_release_region(pdev, 0);
> >> >> >>  err_release_fb:
> >> >> >>          framebuffer_release(info);
> >> >> >> +#endif
> >> >> >>  err_disable:
> >> >> >>  err_out:
> >> >> >>       return ret;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
