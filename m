Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521228983; cv=none;
        d=google.com; s=arc-20160816;
        b=FK0f0f38FNNfbJViSV8WYGRRbMbPA6pg97sYKBBRzgd4z+8aSp2ArPUsJypAF46edC
         HeyK53dkbRCUBZWpu8InWh8aVYMsM7xIuYRfQ2iPDzRLAIkwDeAkw84iW7BKbdvZrzhq
         JZgetqjEcPcGIuBVauDKtBLHdYDKYqgfoeVODZd3rkJ2dQTD0a/u0YA6oM97xGAX7HAM
         ztDYyyQKjLOM+NHnsLszQgCiNqWMjnPsACRLgLKfF2TWX1JeseXufCP/0uaAlXn4yfj5
         IZ5gYhTr4g1p6RUnp5whnYDw11Lm9MDOOA5/z8OXvJUYMFPTO8s60Ec9PZoVQVOe/Zbu
         Mfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=PBwotVWOtJATM0MA1GOib44e+f40aIgciVKRMFgZuGQ=;
        b=L6Hk+FX5249KmSbM2FH0GS+0mdzBWatwyX1yqZ5SpB2QJjAUUEj0oB9LM1+p3LHJxI
         cXuM2fBJEPx2dq9U/+peTOaqOXaU8kP/tHbzxUCS5Dysh1cdW3knRB5lY0YSthV0ppJk
         nKTEjBKNzON7xKmmjQ7A2bnr0TlN6pM+vmLigCrYqRcLOjfeNA4e8C/ZHmBdsLjTdR1n
         GzKH8eMlFtAiZvGAaZReBKIxu+ZLAeEV3C3xoT+IWuVaJC8GCnGEFH2aXEEQ6ug68Cbr
         x++OncN5Y5PUhzjYX/pGJ0srlVGwEHk+1G0E0Q9tsYULJztc/JCsfknHkbtuNLkmXdou
         8qKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OIukIGEq;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OIukIGEq;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvJc0qjC7Q+s0etJNK57Vcu6Z+iVmdmhRAh/9sOjyyIfyOwvyepOo3iXWihtnVTqU6sxKDg/0wq/jo0xTq7H7k=
MIME-Version: 1.0
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 17 Mar 2018 01:06:21 +0530
Message-ID: <CA+G9fYs81eFKnN9411PQtkHsvtVRLWhPH_Txx7PCkVH=0sutvg@mail.gmail.com>
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, Shuah Khan <shuahkh@osg.samsung.com>,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	linux- stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>,
	peter.ujfalusi@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109395590505536?=
X-GMAIL-MSGID: =?utf-8?q?1595124203446757570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16 March 2018 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.15.11 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.15.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.15.11-rc1
>
> Anusha Srivatsa <anusha.srivatsa@intel.com>
>     drm/i915/glk: Disable Guc and HuC on GLK
>
> Sinan Kaya <okaya@codeaurora.org>
>     dmaengine: qcom_hidma: check pending interrupts
>
> Arnd Bergmann <arnd@arndb.de>
>     IB/mlx5: revisit -Wmaybe-uninitialized warning
>
> Mimi Zohar <zohar@linux.vnet.ibm.com>
>     ima: relax requiring a file signature for new files with zero length
>
> Davidlohr Bueso <dave@stgolabs.net>
>     locking/locktorture: Fix num reader/writer corner cases
>
> SeongJae Park <sj38.park@gmail.com>
>     rcutorture/configinit: Fix build directory error message
>
> Mahesh Bandewar <maheshb@google.com>
>     ipvlan: add L2 check for packets arriving via virtual devices
>
> Christophe Leroy <christophe.leroy@c-s.fr>
>     Fix misannotated out-of-line _copy_to_user()
>
> Adrian Hunter <adrian.hunter@intel.com>
>     mmc: mmc_test: Ensure command queue is disabled for testing
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     ASoC: nuc900: Fix a loop timeout test
>
> Horia Geant=C4=83 <horia.geanta@nxp.com>
>     crypto: caam/qi - use correct print specifier for size_t
>
> Luca Coelho <luciano.coelho@intel.com>
>     mac80211: remove BUG() when interface type is invalid
>
> Adiel Aloni <adiel.aloni@intel.com>
>     mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED
>
> Chris Wilson <chris@chris-wilson.co.uk>
>     agp/intel: Flush all chipset writes after updating the GGTT
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset
>
> Nicholas Piggin <npiggin@gmail.com>
>     powerpc/64: Don't trace irqs-off at interrupt return to soft-disabled=
 context
>
> Josh Poimboeuf <jpoimboe@redhat.com>
>     powerpc/modules: Don't try to restore r2 after a sibling call
>
> Yong Zhao <yong.zhao@amd.com>
>     drm/amdkfd: Fix memory leaks in kfd topology
>
> Stephen Hemminger <stephen@networkplumber.org>
>     veth: set peer GSO values
>
> John Fastabend <john.fastabend@gmail.com>
>     net: sched: drop qdisc_reset from dev_graft_qdisc
>
> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>     virtio_net: Disable interrupts if napi_complete_done rescheduled napi
>
> Gustavo A. R. Silva <garsilva@embeddedor.com>
>     media: davinci: vpif_capture: add NULL check on devm_kzalloc return v=
alue
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     media: cpia2: Fix a couple off by one bugs
>
> Heinz Mauelshagen <heinzm@redhat.com>
>     dm raid: fix raid set size revalidation
>
> Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>     media: vsp1: Prevent suspending and resuming DRM pipelines
>
> Ioana Radulescu <ruxandra.radulescu@nxp.com>
>     staging: fsl-dpaa2/eth: Fix access to FAS field
>
> Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>     clk: renesas: r8a77970: Add LVDS clock
>
> Xose Vazquez Perez <xose.vazquez@gmail.com>
>     scsi: dh: add new rdac devices
>
> Xose Vazquez Perez <xose.vazquez@gmail.com>
>     scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
>
> Bart Van Assche <bart.vanassche@wdc.com>
>     scsi: core: scsi_get_device_flags_keyed(): Always return device flags
>
> Michael Chan <michael.chan@broadcom.com>
>     bnxt_en: Don't print "Link speed -1 no longer supported" messages.
>
> Tobias Jordan <Tobias.Jordan@elektrobit.com>
>     spi: sun6i: disable/unprepare clocks on remove
>
> Julien BOIBESSOT <julien.boibessot@armadeus.com>
>     tools/usbip: fixes build with musl libc toolchain
>
> Ben Greear <greearb@candelatech.com>
>     ath10k: fix invalid STS_CAP_OFFSET_MASK
>
> Limin Zhu <liminzhu@marvell.com>
>     mwifiex: cfg80211: do not change virtual interface during scan proces=
sing
>
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>     clk: qcom: msm8916: fix mnd_width for codec_digcodec
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     bnxt_en: Uninitialized variable in bnxt_tc_parse_actions()
>
> Christian K=C3=B6nig <christian.koenig@amd.com>
>     drm/amdgpu: fix amdgpu_sync_resv v2
>
> Monk Liu <Monk.Liu@amd.com>
>     drm/amdgpu:fix virtual dce bug
>
> Sara Sharon <sara.sharon@intel.com>
>     iwlwifi: mvm: avoid dumping assert log when device is stopped
>
> Thomas Richter <tmricht@linux.vnet.ibm.com>
>     perf annotate: Fix objdump comment parsing for Intel mov dissassembly
>
> Thomas Richter <tmricht@linux.vnet.ibm.com>
>     perf annotate: Fix unnecessary memory allocation for s390x
>
> Takeshi Kihara <takeshi.kihara.df@renesas.com>
>     pinctrl: sh-pfc: r8a7795-es1: Fix MOD_SEL1 bit[25:24] to 0x3 when usi=
ng STP_ISEN_1_D
>
> Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>     pinctrl: sh-pfc: r8a7791: Add can_clk function
>
> Jernej Skrabec <jernej.skrabec@siol.net>
>     drm/sun4i: Fix format mask in DE2 driver
>
> Axel Lin <axel.lin@ingics.com>
>     pwm: stmpe: Fix wrong register offset for hwpwm=3D2 case
>
> Li Dongyang <dongyang.li@anu.edu.au>
>     scsi: ses: don't ask for diagnostic pages repeatedly during probe
>
> James Smart <jsmart2021@gmail.com>
>     scsi: lpfc: Fix crash during driver unload with running nvme traffic
>
> Monk Liu <Monk.Liu@amd.com>
>     drm/amdgpu:fix random missing of FLR NOTIFY
>
> Brijesh Singh <brijesh.singh@amd.com>
>     KVM: X86: Restart the guest when insn_len is zero and SEV is enabled
>
> Peter Ujfalusi <peter.ujfalusi@ti.com>
>     dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_fr=
ee
>
> Peter Ujfalusi <peter.ujfalusi@ti.com>
>     dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_f=
ree

arm and arm64 build broken due to this patch for 4.15 and 4.14

drivers/dma/bcm2835-dma.c:815:3: error: implicit declaration of function
'vchan_terminate_vdesc' [-Werror=3Dimplicit-function-declaration]
   vchan_terminate_vdesc(&c->desc->vd);
   ^
cc1: some warnings being treated as errors
