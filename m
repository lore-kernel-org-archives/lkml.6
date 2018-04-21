Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460864-1524331096-2-2735726010023094019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524331096; b=oH14/RNfGRGTL98uEczuLuouWMD9wIgHLT9TQZREyeGIlOeGaG
    K2HRe0TifbCjHNalRjWI/N8zMmUp6RJk4mQmcujaGOcCAoZbc6apTwo4AUZTio/Q
    bYRkJ1IDQ055tnc2hvI9lhM8HQdOypU8smsrFe2Q7sBLHINivFY6r2FcdypcYUio
    yPvvGhoeDxN8qHhS3kbjJRu8gLd8TJf2lvGohBSHEfkFNqjbgBdqVyLQ6QvfbK2y
    yjoBbrZz5VsycV+N35tHIyANI/heTaY4bFrXZK9Qd7kmsP55hjXWKzcMORx+5hBv
    jFpYdN08HIscfwPkq50MHQTvfeXQ/TtqB+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524331096; bh=wnzeU
    sshbMSlAfLQtdxJ2LCzRE9OmIsO9NvCqxQ6Kys=; b=ldoCNny4NyPIIkjxQT9KY
    TkQG1C4pfDffaKImW0zra9KKfzUPrn3p+FZKjp8lmZ3YmmFs5lcPABwf3BG9CVY0
    xN2FfDd3wPURNLIelC2VxawZ9W2pGbUnol76r+ZIDI+EFyRyq8rVRV29ERfaMUnv
    uPpo552dnxlIprqPRQPFYBa4tHsKs/yLpzKwsA6KInJIJJsOdv/7jIwXzj2jA5XG
    I0xHfGRgMnIPF+0E1R4BaRPVb6jlwtu341XWI9ec90Xi4KAn2r7FpOPWW9Ew23v1
    gO7KKb7JgkSHmfWL0XUnFKerth5HpidYBy9fyA/8V+e56rZ+ibbk+XRf3/D7vhnv
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHiQ+VUsg/sONpHXFKLCSNVb3AT/OIRhcOX2uVsmDI4lZ8hIJFM4EbOaWmp7Db09/D2rQ4ta5qegewhgn2+nM4Zr0puISipKApVv4zXeovsxQGa5qsRQ
    zV/LhmsmvvoLr7fwqobRnz6ahpD6SUdqbrqZNS/N5gFxh6mab01THxx/DypbOERtWaqowuMzYAfCtf2rOgqty6NK73ayL2RihOimEv4m8RORRD6jJA9hp4Rw
    N+xi7sA6SJQSJW/0Z79QbA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=lbObu2VxLuC9_tdxFeoA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA48D21104
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 18:18:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 0/3] stagging:iio:meter: Add essential IIO API
 structures for ADE7854
Message-ID: <20180421181803.53addc6c@archlinux>
In-Reply-To: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 21 Apr 2018 08:54:45 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patchset aims to update ADE7854 by adding the required IIO API
> components. The first patch adds the iio_chan_spec for handling seven
> different registers (all of them with a similar behavior). The second
> patch appends the read_raw function defined by the IIO API. Finally, the
> third patch adds the write_raw function and remove the attributes used
> for handling the seven registers. This patchset has the contribution of
> John Syne, which was responsible for mapping the correct ABI name per
> element in the ADE7854; additionally, John provided codes that helped to
> shape these patches.
> 
> Rodrigo Siqueira (3):
>   stagging:iio:meter: Add iio_chan_spec
>   stagging:iio:meter: Add ade7854_read_raw function
>   stagging:iio:meter: Add ade7854_write_raw function
> 
>  drivers/staging/iio/meter/ade7854.c | 129 ++++++++++++++++++++--------
>  1 file changed, 94 insertions(+), 35 deletions(-)
> 
Hi Rodrigo,

Please don't do it like this.   The original discussion with John
involved the addition of an extra chunk of core logic so we would have
the ability to specify the channel without using extended_name.

Extended name is not intended to differentiate between channels (it
isn't in general enough to do so - though it works in this little
corner case of sysfs attributes like you have here).

So the plan is to add another field to the iio_chan_spec structure
to allow for the complexity we need.  See the long discussions
over how we represent the myriad of channels in here.

If you need some pointers, feel free to ask but it may take
me a little while to put together a full description of what needs
doing.

I'll put a few more direct comments in the individual patches.

Thanks,

Jonathan

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
