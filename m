Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1986038-1524526994-2-7585884068631339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524526993; b=QLGXhw3vlKxzqz/FrQsuifBGFfKTZtTyl7nmsJqMNBtTLTirLA
    rwEyrX1+OXLVI56c3Fj0mtbthzKvw3gbseg0MM+fH6AZ17BZPZUixQ1aaGSIPzoD
    kAXQle11bvg6rB87uUu/8wVFjxUaZPYDEbrNfLs+aM96tn3/nEfcGY1ffQyWRNIT
    ukjlt2R9MMXkpno3Uqi+aDpcJ/mIjxhFYgiy3QSpdVpMkMkRenI4OKkUpm8K7HA7
    zBuHPuyaL0W8yMHRlcHik9SStdZgLbEuc3yWjPcWYkk2+DZTL61+/GkSmLBVrDwi
    c3VGHkCIizGfmJYegq7uRJcVzskMa2k38NqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524526993; bh=3dtjT
    S/bGOedGL01ELLnt6uOQosw2xjEju8xAQ1HEqg=; b=DS/wLKBMGzkskMX/KN5CS
    DigNTc7+3r+vB4LLxaFHGwn8Yuzxz+QmD7ApNYTq/HTfI/CarFVRVDxvfarcraI3
    g/FJLTNTx7pG7zm6j1FmCQI1KA/4MTB4MurQp56BIHDmttJb2mnpAb4gKMhyx26o
    RvKiJCnsFXDABtd3hVwMkoJoUmpbBdYQ+XME3e+SKGKoL0bc60UYXBqHL27eObDA
    4QZv1GwQP+jPilLBL94KTzHwP2T9HfrRwHuUkxwXf8VHQYrr/tZp5QKdIiQjy2+h
    9pEWy2sJBjvMNTb/XPH/rKb8TsgIRdguUpItdm6q9BHRPKsBr14N2BP9PLwVuyS/
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SjMcrw9k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qDDVpvTw;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SjMcrw9k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qDDVpvTw;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKXahxit9UtET2jYUnC74jTK3dGmz5cHO706ftx/BaitphWQch/NUE9XnHOaahoxjs7IQHJ4ldaME/j/nXCw9m1i7jshgSvPlCCcNJykJTxAHutEmyhv
    t9y4C/gcOuPuZzL9WagqWSLnu3bJeittF6VR8XJXbfQXePxGSAKfGIx0IKAXpWTps4CZfAPK8cRvRUetifL63zZds/DA2yUFoSA7F4rAn5pT54D2jlr+HgSm
    2rOURy8Y4kjM1X6QJNLCeg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=px3f5oUF_X8A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=PejntSQPOAM2ErAFQv4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrdLh427KRqCYirKcqNA+31Fh4LlkOQpFjVcXuSYee3Hr/MrRFyh3XWtzTsdBRF4YiHBeP79Q==
Date: Mon, 23 Apr 2018 20:42:55 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/3] stagging:iio:meter: Add essential IIO API structures
 for ADE7854
Message-ID: <20180423234255.mvbt3x6v2xotqd76@smtp.gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <20180421181803.53addc6c@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180421181803.53addc6c@archlinux>
User-Agent: NeoMutt/20180323
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

Hi Jonathan,

Thanks for all the feedbacks and sorry for some basic mistakes, I will
work on the second version based on all your comments.

Best Regards
Rodrigo Siqueira

On 04/21, Jonathan Cameron wrote:
> On Sat, 21 Apr 2018 08:54:45 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
> > This patchset aims to update ADE7854 by adding the required IIO API
> > components. The first patch adds the iio_chan_spec for handling seven
> > different registers (all of them with a similar behavior). The second
> > patch appends the read_raw function defined by the IIO API. Finally, the
> > third patch adds the write_raw function and remove the attributes used
> > for handling the seven registers. This patchset has the contribution of
> > John Syne, which was responsible for mapping the correct ABI name per
> > element in the ADE7854; additionally, John provided codes that helped to
> > shape these patches.
> > 
> > Rodrigo Siqueira (3):
> >   stagging:iio:meter: Add iio_chan_spec
> >   stagging:iio:meter: Add ade7854_read_raw function
> >   stagging:iio:meter: Add ade7854_write_raw function
> > 
> >  drivers/staging/iio/meter/ade7854.c | 129 ++++++++++++++++++++--------
> >  1 file changed, 94 insertions(+), 35 deletions(-)
> > 
> Hi Rodrigo,
> 
> Please don't do it like this.   The original discussion with John
> involved the addition of an extra chunk of core logic so we would have
> the ability to specify the channel without using extended_name.
> 
> Extended name is not intended to differentiate between channels (it
> isn't in general enough to do so - though it works in this little
> corner case of sysfs attributes like you have here).
> 
> So the plan is to add another field to the iio_chan_spec structure
> to allow for the complexity we need.  See the long discussions
> over how we represent the myriad of channels in here.
> 
> If you need some pointers, feel free to ask but it may take
> me a little while to put together a full description of what needs
> doing.
> 
> I'll put a few more direct comments in the individual patches.
> 
> Thanks,
> 
> Jonathan
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
