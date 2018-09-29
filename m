Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 23:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777E0206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 23:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szwYnBi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777E0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeI3GJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 02:09:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38339 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeI3GJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 02:09:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so8396909oif.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odLMkhQWTNARMM6YawWc9Ly5igLlSrf3/+eWxTXNQp4=;
        b=szwYnBi899WIyvDFvM9QoChm0MyYf6jLJvj20lSEkSN4CBdhk0D63AqeloyIutE3/2
         twIw8p7OmStA4tIrtgVnw7brwjt/NTQ8iBC8qeKk/xIllGoWJkVw1zsPcPbZ0sYxF2BQ
         DqBht9GdHDQiF72lt7ru6eKgQRxN8MgnRFVfP/lGvNPXlwIUdb+4OwB9CfkERwqJoQoF
         RhmCkzFQHmfro191ofVkb+aA00nHh2SgY9w8LUDrwKn0tk3aiZSIG55iN9iWoVfjiEwk
         EWGdF4cd2oR3+OotWx4Irk1KR4pJe6j7+n7Gp9PM2sO2FmSxlHb1udxuCK0954coDrXk
         VgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odLMkhQWTNARMM6YawWc9Ly5igLlSrf3/+eWxTXNQp4=;
        b=D4DDgtcF31IzjPSUsPtuDaELXiRgnMk9QsfaEp4ylYujloisbhHwTlmSSttIfIPzDh
         M36M9sjNR36ycahCDv1Az2NlKECpDa/W1a8EFfjaIjkTz6N6mA9V3qFjVdTMuuaV9Bcs
         evrG7knDS4oJak56rML4PtxMS38ON5iFC798TK278mm2cyTw7cO/0zqyhrmuz7/bv9FX
         KVs3obmKOl8SulaT1LYhaH2PhLHX2c8T/YqbdwZtuhBi7t6O9dNalidfIkJ9emMtgNRy
         EsDw3rragGosqhYcRqOF3n20ZFsE9SXNQeYn9eH3zQ0I1iMs2qIdrWpTB6RiZaQ1eaDu
         dJxA==
X-Gm-Message-State: ABuFfoivUAQqRMeP08s5F5m9YyoSz1rKN/dxBTJauoEhAIijCaFR3Ht4
        VUV+fP9t2EHnJvCOWy0VOwwHLvuXe7V3rcSKMlVEtg==
X-Google-Smtp-Source: ACcGV63ndwuvC3PxFXMaVT2cjwj2VwCqEVPxNciBLVUREp11qqi7lraWMRnEn9uZuKMjdRO89BaUzXGgnCSZ7cAfrV0=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr2126988oif.177.1538264316899;
 Sat, 29 Sep 2018 16:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180929014926.227002-1-jannh@google.com> <201809300728.3lyFpriz%fengguang.wu@intel.com>
In-Reply-To: <201809300728.3lyFpriz%fengguang.wu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 30 Sep 2018 01:38:10 +0200
Message-ID: <CAG48ez16J=GaemUbXQm71oUeXjnJy6m71gXC7jeAt8sCmA6ZrQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: don't try to replace stale label in ptraceme check
To:     lkp@intel.com
Cc:     kbuild-all@01.org, John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>, rong.a.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 1:24 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Jann,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on security/next]
> [also build test WARNING on v4.19-rc5 next-20180928]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

This looks to me as if something went very wrong in the 0day test bot;
the warnings below don't have anything to do with my patch, as far as
I can tell, and the "TO:" and "CC:" lines at the bottom of this
message are also entirely unrelated.

> url:    https://github.com/0day-ci/linux/commits/Jann-Horn/apparmor-don-t-try-to-replace-stale-label-in-ptraceme-check/20180929-101346
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All warnings (new ones prefixed by >>):
>
>    drivers/net/wireless/marvell/mwifiex/usb.c:885:41: warning: incorrect type in assignment (different base types)
>    drivers/net/wireless/marvell/mwifiex/usb.c:885:41:    expected unsigned short [unsigned] [short] [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:885:41:    got restricted __le16 [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:886:45: warning: incorrect type in assignment (different base types)
>    drivers/net/wireless/marvell/mwifiex/usb.c:886:45:    expected unsigned short [unsigned] [short] [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:886:45:    got restricted __le16 [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:891:41: warning: incorrect type in assignment (different base types)
>    drivers/net/wireless/marvell/mwifiex/usb.c:891:41:    expected unsigned short [unsigned] [short] [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:891:41:    got restricted __le16 [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:892:45: warning: incorrect type in assignment (different base types)
>    drivers/net/wireless/marvell/mwifiex/usb.c:892:45:    expected unsigned short [unsigned] [short] [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:892:45:    got restricted __le16 [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:1071:37: warning: incorrect type in assignment (different base types)
>    drivers/net/wireless/marvell/mwifiex/usb.c:1071:37:    expected unsigned short [unsigned] [short] [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:1071:37:    got restricted __le16 [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:1073:33: warning: incorrect type in assignment (different base types)
>    drivers/net/wireless/marvell/mwifiex/usb.c:1073:33:    expected unsigned short [unsigned] [short] [usertype] <noident>
>    drivers/net/wireless/marvell/mwifiex/usb.c:1073:33:    got restricted __le16 [usertype] <noident>
> >> drivers/net/wireless/marvell/mwifiex/usb.c:1099:13: warning: context imbalance in 'mwifiex_usb_tx_aggr_tmo' - wrong count at exit
> --
> >> drivers/staging/android/ion/ion_cma_heap.c:109:5: warning: symbol '__ion_add_cma_heaps' was not declared. Should it be static?
> --
> >> drivers/md/dm.c:1526:28: warning: incorrect type in argument 2 (different base types)
>    drivers/md/dm.c:1526:28:    expected restricted blk_status_t [usertype] error
>    drivers/md/dm.c:1526:28:    got int [signed] [assigned] error
>    drivers/md/dm.c:931:25: warning: context imbalance in 'dm_dax_get_live_target' - wrong count at exit
>    drivers/md/dm.c:971:9: warning: context imbalance in 'dm_dax_direct_access' - unexpected unlock
>    drivers/md/dm.c:995:9: warning: context imbalance in 'dm_dax_copy_from_iter' - unexpected unlock
> >> drivers/md/dm.c:1015:9: warning: context imbalance in 'dm_dax_flush' - unexpected unlock
> --
> >> drivers/md/dm-bufio.c:1323:11: warning: incorrect type in assignment (different base types)
>    drivers/md/dm-bufio.c:1323:11:    expected restricted blk_status_t [usertype] a
>    drivers/md/dm-bufio.c:1323:11:    got int [signed] [assigned] __ret
> >> drivers/md/dm-bufio.c:1326:24: warning: incorrect type in return expression (different base types)
>    drivers/md/dm-bufio.c:1326:24:    expected int
>    drivers/md/dm-bufio.c:1326:24:    got restricted blk_status_t [usertype] a
> --
> >> drivers/gpu/drm/drm_dp_mst_topology.c:3020:6: warning: symbol 'drm_dp_mst_duplicate_state' was not declared. Should it be static?
> >> drivers/gpu/drm/drm_dp_mst_topology.c:3034:6: warning: symbol 'drm_dp_mst_swap_state' was not declared. Should it be static?
> >> drivers/gpu/drm/drm_dp_mst_topology.c:3046:6: warning: symbol 'drm_dp_mst_destroy_state' was not declared. Should it be static?
> --
> >> sound/soc/codecs/hdmi-codec.c:70:33: warning: symbol 'hdmi_codec_stereo_chmaps' was not declared. Should it be static?
> >> sound/soc/codecs/hdmi-codec.c:77:33: warning: symbol 'hdmi_codec_8ch_chmaps' was not declared. Should it be static?
> >> sound/soc/codecs/hdmi-codec.c:343:6: warning: symbol 'hdmi_codec_eld_chmap' was not declared. Should it be static?
> --
> >> sound/soc/codecs/zx_aud96p22.c:385:27: warning: symbol 'aud96p22_dt_ids' was not declared. Should it be static?
> --
> >> drivers/staging/typec/tcpm.c:1019:49: warning: incorrect type in assignment (different base types)
>    drivers/staging/typec/tcpm.c:1019:49:    expected unsigned int [unsigned] [usertype] <noident>
>    drivers/staging/typec/tcpm.c:1019:49:    got restricted __le32 [usertype] <noident>
> --
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:465:36: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:466:41: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:478:17: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:480:17: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:492:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:492:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:492:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:499:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:499:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:499:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:506:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:506:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:506:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:513:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:513:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:513:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:521:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:521:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:521:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:521:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:521:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:521:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:527:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:527:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:527:25: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:536:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:536:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:536:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:536:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:536:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:536:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:541:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:541:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:541:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:607:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:607:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:607:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:608:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:608:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:608:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:610:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:610:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:610:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:611:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:611:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:611:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:612:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:612:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:612:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:617:49: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:617:49:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:617:49:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:619:49: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:619:49:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:619:49:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:622:57: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:622:57:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:622:57:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:629:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:629:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:629:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:630:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:630:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:630:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:632:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:632:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:632:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:633:25: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:633:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:633:25:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:702:34: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:703:40: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:704:38: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:710:34: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:711:40: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:712:38: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:718:34: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:719:40: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:720:38: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:726:34: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:727:40: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:728:38: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:734:34: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:735:40: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:736:38: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:740:48: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:740:48:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:740:48:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:905:18: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:906:19: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2028:6: warning: symbol 'gfx_v9_0_rlc_stop' was not declared. Should it be static?
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2092:28: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2093:19: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2185:18: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2186:19: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2195:18: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2196:19: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2205:18: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2206:19: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2374:18: warning: cast to restricted __le32
> >> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:4159:27: warning: symbol 'gfx_v9_0_ip_funcs' was not declared. Should it be static?
>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:4445:38: warning: symbol 'gfx_v9_0_ip_block' was not declared. Should it be static?
> --
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:199:53: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:200:58: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:212:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:212:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:212:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:768:27: warning: cast to restricted __le32
> >> drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:770:33: warning: cast to restricted __le16
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:771:33: warning: cast to restricted __le16
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:775:39: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:782:33: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:863:28: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:863:28:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:863:28:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:881:23: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:925:28: warning: incorrect type in assignment (different base types)
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:925:28:    expected unsigned int volatile [unsigned] [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:925:28:    got restricted __le32 [usertype] <noident>
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:957:15: warning: cast to restricted __le32
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:1545:27: warning: symbol 'sdma_v4_0_ip_funcs' was not declared. Should it be static?
>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:1702:38: warning: symbol 'sdma_v4_0_ip_block' was not declared. Should it be static?
> --
> >> drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c:252:24: warning: symbol 'pctl0_data' was not declared. Should it be static?
> >> drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c:277:24: warning: symbol 'pctl1_data' was not declared. Should it be static?
> ..
>
> vim +/mwifiex_usb_tx_aggr_tmo +1099 drivers/net/wireless/marvell/mwifiex/usb.c
>
> c5994293 Xinming Hu 2017-05-23  1098
> a2ca85ad Xinming Hu 2017-05-23 @1099  static void mwifiex_usb_tx_aggr_tmo(unsigned long context)
> a2ca85ad Xinming Hu 2017-05-23  1100  {
> a2ca85ad Xinming Hu 2017-05-23  1101    struct urb_context *urb_cnxt = NULL;
> a2ca85ad Xinming Hu 2017-05-23  1102    struct sk_buff *skb_send = NULL;
> a2ca85ad Xinming Hu 2017-05-23  1103    struct tx_aggr_tmr_cnxt *timer_context =
> a2ca85ad Xinming Hu 2017-05-23  1104            (struct tx_aggr_tmr_cnxt *)context;
> a2ca85ad Xinming Hu 2017-05-23  1105    struct mwifiex_adapter *adapter = timer_context->adapter;
> a2ca85ad Xinming Hu 2017-05-23  1106    struct usb_tx_data_port *port = timer_context->port;
> a2ca85ad Xinming Hu 2017-05-23  1107    unsigned long flags;
> a2ca85ad Xinming Hu 2017-05-23  1108    int err = 0;
> a2ca85ad Xinming Hu 2017-05-23  1109
> a2ca85ad Xinming Hu 2017-05-23  1110    spin_lock_irqsave(&port->tx_aggr_lock, flags);
> a2ca85ad Xinming Hu 2017-05-23  1111    err = mwifiex_usb_prepare_tx_aggr_skb(adapter, port, &skb_send);
> a2ca85ad Xinming Hu 2017-05-23  1112    if (err) {
> a2ca85ad Xinming Hu 2017-05-23  1113            mwifiex_dbg(adapter, ERROR,
> a2ca85ad Xinming Hu 2017-05-23  1114                        "prepare tx aggr skb failed, err=%d\n", err);
> a2ca85ad Xinming Hu 2017-05-23  1115            return;
> a2ca85ad Xinming Hu 2017-05-23  1116    }
> a2ca85ad Xinming Hu 2017-05-23  1117
> a2ca85ad Xinming Hu 2017-05-23  1118    if (atomic_read(&port->tx_data_urb_pending) >=
> a2ca85ad Xinming Hu 2017-05-23  1119        MWIFIEX_TX_DATA_URB) {
> a2ca85ad Xinming Hu 2017-05-23  1120            port->block_status = true;
> a2ca85ad Xinming Hu 2017-05-23  1121            adapter->data_sent =
> a2ca85ad Xinming Hu 2017-05-23  1122                    mwifiex_usb_data_sent(adapter);
> a2ca85ad Xinming Hu 2017-05-23  1123            err = -1;
> a2ca85ad Xinming Hu 2017-05-23  1124            goto done;
> a2ca85ad Xinming Hu 2017-05-23  1125    }
> a2ca85ad Xinming Hu 2017-05-23  1126
> a2ca85ad Xinming Hu 2017-05-23  1127    if (port->tx_data_ix >= MWIFIEX_TX_DATA_URB)
> a2ca85ad Xinming Hu 2017-05-23  1128            port->tx_data_ix = 0;
> a2ca85ad Xinming Hu 2017-05-23  1129
> a2ca85ad Xinming Hu 2017-05-23  1130    urb_cnxt = &port->tx_data_list[port->tx_data_ix++];
> a2ca85ad Xinming Hu 2017-05-23  1131    err = mwifiex_usb_construct_send_urb(adapter, port, port->tx_data_ep,
> a2ca85ad Xinming Hu 2017-05-23  1132                                         urb_cnxt, skb_send);
> a2ca85ad Xinming Hu 2017-05-23  1133  done:
> a2ca85ad Xinming Hu 2017-05-23  1134    if (err == -1)
> a2ca85ad Xinming Hu 2017-05-23  1135            mwifiex_write_data_complete(adapter, skb_send, 0, -1);
> a2ca85ad Xinming Hu 2017-05-23  1136    spin_unlock_irqrestore(&port->tx_aggr_lock, flags);
> a2ca85ad Xinming Hu 2017-05-23  1137  }
> a2ca85ad Xinming Hu 2017-05-23  1138
>
> :::::: The code at line 1099 was first introduced by commit
> :::::: a2ca85ad721de50b90d50f3a11b67c4776a1236d mwifiex: usb: add timer to flush aggregation packets
>
> :::::: TO: Xinming Hu <huxm@marvell.com>
> :::::: CC: Kalle Valo <kvalo@codeaurora.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
