Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4983BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A95261D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WON6BLyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A95261D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934694AbeF0OgM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:36:12 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50965 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932907AbeF0OgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:36:10 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7CACA24E0C4E;
        Wed, 27 Jun 2018 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530110169; bh=ygQ2cDJwumCdT+iRwiRBE+JOcErPlCWtr+EMW8T4GIE=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=WON6BLypeUsEILH+V6NzcTPw80zNf8uzuVYEJ49qx2WMXpmFPvkwXRRfhKC7o70PU
         XxOOr2zTih3GzfLlRXWGhKJTEcqEbSOLZJ5G3/P8LRlTPrbJX8KIUjjjmOxjuTRTsR
         F9FOKM1FPDkEDASmulHrOq6qdzxI0XvLhQgqip5kEmcF2XMenK6Rqwbkb9Tyyh0Kh2
         zqJX0aruSlk2xsalydtD6+l+DZIlNV1Ja+hcneJuW5l5PUEFV1a3mbod+Ii05SkR+6
         ZFifdMtZerQ/B614YfTYuSulRYiXFjyEiClOOCk3FdNbk/Hq3c0ggzyNlPJKSjIwt/
         RZFJi/qsvEvOA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1C1A83E04;
        Wed, 27 Jun 2018 07:36:09 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 27 Jun 2018 07:36:08 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 27 Jun 2018 16:36:06 +0200
Received: from [10.0.2.15] (10.107.19.20) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Jun
 2018 16:36:06 +0200
Subject: Re: [PATCH net-next] net: stmmac: Add support for CBS QDISC
To:     kbuild test robot <lkp@intel.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <daa3124702201f0d1c30da51f2a90cf432e39ba3.1530103308.git.joabreu@synopsys.com>
 <201806272221.VPR2vJhr%fengguang.wu@intel.com>
 <3780919b-c9ce-2ab6-be3a-376752c608ac@synopsys.com>
CC:     <kbuild-all@01.org>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <08928bbb-9c33-8e55-dddf-a6a214c440e6@synopsys.com>
Date:   Wed, 27 Jun 2018 15:36:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3780919b-c9ce-2ab6-be3a-376752c608ac@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.20]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ LKML because I just noticed this is using generic headers.

On 27-06-2018 15:32, Jose Abreu wrote:
> ++ SH Maintainers
> ++ SH ML
>
> Hi SH Maintainers,
>
> On 27-06-2018 15:15, kbuild test robot wrote:
>> Hi Jose,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on net-next/master]
>>
>> url:    https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux_commits_Jose-2DAbreu_net-2Dstmmac-2DAdd-2Dsupport-2Dfor-2DCBS-2DQDISC_20180627-2D214704&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=YIae3rrFzqYg_5b4eVIAXuyvT_EV0vKACS25rJugux8&s=qW5_vbinGt0OnyDfQ2wtKdb2ZGzCcLwq6Fmlaki61xw&e=
>> config: sh-allyesconfig (attached as .config)
>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://urldefense.proofpoint.com/v2/url?u=https-3A__raw.githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=YIae3rrFzqYg_5b4eVIAXuyvT_EV0vKACS25rJugux8&s=4nNar4fgVZq0LjrPKIZP30nxVUY4yeu5QeyKbmlsu8A&e= -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.2.0 make.cross ARCH=sh 
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from ./arch/sh/include/generated/asm/div64.h:1:0,
>>                     from include/linux/kernel.h:174,
>>                     from include/linux/list.h:9,
>>                     from include/linux/timer.h:5,
>>                     from include/linux/workqueue.h:9,
>>                     from include/net/pkt_cls.h:6,
>>                     from drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c:7:
>>    drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c: In function 'tc_setup_cbs':
>>    include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
>>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>>                                ^
>>>> drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c:325:2: note: in expansion of macro 'do_div'
>>      do_div(value, speed_div);
>>      ^~~~~~
>>    include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
>>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
> I'm not seeing the reason for this warning as I'm using a 64 bit
> var. I guess the warning is appearing only because its signed
> [see source bellow]. Is this not supported?
>
> Thanks and Best Regards,
> Jose Miguel Abreu
>
>>                                ^
>>    drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c:329:2: note: in expansion of macro 'do_div'
>>      do_div(value, speed_div);
>>      ^~~~~~
>>
>> vim +/do_div +325 drivers/net//ethernet/stmicro/stmmac/stmmac_tc.c
>>
>>    291	
>>    292	static int tc_setup_cbs(struct stmmac_priv *priv,
>>    293				struct tc_cbs_qopt_offload *qopt)
>>    294	{
>>    295		u32 tx_queues_count = priv->plat->tx_queues_to_use;
>>    296		u32 queue = qopt->queue;
>>    297		u32 ptr, speed_div;
>>    298		u32 mode_to_use;
>>    299		s64 value;
>>    300		int ret;
>>    301	
>>    302		/* Queue 0 is not AVB capable */
>>    303		if (queue <= 0 || queue >= tx_queues_count)
>>    304			return -EINVAL;
>>    305		if (priv->speed != SPEED_100 && priv->speed != SPEED_1000)
>>    306			return -EOPNOTSUPP;
>>    307	
>>    308		mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
>>    309		if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
>>    310			ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
>>    311			if (ret)
>>    312				return ret;
>>    313	
>>    314			priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;
>>    315		} else if (!qopt->enable) {
>>    316			return stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_DCB);
>>    317		}
>>    318	
>>    319		/* Port Transmit Rate and Speed Divider */
>>    320		ptr = (priv->speed == SPEED_100) ? 4 : 8;
>>    321		speed_div = (priv->speed == SPEED_100) ? 100000 : 1000000;
>>    322	
>>    323		/* Final adjustments for HW */
>>    324		value = qopt->idleslope * 1024 * ptr;
>>  > 325		do_div(value, speed_div);
>>    326		priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
>>    327	
>>    328		value = -qopt->sendslope * 1024UL * ptr;
>>    329		do_div(value, speed_div);
>>    330		priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
>>    331	
>>    332		value = qopt->hicredit * 1024 * 8;
>>    333		priv->plat->tx_queues_cfg[queue].high_credit = value & GENMASK(31, 0);
>>    334	
>>    335		value = qopt->locredit * 1024 * 8;
>>    336		priv->plat->tx_queues_cfg[queue].low_credit = value & GENMASK(31, 0);
>>    337	
>>    338		ret = stmmac_config_cbs(priv, priv->hw,
>>    339					priv->plat->tx_queues_cfg[queue].send_slope,
>>    340					priv->plat->tx_queues_cfg[queue].idle_slope,
>>    341					priv->plat->tx_queues_cfg[queue].high_credit,
>>    342					priv->plat->tx_queues_cfg[queue].low_credit,
>>    343					queue);
>>    344		if (ret)
>>    345			return ret;
>>    346	
>>    347		dev_info(priv->device, "CBS queue %d: send %d, idle %d, hi %d, lo %d\n",
>>    348				queue, qopt->sendslope, qopt->idleslope,
>>    349				qopt->hicredit, qopt->locredit);
>>    350		return 0;
>>    351	}
>>    352	
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.01.org_pipermail_kbuild-2Dall&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=YIae3rrFzqYg_5b4eVIAXuyvT_EV0vKACS25rJugux8&s=yMjbhyNoi6ZESIohHtaqFOTXipZVefU7mA4Tfc5QPms&e=                   Intel Corporation

