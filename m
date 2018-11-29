Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69FAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5A22145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="Bu4ioNnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5A22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeK3Iz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:55:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36913 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeK3Iz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:55:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so1529949pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=fvwWf5g4+Jr/zoc59SP2EwVKDuABOW/dJu1M6vs4190=;
        b=Bu4ioNnAwINOPeN+bEHmxrxCbh2zHG+76YKSVE0cW92XzlNqeBsKUJd/oZ70cYWnaW
         AO7ZRudNEObRCATw2wZCj3BLdH3+Fr0DVM96lPOPuuhhHxpqn7aQG796tk3CO8zTMobb
         76x6kf2TDvwGDRLimaAKa6q+WPrNOcNtNRR6OWJGlQNUW+TEB7Y2cjvvBIDU/V5ABLFi
         coMQOb/t6gsUg++ofsXf0AIenwyCuVfM+TciI4+mTJQ3Wa9/N/YUfqoXBp2Fsn4HMguR
         +K+hmKv0I6GSIV0nJylG9u3ewKcT92lxFj7yikv7q8jcssERHqQynr3jQMrcAdS5t5+0
         Ewfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=fvwWf5g4+Jr/zoc59SP2EwVKDuABOW/dJu1M6vs4190=;
        b=PkrPqY+Xu/HEXBWwo3CdbwE16XuTF2OvqaAbIELANqP0rwDi87tCoh79iQK7RadJZH
         D6tVEHWZWan0LNBXqQ/HbsoVzFZclTG1H83T8zzJN+XeT3Fyjq2di94lRflH9c2LBCJJ
         6MoOe6L/rCWnPXAJynQYmQdBt+gpH+KIg7G/IWfjB2IssQiw7iMEp0lJ+TXlgWkEgMXy
         ZKSe5JfbE98KCbOw1Pk1nHEoYr2ZO/1U9gzQyQgHOPreUszYXyPb1D3A9SkpCy93o3D+
         99pRALNUTLj95uVk2AJ8rmzv/EW8eq23i5lvKeSvWY3G+H39DK4LWBg/S+tV/ch42yZi
         t/2Q==
X-Gm-Message-State: AA+aEWacEDChOoLEZW+vgaV6E3mfyFQ08sc6+KhHGfijYMlW0OrUnA+6
        vWleT3WpH/IssAX8VndZvtiWRdvm9U7Gng==
X-Google-Smtp-Source: AFSGD/V32CvY5TgLpuBB7b1K/3U1AFhpDM9hF6Pj+Tisgm2kFVL1cU+JIg5Km6FKh9F05n72nbEA1g==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr2702333pgb.242.1543528146618;
        Thu, 29 Nov 2018 13:49:06 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.44])
        by smtp.gmail.com with ESMTPSA id q75sm4920412pfa.38.2018.11.29.13.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:49:05 -0800 (PST)
Date:   Fri, 30 Nov 2018 03:19:48 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.4 00/86] 4.4.166-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <44D4B41B-1B62-471D-B37B-8F0C5C854154@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 November 2018 7:41:25 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E4=2E166 release=
=2E
>There are 86 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sat Dec  1 14:00:43 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E4=2E166-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E4=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
>
>-------------
>Pseudo-Shortlog of commits:
>
>Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>    Linux 4=2E4=2E166-rc1
>
>Thomas Zimmermann <tzimmermann@suse=2Ede>
>    drm/ast: Remove existing framebuffers before loading driver
>
>Janosch Frank <frankja@linux=2Eibm=2Ecom>
>    s390/mm: Check for valid vma before zapping in gmap_discard
>
>Salvatore Mesoraca <s=2Emesoraca16@gmail=2Ecom>
>    namei: allow restricted O_CREAT of FIFOs and regular files
>
>Steven Rostedt (VMware) <rostedt@goodmis=2Eorg>
>sched/core: Allow __sched_setscheduler() in interrupts when PI is not
>used
>
>Qu Wenruo <wqu@suse=2Ecom>
>    btrfs: Ensure btrfs_trim_fs can trim the whole filesystem
>
>Aaron Ma <aaron=2Ema@canonical=2Ecom>
>usb: xhci: fix uninitialized completion when USB3 port got wrong status
>
>Greg Kroah-Hartman <greg@kroah=2Ecom>
>    tty: wipe buffer if not echoing data
>
>Linus Torvalds <torvalds@linux-foundation=2Eorg>
>    tty: wipe buffer=2E
>
>Emmanuel Grumbach <emmanuel=2Egrumbach@intel=2Ecom>
>    iwlwifi: mvm: fix regulatory domain update when the firmware starts
>
>Mauricio Faria de Oliveira <mauricfo@linux=2Evnet=2Eibm=2Ecom>
>    scsi: qla2xxx: do not queue commands when unloading
>
>Subhash Jadavani <subhashj@codeaurora=2Eorg>
>    scsi: ufshcd: release resources if probe fails
>
>Subhash Jadavani <subhashj@codeaurora=2Eorg>
>    scsi: ufs: fix race between clock gating and devfreq scaling work
>
>Venkat Gopalakrishnan <venkatg@codeaurora=2Eorg>
>    scsi: ufshcd: Fix race between clk scaling and ungate work
>
>Yaniv Gardi <ygardi@codeaurora=2Eorg>
>    scsi: ufs: fix bugs related to null pointer access and array size
>
>Liping Zhang <zlpnobody@gmail=2Ecom>
>netfilter: nf_tables: fix oops when inserting an element into a verdict
>map
>
>Karthik D A <karthida@marvell=2Ecom>
>    mwifiex: fix p2p device doesn't find in scan problem
>
>Amitkumar Karwar <akarwar@marvell=2Ecom>
>    mwifiex: Fix NULL pointer dereference in skb_dequeue()
>
>Johannes Thumshirn <jthumshirn@suse=2Ede>
>    cw1200: Don't leak memory if krealloc failes
>
>Ramses Ram=C3=ADrez <ramzeto@gmail=2Ecom>
>    Input: xpad - add support for Xbox1 PDP Camo series gamepad
>
>Enno Boland <gottox@voidlinux=2Eeu>
>    Input: xpad - fix GPD Win 2 controller name
>
>Ethan Lee <flibitijibibo@gmail=2Ecom>
>    Input: xpad - add GPD Win 2 Controller USB IDs
>
>Marcus Folkesson <marcus=2Efolkesson@gmail=2Ecom>
>    Input: xpad - avoid using __set_bit() for capabilities
>
>Leo Sperling <leosperling97@gmail=2Ecom>
>    Input: xpad - fix some coding style issues
>
>Francis Therien <frtherien@gmail=2Ecom>
>    Input: xpad - add PDP device id 0x02a4
>
>Mark Furneaux <mark@furneaux=2Eca>
>    Input: xpad - add support for PDP Xbox One controllers
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - validate USB endpoint type during probe
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - fix PowerA init quirk for some gamepad models
>
>Arvind Yadav <arvind=2Eyadav=2Ecs@gmail=2Ecom>
>    Input: xpad - constify usb_device_id
>
>Benjamin Valentin <benpicco@googlemail=2Ecom>
>    Input: xpad - sync supported devices with XBCD
>
>Benjamin Valentin <benpicco@googlemail=2Ecom>
>    Input: xpad - sync supported devices with 360Controller
>
>Benjamin Valentin <benpicco@googlemail=2Ecom>
> Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer Sabertooth
>
>Benjamin Valentin <benpicco@googlemail=2Ecom>
>    Input: xpad - sync supported devices with xboxdrv
>
>Benjamin Valentin <benpicco@googlemail=2Ecom>
>    Input: xpad - sort supported devices by USB ID
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - support some quirky Xbox One pads
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - restore LED state after device resume
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - fix stuck mode button on Xbox One S pad
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - don't depend on endpoint order
>
>Pavel Rojtberg <rojtberg@gmail=2Ecom>
>    Input: xpad - simplify error condition in init_output
>
>Daniel Tobias <dan=2Eg=2Etob@gmail=2Ecom>
>   Input: xpad - move reporting xbox one home button to common function
>
>Daniel Tobias <dan=2Eg=2Etob@gmail=2Ecom>
>    Input: xpad - correctly sort vendor id's
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - fix Xbox One rumble stopping after 2=2E5 secs
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - add product ID for Xbox One S pad
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - power off wireless 360 controllers on suspend
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>    Input: xpad - fix rumble on Xbox One controllers with 2015 firmware
>
>Pavel Rojtberg <rojtberg@gmail=2Ecom>
>    Input: xpad - xbox one elite controller support
>
>Pavel Rojtberg <rojtberg@gmail=2Ecom>
>    Input: xpad - add more third-party controllers
>
>Cameron Gutman <aicommander@gmail=2Ecom>
>   Input: xpad - prevent spurious input from wired Xbox 360 controllers
>
>Silvan Jegen <s=2Ejegen@gmail=2Ecom>
>    Input: xpad - add Mad Catz FightStick TE 2 VID/PID
>
>Arnd Bergmann <arnd@arndb=2Ede>
>    Input: xpad - remove unused function
>
>Pavel Rojtberg <rojtberg@gmail=2Ecom>
>    Input: xpad - correct xbox one pad device name
>
>Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>    Input: xpad - use LED API when identifying wireless controllers
>
>Pavel Rojtberg <rojtberg@gmail=2Ecom>
>    Input: xpad - workaround dead irq_out after suspend/ resume
>
>Pierre-Loup A=2E Griffais <githubpublic@plagman=2Enet>
>    Input: xpad - update Xbox One Force Feedback Support
>
>Pierre-Loup A=2E Griffais <pgriffais@valvesoftware=2Ecom>
>    Input: xpad - handle "present" and "gone" correctly
>
>Clement Calmels <clement=2Ecalmels@free=2Efr>
>   Input: xpad - remove spurious events of wireless xpad 360 controller
>
>Vasanthakumar Thiagarajan <vthiagar@qti=2Equalcomm=2Ecom>
>    ath10k: fix kernel panic due to race in accessing arvif list
>
>Greg Hackmann <ghackmann@android=2Ecom>
>    arm64: remove no-op -p linker flag
>
>Andy Lutomirski <luto@kernel=2Eorg>
>    x86/entry/64: Remove %ebx handling from error_entry/exit
>
>Nicolas Iooss <nicolas=2Eiooss_linux@m4x=2Eorg>
>    x86/entry: spell EBX register correctly in documentation
>
>Johan Hovold <johan@kernel=2Eorg>
>    net: bcmgenet: fix OF child-node lookup
>
>Johan Hovold <johan@kernel=2Eorg>
>    NFC: nfcmrvl_uart: fix OF child-node lookup
>
>Johan Hovold <johan@kernel=2Eorg>
>    of: add helper to lookup compatible child node
>
>Yufen Yu <yuyufen@huawei=2Ecom>
>tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative
>offset
>
>Satheesh Rajendran <sathnaga@linux=2Evnet=2Eibm=2Ecom>
>    powerpc/numa: Suppress "VPHN is not supported" messages
>
>Prarit Bhargava <prarit@redhat=2Ecom>
>    kdb: Use strscpy with destination buffer size
>
>Trond Myklebust <trond=2Emyklebust@hammerspace=2Ecom>
>    SUNRPC: Fix a bogus get/put in generic_key_to_expire()
>
>Russell King <rmk+kernel@armlinux=2Eorg=2Euk>
>    ARM: make lookup_processor_type() non-__init
>
>Anson Huang <anson=2Ehuang@nxp=2Ecom>
>    cpufreq: imx6q: add return value check for voltage scale
>
>Scott Wood <oss@buserror=2Enet>
>    KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE
>
>Mathias Nyman <mathias=2Enyman@linux=2Eintel=2Ecom>
>usb: xhci: Prevent bus suspend if a port connect change or polling
>state is detected
>
>Erik Schmauss <erik=2Eschmauss@intel=2Ecom>
>ACPICA: AML interpreter: add region addresses in global list during
>initialization
>
>Marc Kleine-Budde <mkl@pengutronix=2Ede>
>can: dev: __can_get_echo_skb(): print error message, if trying to echo
>non existing skb
>
>Marc Kleine-Budde <mkl@pengutronix=2Ede>
>can: dev: __can_get_echo_skb(): Don't crash the kernel if
>can_priv::echo_skb is accessed out of bounds
>
>Marc Kleine-Budde <mkl@pengutronix=2Ede>
>can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame
>to access frame length
>
>Marc Kleine-Budde <mkl@pengutronix=2Ede>
>can: dev: can_get_echo_skb(): factor out non sending code to
>__can_get_echo_skb()
>
>Y=2EC=2E Chen <yc_chen@aspeedtech=2Ecom>
>    drm/ast: fixed cursor may disappear sometimes
>
>Y=2EC=2E Chen <yc_chen@aspeedtech=2Ecom>
>    drm/ast: change resolution may cause screen blurred
>
>Eric Dumazet <edumazet@google=2Ecom>
>    llc: do not use sk_eat_skb()
>
>Andrew Price <anprice@redhat=2Ecom>
>    gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd
>
>Xin Long <lucien=2Exin@gmail=2Ecom>
>sctp: clear the transport of some out_chunk_list chunks in
>sctp_assoc_rm_peer
>
>Tetsuo Handa <penguin-kernel@I-love=2ESAKURA=2Ene=2Ejp>
>    bfs: add sanity check at bfs_fill_super()
>
>Dominique Martinet <dominique=2Emartinet@cea=2Efr>
>    v9fs_dir_readdir: fix double-free on p9stat_read error
>
>Emmanuel Grumbach <emmanuel=2Egrumbach@intel=2Ecom>
>    iwlwifi: mvm: support sta_statistics() even on older firmware
>
>Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>    MAINTAINERS: Add Sasha as a stable branch maintainer
>
>Aaron Ma <aaron=2Ema@canonical=2Ecom>
>    usb: xhci: fix timeout for transition from RExit to U0
>
>Dennis Wassenberg <dennis=2Ewassenberg@secunet=2Ecom>
>    usb: core: Fix hub port connection events lost
>
>
>-------------
>
>Diffstat:
>
> Documentation/sysctl/fs=2Etxt                  |  36 ++
> MAINTAINERS                                  |   1 +
> Makefile                                     |   4 +-
> arch/arm/kernel/head-common=2ES                |   6 +-
> arch/arm64/Makefile                          |   2 +-
> arch/powerpc/kvm/trace=2Eh                     |   8 +-
> arch/powerpc/kvm/trace_booke=2Eh               |   9 +-
> arch/powerpc/kvm/trace_hv=2Eh                  |   9 +-
> arch/powerpc/kvm/trace_pr=2Eh                  |   9 +-
> arch/powerpc/mm/numa=2Ec                       |   2 +-
> arch/s390/mm/pgtable=2Ec                       |   2 +
> arch/x86/entry/entry_64=2ES                    |  20 +-
> drivers/acpi/acpica/dsopcode=2Ec               |   4 +
> drivers/cpufreq/imx6q-cpufreq=2Ec              |   7 +-
> drivers/gpu/drm/ast/ast_drv=2Ec                |  21 +
> drivers/gpu/drm/ast/ast_mode=2Ec               |   3 +-
>drivers/input/joystick/xpad=2Ec                | 810
>+++++++++++++++++++++------
> drivers/net/can/dev=2Ec                        |  48 +-
> drivers/net/ethernet/broadcom/genet/bcmmii=2Ec |   2 +-
> drivers/net/wireless/ath/ath10k/mac=2Ec        |   6 +
> drivers/net/wireless/cw1200/wsm=2Ec            |  16 +-
> drivers/net/wireless/iwlwifi/mvm/mac80211=2Ec  |  12 +-
> drivers/net/wireless/iwlwifi/mvm/nvm=2Ec       |   5 +-
> drivers/net/wireless/mwifiex/cfg80211=2Ec      |  10 +-
> drivers/net/wireless/mwifiex/wmm=2Ec           |  12 +-
> drivers/nfc/nfcmrvl/uart=2Ec                   |   5 +-
> drivers/of/base=2Ec                            |  25 +
> drivers/scsi/qla2xxx/qla_os=2Ec                |   5 +
> drivers/scsi/ufs/ufs=2Eh                       |   3 +-
> drivers/scsi/ufs/ufshcd-pci=2Ec                |   2 +
> drivers/scsi/ufs/ufshcd-pltfrm=2Ec             |   5 +-
> drivers/scsi/ufs/ufshcd=2Ec                    |  75 ++-
> drivers/tty/n_tty=2Ec                          |  19 +-
> drivers/tty/tty_buffer=2Ec                     |   2 +
> drivers/usb/core/hub=2Ec                       |   4 +-
> drivers/usb/host/xhci-hub=2Ec                  |  66 ++-
> drivers/usb/host/xhci-ring=2Ec                 |   2 +-
> drivers/usb/host/xhci=2Eh                      |   2 +-
> fs/9p/vfs_dir=2Ec                              |  11 -
> fs/bfs/inode=2Ec                               |   9 +-
> fs/btrfs/extent-tree=2Ec                       |  10 +-
> fs/btrfs/ioctl=2Ec                             |  11 +-
> fs/gfs2/ops_fstype=2Ec                         |   2 +-
> fs/namei=2Ec                                   |  53 +-
> include/linux/can/dev=2Eh                      |   1 +
> include/linux/fs=2Eh                           |   2 +
> include/linux/of=2Eh                           |   8 +
> kernel/debug/kdb/kdb_io=2Ec                    |  15 +-
> kernel/debug/kdb/kdb_private=2Eh               |   2 +-
> kernel/debug/kdb/kdb_support=2Ec               |  10 +-
> kernel/sched/core=2Ec                          |   4 +-
> kernel/sysctl=2Ec                              |  18 +
> mm/shmem=2Ec                                   |   4 +-
> net/llc/af_llc=2Ec                             |  11 +-
> net/netfilter/nf_tables_api=2Ec                |   1 +
> net/sctp/associola=2Ec                         |  10 +-
> net/sunrpc/auth_generic=2Ec                    |   8 +-
> 57 files changed, 1126 insertions(+), 343 deletions(-)

Built and booted on the Pixel 2, no dmesg regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
