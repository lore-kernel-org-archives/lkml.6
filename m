Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeDSPCV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:02:21 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34370 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752932AbeDSPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:02:19 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Thu, 19 Apr 2018 16:02:13 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 05/21] regulator: arizona-ldo1: Look up a descriptor and
 pass to the core
Message-ID: <20180419150213.kzcl5ghpzkt2kkgk@localhost.localdomain>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
 <20180212131717.27193-6-linus.walleij@linaro.org>
 <20180213110631.o3zn5bifvypofsyg@localhost.localdomain>
 <CACRpkdbOfycfGD-13OTEk7xT5FqLQsvcHrN-mn-vgjQ93cPHyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdbOfycfGD-13OTEk7xT5FqLQsvcHrN-mn-vgjQ93cPHyQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=854 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804190133
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:43:22PM +0200, Linus Walleij wrote:
> On Tue, Feb 13, 2018 at 12:06 PM, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Mon, Feb 12, 2018 at 02:17:01PM +0100, Linus Walleij wrote:
> >> Instead of passing a global GPIO number, pass a descriptor looked
> >> up with the standard devm_gpiod_get_optional() call.
> >>
> >> We have augmented the GPIO core to look up the regulator special
> >> GPIO "wlf,ldoena" in a separate patch.
> >>
> >> Cc: patches@opensource.cirrus.com
> >> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> > Also looking at this more you will need to you
> > devm_gpio_get_from_of_node here since the device tree binding is
> > for wlf,ldoena not wlf,ldoena-gpio. So this patch currently
> > breaks the binding.
> 
> Actually not, because I fixed that in  the special quirk patch
> 6a537d48461d
> "gpio: of: Support regulator nonstandard GPIO properties"
> as mentioned in the commit message. (Will clarify.)

Apologies my bad should have spotted that in the commit message.

Thanks,
Charles
