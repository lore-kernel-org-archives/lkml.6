Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeBSO2d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:28:33 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47390 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751446AbeBSO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:28:32 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 19 Feb 2018 14:28:16 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180219142816.ccrkxthzmtpopnw5@localhost.localdomain>
References: <20180219133038.21995-1-ckeepax@opensource.cirrus.com>
 <CAHp75Vc6ok2s0fiQi9ePgmf4BVyO5N125B6iE1jnqWmgWF01Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc6ok2s0fiQi9ePgmf4BVyO5N125B6iE1jnqWmgWF01Ng@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=930 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802190180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 03:36:29PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 19, 2018 at 3:30 PM, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > Now GPIOD has support for both pdata systems and for non-standard DT
> > bindings the Arizona reset GPIO can be converted to use it.
> 
> >  static inline void arizona_enable_reset(struct arizona *arizona)
> >  {
> > -       if (arizona->pdata.reset)
> > -               gpio_set_value_cansleep(arizona->pdata.reset, 0);
> > +       gpiod_set_value_cansleep(arizona->pdata.reset, 0);
> >  }
> 
> Did you try that code when !GPIOLIB ?
> 
> Or driver depends on it?
> 

Hmm... yeah ok maybe I need to leave that if (reset) in, didn't
realise all those stubs straight up call WARNs. Although seems a bit
of a shame as gpiod_set_value_cansleep will do the NULL check as well.

Looks like attempt 3 it is :-)

Thanks,
Charles
