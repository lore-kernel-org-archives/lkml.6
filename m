Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCE6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ACE2596E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTe4P2I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7ACE2596E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeFYMoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:44:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42582 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeFYMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:44:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PChv6E074010;
        Mon, 25 Jun 2018 12:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2017-10-26; bh=M3jqy7cZwyxuJWNB3w7cVQL4dbAPtRqH8u03LsdQJWc=;
 b=NTe4P2I6ZqvTSc8LAiP9sYKJz2NGtlz256LA+L13Sp9H4J8BnoajzphceRFb1ya03s62
 1t9LgTGJjAwhjNocrtcsOE3x9BTN1xB28/Fn7wXVjjllFEu7OD0s7kzvGNE+f424IHgn
 EVaXixVX8oW0beZnN8WVOAXZ9QPeziC0jAFpU/PFC8rPMTYOpqnQXSn9mRv3UQUOjpAi
 2+HfliIAjuuFGKgloM7d/zY3yHQwPdmqkTyhqEJ0xL7BGFiDqw3kk+eOJBtAycaj8GSp
 QjwIneGeJbH1l+l6I58RXqYXUErwX2s2Vl6SXJsDXRK7CDw8taTPr297lfpgYy5Esiw+ IA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jt7natjm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:43:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5PChttv026299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:43:55 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5PChrpc007477;
        Mon, 25 Jun 2018 12:43:53 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 05:43:52 -0700
Date:   Mon, 25 Jun 2018 15:43:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Tomer Maimon <tmaimon77@gmail.com>
Cc:     kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        jdelvare@suse.com, linux@roeck-us.net, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: npcm750: add NPCM7xx PWM and Fan driver
Message-ID: <20180625124332.e7oyxezasn374w4b@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624124155.82412-3-tmaimon77@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hwmon/hwmon-next]
[also build test WARNING on v4.18-rc2 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tomer-Maimon/dt-binding-hwmon-Add-NPCM7xx-PWM-and-Fan-controller-documentation/20180624-205017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next

New smatch warnings:
drivers/hwmon/npcm750-pwm-fan.c:261 npcm7xx_pwm_config_set() warn: inconsistent returns 'mutex:&data->pwm_lock[module]'.
  Locked on:   line 245
  Unlocked on: line 261

Old smatch warnings:
drivers/hwmon/npcm750-pwm-fan.c:836 npcm7xx_pwm_cz_set_cur_state() warn: potential spectre issue 'cdev->cooling_levels'

# https://github.com/0day-ci/linux/commit/5ef6a0a11de5f3f0711993a20b13820cc0884c7e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 5ef6a0a11de5f3f0711993a20b13820cc0884c7e
vim +261 drivers/hwmon/npcm750-pwm-fan.c

5ef6a0a1 Tomer Maimon 2018-06-24  210  
5ef6a0a1 Tomer Maimon 2018-06-24  211  static int npcm7xx_pwm_config_set(struct npcm7xx_pwm_fan_data *data,
5ef6a0a1 Tomer Maimon 2018-06-24  212  				  int channel, u16 val)
5ef6a0a1 Tomer Maimon 2018-06-24  213  {
5ef6a0a1 Tomer Maimon 2018-06-24  214  	u32 pwm_ch = (channel % NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
5ef6a0a1 Tomer Maimon 2018-06-24  215  	u32 module = (channel / NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
5ef6a0a1 Tomer Maimon 2018-06-24  216  	u32 tmp_buf, ctrl_en_bit, env_bit;
5ef6a0a1 Tomer Maimon 2018-06-24  217  
5ef6a0a1 Tomer Maimon 2018-06-24  218  	/*
5ef6a0a1 Tomer Maimon 2018-06-24  219  	 * Config PWM Comparator register for setting duty cycle
5ef6a0a1 Tomer Maimon 2018-06-24  220  	 */
5ef6a0a1 Tomer Maimon 2018-06-24  221  	mutex_lock(&data->pwm_lock[module]);
5ef6a0a1 Tomer Maimon 2018-06-24  222  
5ef6a0a1 Tomer Maimon 2018-06-24  223  	/* write new CMR value  */
5ef6a0a1 Tomer Maimon 2018-06-24  224  	iowrite32(val, NPCM7XX_PWM_REG_CMRx(data->pwm_base, module, pwm_ch));
5ef6a0a1 Tomer Maimon 2018-06-24  225  	tmp_buf = ioread32(NPCM7XX_PWM_REG_CR(data->pwm_base, module));
5ef6a0a1 Tomer Maimon 2018-06-24  226  
5ef6a0a1 Tomer Maimon 2018-06-24  227  	switch (pwm_ch) {
5ef6a0a1 Tomer Maimon 2018-06-24  228  	case 0:
5ef6a0a1 Tomer Maimon 2018-06-24  229  		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH0_EN_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  230  		env_bit = NPCM7XX_PWM_CTRL_CH0_INV_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  231  		break;
5ef6a0a1 Tomer Maimon 2018-06-24  232  	case 1:
5ef6a0a1 Tomer Maimon 2018-06-24  233  		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH1_EN_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  234  		env_bit = NPCM7XX_PWM_CTRL_CH1_INV_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  235  		break;
5ef6a0a1 Tomer Maimon 2018-06-24  236  	case 2:
5ef6a0a1 Tomer Maimon 2018-06-24  237  		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH2_EN_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  238  		env_bit = NPCM7XX_PWM_CTRL_CH2_INV_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  239  		break;
5ef6a0a1 Tomer Maimon 2018-06-24  240  	case 3:
5ef6a0a1 Tomer Maimon 2018-06-24  241  		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH3_EN_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  242  		env_bit = NPCM7XX_PWM_CTRL_CH3_INV_BIT;
5ef6a0a1 Tomer Maimon 2018-06-24  243  		break;
5ef6a0a1 Tomer Maimon 2018-06-24  244  	default:
5ef6a0a1 Tomer Maimon 2018-06-24  245  		return -ENODEV;
                                                ^^^^^^^^^^^^^^
5ef6a0a1 Tomer Maimon 2018-06-24  246  	}
5ef6a0a1 Tomer Maimon 2018-06-24  247  
5ef6a0a1 Tomer Maimon 2018-06-24  248  	if (val == 0) {
5ef6a0a1 Tomer Maimon 2018-06-24  249  		/* Disable PWM */
5ef6a0a1 Tomer Maimon 2018-06-24  250  		tmp_buf &= ~ctrl_en_bit;
5ef6a0a1 Tomer Maimon 2018-06-24  251  		tmp_buf |= env_bit;
5ef6a0a1 Tomer Maimon 2018-06-24  252  	} else {
5ef6a0a1 Tomer Maimon 2018-06-24  253  		/* Enable PWM */
5ef6a0a1 Tomer Maimon 2018-06-24  254  		tmp_buf |= ctrl_en_bit;
5ef6a0a1 Tomer Maimon 2018-06-24  255  		tmp_buf &= ~env_bit;
5ef6a0a1 Tomer Maimon 2018-06-24  256  	}
5ef6a0a1 Tomer Maimon 2018-06-24  257  
5ef6a0a1 Tomer Maimon 2018-06-24  258  	iowrite32(tmp_buf, NPCM7XX_PWM_REG_CR(data->pwm_base, module));
5ef6a0a1 Tomer Maimon 2018-06-24  259  	mutex_unlock(&data->pwm_lock[module]);
5ef6a0a1 Tomer Maimon 2018-06-24  260  
5ef6a0a1 Tomer Maimon 2018-06-24 @261  	return 0;
5ef6a0a1 Tomer Maimon 2018-06-24  262  }
5ef6a0a1 Tomer Maimon 2018-06-24  263  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
