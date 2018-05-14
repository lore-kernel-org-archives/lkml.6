Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-899412-1526306777-2-6352034317090941930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526306776; b=eP3tljZiRbTxzDhzyL6ZP358vgpX2blobPjDLjT6hMDrS/QPl+
    d+79Su++7HA8VfrmMwrmmdfTtSmodIy3NqJzJPITFUDSCBGzH2UDMNw/BgsXO2uD
    jjmRlw5pPQwPKnV6ctS07WmfBTZo3Nhfi6mSdHTmEr5+AAQYe3Rx4SFg6O/xDJ5H
    xyDsWgjLdv6fYgo8diEuER6y+AmQ02f0PSczye3SFX785PEIRtU7xLrg2hBlDJEo
    k4Mid42Sy0R2Qtqt1JBArPe7WsGYbpsKSGmoxdRUrC15diIpf+XPPnYB0VyYF28i
    b8jhQdoScISC9xmDUFXczzp6Yx9NXn88jRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526306776; bh=pehIq
    YCv76IyJO2eu/+BARhEmnORCAibnBXyW5dGK/s=; b=mc7Q8srtLguCffI09Pbug
    n52gn+rmVTgSJoMDPk33uZdsRz4OO6klt7/hLy7Edz5YQCtH7oDsotfDZVB9gr+E
    STuKIKLZ3YIhxEOObTiCfGuMWCxy+YaFvcoD7mABSpOxHbS7F56udRhtoBQsBGj4
    daqtlBhgmdSSs6BUAzQwm8hhEs83t9r51jqfrwUco4FP06OangkC5sxjiyMExxp4
    MXB575/5JWy3x2sLn0AACE+KBrhXnJOdjBypBOstavDbqDXv0u2q0loRgQ50NNBZ
    NcVqzf2wsoqunrAKBNM04H04DVf8vWsAyZp2jU6+q3e32IXzzJ4LJH3ncbDqOx7i
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=kQ9DvXcd x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=sH3J4NUR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=kQ9DvXcd x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=sH3J4NUR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDQ1M8Q3VTAelY7qBu8bPXN59I4JODaie9PnnizM+sby7cU7HnJN+mrB2X/pmr91WFsNOAF3fB28+amdOiDdtMyXee884b8w20Ta/gUfWgWdrH+O4G2j
    eKzB5Nd5rK2dhfhQjBu+8KFjEJE8XqmeIPzUm5mYjugOkSCxIPiuszYTsXoHHpmXACJ7l3i1zp0SztVoo+J+0vSc06b11lxVrJRnFxEpd+QG6jWU3WSbcGX5
    OnnpfMN1GIYSRDgrG1SZsg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=n7jXXj0E-eMQoVe5m4QA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZokn/oWHaJCBXt0pGNK4I27EetcAm0xC3Uptk8jn9NXeZY8EH3qZxwmbrci3qI2QeO/tignFA==
Date: Mon, 14 May 2018 07:06:22 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/7] staging: ks7010: Remove unnecessary limit checks
Message-ID: <20180514140622.GA13207@flashbox>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-3-natechancellor@gmail.com>
 <20180514131736.ysftvs3nk552kjnx@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514131736.ysftvs3nk552kjnx@mwanda>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 04:17:36PM +0300, Dan Carpenter wrote:
> On Sun, May 06, 2018 at 03:03:00PM -0700, Nathan Chancellor wrote:
> > uwrq is an unsigned 32-bit integer, it cannot be less than zero.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> > index e96477937f65..0c83d6fe270f 100644
> > --- a/drivers/staging/ks7010/ks_wlan_net.c
> > +++ b/drivers/staging/ks7010/ks_wlan_net.c
> > @@ -1928,7 +1928,7 @@ static int ks_wlan_set_beacon_lost(struct net_device *dev,
> >  	if (priv->sleep_mode == SLP_SLEEP)
> >  		return -EPERM;
> >  	/* for SLEEP MODE */
> > -	if (*uwrq < BEACON_LOST_COUNT_MIN || *uwrq > BEACON_LOST_COUNT_MAX)
> > +	if (*uwrq > BEACON_LOST_COUNT_MAX)
> 
> I believe Smatch is supposed to ignore this sort of code because
> comparing "if (foo < 0 || foo > max) " is pretty readable and idiomatic.
> 
> Presumably this was so we could redefine BEACON_LOST_COUNT_MIN, but it's
> fine to unused code.  The define isn't needed at all, so you can
> delete that as well.
> 
> regards,
> dan carpenter
> 

Hi Dan,

Thanks for the suggestion, I just sent a patch.

This warning came from GCC as a -Wtype-limit warning. I should have put
that in the commit message to be more clear. I will keep this in mind
for the future if I come across any more checks like this with defines.

Thanks!
Nathan Chancellor
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
