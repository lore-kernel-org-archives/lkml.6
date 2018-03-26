Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeCZIeT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:34:19 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:41838 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752575AbeCZIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:34:12 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 26 Mar 2018 09:34:04 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180326083404.ewogeas2rdgbfvhh@localhost.localdomain>
References: <20180312155201.30108-1-ckeepax@opensource.cirrus.com>
 <CACRpkdY396hwrZtAqH=L8nvrr_f5An9zF+EFhO=4mz4XSc45=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdY396hwrZtAqH=L8nvrr_f5An9zF+EFhO=4mz4XSc45=A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=777 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803260094
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 03:32:05PM +0100, Linus Walleij wrote:
> On Mon, Mar 12, 2018 at 4:52 PM, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> 
> > Now GPIOD has support for both pdata systems and for non-standard DT
> > bindings the Arizona reset GPIO can be converted to use it. Worth
> > noting gpiod_set_raw_value_cansleep is used to match the behaviour
> > of the old GPIOs. This is because the part is fairly widely used and
> > it is unknown how many DTs are correctly setting active low through
> > device tree, so to avoid breaking any existing users it is best to
> > match the previous behaviour.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> The use of gpiod_set_raw* should be done with caution, but this
> is one of the cases where we need to take out the big hammer to
> make sure things stay compatible.
> 
> I haven't read why it is like so but I guess because the right flags
> in the device tree can not be guaranteed?
> 

Exactly yes there are a lot of these parts out there and since
they never required the DT flags to be set correctly before I
very much doubt all those DTs are set correctly.

Thanks,
Charles
