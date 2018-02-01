Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeBALT5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:19:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53710 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBALTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:19:53 -0500
Date: Thu, 1 Feb 2018 14:16:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: reduce false positives
Message-ID: <20180201111610.24r75fssivaykff3@mwanda>
References: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
 <20180201102501.kc5pfxojn7fhxat4@mwanda>
 <alpine.DEB.2.20.1802011158110.3135@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802011158110.3135@hadrien>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=627
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 12:06:35PM +0100, Julia Lawall wrote:
> Here are the results that are eliminated by my change:
> 
> drivers/clk/axs10x/pll_clock.c:323:1-6 kfree(pll_clk);
> drivers/clk/clk-gpio.c:131:2-7 kfree(clk_gpio);
> drivers/clk/clk-hsdk-pll.c:410:1-6 kfree(pll_clk);
> drivers/clk/hisilicon/clk.c:97:1-6 kfree(clk_data);
> drivers/mfd/syscon.c:130:1-8 iounmap(base);
> drivers/mfd/syscon.c:132:1-6 kfree(syscon);
> drivers/pinctrl/freescale/pinctrl-mxs.c:139:2-7 kfree(group);
> drivers/pinctrl/samsung/pinctrl-exynos5440.c:264:1-6 kfree(gname);
> drivers/platform/chrome/cros_ec_debugfs.c:248:1-6 kfree(msg);
> drivers/pwm/pwm-lp3943.c:56:3-8 kfree(pwm_map);
> 
> The semantic patch is pretty naive in that it assumes that all uses of the
> same name point to the same thing.
> 

Huh...  It leads to false positives but it is an easier way to do cross
function analysis.  I had wondered about that.

regards,
dan carpenter
